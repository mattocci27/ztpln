
# Rebuild the package
Rcpp::compileAttributes()
devtools::load_all()

# Test type2 ZTPLN
sum(dztpln(1:10000, mu = 3, sig = 2, type1 = FALSE))  # Should be ~1
sum(dztpln(1:10000, mu = 3, sig = 2, type1 = TRUE))  # Should be ~1

# Compare type1 vs type2
dztpln(1:5, mu = 3, sig = 2, type1 = TRUE)
dztpln(1:5, mu = 3, sig = 2, type1 = FALSE)
