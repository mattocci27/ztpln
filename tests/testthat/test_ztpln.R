library(testthat)
library(ztpln)

test_that("pztpln", {
  set.seed(123)
  cdf1 <- pztpln(5, 3, 2)
  cdf1_raw <- sum(dztpln(1:5, 3, 2))
  expect_equal(cdf1, cdf1_raw)

  cdf2 <- pztpln(5, 3, 2, type1 = FALSE)
  cdf2_raw <- sum(dztpln(1:5, 3, 2, type1 = FALSE))
  expect_equal(cdf2, cdf2_raw)
})
