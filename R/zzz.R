`.onLoad` <-
function(libname, pkgname) {
}

`.onAttach` <- function(libname, pkgname) {
    if (interactive()) {
        # Extract version information
        version <- utils::packageVersion("randomNames")

        # Define a friendly startup message
	message_text <- paste0(
	    magenta(bold("\uD83C\uDF89 randomNames v", version)), " - ", toOrdinal::toOrdinalDate("2024-11-22"), "\n",
	    "\U1F4A1 Tip: ", magenta(bold("> help(\"randomNames\")")), "\n",
	    "\U1F310 Docs: ", magenta(bold("https://centerforassessment.github.io/randomNames")), "\n",
	    "\u2728 Happy randomNaming!"
	)

        # Display the startup message
        packageStartupMessage(message_text)
    }
}
