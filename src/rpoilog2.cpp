#include <Rcpp.h>
#include <Rmath.h>
using namespace Rcpp;

// [[Rcpp::export]]
int rztpois(double lambda){
  double k;
  k = 1;
  double t, s, u;
  t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
  s = t;
  u = R::runif(0, 1);
  double m[4] = {2.0, 1.414, 1.189, 1.09};
  for ( int i = 0; i < 4; i++) {
    while (s < u){
      k *=  m[i];
      t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
      s = t;
    }
    k = ceil(k / m[i]);
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  }
  while (s < u){
    k += 100;
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  }
    k = k - 100; 
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  while (s < u){
    k += 1;
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  }
  return k;
}

// [[Rcpp::export]]
int rpoilog_tmp(double mu, double sigma){
  double k, t, s, u, tau, lambda;
  tau = R::rnorm(0, 1);
  lambda = exp(mu + tau * sigma);
  k = 1;
  t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
  s = t;
  u = R::runif(0, 1);
  double m[4] = {2.0, 1.414, 1.189, 1.09};
  for ( int i = 0; i < 4; i++) {
    while (s < u){
      k *= m[i];
      t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
      s = t;
    }
    k = ceil(k / m[i]);
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  }
  while (s < u){
    k += 100;
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  }
    k = k - 100; 
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  while (s < u){
    k += 1;
    t = (R::ppois(k, lambda, 1, 0) - exp(-lambda)) / (1 - exp(-lambda));
    s = t;
  }
  return k;
}

// [[Rcpp::export]]
Rcpp::IntegerVector rztpln(int n, double mu, double sigma){
  Rcpp::IntegerVector pois(n);
  for ( int i = 0; i < n; i++) {
    pois[i]  = rpoilog_tmp(mu, sigma);
  }
  return pois;
}
