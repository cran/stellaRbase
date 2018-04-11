context("Testing offers from a specific account.")

expected_correct_links_length = 3
test_address = "GBU6GMZZ2KTQ33CHNVPAWWEJ22ZHLYGBGO3LIBKNANXUMNEOFROZKO62"
expected_error = "You can't request less a cursor that's less than 0 on the Horizon API."

t1 = getOffers_Account(test_address, data.table = FALSE)
t2 = getOffers_Account(test_address, order = "asc", data.table = FALSE)
t3 = expect_warning(getOffers_Account(test_address, limit = 0, order = "desc", data.table = FALSE), "0 records")
t4 = getOffers_Account(test_address, limit = 1, order = "desc", cursor = 12884905984, data.table = FALSE)

regex = paste0("[", test_address, "\\/offers]")
ops_url_ind = grep(regex, t2[['_links']][['self']])

test_that("The links returned are as expected.", {
  expect_length(t1[['_links']], expected_correct_links_length)
  expect_length(t2[['_links']], expected_correct_links_length)
  expect_length(t3[['_links']], 0)
  expect_length(t4[['_links']], expected_correct_links_length)
})

test_that("Using a negative cursor value returns an error from the client's side.", {
  expect_error(getOffers_Account(test_address,
                                 limit = 1,
                                 order = "desc",
                                 cursor = -1),
               expected_error)
})

test_that("The offers resource has been queried.", {
  expect_length(ops_url_ind, 1)
})
