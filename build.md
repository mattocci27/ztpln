
## Docker

```{r}
# build
docker build -t ztpln:4.0.2 ./docker --build-arg USER_NAME=mattocci

# tag and push to private repo
docker tag ztpln:4.0.2  192.168.1.123:5000/ztpln:4.0.2
docker push 192.168.1.123:5000/ztpln:4.0.2

# run bash
docker run -it --rm -v $(pwd):/home/mattocci/ztpln -u mattocci ztpln:4.0.2 /bin/bash

# run rstudio
docker run -it --rm -p 8787:8787 -v $(pwd):/home/rstudio/ztpln -e PASSWORD=<password> ztpln:4.0.2

```

## Check

1. Build

```{r}

Rcpp::sourceCpp("./src/rztpln.cpp")
Rcpp::sourceCpp("./src/dztpln.cpp")

roxygen2::roxygenise()
devtools::build_vignettes()
devtools::build_manual(".")
devtools::build(".")


devtools::install_deps()
devtools::test()
devtools::test_coverage()
devtools::run_examples()
devtools::document()

devtools::check(".", manual = TRUE)

```

2. Copy pdf and tar.gz to this repo

```
cp ../ztpln_0.1.0.pdf .
cp ../ztpln_0.1.0.tar.gz .
```


3. Install (optional)

```{r}
install.packages("ztpln_0.1.0.tar.gz")
```

4. Check for Windows

```{r}
devtools::check_win_release()
devtools::check_win_devel()
devtools::check_win_oldrelease()
```

5.  rhub
```{r}
library(rhub)
validate_email("mattocci27@gmail.com")
check_on_linux()

check_on_macos()

devtools::check(".", manual = TRUE)

```

