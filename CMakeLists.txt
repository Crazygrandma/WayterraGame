cmake_minimum_required(VERSION 3.28)
project(Wayterra VERSION 1.0 LANGUAGES C)

# Download SDL3 automatically so no system-wide SDL install is needed.
include(FetchContent)

set(SDL_SHARED OFF CACHE BOOL "" FORCE)
set(SDL_STATIC ON CACHE BOOL "" FORCE)
set(SDL_TEST_LIBRARY OFF CACHE BOOL "" FORCE)

FetchContent_Declare(
    SDL3
    GIT_REPOSITORY https://github.com/libsdl-org/SDL.git
    GIT_TAG release-3.4.20
    GIT_SHALLOW TRUE
)
FetchContent_MakeAvailable(SDL3)

add_executable(Wayterra WIN32 game.c) # WIN32 = GUI-subsystem, no console window
target_link_libraries(Wayterra PRIVATE SDL3::SDL3-static)
target_compile_options(Wayterra PRIVATE -O2)
target_compile_definitions(Wayterra PRIVATE SDL_MAIN_USE_CALLBACKS=1)

if(MINGW)
    # Fully static runtime -> a single .exe with zero DLL dependencies.
    target_link_options(Wayterra PRIVATE -static -static-libgcc -mwindows)
endif()
