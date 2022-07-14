/*
Grøtan Grotan and Steinar Engen 2007
Masatoshi Katabuchi 2020
*/

#include <RcppEigen.h>
#include <RcppNumerical.h>
#include <Rmath.h>
using namespace Numer;

double maxf(int x, double mu, double sig) {
  double d, z;
  z = 0;
  d = 100;
  while (d > 0.00001) {
    if (x - 1 - exp(z) - 1 / sig * (z - mu) > 0)
      z = z + d;
    else
      z = z - d;
    d = d / 2;
  }
  return (z);
};

double upper(int x, double m, double mu, double sig) {
  double d, z, mf;
  mf = (x - 1) * m - exp(m) - 0.5 / sig * ((m - mu) * (m - mu));
  z = m + 20;
  d = 10;
  while (d > 0.000001) {
    if ((x - 1) * z - exp(z) - 0.5 / sig * ((z - mu) * (z - mu)) - mf +
            log(1000000.0) >
        0)
      z = z + d;
    else
      z = z - d;
    d = d / 2;
  }
  return (z);
};

/* ---------------------------------------------------------------------------*/

double lower(int x, double m, double mu, double sig) {
  double d, z, mf;
  mf = (x - 1) * m - exp(m) - 0.5 / sig * ((m - mu) * (m - mu));
  z = m - 20;
  d = 10;
  while (d > 0.000001) {
    if ((x - 1) * z - exp(z) - 0.5 / sig * ((z - mu) * (z - mu)) - mf +
            log(1000000.0) >
        0)
      z = z - d;
    else
      z = z + d;
    d = d / 2;
  }
  return (z);
};

double maxf2(int x, double mu, double sig) {
  double d, z;
  z = 0;
  d = 100;
  while (d > 0.00001) {
    if (x - 1 - exp(z) - log(1 - exp(-exp(z))) - 1 / sig * (z - mu) > 0)
      z = z + d;
    else
      z = z - d;
    d = d / 2;
  }
  return (z);
};

double upper2(int x, double m, double mu, double sig) {
  double d, z, mf;
  z = m + 20;
  d = 10;
  mf = (x - 1) * m - exp(z) - log(1 - exp(-exp(m))) - 0.5 / sig * ((m - mu) * (m - mu));
  while (d > 0.000001) {
    if ((x - 1) * z - exp(z) - log(1 - exp(-exp(z))) - 0.5 / sig * ((z - mu) * (z - mu)) - mf +
            log(1000000.0) >
        0)
      z = z + d;
    else
      z = z - d;
    d = d / 2;
  }
  return (z);
};

double lower2(int x, double m, double mu, double sig) {
  double d, z, mf;
  z = m - 20;
  d = 10;
  mf = (x - 1) * m - exp(z) - log(1 - exp(-exp(m))) - 0.5 / sig * ((m - mu) * (m - mu));
  while (d > 0.000001) {
    if ((x - 1) * z - exp(z) - log(1 - exp(-exp(z))) - 0.5 / sig * ((z - mu) * (z - mu)) - mf +
            log(1000000.0) >
        0)
      z = z - d;
    else
      z = z + d;
    d = d / 2;
  }
  return (z);
};

class plnintegrand : public Func {
private:
  int x;
  double mu;
  double sig;

public:
  plnintegrand(int x_, double mu_, double sig_) : x(x_), mu(mu_), sig(sig_) {}
  double operator()(const double &z) const {
    double fac;
    fac = std::lgamma(x + 1);
    return exp(z * x - exp(z) - 0.5 / sig * ((z - mu) * (z - mu)) - fac);
  }
};

class plnintegrand2 : public Func {
private:
  int x;
  double mu;
  double sig;

public:
  plnintegrand2(int x_, double mu_, double sig_) : x(x_), mu(mu_), sig(sig_) {}
  double operator()(const double &z) const {
    double fac;
    fac = std::lgamma(x + 1);
    return exp(z * x - exp(z) - log(1 - exp(-exp(z))) - 0.5 / sig * ((z - mu) * (z - mu)) -
               fac);
  }
};

