
add_tinytest_executable(
    chapter5_bindAddressToSocket
    bindAddressToSocket.c)
add_test(
    NAME chapter5::bindAddressToSocket
    COMMAND chapter5_bindAddressToSocket)

add_tinytest_executable(chapter5_getSocketAddress
    getSocketAddress.c)
add_test(
    NAME chapter5::getSocketAddress
    COMMAND chapter5_getSocketAddress
)

add_executable(chapter5_getPeerSocketAddress
    getPeerSocketAddress.c)
add_test(
    NAME chapter5::getPeerSocketAddress
    COMMAND chapter5_getPeerSocketAddress
)