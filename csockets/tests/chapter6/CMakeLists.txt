add_executable(chapter6_datagrams datagrams.c)
add_test(NAME chapter6::datagrams COMMAND chapter6_datagrams)

add_executable(chapter6_connectionless_sendto
    connectionless_sendto.c)
add_test(
    NAME chapter6::connectionless::sendto
    COMMAND chapter6_connectionless_sendto
)