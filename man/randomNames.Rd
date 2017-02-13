\name{randomNames}
\alias{randomNames}
\title{Random Names Function}
\description{
Function to generate random gender and ethnicity correct first and/or last names. Names are chosen proportionally based upon their probability of appearing in a large scale database of real names.
Function to generate random gender and ethnicity correct first and/or/last names. The function probabilistically samples from the embedded randomNamesData dataset to provide a realistic list of
first and/or last names.
}
\usage{
randomNames(n,
            gender,
            ethnicity,
            which.names="both",
            name.order="last.first",
            name.sep=", ",
            sample.with.replacement=TRUE,
            return.complete.data=FALSE)
}

\arguments{
  \item{n}{OPTIONAL. Positive integer indicating how many name to produce. Best to use when no gender or ethnicity data is provided and one simply wants \code{n} random first and/or
  last names.
  }
  \item{gender}{OPTIONAL. A vector indicating the genders for the names to be calculated. The maximum of \code{n}, the length of \code{gender} and the length of
  \code{ethnicity} is the number of random names returned. Note that the gender vector is only employed for deriving first names.
  If no gender vector is provided, the function randomly samples from both genders to produce a sample of names. Current gender codes are \code{0: Male}
  and \code{1: Female}. See examples for various use cases.
  }
  \item{ethnicity}{OPTIONAL. A vector indicating the ethnicities for the names to be calculated. The maximum of \code{n}, the length of \code{gender} and the length of
  \code{ethnicity} is the number of random names returned. Note that the ethnicity vector is employed for both deriving first and last names. If no ethnicity vector
  is provided the function samples from all ethnicity to produce a sample of names. Current ethnicity codes are:
 	\describe{
	       \item{1}{American Indian or Native Alaskan}
	       \item{2}{Asian or Pacific Islander}
	       \item{3}{Black (not Hispanic)}
	       \item{4}{Hispanic}
	       \item{5}{White (not Hispanic)}
	       \item{6}{Middle-Eastern, Arabic}
	}
  }
  \item{which.names}{OPTIONAL. One of \code{"both"} (the default), \code{"first"}, or \code{"last"}, \code{"complete.data"} indicating what names to produce. \code{"complete.data"}
  provides a data.table with \code{ethnicity} and \code{gender} codes.
  }
  \item{name.order}{OPTIONAL. If \code{which.names} is \code{"both"}, then names can be returned as either \code{"last.first"} (the default) or \code{"first.last"}.
  }
  \item{name.sep}{OPTIONAL. If \code{which.names} is \code{"both"}, then names are separated by the \code{name.sep} string provided. Defaults to comma-space separated.
  }
  \item{sample.with.replacement}{Boolean argument (defaults to TRUE) indicating whether sampling is done with replacement.
  }
  \item{return.complete.data}{Boolean argument (defaults to FALSE) indicating whether to return data including gender and ethnicity codes used for name construct. If set to TRUE,
  data is returned as a data.frame/data.table.}
}


\details{Typical use of the function is to submit a vector of genders and ethnicities to derived a gender and ethnicity representative vector of first and/or last names.
}

\value{Function returns a character vector containing first and/or last names.
}

\author{Damian W. Betebenner \email{dbetebenner@nciea.org} }

\seealso{\code{\link{randomNamesData}}}

\examples{
randomNames()  ## Returns a single name in "last, first" format

randomNames(5, which.names="first") ## Returns 5 first names

randomNames(5, return.complete.data=TRUE) ## Returns entire data.table

test.df <- data.frame(GENDER=sample(0:1, 100, replace=TRUE),
	ETHNICITY=sample(1:6, 100, replace=TRUE))

test.names <- randomNames(gender=test.df$GENDER,
	ethnicity=test.df$ETHNICITY)

head(test.names)


ethnicities <- c("African American", "Hispanic", "Asian", "White", "Native American")
genders <- c("Female", "Male")

test.df <- data.frame(GENDER=sample(genders, 100, replace=TRUE),
	ETHNICITY=sample(ethnicities, 100, replace=TRUE))

test.names <- randomNames(gender=test.df$GENDER,
	ethnicity=test.df$ETHNICITY)

head(test.names)
}

\keyword{ misc }
\keyword{ models }
