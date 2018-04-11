context("Testing operations from a specific transaction.")

expected_correct_links_length = 3
test_hash = "d951a576e31a174bc438de0cf08ccf654f7045d56e0f34bd66ee9bf58dccd44a"

t1 = getOperations_Transaction(test_hash, data.table = FALSE)
t2 = getOperations_Transaction(test_hash, order = "asc", data.table = FALSE)
t3 = expect_warning(getOperations_Transaction(test_hash, limit = 0, order = "desc", data.table = FALSE), "0 records")
t4 = getOperations_Transaction(test_hash, limit = 1, order = "desc", cursor = 12884905984, data.table = FALSE)
t5 = getOperations_Transaction(test_hash, limit = 1, order = "desc", cursor = 1, data.table = FALSE)
t6 = getOperations_Transaction(test_hash, cursor = "now", data.table = FALSE)
t7 = getOperations_Transaction(test_hash, data.table = TRUE)

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/operations].+", t2[['_embedded']][['records']][[1]])

test_that("The links returned are as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], 0)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("Test #5 returns a server-side error.", {
  expect_equal(t5[['status']], 410)
})

test_that("The row counts are as expected.", {
  expect_length(t3[['_embedded']][['records']], 0)
  expect_length(t2[['_embedded']][['records']], 1)
})

test_that("Using cursor=now doesn't break anything.", {
  expect_length(t6[['_links']], 3)
})

test_that("The operations endpoint was queried.", {
  expect_length(ops_url_ind, 3)
})

test_that("The row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t7), no_t1_records)
  expect_equal(nrow(t7), 1)
})
