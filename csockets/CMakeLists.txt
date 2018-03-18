cmake_minimum_required(VERSION 3.5.0)

project(csockets)

enable_testing()
include(tinyCUnit.cmake)

# bad
set(CMAKE_C_FLAGS "-Wno-implicit-function-declaration")

add_tinytest_executable(test_createSocket tests/chapter1/createSocket.c)
add_test(NAME chapter1::createSocket COMMAND test_createSocket)

add_tinytest_executable(test_createSocketAddress tests/chapter2/createSocketAddress.c)
add_test(NAME chapter2::createSocketAddress COMMAND test_createSocketAddress)

add_tinytest_executable(test_classifyIPAddresses tests/chapter3/classifyIPAddresses.c)
add_test(NAME chapter3::classifyIPAddresses COMMAND test_classifyIPAddresses)

add_tinytest_executable(test_socketTypes tests/chapter4/socketTypes.c)
add_test(NAME chapter4::socketTypes COMMAND test_socketTypes)

add_tinytest_executable(test_bindAddressToSocket tests/chapter5/bindAddressToSocket.c)
add_test(NAME chapter5::bindAddressToSocket COMMAND test_bindAddressToSocket)

add_tinytest_executable(test_datagrams tests/chapter6/datagrams.c)
add_test(NAME chapter6::datagrams COMMAND test_datagrams)


