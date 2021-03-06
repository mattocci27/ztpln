% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ztplnmMLE.r
\name{ztplnmMLE}
\alias{ztplnmMLE}
\title{MLE for the Zero-truncated Poisson Lognormal mixture distribtuion}
\usage{
ztplnmMLE(
  n,
  K = 2,
  lower_mu = rep(0, K),
  upper_mu = rep(log(max(n)), K),
  lower_sig = rep(0.001, K),
  upper_sig = rep(10, K),
  lower_theta = rep(0.001, K),
  upper_theta = rep(0.999, K),
  type1 = TRUE,
  message = FALSE
)
}
\arguments{
\item{n}{a vector of counts}

\item{K}{number of components}

\item{lower_mu, upper_mu}{numeric values of lower and upper bounds for mean of
the variables's natural logarithm.}

\item{lower_sig, upper_sig}{numeric values of lower and upper bounds for
standard deviation of the variables's natural logarithm}

\item{lower_theta, upper_theta}{numeric values of lower and upper bounds for
mixture weights.}

\item{type1}{logical; if TRUE, Use type 1 ztpln else use type 2.}

\item{message}{mean of lognormal distribution in sample 3.}
}
\value{
\item{convergence}{An integer code. 0 indicates successful
convergence.}

\item{iterations}{Number of iterations performed.}

\item{message}{A character string giving any additional information
returned by the optimizer, or NULL. For details, see PORT documentation.}

\item{evaluation}{Number of objective function and gradient function
evaluations}

\item{mu}{Maximum likelihood estimates of mu}

\item{sig}{Maximum likelihood estimates of sig}

\item{theta}{Maximum likelihood estimates of theta}

\item{loglik}{loglikelihood}
}
\description{
\code{ztplnmMLE} fits the Zero-truncated Poisson lognormal mixture distribution
to data and estimates parameters mean \code{mu}, standard deviation \code{sig} and
mixture weight \code{theta} in the lognormal distribution.
}
\details{
The function searches the maximum likelihood estimators of mean vector \code{mu},
standard deviation vector \code{sig} and mixture weight vector \code{theta} using the
optimization procedures in \code{\link{nlminb}}.
}
\examples{
y <- rztplnm(100, c(1, 10), c(2, 1), c(0.2, 0.8))
ztplnmMLE(y)
}
