
function(add_tinytest_executable targetName sourcePath)
    if (IS_ABSOLUTE ${sourcePath})
        set(sourcePathAbs ${sourcePath})
    else()
        set(sourcePathAbs ${CMAKE_CURRENT_SOURCE_DIR}/${sourcePath})
    endif()
    get_filename_component(automainExtension ${sourcePath} EXT)
    set(testRunner ${CMAKE_BINARY_DIR}/${targetName}_automain${automainExtension})
    set(generator /usr/bin/env python ${CMAKE_CURRENT_LIST_DIR}/testRunnerGenerator.py)
    add_executable(${targetName} ${sourcePath} ${testRunner})
    add_custom_command(
        OUTPUT ${testRunner}
        COMMAND ${generator} ${sourcePathAbs} ${CMAKE_BINARY_DIR}/${targetName}_automain${automainExtension}
    )
endfunction()