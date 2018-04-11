context("Testing operations from a specific account.")

expected_correct_links_length = 3
test_address = "GAOKCV6MIEO3MVOYCR3P4LGJJOIZAJU3WSVJOZJPHWO7RNAA7VAO7EVH"

t1 = getOperations_Account(test_address, data.table = FALSE)
t2 = getOperations_Account(test_address, order = "asc", data.table = FALSE)
t3 = getOperations_Account(test_address, limit = 1, order = "desc", data.table = FALSE)
t4 = getOperations_Account(test_address, limit = 1, order = "desc", cursor = 12884905984, data.table = FALSE)
t5 = getOperations_Account(test_address, limit = 1, order = "desc", cursor = 1, data.table = FALSE)
t6 = getOperations_Account(test_address, order = "desc", data.table = FALSE)
t7 = getOperations_Account(test_address, cursor = "now", data.table = FALSE)
t8 = getOperations_Account(test_address, data.table = TRUE)

t2_records = t2[['_embedded']][['records']]
t6_records = t6[['_embedded']][['records']]

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/operations].+", t2_records[[1]])

test_that("The number of links returned is as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], expected_correct_links_length)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("Test #5 returns a server side error.", {
  expect_equal(t5[['status']], 410)
})

test_that("Row counts are as expected.", {
  expect_length(t3[['_embedded']][['records']], 1)
  expect_length(t2[['_embedded']][['records']], 10)
})

test_that("The ordering functionality of the API is working as expected.", {
  expect_true(t2_records[[1]][['paging_token']] < t2_records[[2]][['paging_token']])
  expect_true(t6_records[[1]][['paging_token']] > t6_records[[2]][['paging_token']])
})

test_that("Using cursor=now returns correctly.", {
  expect_length(t7[['_links']], 3)
})

test_that("The operations endpoint has been queried.", {
  expect_equal(ops_url_ind, 1)
})

test_that("Row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t8), no_t1_records)
  expect_equal(nrow(t8), 10)
})
