# Startup banner. It runs only in an interactive session, makes at most two web
# requests with a two-second timeout, and can be switched off with
#   options(randomNames.startup_message = FALSE)
# or the environment variable RANDOMNAMES_QUIET=true.

.startup_wanted <- function(is_interactive = interactive()) {
  is_interactive &&
    isTRUE(getOption("randomNames.startup_message", TRUE)) &&
    !tolower(Sys.getenv("RANDOMNAMES_QUIET", "false")) %in% c("1", "true", "yes")
}

# First regular-expression capture from a web page, or NA on any failure.
.fetch_capture <- function(address, pattern, timeout = 2) {
  old <- options(timeout = timeout)
  on.exit(options(old), add = TRUE)
  tryCatch({
    con <- url(address, open = "r")
    on.exit(close(con), add = TRUE)
    lines <- suppressWarnings(readLines(con, n = 200L, warn = FALSE))
    hit <- regmatches(lines, regexec(pattern, lines))
    hit <- hit[lengths(hit) > 1L]
    if (length(hit)) hit[[1L]][2L] else NA_character_
  }, error = function(e) NA_character_, warning = function(w) NA_character_)
}

.version_label <- function(v, ok) {
  if (is.na(v)) cli::col_red("Not Available") else ok(paste0("v", v))
}

.onAttach <- function(libname, pkgname) {
  if (!.startup_wanted()) return(invisible())
  installed <- as.character(utils::packageVersion(pkgname))
  cran <- .fetch_capture(
    "https://crandb.r-pkg.org/randomNames", "\"Version\"\\s*:\\s*\"([^\"]+)\""
  )
  dev <- .fetch_capture(
    "https://raw.githubusercontent.com/CenterForAssessment/randomNames/refs/heads/master/DESCRIPTION",
    "^Version:\\s*(\\S+)"
  )
  rule <- strrep("\u2501", 40)
  packageStartupMessage(paste0(
    cli::col_magenta(cli::style_bold(paste0("\U1F389 randomNames v", installed))),
    " - ", toOrdinal::toOrdinalDate(as.character(Sys.Date())), "\n", rule, "\n",
    cli::style_bold("\U1F4E6 CRAN: "), .version_label(cran, cli::col_green), "\n",
    cli::style_bold("\U1F527 Dev: "), .version_label(dev, cli::col_cyan), "\n", rule, "\n",
    "\U1F4A1 Tip: ", cli::col_magenta(cli::style_bold("> help(package=\"randomNames\")")), "\n",
    "\U1F310 Docs: ", cli::col_magenta(cli::style_bold("https://centerforassessment.github.io/randomNames")), "\n",
    rule, "\n", "\u2728 Happy randomNaming!"
  ))
}
