\name{randomNames}
\alias{randomNames}
\title{Random Names Function}
\description{
Function to generate random gender and ethnicity correct first and/or last names. Names are chosen proportionally based upon their probability of appearing in a large scale data base of real names.
Function to generate random gender and ethnicity correct first and/or/last names. The function probabilistically samples from the embedded randomNamesData dataset to provide a realistic list of 
first and/or last names. 
}
\usage{
randomNames(n,                                                    
            gender,                                          
            ethnicity,                                 
            which.names="both",                               
            name.order="last.first",                                         
            name.sep=", ")                 
}

\arguments{
  \item{n}{OPTIONAL. Integer indicating how many name to produce. Best to use when no gender or ethnicity data is provided and one simple wants \code{n} random first and/or
  last names. 
  }
  \item{gender}{OPTIONAL. A vector indicating the genders for the names to be calcualted. The maximum of \code{n}, the length of \code{gender} and the length of 
  \code{ethnicity} is the number of random names returned. Note that the gender vector is only employed for deriving first names.
  If no gender vector is provided, the function randomly samples from both genders to produce a sample of names. See examples for various use cases.
  }
  \item{ethnicity}{OPTIONAL. A vector indicating the ethnicities for the names to be calculated. The maximum of \code{n}, the length of \code{gender} and the length of 
  \code{ethnicity} is the number of random names returned. Note that the ethnicity vector is employed for both deriving first and last names. If no ethnicity vector
  is provided the function samples from all ethnicity to produce a sample of names. See examples for various use cases.
  }
  \item{which.names}{OPTIONAL. One of \code{"both"} (the default), \code{"first"}, or \code{"last"} indicating what names to produce.
  }
  \item{name.order}{OPTIONAL. If \code{which.names} is \code{"both"}, then names can be returned as either \code{"last.first"} (the default) or \code{"first.last"}. 
  }
  \item{name.sep}{OPTIONAL. If \code{which.names} is \code{"both"}, then names are separated by the \code{name.sep} string provided. Defaults to comma-space separated.
  }
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

test.df <- data.frame(GENDER=round(runif(100)),
	ETHNICITY=round(runif(100,min=1, max=5)))

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
