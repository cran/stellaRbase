context("Testing effects from a specific ledger.")

expected_correct_links_length = 3
test_ledger = 16957910

t1 = getEffects_Ledger(test_ledger, data.table = FALSE)
t2 = getEffects_Ledger(test_ledger, order = "asc", data.table = FALSE)
t3 = getEffects_Ledger(test_ledger, limit = 1, data.table = FALSE)
t4 = getEffects_Ledger(test_ledger, order = "desc", data.table = FALSE)
t5 = expect_warning(getEffects_Ledger(test_ledger, limit = 0, data.table = FALSE), "0 records")
t6 = getEffects_Ledger(test_ledger, data.table = TRUE)

t2_records = t2[['_embedded']][['records']]
t4_records = t4[['_embedded']][['records']]

no_t1_records = length(t1[['_embedded']][['records']])

ops_url_ind = grep("^[https://horizon.stellar.org/ledgers].+", t2_records[[1]])

test_that("The correct number of resource links are returned.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], expected_correct_links_length)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("Test #5 returns an error status from the server.", {
  expect_equal(t5[['status']], 400)
})

test_that("The number of records returned is as expected.", {
  expect_length(t3[['_embedded']][['records']], 1)
  expect_length(t2[['_embedded']][['records']], 2)
})

test_that("The ordering mechanism of the API works as expected.", {
  expect_true(t2_records[[1]][['paging_token']] < t2_records[[2]][['paging_token']])
  expect_true(t4_records[[1]][['paging_token']] > t4_records[[2]][['paging_token']])
})

test_that("The ledgers resource was queried and indicated in the reply.", {
  expect_length(ops_url_ind, 3)
})

test_that("Row counts consolidate between lists and data tables.", {
  expect_equal(nrow(t6), no_t1_records)
  expect_equal(nrow(t6), 2)
})
