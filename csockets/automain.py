
import os
import re
try:
    import io as StringIO
except ImportError:  # python 2.7 compatibility
    import StringIO
import sys


class Stream(object):
    """
    A wrapper around the file interface to store the current (most recently read) line.
    """
    def __init__(self, fp):
        """

        Args:
            fp (file): an object that implements the file interface
        """
        self.fp = fp
        self._curr = self.next_line()

    def current_line(self):
        return self._curr if self._curr != EOFError else ''

    def next_line(self):
        self._curr = self.fp.readline()
        if self._curr == '':
            self._curr = EOFError
            return ''
        return self._curr

    def is_eof(self):
        return self._curr == EOFError


class SourceObjectInterface(object):
    """
    To describe a specific construct in the source code
    """

    @classmethod
    def create(cls, stream):
        """
        Some source objects can be created by parsing an existing subject (other source files).

        Args:
            stream (Stream):

        Returns:
            SourceObjectInterface:
        """
        return None

    def to_string(self, options=None):
        """
        Creates a string representation.

        Note that indentation, spacing and other printing specific attributes are handled by formatter.

        Args:
            options (dict): optional

        Returns:
            str:
        """
        raise NotImplementedError()


def to_dict(options):
    return options if options is not None else dict()


class FuncDeclaration(SourceObjectInterface):

    def __init__(self, func_name, source_line='', signature=''):
        self.source_line = source_line
        self.func_name = func_name
        self.signature = signature if signature else 'void {}()'

    def to_string(self, options=None):
        options = to_dict(options)
        s = self.signature.format(self.func_name)
        if options.get('externDecl'):
            s = 'extern {}'.format(s)
        return '{};'.format(s)


class TestFunctionDeclaration(FuncDeclaration):

    RE = re.compile('^([\w]+) (test_[\w_-]+).*(\(.*\))')

    @classmethod
    def create(cls, stream):
        line = stream.current_line()
        r = cls.RE.match(line)
        if r:
            stream.next_line()
            s = r.groups()
            return cls(s[1], source_line=line, signature='{} {{}}{}'.format(s[0], s[2]))
        return None

    def create_call_statement(self):
        return CallFunction(
            self.func_name,
            pre='printf("Running {}() ......");'.format(self.func_name),
            post='printf("Done\\n");'
        )


class SetUpFunctionDeclaration(FuncDeclaration):

    @classmethod
    def create(cls, stream):
        line = stream.current_line()
        search = re.search('void SetUpGlobal', line)
        if search:
            stream.next_line()
            return cls._create_global_setup(1)
        search = re.search('void setUp', line)
        if search:
            stream.next_line()
            return cls._create_case_setup(1)
        return None

    def create_call_statement(self):
        return CallFunction(self.func_name)

    @classmethod
    def _create_global_setup(cls, s):
        ins = cls('SetUpGlobal')
        ins.is_global = True
        return ins

    @classmethod
    def _create_case_setup(cls, s):
        ins = cls('setUp')
        ins.is_global = False
        return ins


class TearDownFunctionDeclaration(FuncDeclaration):

    @classmethod
    def create(cls, stream):
        line = stream.current_line()
        search = re.search('void TearDownGlobal', line)
        if search:
            stream.next_line()
            return cls._create_global_setup(1)
        search = re.search('void tearDown', line)
        if search:
            stream.next_line()
            return cls._create_case_setup(1)
        return None

    def create_call_statement(self):
        return CallFunction(self.func_name)

    @classmethod
    def _create_global_setup(cls, s):
        ins = cls('TearDownGlobal')
        ins.is_global = True
        return ins

    @classmethod
    def _create_case_setup(cls, s):
        ins = cls('tearDown')
        ins.is_global = False
        return ins


class IncludeStatement(SourceObjectInterface):

    def __init__(self, lib, is_std_library=True):
        self._lib = lib
        self.is_std_library = is_std_library

    def to_string(self, options=None):
        options = to_dict(options)
        l = self._lib
        if self.is_std_library and options.get('CXX') and self._lib.endswith('.h'):
            l = 'c{}'.format(self._lib.replace('.h', ''))
        return '#include <{}>'.format(l)

    @classmethod
    def create(cls, stream):
        raise RuntimeError('can not be parsed from source file')


