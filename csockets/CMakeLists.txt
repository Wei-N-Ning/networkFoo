cmake_minimum_required(VERSION 3.5.0)

project(csockets)

enable_testing()
include(tinyCUnit.cmake)

add_tinytest_executable(chapter1_createSocket tests/chapter1/createSocket.c)
add_test(NAME chapter1::createSocket COMMAND chapter1_createSocket)

add_executable(chapter1_simpleServerClient tests/chapter1/simpleServerClient.c)
add_test(NAME chapter1::simpleServerClient COMMAND chapter1_simpleServerClient)

add_tinytest_executable(chapter2_createSocketAddress tests/chapter2/createSocketAddress.c)
add_test(NAME chapter2::createSocketAddress COMMAND chapter2_createSocketAddress)

add_tinytest_executable(chapter3_classifyIPAddresses tests/chapter3/classifyIPAddresses.c)
add_test(NAME chapter3::classifyIPAddresses COMMAND chapter3_classifyIPAddresses)

add_tinytest_executable(chapter4_socketTypes tests/chapter4/socketTypes.c)
add_test(NAME chapter4::socketTypes COMMAND chapter4_socketTypes)

add_tinytest_executable(chapter5_bindAddressToSocket tests/chapter5/bindAddressToSocket.c)
add_test(NAME chapter5::bindAddressToSocket COMMAND chapter5_bindAddressToSocket)

add_tinytest_executable(chapter6_datagrams tests/chapter6/datagrams.c)
add_test(NAME chapter6::datagrams COMMAND chapter6_datagrams)


