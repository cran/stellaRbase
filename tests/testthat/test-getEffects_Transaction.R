context("Testing effects from a specific transaction.")

expected_correct_links_length = 3
test_hash = "d951a576e31a174bc438de0cf08ccf654f7045d56e0f34bd66ee9bf58dccd44a"

t1 = getEffects_Transaction(test_hash, data.table = FALSE)
t2 = getEffects_Transaction(test_hash, order = "asc", data.table = FALSE)
t3 = getEffects_Transaction(test_hash, limit = 1, order = "desc", data.table = FALSE)
t4 = getEffects_Transaction(test_hash, limit = 1, order = "desc", cursor = 12884905984, data.table = FALSE)
t5 = getEffects_Transaction(test_hash, limit = 1, order = "desc", cursor = 1, data.table = FALSE)
t6 = getEffects_Transaction(test_hash, order = "desc", data.table = FALSE)
t7 = getEffects_Transaction(test_hash, cursor = "now", data.table = FALSE)
t8 = getEffects_Transaction(test_hash, data.table = TRUE)

t2_records = t2[['_embedded']][['records']]
t6_records = t6[['_embedded']][['records']]

no_t1_records = length(t1[['_embedded']][['records']])

test_string = t2_records[[1]][['_links']][['succeeds']]
ops_url_ind = grep("^[https://horizon.stellar.org/effects].+", test_string)

test_that("The correct number of links have been returned.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], expected_correct_links_length)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("Test #5 returns an error from the server.", {
  expect_equal(t5[['status']], 410)
})

test_that("The row counts are as expected.", {
  expect_length(t3[['_embedded']][['records']], 1)
  expect_length(t2[['_embedded']][['records']], 2)
})

test_that("The order mechanism of the API is working as expected.", {
  expect_true(t2_records[[1]][['paging_token']] < t2_records[[2]][['paging_token']])
  expect_true(t6_records[[1]][['paging_token']] > t6_records[[2]][['paging_token']])
})

test_that("Using cursor=now doesn't break.", {
  expect_length(t7[['_links']], 3)
})

test_that("The effects resource was called.", {
  expect_length(ops_url_ind, 1)
})

test_that("Row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t8), no_t1_records)
  expect_equal(nrow(t8), 2)
})
