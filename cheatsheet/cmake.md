# CMake Cheatsheet

Cross-platform build system generator. CMake generates native build files (Makefiles, Ninja, etc.) from `CMakeLists.txt`.

---

## Workflow

```bash
# 1. Configure (generate build files)
cmake -B build -S .

# 2. Build
cmake --build build

# 3. Install (optional)
cmake --install build
```

## Configure

```bash
cmake -B build                       # configure into build/ dir (source = .)
cmake -B build -S src                # explicit source directory
cmake -B build -G Ninja              # use Ninja generator
cmake -B build -G "Unix Makefiles"   # use Make generator
cmake -B build -DCMAKE_BUILD_TYPE=Release    # set build type
cmake -B build -DCMAKE_INSTALL_PREFIX=/usr/local  # install prefix
cmake -B build -DBUILD_SHARED_LIBS=ON        # build shared libraries
cmake -B build -DCMAKE_EXPORT_COMPILE_COMMANDS=ON  # for LSP/clangd
```

### Common `-D` Variables

| Variable | Description |
|----------|-------------|
| `CMAKE_BUILD_TYPE` | `Debug`, `Release`, `RelWithDebInfo`, `MinSizeRel` |
| `CMAKE_INSTALL_PREFIX` | Install destination (default `/usr/local`) |
| `CMAKE_C_COMPILER` | Path to C compiler |
| `CMAKE_CXX_COMPILER` | Path to C++ compiler |
| `CMAKE_C_FLAGS` | Additional C flags |
| `CMAKE_CXX_FLAGS` | Additional C++ flags |
| `CMAKE_PREFIX_PATH` | Search path for find_package |
| `CMAKE_TOOLCHAIN_FILE` | Toolchain file for cross-compiling |
| `CMAKE_EXPORT_COMPILE_COMMANDS` | Generate `compile_commands.json` |
| `BUILD_SHARED_LIBS` | Build shared instead of static libs |
| `BUILD_TESTING` | Enable/disable tests |
| `CMAKE_VERBOSE_MAKEFILE` | Verbose build output |

### Generators (`-G`)

| Generator | Description |
|-----------|-------------|
| `"Unix Makefiles"` | Default on Linux/macOS |
| `Ninja` | Fast parallel builds |
| `"Ninja Multi-Config"` | Ninja with multi-config support |
| `Xcode` | macOS Xcode projects |
| `"Visual Studio 17 2022"` | Windows MSVC |

## Build

```bash
cmake --build build                  # build all targets
cmake --build build --target myapp   # build specific target
cmake --build build --config Release # multi-config: select config
cmake --build build --parallel 8     # parallel build (8 jobs)
cmake --build build -j               # parallel (auto-detect cores)
cmake --build build --clean-first    # clean then build
cmake --build build --verbose        # verbose output
```

## Install

```bash
cmake --install build                # install
cmake --install build --prefix /opt  # override install prefix
cmake --install build --component dev  # install specific component
cmake --install build --strip        # strip binaries
```

## Testing (CTest)

```bash
cd build && ctest                    # run all tests
ctest --test-dir build               # specify build dir
ctest --test-dir build -j8           # parallel
ctest --test-dir build --output-on-failure  # show output on fail
ctest --test-dir build -R "regex"    # run tests matching regex
ctest --test-dir build -E "regex"    # exclude tests matching regex
ctest --test-dir build -V            # verbose
ctest --test-dir build --rerun-failed  # rerun only failed tests
```

## Packaging (CPack)

```bash
cd build && cpack                    # create package
cpack -G TGZ                        # tar.gz package
cpack -G DEB                        # Debian package
cpack -G RPM                        # RPM package
cpack -G ZIP                        # ZIP archive
```

## CMakeLists.txt Basics

### Minimal Project

```cmake
cmake_minimum_required(VERSION 3.20)
project(MyProject VERSION 1.0 LANGUAGES CXX)

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

add_executable(myapp src/main.cpp src/util.cpp)
```

### Library

```cmake
add_library(mylib src/lib.cpp)
add_library(mylib_static STATIC src/lib.cpp)
add_library(mylib_shared SHARED src/lib.cpp)

# Header-only library
add_library(myheader INTERFACE)
target_include_directories(myheader INTERFACE include/)
```

