context("Transactions from a specific account.")

expected_correct_links_length = 3
test_address = "GA2HGBJIJKI6O4XEM7CZWY5PS6GKSXL6D34ERAJYQSPYA6X6AI7HYW36"

t1 = getTransactions_Account(test_address, data.table = FALSE)
t2 = getTransactions_Account(test_address, order = "asc", data.table = FALSE)
t3 = expect_warning(getTransactions_Account(test_address, limit = 0, order = "desc", data.table = FALSE), "0 records")
t4 = getTransactions_Account(test_address, limit = 1, order = "desc", cursor = 12884905984, data.table = FALSE)
t5 = getTransactions_Account(test_address, limit = 1, order = "desc", cursor = 1, data.table = FALSE)
t6 = getTransactions_Account(test_address, cursor = "now", data.table = FALSE)
t7 = getTransactions_Account(test_address, data.table = TRUE)

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/transactions].+", t2[['_embedded']][['records']][[1]])

test_that("The links returned are as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], 0)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("Test #5 returns a server-side error.", {
  expect_equal(t5[['status']], 410)
})

test_that("Row counts are as expected.", {
  expect_length(t3[['_embedded']][['records']], 0)
  expect_length(t2[['_embedded']][['records']], 1)
})

test_that("The transactions endpoint is queried.", {
  expect_length(ops_url_ind, 3)
})

test_that("Row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t7), no_t1_records)
  expect_equal(nrow(t7), 1)
})
