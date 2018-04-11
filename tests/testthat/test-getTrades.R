context("Trades only.")

t1 = getTrades(limit = 200, data.table = TRUE)
t2 = getTrades(limit = 200, data.table = FALSE)

test_that("Row counts are as expected and consolidate between lists and data tables.", {
  expect_equal(nrow(t1), 200)
  expect_length(t2[['_embedded']][['records']], 200)
})