class ScopeBegin(SourceObjectInterface):

    def to_string(self, options=None):
        options = to_dict(options)
        if options.get('scopeNewline'):
            return '\n{'
        return ' {'


class FuncScopeBegin(ScopeBegin):
    """
    not a parsed source object!
    """

    def __init__(self, func_name, ret='void', args=None, attr=None):
        """

        Args:
            func_name (str):
            args (list): a list of arguments, note that c uses positional arguments
            ret (str): return type
            attr (str): not used, possible use case is static, extern ....
        """
        self.func_name = func_name
        self.args = args
        self.ret = ret
        self.attr = attr

    def _args_to_string(self, options):
        if not self.args:
            return '()'
        return '({})'.format(', '.join(self.args))

    def to_string(self, options=None):
        options = to_dict(options)
        return self.ret + ' ' + self.func_name + self._args_to_string(options) + ' {'

    @classmethod
    def create(cls, stream):
        raise RuntimeError('can not be parsed from source file')


class ScopeEnd(SourceObjectInterface):

    def to_string(self, options=None):
        return '}'


class CTimerBegin(SourceObjectInterface):
    """
    clock_t before = clock(), after;
    double msec = 0.0;

    ...

    after = clock();
    msec = after - before;
    printf("\nTime spent: %f s (%f us)\n", msec/CLOCKS_PER_SEC, msec);
    """

    def to_string(self, options=None):
        s = list()
        s.append('clock_t before = clock(), after;')
        s.append('double msec = 0.0;')
        s.append('\n')
        return ''.join(s)


class CTimerEnd(SourceObjectInterface):

    def to_string(self, options=None):
        options = to_dict(options)
        s = list()
        s.append('after = clock();')
        s.append('msec = after - before;')
        if not options.get('noPrint'):
            s.append(
                'printf("\\nTime spent: %f s (%f us)\\n", msec/CLOCKS_PER_SEC, msec);')
        return ''.join(s)


class CallFunction(SourceObjectInterface):

    def __init__(self, func_name, ret_var=None, args=None, pre='', post=''):
        """

        Args:
            func_name (str):
            ret_var (str): if the return variable is defined inline, it needs to be written here
            args (list): a list of arg variables
            pre (str): an arbitrary statement that runs before this call statement
            post (str): an arbitrary statement that runs after this call statement
        """
        self.func_name = func_name
        self.ret_var = ret_var
        self.args = args
        self.pre = pre
        self.post = post

    def to_string(self, options=None):
        if self.args:
            s = '{}({});'.format(self.func_name, ', '.join(self.args))
        else:
            s = '{}();'.format(self.func_name)
        if self.ret_var:
            line = '{} = {}'.format(self.ret_var, s)
        else:
            line = s
        return '{}{}{}'.format(self.pre, line, self.post)


class ReturnStatement(SourceObjectInterface):

    def __init__(self, var):
        self.var = var

    def to_string(self, options=None):
        return 'return {};'.format(self.var)


class GenericStatement(SourceObjectInterface):

    def __init__(self, s):
        self.s = s

    def to_string(self, options=None):
        if self.s.endswith(';'):
            return self.s
        return '{};'.format(self.s)


class Parser(object):

    def __init__(self):
        self._factories = (
            TestFunctionDeclaration,
            SetUpFunctionDeclaration,
            TearDownFunctionDeclaration,
        )
        self._source_objects = list()
        self._g_setup = None
        self._g_teardown = None
        self._c_setup = None
        self._c_teardown = None

    def parse(self, stream):
        """

        Args:
            stream (Stream):

        Returns:

        """
        while not stream.is_eof():
            for factory in self._factories:
                source_object = factory.create(stream)
                if source_object is not None:
                    self._source_objects.append(source_object)

                if isinstance(source_object, SetUpFunctionDeclaration):
                    if source_object.is_global:
                        self._g_setup = source_object
                    else:
                        self._c_setup = source_object
                elif isinstance(source_object, TearDownFunctionDeclaration):
                    if source_object.is_global:
                        self._g_teardown = source_object
                    else:
                        self._c_teardown = source_object

            else:
                stream.next_line()
        return self

    def source_objects(self):
        return self._source_objects

    def global_setup(self):
        return self._g_setup

    def case_setup(self):
        return self._c_setup

    def global_teardown(self):
        return self._g_teardown

    def case_teardown(self):
        return self._c_teardown


