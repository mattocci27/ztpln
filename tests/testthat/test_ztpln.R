test_that("pztpln", {
  set.seed(123)
  cdf1 <- pztpln(5, 3, 2)
  cdf1_raw <- sum(dztpln(1:5, 3, 2))
  expect_equal(cdf1, cdf1_raw)

  cdf2 <- pztpln(5, 3, 2, type1 = FALSE)
  cdf2_raw <- sum(dztpln(1:5, 3, 2, type1 = FALSE))
  expect_equal(cdf2, cdf2_raw)
})

test_that("dztpln type 1 matches numerical integration", {

  my_dpoilog <- function(x, k, mu, sig) {
    dpois(k, x) * dlnorm(x, mu, sig)
  }
  p0 <- integrate(my_dpoilog, 0, 3, 2, lower = 0, upper = 20)$value
  p5 <- integrate(my_dpoilog, 5, 3, 2, lower = 0, upper = 1e+3)$value
  expect_equal(dztpln(5, 3, 2), p5 / (1 - p0), tolerance = 1e-6)
})

test_that("dztpln type 2 matches numerical integration", {
  my_dpoilog2 <- function(x, k, mu, sig) {
    dpois(k, x) / (1 - dpois(0, x)) * dlnorm(x, mu, sig)
  }
  p <- integrate(my_dpoilog2, 5, 3, 2, lower = 0, upper = 1e+3)$value
  expect_equal(dztpln(5, 3, 2, type1 = FALSE), p, tolerance = 1e-6)
})

test_that("dztpln sums to approximately 1", {
  # Type 1
  sum1 <- sum(dztpln(1:10000, mu = 3, sig = 2, type1 = TRUE))
  expect_true(sum1 > 0.99 && sum1 <= 1)


  # Type 2
  sum2 <- sum(dztpln(1:10000, mu = 3, sig = 2, type1 = FALSE))
  expect_true(sum2 > 0.99 && sum2 <= 1)
})

test_that("dztpln returns positive values for positive integers", {
  lik1 <- dztpln(1:10, mu = 2, sig = 1, type1 = TRUE)
  expect_true(all(lik1 > 0))

  lik2 <- dztpln(1:10, mu = 2, sig = 1, type1 = FALSE)
  expect_true(all(lik2 > 0))
})

test_that("dztpln log argument works correctly", {
  lik <- dztpln(5, mu = 2, sig = 1)
  log_lik <- dztpln(5, mu = 2, sig = 1, log = TRUE)
  expect_equal(log(lik), log_lik)
})

test_that("rztpln generates positive integers", {
  set.seed(123)
  samples1 <- rztpln(100, mu = 2, sig = 1, type1 = TRUE)
  expect_true(all(samples1 >= 1))
  expect_true(all(samples1 == floor(samples1)))

  samples2 <- rztpln(100, mu = 2, sig = 1, type1 = FALSE)
  expect_true(all(samples2 >= 1))
  expect_true(all(samples2 == floor(samples2)))
})

test_that("rztpln returns correct number of samples", {
  set.seed(123)
  n <- 50
  samples <- rztpln(n, mu = 2, sig = 1)
  expect_length(samples, n)
})

test_that("dztplnm is weighted sum of dztpln", {
  mu <- c(1, 5)
  sig <- c(0.5, 1)
  theta <- c(0.3, 0.7)
  x <- 1:10

  # Manual calculation
  manual <- theta[1] * dztpln(x, mu[1], sig[1]) +
            theta[2] * dztpln(x, mu[2], sig[2])

  # Function output
  result <- dztplnm(x, mu, sig, theta)

  expect_equal(result, manual)
})

test_that("dztplnm sums to approximately 1", {
  mu <- c(1, 5)
  sig <- c(0.5, 1)
  theta <- c(0.3, 0.7)

  sum1 <- sum(dztplnm(1:10000, mu, sig, theta, type1 = TRUE))
  expect_true(sum1 > 0.99 && sum1 <= 1)

  sum2 <- sum(dztplnm(1:10000, mu, sig, theta, type1 = FALSE))
  expect_true(sum2 > 0.99 && sum2 <= 1)
})

test_that("rztplnm generates positive integers", {
  set.seed(123)
  mu <- c(1, 5)
  sig <- c(0.5, 1)
  theta <- c(0.3, 0.7)

  samples <- rztplnm(100, mu, sig, theta)
  expect_true(all(samples >= 1))
  expect_true(all(samples == floor(samples)))
})

test_that("ztplnMLE converges for simple data", {
  set.seed(123)
  true_mu <- 2
  true_sig <- 1
  y <- rztpln(100, mu = true_mu, sig = true_sig, type1 = TRUE)

  fit <- ztplnMLE(y, type1 = TRUE)

  expect_equal(fit$convergence, 0)
  expect_true(abs(fit$mu - true_mu) < 1)
  expect_true(abs(fit$sig - true_sig) < 1)
})

test_that("ztplnMLE works for type2", {
  set.seed(456)
  true_mu <- 3
  true_sig <- 1.5
  y <- rztpln(100, mu = true_mu, sig = true_sig, type1 = FALSE)

  fit <- ztplnMLE(y, type1 = FALSE)

  expect_equal(fit$convergence, 0)
})

test_that("type2 has higher density for small k compared to type1", {
  # This is a key property from the vignette
  lik1 <- dztpln(1, mu = 3, sig = 2, type1 = TRUE)
  lik2 <- dztpln(1, mu = 3, sig = 2, type1 = FALSE)
  expect_true(lik2 > lik1)
})

test_that("dztpln handles edge cases", {
  # Very small sigma

  lik <- dztpln(5, mu = 2, sig = 0.1)
  expect_true(is.finite(lik))
  expect_true(lik > 0)

  # Larger values of k
  lik_large <- dztpln(100, mu = 3, sig = 2)
  expect_true(is.finite(lik_large))
  expect_true(lik_large >= 0)
})
