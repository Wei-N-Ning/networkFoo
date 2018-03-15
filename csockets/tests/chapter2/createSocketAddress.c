
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>

void RunTinyTests();

void test_createUnixAddressUsingFSPath() {
    int z;
    int s;
    struct sockaddr_un addr;
    int len;
    const char path[255] = "/tmp/ddd";
    s = socket(AF_UNIX, SOCK_STREAM, 0);
    assert(-1 != s);
    unlink(path);
    addr.sun_family = AF_UNIX;

    // the trailing null byte is needed by SUN_LEN() macro
    strncpy(addr.sun_path, path, sizeof(addr.sun_path) - 1)[sizeof(addr.sun_path)] = '\0';
    len = SUN_LEN(&addr);
    assert(10 == len);  // 2 bytes header + 8 characters
    
    // expect /tmp/ddd shows up in ls and netstat -ap
    z = bind(s, (struct sockaddr *)&addr, len);
    assert(0 == z);
    z = close(s);
    assert(0 == z);

    // the pathname created for the socket is removed (unlinked)
    unlink(path);
}

// if the pathname is not free to use, bind() will fail;
// therefore Linux provides abstract name for a local socket - the
// trick is to make the first byte of the pathname a null byte (Socket Example P70)
void test_createAbstractLocalAddress() {
    int z = -1;
    int s = -1;
    struct sockaddr_un addr;
    int len = 0;
    const char path[255] = "Zthere*is-no+spoon";
    s = socket(AF_UNIX, SOCK_STREAM, 0);
    assert(-1 != s);
    addr.sun_family = AF_UNIX;
    strncpy(addr.sun_path, path, sizeof(addr.sun_path))[sizeof(addr.sun_path)] = '\0';
    len = SUN_LEN(&addr);
    assert(20 == len);
    addr.sun_path[0] = '\0';

    // expect @there*is-no+spoon to show up in netstat -ap
    // the leading @ is used by netstat to indicate abstract UNIX socket names, 
    // the above code deliberately replace the original Z character with a null
    z = bind(s, (struct sockaddr *)&addr, len);
    assert(0 == z);
    z = close(s);
    assert(0 == z);
}

int main() {
    RunTinyTests();
    return 0;
}

