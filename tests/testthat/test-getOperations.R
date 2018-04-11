context("Operations only.")

t1 = getOperations(limit = 66, data.table = FALSE)
t2 = expect_warning(getOperations(limit = 66, data.table = TRUE), "non-uniform lists")
t3 = getOperations(stream = TRUE)

test_that("The number of records returned is as expected and consolidates between lists and data tables.", {
  expect_length(t1[['_embedded']][['records']], 66)
  expect_equal(length(t1[['_embedded']][['records']]), nrow(t2))
})

test_that("The streaming capability returns the correct schema.", {
  expect_named(t3[1:3], c("retry", "event", "data"))
  expect_type(t3, "list")
  expect_equal(t3[[3]], '"hello"')
})
