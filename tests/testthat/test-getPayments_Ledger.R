context("Payments from a specific ledger")

expected_correct_links_length = 3
test_ledger = 16957910

t1 = getPayments_Ledger(test_ledger, data.table = FALSE)
t2 = getPayments_Ledger(test_ledger, order = "asc", data.table = FALSE)
t3 = expect_warning(getPayments_Ledger(test_ledger, limit = 0, data.table = FALSE), "0 records")
t4 = getPayments_Ledger(test_ledger, data.table = TRUE)

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/ledgers].+", t2[['_embedded']])

test_that("The links returned are as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
})

test_that("Test #3 returns a server-side error.", {
  expect_equal(t3[['status']], 400)
})

test_that("The row counts are as expected.", {
  expect_length(t2[['_embedded']][['records']], 1)
})

test_that("The ledgers endpoint is queried.", {
  expect_length(ops_url_ind, 1)
})

test_that("Row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t4), no_t1_records)
  expect_equal(nrow(t4), 1)
})