### Linking

```cmake
target_link_libraries(myapp PRIVATE mylib)
target_link_libraries(myapp PUBLIC otherlib)
target_link_libraries(myapp INTERFACE headerlib)
```

| Scope | Description |
|-------|-------------|
| `PRIVATE` | Only for this target |
| `PUBLIC` | For this target and anything linking to it |
| `INTERFACE` | Only for things linking to this target |

### Include Directories

```cmake
target_include_directories(myapp PRIVATE ${CMAKE_SOURCE_DIR}/include)
target_include_directories(mylib PUBLIC include/)
```

### Find Dependencies

```cmake
find_package(Threads REQUIRED)
target_link_libraries(myapp PRIVATE Threads::Threads)

find_package(OpenSSL REQUIRED)
target_link_libraries(myapp PRIVATE OpenSSL::SSL OpenSSL::Crypto)

find_package(PkgConfig REQUIRED)
pkg_check_modules(LIBFOO REQUIRED libfoo)
target_link_libraries(myapp PRIVATE ${LIBFOO_LIBRARIES})
```

### FetchContent (download deps at configure time)

```cmake
include(FetchContent)

FetchContent_Declare(
  googletest
  GIT_REPOSITORY https://github.com/google/googletest.git
  GIT_TAG        v1.14.0
)
FetchContent_MakeAvailable(googletest)

target_link_libraries(mytest PRIVATE GTest::gtest_main)
```

### Compiler Options

```cmake
target_compile_options(myapp PRIVATE -Wall -Wextra -Wpedantic)
target_compile_definitions(myapp PRIVATE DEBUG_MODE=1)
target_compile_features(myapp PRIVATE cxx_std_20)
```

### Install Rules

```cmake
install(TARGETS myapp DESTINATION bin)
install(TARGETS mylib DESTINATION lib)
install(FILES include/mylib.h DESTINATION include)
install(DIRECTORY include/ DESTINATION include)
```

### Testing

```cmake
enable_testing()

add_executable(mytest tests/test_main.cpp)
target_link_libraries(mytest PRIVATE mylib GTest::gtest_main)

include(GoogleTest)
gtest_discover_tests(mytest)
```

### Conditionals and Options

```cmake
option(BUILD_TESTS "Build tests" ON)

if(BUILD_TESTS)
  add_subdirectory(tests)
endif()

if(CMAKE_BUILD_TYPE STREQUAL "Debug")
  target_compile_definitions(myapp PRIVATE DEBUG=1)
endif()

if(UNIX AND NOT APPLE)
  # Linux-specific
endif()
```

### Common Variables (read-only)

| Variable | Description |
|----------|-------------|
| `CMAKE_SOURCE_DIR` | Top-level source directory |
| `CMAKE_BINARY_DIR` | Top-level build directory |
| `CMAKE_CURRENT_SOURCE_DIR` | Current CMakeLists.txt directory |
| `CMAKE_CURRENT_BINARY_DIR` | Current build directory |
| `PROJECT_SOURCE_DIR` | Source dir of most recent project() |
| `PROJECT_NAME` | Name from project() |
| `PROJECT_VERSION` | Version from project() |
| `CMAKE_SYSTEM_NAME` | OS name (Linux, Darwin, Windows) |
| `CMAKE_SYSTEM_PROCESSOR` | CPU architecture |
| `CMAKE_SIZEOF_VOID_P` | Pointer size (4 or 8) |

## Presets (CMakePresets.json)

```json
{
  "version": 6,
  "configurePresets": [
    {
      "name": "release",
      "binaryDir": "build/release",
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Release"
      }
    },
    {
      "name": "debug",
      "binaryDir": "build/debug",
      "cacheVariables": {
        "CMAKE_BUILD_TYPE": "Debug",
        "CMAKE_EXPORT_COMPILE_COMMANDS": "ON"
      }
    }
  ],
  "buildPresets": [
    {
      "name": "release",
      "configurePreset": "release"
    }
  ]
}
```

```bash
cmake --preset release               # configure with preset
cmake --build --preset release       # build with preset
cmake --list-presets                  # list available presets
```
