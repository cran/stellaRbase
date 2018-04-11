context("Transactions from a specific ledger.")

expected_correct_links_length = 3
test_ledger = 16957910

t1 = getTransactions_Ledger(test_ledger, data.table = FALSE)
t2 = getTransactions_Ledger(test_ledger, order = "asc", data.table = FALSE)
t3 = expect_warning(getTransactions_Ledger(test_ledger, limit = 0, order = "desc", data.table = FALSE), "0 records")
t4 = getTransactions_Ledger(test_ledger, limit = 1, order = "desc", data.table = FALSE)
t5 = expect_warning(getTransactions_Ledger(test_ledger, data.table = TRUE),
                    "contains columns with non-uniform lists")

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/ledgers].+", t2[['_embedded']][['records']][[1]])

test_that("The number of links returned is as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t4[['_links']], expected_correct_links_length)
  expect_length(t2[['_embedded']][['records']], 2)
})

test_that("Test #3 returns a server-side error.", {
  expect_equal(t3[['status']], 400)
})

test_that("Row counts are as expected.", {
  expect_length(t4[['_embedded']][['records']], 1)
})

test_that("The ledgers endpoint is queried.", {
  expect_length(ops_url_ind, 3)
})

test_that("Row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t5), no_t1_records)
  expect_equal(nrow(t5), 2)
})
