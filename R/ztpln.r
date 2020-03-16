#' The zero-truncated compund poisson-lognormal distributions and their
#' mixtures
#'
#' Functions for obtaining the density, random deviates and maximum likelihood
#' estimates of the zero-truncated Poisson lognormal distributions and their
#' mixtures.
#'
#' @author Masatoshi Katabuchi <mattocci27@gmail.com> 
#'
#' @references M. G. Bulmer. 1974. On Fitting the Poisson Lognormal Distribution to Species-Abundance Data. Biometrics 30: 101-110 [doi:10.2307/2529621](https://www.jstor.org/stable/2529621?origin=crossref&seq=1#metadata_info_tab_contents)
#'
#' @keywords internal
"_PACKAGE"

#' @import Rcpp
#' @import RcppEigen
#' @import RcppNumerical
#' @import stats
#' @useDynLib ztpln, .registration=TRUE
NULL
