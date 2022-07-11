test_that("pztpln", {
  set.seed(123)
  cdf1 <- pztpln(5, 3, 2)
  cdf1_raw <- sum(dztpln(1:5, 3, 2))
  expect_equal(cdf1, cdf1_raw)

  cdf2 <- pztpln(5, 3, 2, type1 = FALSE)
  cdf2_raw <- sum(dztpln(1:5, 3, 2, type1 = FALSE))
  expect_equal(cdf2, cdf2_raw)
})

test_that("dztpln type 1", {
  my_dpoilog <- function(x, k, mu, sig) {
    dpois(k, x) * dlnorm(x, mu, sig)
  }
  p0 <- integrate(my_dpoilog, 0, 3, 2, lower = 0, upper = 20)$value
  p5 <- integrate(my_dpoilog, 5, 3, 2, lower = 0, upper = 1e+3)$value
  expect_equal(dztpln(5, 3, 2), p5 / (1 - p0), tolerance = 1e-8)
})

test_that("dztpln type 2", {
  my_dpoilog2 <- function(x, k, mu, sig) {
    dpois(k, x) / (1 - dpois(0, x)) * dlnorm(x, mu, sig)
  }
  p <- integrate(my_dpoilog2, 5, 3, 2, lower = 0, upper = 1e+3)$value
  expect_equal(dztpln(5, 3, 2, type1 = FALSE), p, tolerance = 1e-8)
})
