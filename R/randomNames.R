#* @get /randomNames
`randomNames` <-
function(
	n,
	gender,
	ethnicity,
	which.names="both",
	name.order="last.first",
	name.sep=", ",
	sample.with.replacement=TRUE,
	return.complete.data=FALSE) {

	.N <- V1 <- first_name <- last_name <- NULL ## To prevent R CMD check warnings

	first_names <- function(tmp.gender, tmp.ethnicity, tmp.number) {
		tmp <- randomNames::randomNamesData[[paste("first_names_e", tmp.ethnicity, "_g", tmp.gender, sep="")]]
		suppressWarnings(sample(rownames(tmp), tmp.number, replace=sample.with.replacement, prob=tmp))
	}

	last_names <- function(tmp.ethnicity, tmp.number) {
		tmp <- randomNames::randomNamesData[[paste("last_names_e", tmp.ethnicity, sep="")]]
		suppressWarnings(sample(rownames(tmp), tmp.number, replace=sample.with.replacement, prob=tmp))
	}

	if (missing(n) & missing(gender) & missing(ethnicity)) n <- 1
	if (missing(n)) n <- 1
	if (n < 1) {
		message("\tNOTE: Please supply a positive integer for the argument n.")
		return(NULL)
	}
	if (missing(gender)) gender <- NA
	if (missing(ethnicity)) ethnicity <- NA

	tmp.length <- max(n, length(gender), length(ethnicity), na.rm=TRUE)
	if (is.na(tmp.length)) tmp.length <- 1

	if (missing(gender)) gender <- round(runif(tmp.length))
	if (missing(ethnicity)) ethnicity <- round(runif(tmp.length,min=1,max=5))

	gender <- rep(gender, length=tmp.length)
	ethnicity <- rep(ethnicity, length=tmp.length)

	if (!all(gender %in% c(NA,0,1))) {
		tmp <- rep(NA, length(gender))
		tmp[grep("Male|M", gender, ignore.case=TRUE)] <- 0
		tmp[grep("Female|F", gender, ignore.case=TRUE)] <- 1
		gender <- tmp
	}

	if (!all(ethnicity %in% c(NA,1:6))) {
		tmp <- rep(NA, length(ethnicity))
		tmp[grep("Indian|Alaska|Native American", ethnicity, ignore.case=TRUE)] <- 1
		tmp[grep("Hawaii|Pacific|Asian", ethnicity, ignore.case=TRUE)] <- 2
		tmp[grep("Black|African", ethnicity, ignore.case=TRUE)] <- 3
		tmp[grep("Latino|Hispanic", ethnicity, ignore.case=TRUE)] <- 4
		tmp[grep("White|Caucasian", ethnicity, ignore.case=TRUE)] <- 5
		tmp[grep("Middle|Arabic", ethnicity, ignore.case=TRUE)] <- 6
		ethnicity <- tmp
	}

	gender[is.na(gender)] <- sample(0:1, length(gender[is.na(gender)]), replace=TRUE)
	ethnicity[is.na(ethnicity)] <- sample(1:6, length(ethnicity[is.na(ethnicity)]), replace=TRUE)

	tmp.dt <- data.table(seq.int(tmp.length), gender, ethnicity)
	setkeyv(tmp.dt, c("gender", "ethnicity"))

	if (which.names=="first" | which.names=="both") {
		tmp.dt[,first_name:=first_names(gender, ethnicity, .N), by=list(gender, ethnicity)]
	}

	if (which.names=="last" | which.names=="both") {
		tmp.dt[,last_name:=last_names(ethnicity, .N), by=list(ethnicity)]
	}

	setkey(tmp.dt, V1)
	if (!return.complete.data) {
		if (which.names=="first") return(tmp.dt$first_name)
		if (which.names=="last") return(tmp.dt$last_name)
		if (which.names=="both" & name.order=="last.first") return(paste(tmp.dt$last_name, tmp.dt$first_name, sep=name.sep))
		if (which.names=="both" & name.order=="first.last") return(paste(tmp.dt$first_name, tmp.dt$last_name, sep=name.sep))
	} else {
		tmp.dt[,intersect(names(tmp.dt), c("ethnicity", "gender", "last_name", "first_name")), with=FALSE]
	}

} ## END randomNames Function
