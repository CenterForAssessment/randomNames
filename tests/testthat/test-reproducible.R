# Golden values from randomNames 1.6-0.0. Refactoring must not change what a
# seed produces: people rely on it to reproduce anonymised data.
test_that("a seed reproduces the same names", {
  set.seed(1)
  expect_equal(randomNames(5), c("Salazar, Austin", "Mcknight, Samaria", "el-Omer, Saalim",
    "Shrestha, Haseeb", "Moss, Essence"))
  set.seed(2)
  expect_equal(randomNames(4, which.names = "first", gender = c(0, 1), ethnicity = c(3, 4)),
    c("Devin", "Michael", "Antonio", "Hayley"))
  set.seed(3)
  expect_equal(randomNames(4, which.names = "last", ethnicity = 1:4),
    c("Jumpe", "Xiong", "Thomas", "Avila"))
  set.seed(5)
  expect_equal(randomNames(3, name.order = "first.last", name.sep = " "),
    c("Alexis Steward", "Judah Owens", "Xavier Robinson"))
})

test_that("a seed reproduces the same codes", {
  set.seed(4)
  x <- randomNames(3, return.complete.data = TRUE)
  expect_equal(x$gender, c(1, 0, 0))
  expect_equal(x$ethnicity, c(3, 4, 3))
  expect_equal(x$first_name, c("Quanishia", "Alejandro", "Dallas"))
  expect_equal(x$last_name, c("Davis", "Martinez", "Riley"))
})

test_that("an unspecified ethnicity is drawn from all six categories", {
  set.seed(10)
  x <- randomNames(3000, return.complete.data = TRUE)
  expect_setequal(unique(x$ethnicity), 1:6)
  expect_true(all(table(x$ethnicity) > 3000 / 6 * 0.8))
  expect_setequal(unique(x$gender), 0:1)
})
