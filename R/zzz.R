`.onLoad` <-
function(libname, pkgname) {
}

`.onAttach` <- function(libname, pkgname) {
    if (interactive()) {
		# Utility function 
        get_dev_version <- function(package) {
            url <- paste0("https://raw.githubusercontent.com/CenterForAssessment/", package, "/refs/heads/master/DESCRIPTION")
            tryCatch({
                lines <- readLines(url, warn = FALSE)
                version_line <- grep("^Version:", lines, value = TRUE)
                if (length(version_line) > 0) {
                    return(cyan("v", strsplit(version_line, ": ")[[1]][2], sep=""))
                } else {
                    return(red("Not Available"))
                }
            }, error = function(e) {
                return(red("Not Available"))
            }, warning = function(w) {
                return(red("Not Available"))
            })
        }

        # Extract version information
        installed.version <- utils::packageDescription("randomNames")[['Version']]
        cran.version <- tryCatch(
            green("v", pkgsearch::cran_package("randomNames")[['Version']], sep=""),
            error = function(e) red("Not Available"),
            warning = function(w) red("Not Available"))
        dev.version <- get_dev_version("randomNames")

        # Define a friendly startup message
		message_text <- paste0(
		    magenta(bold("\uD83C\uDF89 randomNames v", installed.version, sep="")), " - ", toOrdinal::toOrdinalDate("2024-12-4"), "\n",
			strrep("\u2501", 40), "\n",
    	    bold("\U1F4E6 CRAN: "), cran.version, "\n",
    	    bold("\U1F527 Dev: "), dev.version, "\n",
			strrep("\u2501", 40), "\n",
		    "\U1F4A1 Tip: ", magenta(bold("> help(package=\"randomNames\")")), "\n",
		    "\U1F310 Docs: ", magenta(bold("https://centerforassessment.github.io/randomNames")), "\n",
			strrep("\u2501", 40), "\n",
		    "\u2728 Happy randomNaming!")

        # Display the startup message
        packageStartupMessage(message_text)
    }
}