
import os
import re
import StringIO
import sys


class Stream(object):
    """
    A wrapper around the file interface to store the current (most recently read) line.
    """
    def __init__(self, fp):
        """

        Args:
            fp (file):
        """
        self.fp = fp
        self._curr = self.next_line()

    def current_line(self):
        return self._curr

    def next_line(self):
        self._curr = self.fp.readline()
        if self._curr == '':
            self._curr = EOFError
            return ''
        return self._curr

    def is_eof(self):
        return self._curr == EOFError


class TinyTestFunc(object):

    RE = re.compile('^[\w]+ (test_[\w_-]+)')

    def __init__(self, source_line, func_name):
        self.source_line = source_line
        self.func_name = func_name

    @classmethod
    def create(cls, stream):
        line = stream.current_line()
        stream.next_line()
        r = cls.RE.match(line)
        if r:
            return TinyTestFunc(line, r.groups()[0])
        return None


class CInclude(object):

    def __init__(self, lib):
        self._lib = lib

    def to_str(self):
        return '#include <{}>\n'.format(self._lib)

    @classmethod
    def create(cls, stream):
        raise RuntimeError('can not be parsed from source file')


class VoidCFuncBegin(object):
    """
    not a parsed source object!
    """

    def __init__(self, func_name):
        self.func_name = func_name

    def to_str(self):
        return self.func_name + ' {\n'

    @classmethod
    def create(cls, stream):
        raise RuntimeError('can not be parsed from source file')


class VoidCFuncEnd(object):
    """
    not a parsed source object!
    """

    def to_str(self):
        return '}\n'

    @classmethod
    def create(cls, stream):
        raise RuntimeError('can not be parsed from source file')


class CTimerBegin(object):
    """
    clock_t before = clock(), after;
    double msec = 0.0;

    ...

    after = clock();
    msec = after - before;
    printf("\nTime spent: %f s (%f us)\n", msec/CLOCKS_PER_SEC, msec);
    """
    pass


class CTimerEnd(object):
    pass


class Parser(object):

    def __init__(self):
        self._factories = (TinyTestFunc, )
        self._source_objects = list()

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
        return self

    def source_objects(self):
        return self._source_objects

    def source_lines(self):
        return [so.source_line for so in self._source_objects]


class Formatter(object):
    """
    Format (i.e. sprintf) the source objects
    """

    def __init__(self):
        self._indent = 0
        self._num_char_indent = 4

    def prt(self, source_object):
        if isinstance(source_object, TinyTestFunc):
            return self.prtTinyTestFunc(source_object)
        if isinstance(source_object, VoidCFuncBegin):
            self._indent += 1
            return source_object.to_str()
        if isinstance(source_object, VoidCFuncEnd):
            self._indent -= 1
            return source_object.to_str()
        if isinstance(source_object, CInclude):
            return source_object.to_str()
        if isinstance(source_object, CTimerEnd):
            return self.prtTimerEnd(source_object)
        if isinstance(source_object, CTimerBegin):
            return self.prtTimerBegin(source_object)
        return '\n'

    def indent(self):
        return ' ' * (self._indent * self._num_char_indent)

    def prtTimerBegin(self, _):
        """
        clock_t before = clock(), after;
        double msec = 0.0;
        """
        ss = StringIO.StringIO()
        print >>ss, '{}clock_t before = clock(), after;'.format(self.indent())
        print >>ss, '{}double msec = 0.0;'.format(self.indent())
        return ss.getvalue()

    def prtTimerEnd(self, _):
        """
        msec = after - before;
        printf("\nTime spent: %f s (%f us)\n", msec/CLOCKS_PER_SEC, msec);
        """
        ss = StringIO.StringIO()
        print >>ss, '{}after = clock();'.format(self.indent())
        print >>ss, '{}msec = after - before;'.format(self.indent())
        print >>ss, '{}printf("\\nTime spent: %f s (%f us)\\n", msec/CLOCKS_PER_SEC, msec);'.format(self.indent())
        return ss.getvalue()

    def prtTinyTestFunc(self, source_object):
        """

        Args:
            source_object (TinyTestFunc):

        Returns:
            str
        """

        ss = StringIO.StringIO()
        print >>ss, '{}printf("Running {} ......");'.format(self.indent(), source_object.func_name)
        print >>ss, '{}{}();'.format(self.indent(), source_object.func_name)
        print >>ss, '{}printf("Done\\n");'.format(self.indent())
        return ss.getvalue()


def raise_if_path_not_exist(path):
    if not os.path.isfile(path):
        raise OSError('invalid source file: {}'.format(path))


def raise_if_dir_not_writable(path):
    dn = os.path.dirname(path)
    if not (os.path.isdir(dn) and os.access(dn, os.W_OK | os.R_OK)):
        raise OSError('can not write to path: {}'.format(dn))
    if os.path.exists(path):
        os.remove(path)


def main():
    from_path, to_path = (sys.argv[1:] + ['___', '___'])[0: 2]
    raise_if_path_not_exist(from_path)
    raise_if_dir_not_writable(to_path)
    source_objects = list()
    with open(from_path, 'r') as fp:
        source_objects = Parser().parse(Stream(fp)).source_objects()
    exported = [CInclude('stdio.h'),
                CInclude('stdlib.h'),
                CInclude('time.h'),
                VoidCFuncBegin('void RunTinyTests()'),
                CTimerBegin()]
    exported.extend(source_objects)
    exported.extend([CTimerEnd(),
                     VoidCFuncEnd()])
    formatter = Formatter()
    with open(to_path, 'w') as fp:
        for so in exported:
            fp.write(formatter.prt(so))


if __name__ == '__main__':
    main()
