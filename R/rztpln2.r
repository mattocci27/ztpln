# random draw from PLN2(mu1, sigma1, mu2, sigma2, theta)

rztpln2 <- function(S, mu1, sigma1, mu2, sigma2, theta) {
  # theta: mixture weight for the first compoment
  z <- rbinom(S, 1, 1 - theta) + 1
  sigma <- c(sigma1, sigma2)
  mu <- c(mu1, mu2)
  tau <- rnorm(S) # random variable ~ N(0,1)
  lambda <- exp(sigma[z] * tau + mu[z])
  x <- map_dbl(lambda, rztpois)
  return(x)
}
