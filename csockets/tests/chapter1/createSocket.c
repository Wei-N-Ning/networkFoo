
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
    int s[2];
    assert(0 == socketpair(AF_LOCAL, SOCK_STREAM, 0, s));
}

void test_createSocketExpectFailure() {
    int s[2];
    assert(-1, socketpair(-1, -1, 0, s));
}

void test_performIOExpectSuccess() {
    int s[2];
    char *cp;
    char buf[80];
    assert(0 == socketpair(AF_LOCAL, SOCK_STREAM, 0, s));
    


}

int main(int argc, char **argv) {
    RunTinyTests();
    return 0;
}

