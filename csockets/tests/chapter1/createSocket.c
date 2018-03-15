
#include <assert.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/socket.h>

void RunTinyTests();

// AF_LOCAL is unix domain (preferred over AF_UNIX)
// netstat -p 
// expect to see the name of this executable to show in the program column
void test_createSocketExpectSuccess() {
    int z;
    int s[2];
    z = socketpair(AF_LOCAL, SOCK_STREAM, 0, s);
    assert(0 == z);
}

void test_createSocketExpectFailure() {
    int z;
    int s[2];
    z = socketpair(-1, -1, 0, s);
    assert(-1 == z);
}

void test_performIOExpectSuccess() {
    int z;
    int s[2];
    char *cp;
    char buf[80];
    z = socketpair(AF_LOCAL, SOCK_STREAM, 0, s);
    assert(0 == z);
    z = write(s[1], "dOOm!", 5);
    assert(5 == z);
    z = read(s[0], buf, sizeof(buf));
    assert(5 == z);
    buf[z] = '\0';
    z = strcmp("dOOm!", buf);
    assert(0 == z);
    z = close(s[0]);
    assert(0 == z);
    z = close(s[1]);
    assert(0 == z);
}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}

