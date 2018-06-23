#!/usr/bin/env bash

# I wanted something similar to:
# go run $FILE.go
# dotnet run $FILE.cs
# to automate the building and running of a single c program

WHICH=/bin/which
CC=cc
CXX=c++
LANG=
WORKSPACE=/tmp/ticc
OUT_FILE=${WORKSPACE}/_
FLAGS=
CC_FLAGS="-Wall -Werror"
CXX_FLAGS="-Wall -Werror -std=c++11"

APP=
APP_ARGS=

setUp() {
    ls ${WHICH} >/dev/null 2>&1
    ${WHICH} ${CC} >/dev/null 2>&1
    ${WHICH} ${CXX} >/dev/null 2>&1
    rm -rf ${WORKSPACE}
    mkdir -p ${WORKSPACE}
}

# $1: source file path
identifySourceLang() {
    local ext=

    ext=$( echo ${1} | grep -Po '\.c$' )
    if [[ "${ext}" == ".c" ]]
    then
        LANG=${CC}
        FLAGS="${CC_FLAGS} ${FLAGS}"
        return 0
    fi

    ext=$( echo ${1} | grep -P '(\.cc|\.cpp|\.cxx)$' )
    if [[ "${ext}" != "" ]]
    then
        LANG=${CXX}
        FLAGS="${CXX_FLAGS} ${FLAGS}"
        return 0
    fi

    echo "can not identify source language!"
    echo "$1"
    exit 1
}

# $@: APP_ARGS
buildProgram() {
    identifySourceLang $1
    ${LANG} $1 ${FLAGS} -o ${OUT_FILE}
}

runProgram() {
    ${OUT_FILE}
}

# $@: OUT_FILE APP_ARGS
#              SOURCE_FILE ACTUAL_ARGS
# need to skip SOURCE_FILE
disassemble() {
    local exe=${1:?"missing binary path!"}
    shift 1  # skip exe
    shift 1  # skip src
    local func=${1:-main}
    gdb -batch \
    -ex "set disassembly-flavor intel" \
    -ex "file ${exe}" \
    -ex "disassemble /rs ${func}"
}

tearDown() {
    :
}

parseArgs() {
    if [[ "${1}" != "--" ]]; then
        APP=${1}
        shift 1
    fi
    while [[ ${#} -gt 0 ]]; do
        if [[ "${1}" == "--" ]]; then
            break
        fi
        APP_ARGS="${APP_ARGS} ${1}"
        shift 1
    done
    if [[ ${#} -gt 0 ]]; then
        shift
        FLAGS=${@}
    fi
}

validate() {
    if [[ "${APP}" == "" ]]; then
        echo "missing app name"
        exit 1
    fi
}

runApp() {
    case ${APP} in
        "run")
            buildProgram ${APP_ARGS} && runProgram ${APP_ARGS}
            return 0
            ;;
        "dasm")
            FLAGS="-g ${FLAGS}"
            buildProgram ${APP_ARGS} && disassemble ${OUT_FILE} ${APP_ARGS}
            return 0
            ;;
    esac
    echo "unsupported app: ${APP}"
    exit 1
}

setUp
parseArgs $@
validate
runApp
tearDown
