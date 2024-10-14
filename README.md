randomNames
===========


[![R-CMD-check](https://github.com/CenterForAssessment/randomNames/workflows/R-CMD-check/badge.svg)](https://github.com/CenterForAssessment/randomNames/actions)
[![AppVeyor Build Status](https://ci.appveyor.com/api/projects/status/github/centerforassessment/randomNames?branch=master&svg=true)](https://ci.appveyor.com/project/centerforassessment/randomNames)
[![CRAN_Status_Badge](http://www.r-pkg.org/badges/version/randomNames)](http://cran.r-project.org/package=randomNames)
[![Development Version](https://img.shields.io/badge/devel-1.5--0.1-brightgreen.svg)](https://github.com/CenterForAssessment/randomNames)
[![Rstudio mirror downloads](http://cranlogs.r-pkg.org/badges/grand-total/randomNames)](https://github.com/metacran/cranlogs.app)
[![License](http://img.shields.io/badge/license-GPL%203-brightgreen.svg?style=flat)](https://github.com/CenterForAssessment/randomNames/blob/master/LICENSE.md)
[![https://gitter.im/CenterForAssessment/randomNames](https://badges.gitter.im/Join%20Chat.svg)](https://gitter.im/CenterForAssessment/randomNames?utm_source=badge&utm_medium=badge&utm_campaign=pr-badge&utm_content=badge)


# Overview

The **randomNames** package contains a single function `randomNames` which creates random gender/ethnicity correct first and/or last names where names are proportionally sampled based upon their frequency in a large scale database.


# Installation

## From [CRAN](https://CRAN.R-project.org/package=randomNames)

To install the latest stable release of **randomNames** from [CRAN](https://CRAN.R-project.org/package=randomNames)

```R
> install.packages("randomNames")
```

## From [Github](https://github.com/CenterForAssessment/randomNames/)

To install the development release of **randomNames** from [GitHub](https://github.com/CenterForAssessment/randomNames/):

```R
> devtools::install_github("CenterForAssessment/randomNames")
```

# Usage

```
> randomNames(5) ## 5 last, first names
[1] "Mossberg, Cassie"  "Mendiaz, Victoria" "Miner, Cassidy"    "Austin, Brook"     "Babcock, Lloyd"

> randomNames(5, gender=1) ## 5 female last, first names
[1] "Bruckner, Birva"   "Caringer, Madelyn" "Mendoza, Rebecca"  "el-Haque, Jaleela" "Williams, Miranda"

> randomNames(5, gender=0) ## 5 male last, first names
[1] "al-Salam, Rida"    "Debus, Kai"        "al-Aly, Jaabir"    "Garces, Markus"    "Robertson, Trevor"

> randomNames(5, gender=0, ethnicity=3) ## 5 African American, male last, first names
[1] "Bashir, Shaquille" "Ursery, Keilan"    "Marlow, Marvin"    "Bell, Daishavon"   "Hammond, Kyle"

> randomNames(5, gender=1, ethnicity=6, which.names="first") ## 5 Middle Eastern, female first names
[1] "Jawhara"  "Raaniya"  "Ghaada"   "Ghazaala" "Raabia"
```


# Resources

* [randomNames GitHub Pages](https://CenterForAssessment.github.io/randomNames)
* [CRAN Repo](https://CRAN.R-project.org/package=randomNames)


# Contributors

The **randomNames** Package is crafted with :heart: by:

* [Damian Betebenner](https://github.com/dbetebenner)

I love feedback and am happy to answer questions.