Rcpp::NumericVector do_dpln(Rcpp::IntegerVector x, double mu, double sig) {
  int n = x.size();
  Rcpp::NumericVector out(n);
  double a, b, m;
  for (int i = 0; i < n; i++) {
    m = maxf(x[i], mu, sig);
    a = lower(x[i], m, mu, sig);
    b = upper(x[i], m, mu, sig);
    plnintegrand f(x[i], mu, sig);
    double err_est;
    int err_code;
    out[i] =
        integrate(f, a, b, err_est, err_code) * (1 / std::sqrt(2 * M_PI * sig));
  }
  return out;
}

Rcpp::NumericVector do_dpln2(Rcpp::IntegerVector x, double mu, double sig) {
  int n = x.size();
  Rcpp::NumericVector out(n);
  double a, b, m, a0, b0, m0;
  for (int i = 0; i < n; i++) {
    m = maxf(x[i], mu, sig);
    a = lower(x[i], m, mu, sig);
    b = upper(x[i], m, mu, sig);
    plnintegrand2 f2(x[i], mu, sig);
    double err_est;
    int err_code;
    out[i] = integrate(f2, a, b, err_est, err_code) *
             (1 / std::sqrt(2 * M_PI * sig));
  }
  return out;
}

// [[Rcpp::export]]
Rcpp::NumericVector do_dztpln(Rcpp::IntegerVector x, double mu, double sig) {
  int n = x.size();
  double sig2 = sig * sig;
  Rcpp::IntegerVector zero(1);
  Rcpp::NumericVector p(n), p00(1), p0(n), lik(n);
  p = do_dpln(x, mu, sig2);
  p00 = do_dpln(zero, mu, sig2);
  // p00 = do_dpln(0, mu, sig2);
  p0 = Rcpp::rep(p00, n);
  lik = p / (1.0 - p0);
  return lik;
}

// [[Rcpp::export]]
Rcpp::NumericVector do_dztpln2(Rcpp::IntegerVector x, double mu, double sig) {
  double sig2 = sig * sig;
  return do_dpln2(x, mu, sig2);
}

// [[Rcpp::export]]
Eigen::VectorXd do_dztplnm(Rcpp::IntegerVector x, Rcpp::NumericVector mu,
                           Rcpp::NumericVector sigma, Eigen::VectorXd theta) {
  Rcpp::NumericMatrix lik(x.size(), mu.size());
  for (int j = 0; j < mu.size(); j++) {
    lik.column(j) = do_dztpln(x, mu(j), sigma(j));
    ;
  }
  Eigen::Map<Eigen::MatrixXd> lik2(Rcpp::as<Eigen::Map<Eigen::MatrixXd>>(lik));
  return lik2 * theta;
}

// [[Rcpp::export]]
Eigen::VectorXd do_dztplnm2(Rcpp::IntegerVector x, Rcpp::NumericVector mu,
                            Rcpp::NumericVector sigma, Eigen::VectorXd theta) {
  Rcpp::NumericMatrix lik(x.size(), mu.size());
  for (int j = 0; j < mu.size(); j++) {
    lik.column(j) = do_dztpln2(x, mu(j), sigma(j));
    ;
  }
  Eigen::Map<Eigen::MatrixXd> lik2(Rcpp::as<Eigen::Map<Eigen::MatrixXd>>(lik));
  return lik2 * theta;
}

// [[Rcpp::export]]
double do_pztpln(Rcpp::IntegerVector x, double mu, double sig) {
  int n = x[0];
  Rcpp::IntegerVector a = Rcpp::seq_len(n);
  Rcpp::NumericVector lik = do_dztpln(a, mu, sig);
  double b = sum(lik);
  return b;
}
