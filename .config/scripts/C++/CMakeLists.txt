cmake_minimum_required(VERSION 3.10)
project(Image_Processor_Main)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_FLAGS "-O3 -march=native -flto -pipe")

find_package(OpenCV REQUIRED core imgproc imgcodecs)

add_executable(image_processor main.cpp)
target_link_libraries(image_processor ${OpenCV_LIBS})
