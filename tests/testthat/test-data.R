test_that("the data set has the documented arrays", {
  expect_true(is.environment(randomNamesData))
  expect_setequal(ls(randomNamesData), c(
    paste0("first_names_e", rep(1:6, each = 2), "_g", 0:1), paste0("last_names_e", 1:6)
  ))
})

test_that("each array has names and frequency probabilities", {
  for (nm in ls(randomNamesData)) {
    a <- randomNamesData[[nm]]
    expect_true(!is.null(rownames(a)), info = nm)
    expect_gt(nrow(a), 100, label = paste("rows in", nm))
    expect_false(anyNA(a), info = nm)
    expect_true(all(a >= 0), info = nm)
  }
})
