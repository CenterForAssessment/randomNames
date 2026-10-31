test_that("the startup banner is silent when not interactive", {
  expect_false(.startup_wanted())
})

test_that("the banner has two off switches", {
  expect_true(.startup_wanted(is_interactive = TRUE))
  withr::with_options(list(randomNames.startup_message = FALSE),
    expect_false(.startup_wanted(is_interactive = TRUE)))
  withr::with_envvar(c(RANDOMNAMES_QUIET = "true"),
    expect_false(.startup_wanted(is_interactive = TRUE)))
})

test_that("a failed web request returns NA rather than an error", {
  expect_true(is.na(.fetch_capture("http://127.0.0.1:9/none", "(x)", timeout = 1)))
})
