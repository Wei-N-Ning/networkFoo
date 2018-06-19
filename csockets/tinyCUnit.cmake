
function(make_automain_exe)
    get_filename_component(automainExeDir ${CMAKE_CURRENT_LIST_FILE} DIRECTORY)
    file(COPY ${automainExeDir}/automain.py
        DESTINATION ${PROJECT_BINARY_DIR}
        FILE_PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE)
    if (NOT EXISTS ${automainExeDir}/automain.py)
        message(FATAL_ERROR "failed to create automain executable")
    endif()
endfunction()

make_automain_exe()

function(add_tinytest_executable targetName sourcePath)
    if (IS_ABSOLUTE ${sourcePath})
        set(sourcePathAbs ${sourcePath})
    else()
        set(sourcePathAbs ${CMAKE_CURRENT_SOURCE_DIR}/${sourcePath})
    endif()
    get_filename_component(automainExtension ${sourcePath} EXT)
    set(testRunner ${CMAKE_BINARY_DIR}/${targetName}_automain${automainExtension})
    set(generator /usr/bin/env python ${PROJECT_BINARY_DIR}/automain.py)
    add_executable(${targetName} ${sourcePath} ${testRunner})
    add_custom_command(
        OUTPUT ${testRunner}
        COMMAND ${generator} ${sourcePathAbs} ${CMAKE_BINARY_DIR}/${targetName}_automain${automainExtension}
        DEPENDS ${sourcePath}
    )
endfunction()
