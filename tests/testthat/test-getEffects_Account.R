context("Testing effects from a specific account.")

expected_correct_links_length = 3
test_address = "GA2HGBJIJKI6O4XEM7CZWY5PS6GKSXL6D34ERAJYQSPYA6X6AI7HYW36"

t1 = getEffects_Account(test_address, data.table = FALSE)
t2 = getEffects_Account(test_address, order = "asc", data.table = FALSE)
t3 = getEffects_Account(test_address, limit = 1, order = "desc", data.table = FALSE)
t4 = getEffects_Account(test_address, limit = 1, order = "desc", cursor = 12884905984, data.table = FALSE)
t5 = getEffects_Account(test_address, limit = 1, order = "desc", cursor = 1, data.table = FALSE)
t6 = getEffects_Account(test_address, order = "desc", data.table = FALSE)
t7 = getEffects_Account(test_address, cursor = "now", data.table = FALSE)
t8 = getEffects_Account(test_address, data.table = TRUE)

t2_records = t2[['_embedded']][['records']]
t6_records = t6[['_embedded']][['records']]

ops_url_ind = grep("^[https://horizon.stellar.org/effects].+", t2_records[[1]])

test_that("Account effects objects contain the correct number of resource references.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], expected_correct_links_length)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("The fifth test returns an error from the server.", {
  expect_equal(t5[['status']], 410)
})

test_that("Row counts are correct.", {
  expect_length(t3[['_embedded']][['records']], 1)
  expect_length(t2[['_embedded']][['records']], 2)
})

test_that("The ordering capability of the API has returned the correct result.", {
  expect_true(t2_records[[1]][['paging_token']] < t2_records[[2]][['paging_token']])
  expect_true(t6_records[[1]][['paging_token']] > t6_records[[2]][['paging_token']])
})

test_that("Using cursor=now works as expected.", {
  expect_length(t7[['_links']], 3)
})

test_that("The number of link references indicates that effects was queried.", {
  expect_length(ops_url_ind, 2)
})

test_that("Row counts are correct and consolidate between lists and data tables.", {
  no_t1_records = length(t1[['_embedded']][['records']])
  expect_equal(nrow(t8), no_t1_records)
  expect_equal(nrow(t8), 2)
})


