\name{randomNamesData}
\alias{randomNamesData}
\docType{data}
\title{First names (by gender and ethnicity) and last names (by ethnicity) for randomNames function}
\description{
A dataset compiled from a large scale data set of names providing first names by gender and ethnicity and last names by ethnicity. The dataset provides
frequency probabilities from the original data set so that sampling provides a reasonable set of random names. The dataset is for use with the
\code{randomNames} function to quickly generate random names that can be used, for example, to anonymize results.
}
\format{
  An environment of first and last names by gender and ethnicity (first names) and ethnicity (last names)
  Gender is coded 0 for male and 1 for female, ethnicity is coded 1 for American Indian or Native Alaskan,
  2 for Asian or Pacific Islander, 3 for Black (not Hispanic), 4 for Hispanic, and 5 for White (not
  Hispanic). For example, the array \code{first_names_e1_g0} in \code{randomNamesData} provides first
  and associated frequency probabilities for male, American Indians or Native Alaskans. To view names of
  all environment arrays type \code{ls(randomNamesData)} after loading the package.
  }

\seealso{\code{\link{randomNames}}}

\source{Large scale state data}
\keyword{datasets}
