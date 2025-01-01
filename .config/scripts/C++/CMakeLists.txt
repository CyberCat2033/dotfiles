cmake_minimum_required(VERSION 3.10)
project(extractor)

find_package(OpenCV REQUIRED)
# target_link_libraries(image_processor ${OpenCV_LIBS})
set(CMAKE_CXX_STANDARD 17)
find_package(OpenCV REQUIRED)
include_directories(${OpenCV_INCLUDE_DIRS})
add_executable(image_processor extractor.cpp)
