test_that("an invalid n is an error", {
  for (bad in list(0, -3, 2.5, NA_real_, "a", c(1, 2), NULL, Inf)) {
    expect_error(randomNames(bad), "'n' must be a single positive whole number.", fixed = TRUE)
  }
})

test_that("unknown choices are errors, not silent NULLs", {
  expect_error(randomNames(2, which.names = "middle"), "'which.names' must be one of")
  expect_error(randomNames(2, name.order = "alphabetical"), "'name.order' must be one of")
  expect_error(randomNames(2, which.names = c("first", "last")), "'which.names' must be one of")
})

test_that("other arguments are validated", {
  expect_error(randomNames(2, name.sep = NA), "'name.sep'")
  expect_error(randomNames(2, name.sep = c("a", "b")), "'name.sep'")
  expect_error(randomNames(2, sample.with.replacement = "yes"), "'sample.with.replacement'")
  expect_error(randomNames(2, return.complete.data = NA), "'return.complete.data'")
})
