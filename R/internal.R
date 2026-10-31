.check_choice <- function(x, arg, choices) {
  if (!is.character(x) || length(x) != 1L || is.na(x) || !x %in% choices) {
    stop("'", arg, "' must be one of ", paste0("\"", choices, "\"", collapse = ", "), ".", call. = FALSE)
  }
  x
}

.check_flag <- function(x, arg) {
  if (!is.logical(x) || length(x) != 1L || is.na(x)) {
    stop("'", arg, "' must be TRUE or FALSE.", call. = FALSE)
  }
  invisible(x)
}

# Valid numeric codes (also as text, "1") are kept as they are.
.keep_codes <- function(x, valid) {
  num <- suppressWarnings(as.numeric(as.character(x)))
  ifelse(num %in% valid, num, NA_real_)
}

# Gender as 0 (male), 1 (female) or NA. Text that matches neither is NA, with a warning.
.code_gender <- function(gender) {
  if (all(gender %in% c(NA, 0, 1))) return(gender)
  supplied <- !is.na(gender)
  out <- .keep_codes(gender, 0:1)
  text <- is.na(out)
  out[text & seq_along(out) %in% grep("Male|M", gender, ignore.case = TRUE)] <- 0
  out[text & seq_along(out) %in% grep("Female|F", gender, ignore.case = TRUE)] <- 1
  .warn_unmatched(supplied & is.na(out), "gender")
  out
}

# Ethnicity as 1-6 or NA. Text or numbers that match nothing are NA, with a warning.
.code_ethnicity <- function(ethnicity) {
  if (all(ethnicity %in% c(NA, 1:6))) return(ethnicity)
  supplied <- !is.na(ethnicity)
  out <- .keep_codes(ethnicity, 1:6)
  text <- is.na(out)
  patterns <- c(
    "Indian|Alaska|Native American", "Hawaii|Pacific|Asian", "Black|African",
    "Latino|Hispanic", "White|Caucasian", "Middle|Arabic"
  )
  for (code in 1:6) {
    hit <- grep(patterns[code], ethnicity, ignore.case = TRUE)
    out[text & seq_along(out) %in% hit] <- code
  }
  .warn_unmatched(supplied & is.na(out), "ethnicity")
  out
}

.warn_unmatched <- function(unmatched, what) {
  k <- sum(unmatched)
  if (k > 0) {
    warning(k, " ", what, " value", if (k > 1) "s were" else " was",
      " not recognised and ", if (k > 1) "were" else "was", " drawn at random.", call. = FALSE)
  }
}
