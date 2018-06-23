
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <sys/un.h>
#include <netinet/in.h>

void RunTinyTests();

// linux socket by example P64
// local addresses:
// this address format is used by
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

    // WARNING: make sure SUN_LEN() macro is called before this
    addr.sun_path[0] = '\0';

    // expect @there*is-no+spoon to show up in netstat -ap
    // the leading @ is used by netstat to indicate abstract UNIX socket names, 
    // the above code deliberately replace the original Z character with a null
    z = bind(s, (struct sockaddr *)&addr, len);
    assert(0 == z);
    z = close(s);
    assert(0 == z);
}

// Socket Example P77
// For agreement to exist over the network, it was decided that big-endian byte
// order would be the order used on a network.
void test_convertHostOrderToNetworkOrder() {
    uint16_t fromShort = 0x1234;
    uint32_t fromLong = 0xDEADBEEF;
    uint16_t toShort = htons(fromShort);
    assert(0x3412 == toShort);
    fromShort = ntohs(toShort);
    assert(0x1234 == fromShort);
    assert(0xDEADBEEF == htonl(ntohl(fromLong)));
}

// source
// linux socket by example P79
// when you specify a wild IP number, you allow the
// system to pick the route to the rmote service,
// the kernel will then determine what your final
// local socket address will be at the time the
// connection is established
void test_createWildIPv4SocketAddress() {
    struct sockaddr_in addr;
    int len = 0;
    int z = -1;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(0);
    addr.sin_addr.s_addr = htonl(INADDR_ANY);
    len = sizeof(addr);

    // expect addr to be 0.0.0.0
}

// source
// linux socket by example P79
// another commonly used IP number is ... this refers
// to the loopback device.
// the loopback device lets you communicate with another
// process on the same host as your process
void test_createLoopbackSocketAddress() {
    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(0);
    addr.sin_addr.s_addr = htonl(INADDR_LOOPBACK);
}

void test_createSpecificIPv4SocketAddress() {
    struct sockaddr_in addr;
    socklen_t len = 0;
    int s = -1;
    int z = -1;
    const unsigned char IPno[4] = {127, 0, 0, 23};
    s = socket(AF_INET, SOCK_STREAM, 0);
    assert(-1 != s);
    addr.sin_family = AF_INET;
    addr.sin_port = htons(9000);
    memcpy(&addr.sin_addr.s_addr, IPno, 4);
    len = sizeof(addr);
    z = bind(s, (struct sockaddr *)&addr, len);
    assert(0 == z);
    close(s);
}

int main() {
    RunTinyTests();
    return 0;
}

