test_that("the default is one 'last, first' name", {
  x <- randomNames()
  expect_type(x, "character")
  expect_length(x, 1L)
  expect_match(x, ", ")
})

test_that("n sets the number of names", {
  expect_length(randomNames(7), 7L)
  expect_length(randomNames(1), 1L)
})

test_that("the longest of n, gender and ethnicity sets the length, and the rest recycle", {
  expect_length(randomNames(gender = c(0, 1, 0, 1)), 4L)
  expect_length(randomNames(2, gender = c(0, 1, 0)), 3L)
  expect_length(randomNames(gender = 0, ethnicity = 1:5), 5L)
})

test_that("which.names, name.order and name.sep shape the output", {
  set.seed(1)
  first <- randomNames(5, which.names = "first")
  last <- randomNames(5, which.names = "last")
  expect_false(any(grepl(", ", c(first, last))))

  both <- randomNames(5, name.order = "first.last", name.sep = " ")
  expect_true(all(lengths(strsplit(both, " ")) >= 2L))
  expect_false(any(grepl(",", both)))

  expect_match(randomNames(3, name.sep = " | "), " \\| ")
})

test_that("return.complete.data gives a table of codes and names", {
  x <- randomNames(6, gender = 1, ethnicity = 3, return.complete.data = TRUE)
  expect_s3_class(x, "data.table")
  expect_named(x, c("gender", "ethnicity", "last_name", "first_name"), ignore.order = TRUE)
  expect_equal(nrow(x), 6L)
  expect_true(all(x$gender == 1))
  expect_true(all(x$ethnicity == 3))
})

test_that("return.complete.data keeps only the requested names", {
  x <- randomNames(3, which.names = "first", return.complete.data = TRUE)
  expect_named(x, c("gender", "ethnicity", "first_name"), ignore.order = TRUE)
})

test_that("names come back in the order of the inputs", {
  set.seed(2)
  x <- randomNames(gender = c(0, 1, 0, 1, 1, 0), ethnicity = c(1, 2, 3, 4, 5, 6), return.complete.data = TRUE)
  expect_equal(x$gender, c(0, 1, 0, 1, 1, 0))
  expect_equal(x$ethnicity, c(1, 2, 3, 4, 5, 6))
})

test_that("sampling without replacement gives distinct names", {
  set.seed(3)
  x <- randomNames(50, gender = 1, ethnicity = 5, which.names = "first", sample.with.replacement = FALSE)
  expect_equal(anyDuplicated(x), 0L)
})
