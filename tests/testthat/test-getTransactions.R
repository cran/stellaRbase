context("Transactions only.")

t1 = getTransactions(limit = 20, data.table = FALSE)
t2 = expect_warning(getTransactions(limit = 20))
t3 = getTransactions(stream = TRUE)

test_that("Row counts are as expected and consolidate between lists and data tables.", {
  expect_length(t1[['_embedded']][['records']], 20)
  expect_equal(nrow(t2), 20)
})

test_that("The streaming capability returns the correct data format.", {
  expect_named(t3[1:3], c("retry", "event", "data"))
  expect_type(t3, "list")
  expect_equal(t3[[3]], '"hello"')
})
