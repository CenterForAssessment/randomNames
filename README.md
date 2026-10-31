# randomNames <a href="https://centerforassessment.github.io/randomNames/"><img src="man/figures/logo.svg" align="right" height="139" alt="randomNames hex logo" /></a>

<!-- badges: start -->
[![R-CMD-check](https://github.com/CenterForAssessment/randomNames/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/CenterForAssessment/randomNames/actions/workflows/R-CMD-check.yaml)
[![CRAN status](https://www.r-pkg.org/badges/version/randomNames)](https://CRAN.R-project.org/package=randomNames)
[![License: GPL v3](https://img.shields.io/badge/license-GPL%203-blue.svg)](https://github.com/CenterForAssessment/randomNames/blob/master/LICENSE.md)
<!-- badges: end -->

## Overview

**randomNames** has one function, `randomNames()`, that creates random first and/or last names that fit a gender and an ethnicity. Names are sampled in proportion to how often they occur in a large database of real names, so a roster of random names looks like a roster of real ones. That makes it useful for anonymising results that would otherwise identify people.

## Installation

From [CRAN](https://CRAN.R-project.org/package=randomNames):

``` r
install.packages("randomNames")
```

The development version from [GitHub](https://github.com/CenterForAssessment/randomNames/):

``` r
# install.packages("pak")
pak::pak("CenterForAssessment/randomNames")
```

## Usage

``` r
library(randomNames)

randomNames(5)                                    # last, first
randomNames(5, gender = 1)                        # female
randomNames(5, gender = 0, ethnicity = 3)         # male, Black
randomNames(5, gender = 1, ethnicity = 6, which.names = "first")

# Text works as well as codes
randomNames(3, gender = c("Female", "Male"), ethnicity = c("Hispanic", "White", "Asian"))

# The codes used, next to the names
randomNames(3, return.complete.data = TRUE)

# The same names again
set.seed(42); randomNames(3)
set.seed(42); randomNames(3)
```

Ethnicity codes are 1 American Indian or Native Alaskan, 2 Asian or Pacific Islander, 3 Black (not Hispanic), 4 Hispanic, 5 White (not Hispanic) and 6 Middle-Eastern or Arabic. Gender codes are 0 male and 1 female. When you give neither, each is drawn at random.

## The startup message

In an interactive session the package prints a short banner that compares the installed version with CRAN and GitHub. It waits at most two seconds for each request. Switch it off with

``` r
options(randomNames.startup_message = FALSE)
```

or set the environment variable `RANDOMNAMES_QUIET=true`. It never runs in scripts, `R CMD check` or on a server.

## Resources

- [Website](https://centerforassessment.github.io/randomNames/)
- [CRAN](https://CRAN.R-project.org/package=randomNames)
- [Issues](https://github.com/CenterForAssessment/randomNames/issues)

Maintained by [Damian Betebenner](https://github.com/dbetebenner) at the [Center for Assessment](https://www.nciea.org/).
