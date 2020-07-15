# Zero Truncated Poisson Lognormal Distribution

[![Build Status](https://travis-ci.org/mattocci27/ztpln.svg)](https://travis-ci.org/mattocci27/ztpln)

The type 1 zero truncated Poisson lognormal distribution uses the
conditional probability distribution of Poisson lognormal and the type 2 zero truncated Poisson lognormal distribution uses the zero truncated Poisson distribution. Please see `vignette("ztpln")` for details.

````r
devtools::install_github("mattocci27/ztpln")
````

## Functions

- `dztpln(x, mu, sig, log = FALSE, type1 = TRUE)`: gives the (log) density of a zero truncated poisson lognormal
  distribution
- `rztpln(n, mu, sig, type1 = TRUE)`: random draw from a zero truncated poisson lognormal
  distribution
- `dztplnm(x, mu, sig, theta, log = FALSE, type1 = TRUE)`: gives the (log) density of a zero truncated poisson
  lognormal distribution mixture.
- `ztplnm(n, mu, sig, theta, type1 = TRUE)`: random draw from a zero truncated poisson
  lognormal distribution mixture.


## Examples

````r
set.seed(123)
rztpln(n = 10, mu = 1, sig = 2)
#> [1]  21   3   2   4  25   2  15   6   2 102

rztpln(n = 10, mu = 1, sig = 2, type1 = FALSE)
#> [1]  1 21  3  2  4 25  3 15  6  2

rztpln(n = 10, mu = 6, sig = 4)
#> [1]  41 46771   538   259  2486 67209    78  3167  2009  1012
````

## Reference

Bulmer, M. G. 1974. On Fitting the Poisson Lognormal Distribution to Species-Abundance Data. Biometrics 30:101-110. [doi:10.2307/2529621](https://www.jstor.org/stable/2529621?origin=crossref&seq=1#metadata_info_tab_contents)

Inouye, D., E. Yang, G. Allen, and P. Ravikumar. 2017. A Review of Multivariate Distributions for Count Data Derived from the Poisson Distribution. Wiley interdisciplinary reviews. Computational statistics 9:e1398.[doi:10.1002/wics.1398](https://onlinelibrary.wiley.com/doi/full/10.1002/wics.1398)
