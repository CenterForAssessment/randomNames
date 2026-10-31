# Guards the package-site _quarto.yml against edits that break the Pages artifact flow.
# Run from the package root before `quarto render ui/www`.
args <- commandArgs(trailingOnly = TRUE)
path <- if (length(args)) args[1] else "ui/www/_quarto.yml"
cfg <- yaml::read_yaml(path)
problems <- character(0)
if (!identical(cfg$project$`output-dir`, "_site")) problems <- c(problems, "project.output-dir must be _site")
if (!any(grepl("fonts", unlist(cfg$project$resources)))) {
  problems <- c(problems, "project.resources must include assets/fonts/*.woff2")
}
if (is.null(cfg$format$`pkgsite-html`)) problems <- c(problems, "format must be pkgsite-html")
if (!is.null(cfg$website$navbar$title) && is.null(cfg$website$`site-url`)) problems <- c(problems, "website.site-url is missing")
if (length(problems)) {
  message(paste0("- ", problems, collapse = "\n"))
  quit(status = 1)
}
message("_quarto.yml ok")
