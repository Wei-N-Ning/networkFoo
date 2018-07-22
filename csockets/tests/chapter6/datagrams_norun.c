
#include <stdlib.h>
#include <sys/types.h>
#include <sys/socket.h>
#include <arpa/inet.h>

// Linux Socket By Example P163
//
// Finally there is the issue of datagram size.
// The theoretical maximum size of a UDP datagram is slightly less than 64KB.
// However many UNIX hosts will only support a maximum near 32KB.
//
// # NOTE {
// For comparison, here is the size of a json blob:
// oz app dump --av=athenaPlugins-1.13.1 | wc -c
// 3865 (bytes) ~ 3KB
// }
//
// this limitation is also mentioned in wt's instrumentation which uses
// much larger json blobs;

// The practical limit for the data length which is imposed by the
// underlying IPv4 protocol
// is 65,507 bytes (65,535 − 8 byte UDP header − 20 byte IP)
// from http://en.wikipedia.org/wiki/User_Datagram_Protocol

// recall that most logs on kibana have short message body
//

int main(int argc, char **argv) {
    return 0;
}


