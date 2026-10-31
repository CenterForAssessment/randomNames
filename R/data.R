#' First and last names by gender and ethnicity
#'
#' Names with their frequencies, compiled from a large-scale data set of names in
#' which each person's gender and ethnicity were recorded. The frequencies are the
#' sampling probabilities [randomNames()] uses, so sampling gives a realistic
#' roster. First names are held by gender and ethnicity, last names by ethnicity.
#'
#' @format An environment holding 18 one-column arrays whose row names are the
#'   names and whose values are their frequency probabilities:
#'   * `first_names_e<E>_g<G>`: first names for ethnicity `E` (1 to 6) and gender
#'     `G` (0 male, 1 female), twelve arrays;
#'   * `last_names_e<E>`: last names for ethnicity `E` (1 to 6), six arrays.
#'
#'   Ethnicity is coded 1 American Indian or Native Alaskan, 2 Asian or Pacific
#'   Islander, 3 Black (not Hispanic), 4 Hispanic, 5 White (not Hispanic) and
#'   6 Middle-Eastern or Arabic. For example `first_names_e1_g0` holds first names
#'   and frequency probabilities for male American Indians or Native Alaskans.
#'   `ls(randomNamesData)` lists all arrays.
#'
#' @source Large scale state data.
#' @seealso [randomNames()]
#' @examples
#' head(ls(randomNamesData))
#' head(randomNamesData$last_names_e4)
"randomNamesData"
