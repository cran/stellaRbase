context("Testing operations from a specific ledger.")

expected_correct_links_length = 3
test_ledger = 16957910

t1 = getOperations_Ledger(test_ledger, data.table = FALSE)
t2 = getOperations_Ledger(test_ledger, order = "asc", data.table = FALSE)
t3 = getOperations_Ledger(test_ledger, limit = 1, data.table = FALSE)
t4 = expect_warning(getOperations_Ledger(test_ledger, limit = 0, data.table = FALSE), "You have requested 0 records.")
t5 = getOperations_Ledger(test_ledger, order = "desc", data.table = FALSE)
t6 = expect_warning(getOperations_Ledger(test_ledger, data.table = TRUE), "contains columns with non-uniform lists")

t2_records = t2[['_embedded']][['records']]
t5_records = t5[['_embedded']][['records']]

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/ledgers].+", t2_records[[1]])

test_that("The links returned are as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], expected_correct_links_length)
  expect_length(t5[['_links']], expected_correct_links_length)
})

test_that("Test #5 returns a server-side error.", {
  expect_equal(t4[['status']], 400)
})

test_that("The row counts are expected.", {
  expect_length(t3[['_embedded']][['records']], 1)
  expect_length(t2[['_embedded']][['records']], 2)
})

test_that("The ordering functionality of the API is working as expected.", {
  expect_true(t2_records[[1]][['paging_token']] < t2_records[[2]][['paging_token']])
  expect_true(t5_records[[1]][['paging_token']] > t5_records[[2]][['paging_token']])
})

test_that("The operations endpoint was queried.", {
  expect_length(ops_url_ind, 3)
})

test_that("The row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t6), no_t1_records)
  expect_equal(nrow(t6), 2)
})
