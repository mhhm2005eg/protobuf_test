cmake_minimum_required(VERSION 2.8.9)
project (protobuf_test)
# Find required protobuf package
set (protobuf_repo "/home/medhat/Data/repository/protobuf")
set (protobuf_DIR "${protobuf_repo}/cmake/build/lib/cmake/protobuf")

find_package(protobuf CONFIG REQUIRED)

if(protobuf_VERBOSE)
  message(STATUS "Using Protocol Buffers ${Protobuf_VERSION}")
endif()


include_directories("./generated")
include_directories("${protobuf_repo}\\src")
include_directories("${protobuf_repo}\\src\\google\\protobuf\\stubs")

set(CMAKE_CXX_FLAGS "${CMAKE_CXX_FLAGS} -std=c++11 -g ")

if(MSVC AND protobuf_MSVC_STATIC_RUNTIME)
  foreach(flag_var
      CMAKE_CXX_FLAGS CMAKE_CXX_FLAGS_DEBUG CMAKE_CXX_FLAGS_RELEASE
      CMAKE_CXX_FLAGS_MINSIZEREL CMAKE_CXX_FLAGS_RELWITHDEBINFO)
    if(${flag_var} MATCHES "/MD")
      string(REGEX REPLACE "/MD" "/MT" ${flag_var} "${${flag_var}}")
    endif(${flag_var} MATCHES "/MD")
  endforeach()
endif()

set(CMAKE_ARCHIVE_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_LIBRARY_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/lib)
set(CMAKE_RUNTIME_OUTPUT_DIRECTORY ${CMAKE_BINARY_DIR}/bin)

add_executable(serializer sources/serializer.cpp generated/matrix.pb.cc)
target_link_libraries(serializer  protobuf::libprotoc protobuf::libprotobuf protobuf::libprotobuf-lite)

add_executable(deserializer sources/deserializer.cpp generated/matrix.pb.cc)
target_link_libraries(deserializer  protobuf::libprotoc protobuf::libprotobuf protobuf::libprotobuf-lite)
