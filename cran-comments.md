* Removed `CXX_STD = CXX11` from `src/Makevars` and `src/Makevars.win`, letting the package build with the default C++17 toolchain per the CRAN note.
It has no user facing changes.

# Test environments

* ubuntu 22.04, r-oldrel, r-devel, r-release, GCC
* macOS 10.16+, Apple Silicon, r-release, clang
* Windows Server 2019, r-devel, r-release, r-oldrel, 32/64 bit
