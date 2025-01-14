# sdl2 cmake project-config input for ./configure scripts

set(prefix "/Users/taxxodium/Documents/ExternalDev/marathon-ios/submodules/Libraries/SDL2-2.0.14/build-scripts/platform/arm64-ios") 
set(exec_prefix "${prefix}")
set(libdir "${exec_prefix}/lib")
set(SDL2_PREFIX "/Users/taxxodium/Documents/ExternalDev/marathon-ios/submodules/Libraries/SDL2-2.0.14/build-scripts/platform/arm64-ios")
set(SDL2_EXEC_PREFIX "/Users/taxxodium/Documents/ExternalDev/marathon-ios/submodules/Libraries/SDL2-2.0.14/build-scripts/platform/arm64-ios")
set(SDL2_LIBDIR "${exec_prefix}/lib")
set(SDL2_INCLUDE_DIRS "${prefix}/include/SDL2")
set(SDL2_LIBRARIES "-L${SDL2_LIBDIR}  -lSDL2")
string(STRIP "${SDL2_LIBRARIES}" SDL2_LIBRARIES)

if(NOT TARGET SDL2::SDL2)
  # Remove -lSDL2 as that is handled by CMake, note the space at the end so it does not replace e.g. -lSDL2main
  # This may require "libdir" beeing set (from above)
  string(REPLACE "-lSDL2 " "" SDL2_EXTRA_LINK_FLAGS " -lSDL2 ")
  string(STRIP "${SDL2_EXTRA_LINK_FLAGS}" SDL2_EXTRA_LINK_FLAGS)
  string(REPLACE "-lSDL2 " "" SDL2_EXTRA_LINK_FLAGS_STATIC " -lm -liconv  -lm -liconv -lobjc -Wl,-framework,AVFoundation -Wl,-framework,AudioToolbox -Wl,-framework,CoreAudio -Wl,-framework,CoreGraphics -Wl,-framework,CoreMotion -Wl,-framework,Foundation -Wl,-framework,GameController -Wl,-framework,OpenGLES -Wl,-framework,QuartzCore -Wl,-framework,UIKit ")
  string(STRIP "${SDL2_EXTRA_LINK_FLAGS_STATIC}" SDL2_EXTRA_LINK_FLAGS_STATIC)

  add_library(SDL2::SDL2 SHARED IMPORTED)
  set_target_properties(SDL2::SDL2 PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${prefix}/include/SDL2"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION "${exec_prefix}/lib/${CMAKE_SHARED_LIBRARY_PREFIX}SDL2${CMAKE_SHARED_LIBRARY_SUFFIX}"
    INTERFACE_LINK_LIBRARIES "${SDL2_EXTRA_LINK_FLAGS}")

  add_library(SDL2::SDL2-static STATIC IMPORTED)
  set_target_properties(SDL2::SDL2-static PROPERTIES
    INTERFACE_INCLUDE_DIRECTORIES "${prefix}/include/SDL2"
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION "${exec_prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}SDL2${CMAKE_STATIC_LIBRARY_SUFFIX}"
    INTERFACE_LINK_LIBRARIES "${SDL2_EXTRA_LINK_FLAGS_STATIC}")

  add_library(SDL2::SDL2main STATIC IMPORTED)
  set_target_properties(SDL2::SDL2main PROPERTIES
    IMPORTED_LINK_INTERFACE_LANGUAGES "C"
    IMPORTED_LOCATION "${exec_prefix}/lib/${CMAKE_STATIC_LIBRARY_PREFIX}SDL2main${CMAKE_STATIC_LIBRARY_SUFFIX}")
endif()
