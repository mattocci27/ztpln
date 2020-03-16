library(ztpln)

##
seed <- 123
set.seed(seed)
K <- 3
mu <- runif(K, 0, 15)
sig <- runif(K, 0, 2)
n <- 100

# random draw from dirichlet  distribution
theta0 <- rgamma(K, sample(1:3, K, replace = TRUE))
theta <- theta0 / sum(theta0)

mu
sig
theta

y <- rztplnm(n = 100, mu, sig, theta)
y

lik1 <- sum(dztplnm(y, mu, sig, theta, log = TRUE))

tmp <- NULL
for (k in 1:K) tmp <- cbind(tmp, theta[k] * dztpln(y, mu[k], sig[k]))
lik2 <- sum(log(apply(tmp, 1, sum)))

lik1 - lik2

ztplnmMLE(y, K = 3)
