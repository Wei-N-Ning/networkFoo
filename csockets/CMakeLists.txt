cmake_minimum_required(VERSION 3.5.0)

project(csockets)

enable_testing()
include(tinyCUnit.cmake)

add_tinytest_executable(test_createSocket tests/chapter1/createSocket.c)
add_test(NAME chapter1::createSocket COMMAND test_createSocket)



