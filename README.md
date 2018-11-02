# Zero Truncated Poisson Lognormal Distribution

**DISCLAIMER**: This is an experimental R pacakge to generate Zero Truncated Poisson Lognormal Distribution. There are no help pages at the moment. Please be careful when you run the code.

````r
devtools::install_github("mattocci27/poilog2")
````

## Functions
- ztpln(n, mu, sigma): random draw from a zero truncated poisson lognormal distribution
- ztpln2(n, mu1, sigma1, mu2, sigma2, theta): random draw from a zero truncated poisson lognormal distribution mixture $\theta \mathcal{PLN}(\mu_1, \sigma_1) + (1 -\theta) \mathcal{PLN}(\mu_1, \sigma_1)$, where $0 < \theta< 1$ is the mixture weight.

## Arguments
n: number of random values to return.  

mu, mu1, mu2, sigma, sigma1, sigma2: mean and standard deviation of the distribution on the log scale.

## Details

A compound Poisson-lognormal distribution is a Poisson probability distribution where its parameter λ is a random variable with lognormal distribution, that is to say logλ are normally distributed with mean μ and variance σ2 (Bulmer 1974). The density function is

<a href="https://www.codecogs.com/eqnedit.php?latex=\mathcal{PLN}&space;(k&space;;&space;\mu,&space;\sigma)&space;=&space;\int_0^\infty&space;{Pois}(k;&space;\lambda)&space;\times&space;\mathcal{N}(log\lambda;&space;\mu,&space;\sigma)&space;d\lambda&space;\\&space;=&space;\frac{1}{\sqrt{2\pi\sigma^2}k!}\int^\infty_0\lambda^{k-1}exp(-\lambda)exp(\frac{-(log\lambda-\mu)^2}{2\sigma^2})d\lambda,&space;\;&space;\text{where}&space;\;&space;k&space;=&space;0,&space;1,&space;2,&space;...&space;\;." target="_blank"><img src="https://latex.codecogs.com/svg.latex?\mathcal{PLN}&space;(k&space;;&space;\mu,&space;\sigma)&space;=&space;\int_0^\infty&space;{Pois}(k;&space;\lambda)&space;\times&space;\mathcal{N}(log\lambda;&space;\mu,&space;\sigma)&space;d\lambda&space;\\&space;=&space;\frac{1}{\sqrt{2\pi\sigma^2}k!}\int^\infty_0\lambda^{k-1}exp(-\lambda)exp(\frac{-(log\lambda-\mu)^2}{2\sigma^2})d\lambda,&space;\;&space;\text{where}&space;\;&space;k&space;=&space;0,&space;1,&space;2,&space;...&space;\;." title="\mathcal{PLN} (k ; \mu, \sigma) = \int_0^\infty {Pois}(k; \lambda) \times \mathcal{N}(log\lambda; \mu, \sigma) d\lambda \\ = \frac{1}{\sqrt{2\pi\sigma^2}k!}\int^\infty_0\lambda^{k-1}exp(-\lambda)exp(\frac{-(log\lambda-\mu)^2}{2\sigma^2})d\lambda, \; \text{where} \; k = 0, 1, 2, ... \;." /></a>


Thus, random sampling from PLN(n, mu, sig) will be:

````r
tau <- rnorm(n) # random variable ~ N(0,1)
lambda <- mu + tau * sig
rpois(exp(lambda))
````

The zero-truncated Poisson distribution can be derived from a Poisson distribution,

<a href="https://www.codecogs.com/eqnedit.php?latex=Pois_{ztm}(k&space;;&space;\lambda)&space;=&space;\frac{Pois(k&space;;&space;\lambda)}{1-Pois(0&space;;&space;\lambda)}&space;=&space;\frac{Pois(k&space;;&space;\lambda)}{1-e^{-\lambda}}" target="_blank"><img src="https://latex.codecogs.com/gif.latex?Pois_{ztm}(k&space;;&space;\lambda)&space;=&space;\frac{Pois(k&space;;&space;\lambda)}{1-Pois(0&space;;&space;\lambda)}&space;=&space;\frac{Pois(k&space;;&space;\lambda)}{1-e^{-\lambda}}" title="Pois_{ztm}(k ; \lambda) = \frac{Pois(k ; \lambda)}{1-Pois(0 ; \lambda)} = \frac{Pois(k ; \lambda)}{1-e^{-\lambda}}" /></a>

<img src="https://latex.codecogs.com/svg.latex?Pois_{ztm}(k&space;;&space;\lambda)&space;=&space;\frac{Pois(k&space;;&space;\lambda)}{1-Pois(0&space;;&space;\lambda)}&space;=&space;\frac{Pois(k&space;;&space;\lambda)}{1-e^{-\lambda}}" title="Pois_{ztm}(k ; \lambda) = \frac{Pois(k ; \lambda)}{1-Pois(0 ; \lambda)} = \frac{Pois(k ; \lambda)}{1-e^{-\lambda}}" />


and the cumulative density is

$$
G(k; \lambda) = \int_k \frac{Pois(k ; \lambda)}{1-e^{-\lambda}}dk \\
=  \frac{1}{1-e^{-\lambda}}\int_k Pois(k ; \lambda)dk \\
=  \frac{e^{-\lambda}}{1-e^{-\lambda}} \sum_{i=1}^{k} \frac{\lambda^i}{i!} \\
=  \frac{1}{1-e^{-\lambda}} \bigl\{F(k; \lambda) - F(0; \lambda)\bigr\} \\
=  \frac{1}{1-e^{-\lambda}} \bigl\{F(k; \lambda) - e^{-\lambda}\bigr\}
$$


where $F(k;\lambda)$ is the cumulative density of a Poisson distribution such that $F(k;\lambda) = e^{-\lambda}\sum_{i=0}^{k} \frac{\lambda^i}{i!}$. Now we can generate random samples from a zero truncated Poisson lognormal distribution by inverse transform sampling with this cumulative distribution function of a zero-truncated Poisson.

## Examples

````r
set.seed(123)
rztpln(n = 10, mu = 0, sigma = 1)
#> [1] 1 1 1 1 1 1 2 6 2 1

rztpln(n = 10, mu = 6, sigma = 4)
#>  [1] 513162  10956   6632     20    155      5     24    208    714   6221

````

## Reference

M. G. Bulmer. 1974. On Fitting the Poisson Lognormal Distribution to Species-Abundance Data. Biometrics 30: 101-110 [doi:10.2307/2529621](https://www.jstor.org/stable/2529621?origin=crossref&seq=1#metadata_info_tab_contents)
