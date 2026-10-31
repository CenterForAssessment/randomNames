codes <- function(...) randomNames(..., return.complete.data = TRUE, which.names = "first")

test_that("gender text is matched case-insensitively", {
  x <- codes(gender = c("Male", "female", "M", "f", "FEMALE"))
  expect_equal(x$gender, c(0, 1, 0, 1, 1))
})

test_that("ethnicity text maps to the six codes", {
  x <- codes(ethnicity = c("American Indian", "Alaska Native", "Asian", "Pacific Islander",
    "African American", "Black", "Hispanic", "Latino", "White", "Caucasian", "Middle Eastern", "Arabic"))
  expect_equal(x$ethnicity, c(1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6))
})

test_that("a missing code is filled in at random without a warning", {
  expect_no_warning(x <- codes(gender = c(0, NA, 1), ethnicity = c(NA, 2, 3)))
  expect_true(all(x$gender %in% 0:1))
  expect_true(all(x$ethnicity %in% 1:6))
  expect_equal(x$gender[c(1, 3)], c(0, 1))
  expect_equal(x$ethnicity[2:3], c(2, 3))
})

test_that("values that match nothing are drawn at random, with a warning", {
  expect_warning(x <- codes(gender = c("Male", "robot")), "1 gender value was not recognised")
  expect_equal(x$gender[1], 0)
  expect_true(x$gender[2] %in% 0:1)
  expect_warning(codes(ethnicity = c("White", "Martian", "Venusian")), "2 ethnicity values were not recognised")
  expect_warning(codes(ethnicity = c(1, 7)), "1 ethnicity value was not recognised")
})

test_that("codes and names agree with the data set", {
  set.seed(1)
  x <- randomNames(200, gender = 1, ethnicity = 2, return.complete.data = TRUE)
  expect_true(all(x$first_name %in% rownames(randomNamesData$first_names_e2_g1)))
  expect_true(all(x$last_name %in% rownames(randomNamesData$last_names_e2)))
})

test_that("valid numeric codes survive next to text and invalid values", {
  expect_warning(x <- codes(ethnicity = c(1, 7, 3)), "1 ethnicity value was not recognised")
  expect_equal(x$ethnicity[c(1, 3)], c(1, 3))
  x <- codes(gender = c("1", "Male", 0), ethnicity = c("2", "white", 6))
  expect_equal(x$gender, c(1, 0, 0))
  expect_equal(x$ethnicity, c(2, 5, 6))
})
