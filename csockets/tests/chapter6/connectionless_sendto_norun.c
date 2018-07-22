
// By Example P162

// connectionless communication (such as UDP) requires no connection to
// be established before communication begins;
// this is like a person with a megaphone shouting to a specific person
// of his choice in a crowd. with each new shout, the person sending
// the message can address his statement to another person without any
// prior agreement.

// after you create a connectionless socket, you will be able to send
// messages to any socket that is willing to receive your messages.
// there will be no connection establishment, and each message can be
// directed to a different receiving socket

// Advantages:
// simpler
// flexible, different recipient each time
// efficient, no setUp or tearDown (avoid overhead)
// fast
// broadcast capability, direct one message to many

// Disadvantage:
// not reliable
// no sequencing of multiple datagrams
// there are message size limitations (can be as low as 512 Bytes)

// a datagram is a unit of data.... it represents one complete message,
// like a telegram

////////////////////////////////////////////
// looking at wt's winstrumentation, it uses netdb.h to implement UDP
// transport layer:
// http://manpages.ubuntu.com/manpages/trusty/man7/netdb.h.7posix.html
// see:  UDPTransport::createSocket() from
// instrumentation/cpp/UDPTransport.cc
// and UDPTransport::send(), which calls sendto() function
////////////////////////////////////////////

// sendto()
// there is a similar "single-shot" example in
// ../netcat/connectionless_sendto.sh
// showing a sender and a remote listener
// the only link between them is either an AF_LOCAL address
// or an INET address with a port number

#include <sys/socket.h>
#include <sys/un.h>
#include <sys/types.h>

#include <string.h>

int main() {
    struct sockaddr_un addr;
    addr.sun_family = PF_LOCAL;
    const char* path = "/tmp/thereisacow";
    memset(addr.sun_path, (int)path, strlen(path));
    int addr_len = (int)SUN_LEN(&addr);

    const char* message = "iddqd";
    int message_len = (int)strlen(message);

    return 0;
}


