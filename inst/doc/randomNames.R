## ----include = FALSE-----------------------------------------------------
library(randomNames)
knitr::opts_chunk$set(
    collapse = TRUE,
    comment = ">",
    fig.dpi = 96
			)

## ------------------------------------------------------------------------
randomNames()

## ------------------------------------------------------------------------
randomNames(5)

## ------------------------------------------------------------------------
randomNames(5) ## 5 last, first names

## ------------------------------------------------------------------------
randomNames(5, gender=1) ## 5 female last, first names

randomNames(5, gender=c(0,0,1,1,1)) ## 2 male  and 3 female last, first names

## ------------------------------------------------------------------------
randomNames(5, gender=0, ethnicity=3) ## 5 African American, male last, first names

## ------------------------------------------------------------------------
randomNames(5, gender=1, ethnicity=6, which.names="first") ## 5 Middle Eastern/Arabic, female first names

## ------------------------------------------------------------------------
randomNames(5, gender=1, ethnicity=6, name.order="first.last") ## 5 first last names

## ------------------------------------------------------------------------
randomNames(5, gender=1, ethnicity=6, name.order="first.last", name.sep=" ") ## 5 first last names separated by a space

