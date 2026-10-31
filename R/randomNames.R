#' Generate random first and last names
#'
#' Generates random first and/or last names that are consistent with a given gender
#' and ethnicity. Names are sampled in proportion to how often they occur in the
#' embedded [randomNamesData] data set, so the result looks like a realistic roster.
#' Random names are useful to anonymise results that would otherwise identify people.
#'
#' The number of names returned is the largest of `n`, `length(gender)` and
#' `length(ethnicity)`; shorter vectors are recycled. Gender is used only for first
#' names; ethnicity is used for both first and last names. A missing gender or
#' ethnicity (`NA`, or not supplied) is drawn at random: gender with equal
#' probability, ethnicity with equal probability across the six codes.
#'
#' Gender and ethnicity may be given as codes or as text. Text is matched
#' case-insensitively: `"Male"`/`"M"`, `"Female"`/`"F"`; and for ethnicity
#' `"American Indian"`, `"Alaska"` or `"Native American"` (1); `"Asian"`, `"Hawaii"`
#' or `"Pacific"` (2); `"Black"` or `"African"` (3); `"Hispanic"` or `"Latino"` (4);
#' `"White"` or `"Caucasian"` (5); `"Middle Eastern"` or `"Arabic"` (6). A value that
#' matches nothing is drawn at random, with a warning.
#'
#' @param n Optional. A single positive whole number: how many names to produce.
#'   Defaults to 1. Most useful when no gender or ethnicity is supplied.
#' @param gender Optional. A vector of genders, either codes (`0` male, `1` female)
#'   or text as described in Details.
#' @param ethnicity Optional. A vector of ethnicities, either codes or text as
#'   described in Details. The codes are:
#'   \describe{
#'     \item{1}{American Indian or Native Alaskan}
#'     \item{2}{Asian or Pacific Islander}
#'     \item{3}{Black (not Hispanic)}
#'     \item{4}{Hispanic}
#'     \item{5}{White (not Hispanic)}
#'     \item{6}{Middle-Eastern, Arabic}
#'   }
#' @param which.names One of `"both"` (the default), `"first"` or `"last"`.
#' @param name.order When `which.names` is `"both"`, either `"last.first"` (the
#'   default) or `"first.last"`.
#' @param name.sep When `which.names` is `"both"`, the string placed between the
#'   two names. Defaults to `", "`.
#' @param sample.with.replacement Sample names with replacement? Defaults to
#'   `TRUE`. Without replacement the number of names asked for in one gender and
#'   ethnicity group cannot exceed the names available for it.
#' @param return.complete.data Return a `data.table` with the `ethnicity` and
#'   `gender` codes used alongside the names, instead of a character vector.
#'   Defaults to `FALSE`.
#'
#' @return A character vector of names, or, when `return.complete.data = TRUE`, a
#'   `data.table` with columns `gender`, `ethnicity` and the requested names.
#'
#' @seealso [randomNamesData]
#'
#' @examples
#' randomNames()  # one name in "last, first" form
#'
#' randomNames(5, which.names = "first")
#'
#' randomNames(5, return.complete.data = TRUE)
#'
#' test.df <- data.frame(
#'   GENDER = sample(0:1, 100, replace = TRUE),
#'   ETHNICITY = sample(1:6, 100, replace = TRUE)
#' )
#' head(randomNames(gender = test.df$GENDER, ethnicity = test.df$ETHNICITY))
#'
#' ethnicities <- c("African American", "Hispanic", "Asian", "White", "Native American")
#' genders <- c("Female", "Male")
#' test.df <- data.frame(
#'   GENDER = sample(genders, 100, replace = TRUE),
#'   ETHNICITY = sample(ethnicities, 100, replace = TRUE)
#' )
#' head(randomNames(gender = test.df$GENDER, ethnicity = test.df$ETHNICITY))
#' @export
randomNames <- function(n,
                        gender,
                        ethnicity,
                        which.names = "both",
                        name.order = "last.first",
                        name.sep = ", ",
                        sample.with.replacement = TRUE,
                        return.complete.data = FALSE) {
  .N <- V1 <- first_name <- last_name <- NULL ## To prevent R CMD check warnings

  ### Argument checks
  if (missing(n)) {
    n <- 1
  } else if (!is.numeric(n) || length(n) != 1L || !is.finite(n) || n < 1 || n != floor(n)) {
    stop("'n' must be a single positive whole number.", call. = FALSE)
  }
  which.names <- .check_choice(which.names, "which.names", c("both", "first", "last"))
  name.order <- .check_choice(name.order, "name.order", c("last.first", "first.last"))
  if (!is.character(name.sep) || length(name.sep) != 1L || is.na(name.sep)) {
    stop("'name.sep' must be a single character string.", call. = FALSE)
  }
  .check_flag(sample.with.replacement, "sample.with.replacement")
  .check_flag(return.complete.data, "return.complete.data")

  if (missing(gender)) gender <- NA
  if (missing(ethnicity)) ethnicity <- NA

  tmp.length <- max(n, length(gender), length(ethnicity), na.rm = TRUE)
  gender <- rep(gender, length.out = tmp.length)
  ethnicity <- rep(ethnicity, length.out = tmp.length)

  gender <- .code_gender(gender)
  ethnicity <- .code_ethnicity(ethnicity)

  # The order of these two draws fixes the stream of random numbers: keep it.
  gender[is.na(gender)] <- sample(0:1, length(gender[is.na(gender)]), replace = TRUE)
  ethnicity[is.na(ethnicity)] <- sample(1:6, length(ethnicity[is.na(ethnicity)]), replace = TRUE)

  first_names <- function(tmp.gender, tmp.ethnicity, tmp.number) {
    tmp <- randomNames::randomNamesData[[paste("first_names_e", tmp.ethnicity, "_g", tmp.gender, sep = "")]]
    suppressWarnings(sample(rownames(tmp), tmp.number, replace = sample.with.replacement, prob = tmp))
  }

  last_names <- function(tmp.ethnicity, tmp.number) {
    tmp <- randomNames::randomNamesData[[paste("last_names_e", tmp.ethnicity, sep = "")]]
    suppressWarnings(sample(rownames(tmp), tmp.number, replace = sample.with.replacement, prob = tmp))
  }

  tmp.dt <- data.table(seq.int(tmp.length), gender, ethnicity)
  setkeyv(tmp.dt, c("gender", "ethnicity"))

  if (which.names == "first" || which.names == "both") {
    tmp.dt[, first_name := first_names(gender, ethnicity, .N), by = list(gender, ethnicity)]
  }

  if (which.names == "last" || which.names == "both") {
    tmp.dt[, last_name := last_names(ethnicity, .N), by = list(ethnicity)]
  }

  setkey(tmp.dt, V1)
  if (return.complete.data) {
    return(tmp.dt[, intersect(names(tmp.dt), c("ethnicity", "gender", "last_name", "first_name")), with = FALSE])
  }
  if (which.names == "first") return(tmp.dt$first_name)
  if (which.names == "last") return(tmp.dt$last_name)
  if (name.order == "last.first") {
    paste(tmp.dt$last_name, tmp.dt$first_name, sep = name.sep)
  } else {
    paste(tmp.dt$first_name, tmp.dt$last_name, sep = name.sep)
  }
} ## END randomNames
