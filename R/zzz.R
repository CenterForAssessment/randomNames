`.onLoad` <-
function(libname, pkgname) {
}


`.onAttach` <-
function(libname, pkgname) {
	if (interactive()) {
		packageStartupMessage(magenta$bold('randomNames',paste(paste0(unlist(strsplit(as.character(packageVersion("randomNames")), "[.]")), c(".", "-", ".", "")), collapse=""),' (4-21-2021). For help: >help("randomNames") or visit https://centerforassessment.github.io/randomNames'))
	}
}
