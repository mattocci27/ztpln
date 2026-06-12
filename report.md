# Comparison Report: dev branch vs master branch

## Summary

This report compares the `dev` branch against the `master` branch. The dev branch contains **16 commits** ahead of master with significant changes across **21 files**, resulting in **+1,314 insertions** and **-324 deletions**.

## Commits in dev (not in master)

| Commit | Message |
|--------|---------|
| 1b25ed2 | test |
| 6fe1cc3 | test |
| ed8bcf4 | test |
| 37532ea | test |
| 7204384 | test |
| 2aa9c20 | test |
| 1f1da7e | update workflow |
| 36b935b | update workflow |
| fcf8153 | use exp(-lambda) |
| 8ff1ecf | change upper and lower boundary for type2 |
| 93d90b0 | update Roxygen |
| c4cde9c | add ppoilog description |
| b5e5ac2 | add testthat for pztpln |
| 64343e7 | add pztpln (not tested) |
| a99f57b | Delete dztpln.r |
| dbad86d | update file names |

## Key Changes

### 1. New Feature: `pztpln` Function

A new cumulative distribution function `pztpln` has been added to the package:

- **R implementation** ([R/dztpln.R](R/dztpln.R)): New exported function `pztpln()` for computing the CDF of the zero-truncated Poisson lognormal distribution
- **C++ implementation** ([src/dztpln.cpp](src/dztpln.cpp)): New `do_pztpln()` function added
- **Documentation** ([man/dztpln.Rd](man/dztpln.Rd)): Updated to include `pztpln` documentation
- **NAMESPACE**: New export added for `pztpln`

### 2. Algorithm Improvements in C++ Code

Significant changes to [src/dztpln.cpp](src/dztpln.cpp):

- Added new functions `maxf2()`, `upper2()`, and `lower2()` for improved boundary calculations for type2 ZTPLN
- Changed from `log(exp(z2) - 1)` to `log(1 - exp(-exp(z)))` for better numerical stability
- Simplified `do_dpln2()` function by removing the `check_diff` workaround
- Code reformatting and style improvements

### 3. GitHub Actions Workflow Changes

The [.github/workflows/R-CMD-check.yml](.github/workflows/R-CMD-check.yml) has been substantially modified:

- Changed trigger branches from `master/fix` to `dev`
- Updated to use `ubuntu-latest` instead of `ubuntu-22.04`
- Simplified workflow using `r-lib/actions/setup-r-dependencies@v2` and `r-lib/actions/check-r-package@v2`
- Downgraded `actions/checkout` from v4 to v2
- Added `n1hility/cancel-previous-runs@v2` for canceling previous workflow runs

### 4. Package Metadata Changes

In [DESCRIPTION](DESCRIPTION):

- Version remains at `0.1.2` (dev) vs `0.1.3` (master)
- Date is `2021-10-09` (dev) vs `2025-11-28` (master)
- Author format differs: dev uses older `Author`/`Maintainer` fields vs modern `Authors@R`
- RoxygenNote: `7.2.0` (dev) vs `7.3.2` (master)

### 5. Build Configuration

In [src/Makevars](src/Makevars) and [src/Makevars.win](src/Makevars.win):

- dev branch explicitly sets `CXX_STD = CXX11`
- master branch removed this (using default C++17 per CRAN requirements)

### 6. Test Suite Changes

The [tests/testthat/test_ztpln.R](tests/testthat/test_ztpln.R) has been completely rewritten:

- Master has extensive manual test scripts (95 lines)
- Dev has proper `testthat` unit tests for `pztpln` function (27 lines)

### 7. Documentation Updates

- Fixed typo: "compund" to "compound" throughout documentation
- Fixed typo: "Trauncated" to "Truncated"
- Fixed typo: "natrual" to "natural"
- Fixed typo: "deviatoin" to "deviation"
- Added documentation for `pztpln` function parameters (`q`, `log_p`)

### 8. Other Changes

- Added [.travis.yml](.travis.yml): Travis CI configuration (legacy CI system)
- Added [build.Rmd](build.Rmd): Development/testing notebook (917 lines)
- Updated [.gitignore](.gitignore): Added `/doc/` and `/Meta/`
- Updated [cran-comments.md](cran-comments.md): Different test environment descriptions
- Code style fix in [R/ztplnmMLE.R](R/ztplnmMLE.R): Changed `inherits(fit0, "try-error")` to `class(fit0) == "try-error"`

## File Change Summary

| File | Changes |
|------|---------|
| .github/workflows/R-CMD-check.yml | 143 lines modified |
| .gitignore | 2 lines added |
| .travis.yml | 40 lines added (new file) |
| DESCRIPTION | 14 lines modified |
| NAMESPACE | 1 line added |
| R/RcppExports.R | 4 lines added |
| R/dztpln.R | 43 lines modified |
| R/dztplnm.R | 12 lines modified |
| R/ztplnMLE.R | 6 lines modified |
| R/ztplnmMLE.R | 8 lines modified |
| build.Rmd | 917 lines added (new file) |
| cran-comments.md | 9 lines modified |
| man/dztpln.Rd | 13 lines modified |
| man/dztplnm.Rd | 2 lines modified |
| man/ztplnMLE.Rd | 4 lines modified |
| src/Makevars | 2 lines added |
| src/Makevars.win | 2 lines added |
| src/RcppExports.cpp | 14 lines added |
| src/dztpln.cpp | 271 lines modified |
| tests/testthat/test_ztpln.R | 122 lines modified |
| vignettes/ztpln.Rmd | 9 lines modified |

## Recommendations

1. **Version alignment**: The dev branch has an older version number (0.1.2) compared to master (0.1.3). This should be addressed before merging.

2. **C++ standard**: The dev branch uses C++11 explicitly while master uses the default (C++17). Consider which is appropriate for CRAN submission.

3. **CI/CD**: The dev branch workflow targets the `dev` branch. Update the workflow to include `master` if merging.

4. **Test coverage**: The new `pztpln` function has tests, but the overall test file was significantly reduced. Ensure adequate test coverage is maintained.

5. **build.Rmd**: This appears to be a development notebook and should likely be added to `.Rbuildignore` or removed before CRAN submission.

6. **Travis CI**: The `.travis.yml` file is for a deprecated CI service. Consider removing it in favor of GitHub Actions.
