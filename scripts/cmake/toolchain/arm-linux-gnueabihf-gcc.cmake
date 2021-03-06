if(CMAKE_INSTALL_PREFIX)
    set(ENV{CMAKE_INSTALL_PREFIX} "${CMAKE_INSTALL_PREFIX}")
else()
    set(CMAKE_INSTALL_PREFIX "$ENV{CMAKE_INSTALL_PREFIX}")
endif()

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_SYSTEM_PROCESSOR arm)
set(CROSS_COMPILE_TRIPLE arm-linux-gnueabihf)

string(CONCAT LD_FLAGS
    "-L${CMAKE_INSTALL_PREFIX}/lib "
    "--no-dynamic-linker "
    "-nostdlib "
    "-pie "
    "-static"
)

find_program(CMAKE_C_COMPILER ${CROSS_COMPILE_TRIPLE}-gcc)
if(NOT CMAKE_C_COMPILER)
    message(FATAL_ERROR "Unable to find ${CROSS_COMPILE_TRIPLE}-gcc")
else()
    set(CMAKE_CXX_COMPILER ${CMAKE_C_COMPILER})
endif()

find_program(AS_BIN ${CROSS_COMPILE_TRIPLE}-as)
if(NOT AS_BIN)
    message(FATAL_ERROR "Unable to find ${CROSS_COMPILE_TRIPLE}-as")
endif()

find_program(LD_BIN ${CROSS_COMPILE_TRIPLE}-ld)
if(NOT LD_BIN)
    message(FATAL_ERROR "Unable to find ${CROSS_COMPILE_TRIPLE}-ld")
endif()

find_program(LD_BIN ${CROSS_COMPILE_TRIPLE}-ld)
if(NOT LD_BIN)
    message(FATAL_ERROR "Unable to find ${CROSS_COMPILE_TRIPLE}-ld")
endif()

find_program(AR_BIN ${CROSS_COMPILE_TRIPLE}-ar)
if(NOT AR_BIN)
    message(FATAL_ERROR "Unable to find ${CROSS_COMPILE_TRIPLE}-ar")
endif()

find_program(OBJCOPY_BIN ${CROSS_COMPILE_TRIPLE}-objcopy)
if(NOT OBJCOPY_BIN)
    message(FATAL_ERROR "Unable to find ${TOOLCHAIN_TRIPLE}-objcopy")
endif()

set(CMAKE_C_ARCHIVE_CREATE
    "${AR_BIN} qc <TARGET> <OBJECTS>"
)

set(CMAKE_CXX_ARCHIVE_CREATE
    "${AR_BIN} qc <TARGET> <OBJECTS>"
)

set(CMAKE_C_LINK_EXECUTABLE
    "${LD_BIN} ${LD_FLAGS} <OBJECTS> -o <TARGET> <LINK_LIBRARIES> "
)

set(CMAKE_CXX_LINK_EXECUTABLE
    "${LD_BIN} ${LD_FLAGS} <OBJECTS> -o <TARGET> <LINK_LIBRARIES>"
)

set(CMAKE_C_CREATE_SHARED_LIBRARY
    "${LD_BIN} ${LD_FLAGS} -shared <OBJECTS> -o <TARGET>"
)

set(CMAKE_CXX_CREATE_SHARED_LIBRARY
    "${LD_BIN} ${LD_FLAGS} -shared <OBJECTS> -o <TARGET>"
)

set(CMAKE_C_COMPILER_WORKS 1)
set(CMAKE_CXX_COMPILER_WORKS 1)