class Formatter(object):
    """
    Format (i.e. sprintf) the source objects
    """

    def __init__(self, options=None):
        self._indent = 0
        self._num_char_indent = 4
        self.options = options

    def prt(self, source_objects):
        buf = list()
        for so in source_objects:
            if isinstance(so, ScopeEnd):
                self._indent -= 1
            s = self.prt_each(so)
            if isinstance(so, ScopeBegin):
                self._indent += 1
            buf.append(s)
        return ''.join(buf)

    def prt_each(self, source_object):
        return '{}{}{}'.format(
            self.indent(), source_object.to_string(options=self.options), self.newline()
        )

    def indent(self):
        return ' ' * (self._indent * self._num_char_indent)

    def newline(self):
        return '\n'


def raise_if_path_not_exist(path):
    if not os.path.isfile(path):
        raise OSError('invalid source file: {}'.format(path))


def raise_if_dir_not_writable(path):
    dn = os.path.dirname(path)
    if not (os.path.isdir(dn) and os.access(dn, os.W_OK | os.R_OK)):
        raise OSError('can not write to path: {}'.format(dn))
    if os.path.exists(path):
        os.remove(path)


def generate_func_decls(stream):
    """

    Args:
        stream (Stream):

    Returns:
        Parser:
    """
    parser = Parser()
    parser.parse(stream)
    return parser


def generate_contents(stream):
    static_contents = [
        IncludeStatement('stdio.h'),
        IncludeStatement('time.h'),
        IncludeStatement('stdlib.h')
    ]

    # global decls
    parser = generate_func_decls(stream)
    func_decls = parser.source_objects()

    # main
    main_begin = [
        FuncScopeBegin('RunTinyTests'),
    ]
    main_func = list()

    if parser.global_setup():
        main_func.append(parser.global_setup().create_call_statement())

    num_tests = 0
    for decl in func_decls:
        if isinstance(decl, (SetUpFunctionDeclaration, TearDownFunctionDeclaration)):
            continue

        num_tests += 1
        if parser.case_setup():
            main_func.append(parser.case_setup().create_call_statement())

        main_func.append(decl.create_call_statement())

        if parser.case_teardown():
            main_func.append(parser.case_teardown().create_call_statement())

    if parser.global_teardown():
        main_func.append(parser.global_teardown().create_call_statement())

    main_end = [
        ScopeEnd()
    ]
    main_contents = list()
    main_contents.extend(main_begin)
    main_contents.append(CTimerBegin())
    # summary
    main_contents.append(GenericStatement('printf("\\nRunning {} tests\\n\\n")'.format(num_tests)))

    main_contents.extend(main_func)
    main_contents.append(CTimerEnd())
    main_contents.extend(main_end)

    s = list()
    s.extend(static_contents)
    s.extend(func_decls)
    s.extend(main_contents)
    return s


def print_format(source_objects, o_path, options):
    opts = {
        'externDecl': True,
    }
    opts.update(options)
    formatter = Formatter(options=opts)
    with open(o_path, 'w') as fp:
        fp.write(formatter.prt(source_objects))


def create_automain(i_path, o_path):
    with open(i_path, 'r') as fp:
        stream = Stream(fp)
        so_list = generate_contents(stream)
    if not so_list:
        raise RuntimeError('Failed to parse source:\n{}'.format(i_path))
    options = dict()
    if os.path.splitext(i_path)[-1] in ('.cc', '.cpp', '.cxx'):
        options['CXX'] = True
    print_format(so_list, o_path, options)


def main():
    i_path, o_path = (sys.argv[1:] + ['___', '___'])[0: 2]
    raise_if_path_not_exist(i_path)
    raise_if_dir_not_writable(o_path)
    create_automain(i_path, o_path)


if __name__ == '__main__':
    main()
