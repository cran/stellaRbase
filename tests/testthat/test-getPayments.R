context("Payments only.")

t1 = getPayments(limit = 5, data.table = FALSE)
t2 = getPayments(limit = 5, data.table = TRUE)
t3 = getPayments(stream = TRUE)

test_that("The row counts are as expected and that lists and data tables consolidate.", {
  expect_length(t1[['_embedded']][['records']], 5)
  expect_equal(length(t1[['_embedded']][['records']]), nrow(t2))
})

test_that("Streaming capability returns the correct data format.", {
  expect_named(t3[1:3], c("retry", "event", "data"))
  expect_type(t3, "list")
  expect_equal(t3[[3]], '"hello"')
})
