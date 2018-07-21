#include <sys/socket.h>
#include <sys/un.h>
#include <unistd.h>
#include <assert.h>
#include <string.h>

// note

// this example is to show the usage of getpeername(); it probably has
// no production value

// Chapter 6 also mentions this - the pair of sockets returned from
// socketpair() are connected

int main() {
    int tmp[2];
    assert(0 == socketpair(PF_LOCAL, SOCK_STREAM, 0, tmp));

    struct sockaddr_un addr;
    memset(&addr, 0, sizeof(addr));
    addr.sun_family = PF_LOCAL;
    const char* path = "/tmp/sut/thereisacow";
    strncpy(addr.sun_path, path, strlen(path));
    socklen_t addr_len = SUN_LEN(&addr);

    assert(bind(tmp[0], (struct sockaddr *)&addr, addr_len) != -1);
    struct sockaddr_un receiver;
    socklen_t receiver_len = sizeof(receiver);
    assert(
        0 == getpeername(
            tmp[1], (struct sockaddr *)&receiver, &receiver_len
        )
    );

    assert(0 == strcmp(path, receiver.sun_path));
    close(tmp[0]);
    close(tmp[1]);

    return 0;
}
