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


