context("Testing transaction details.")

test_hash = "d951a576e31a174bc438de0cf08ccf654f7045d56e0f34bd66ee9bf58dccd44a"
t1 = getTransactionDetail(test_hash)

test_that("Ids and hashes match.", {
  expect_equal(t1$id, test_hash)
  expect_equal(t1$hash, test_hash)
})

test_that("The number of links returned is as expected.", {
  expect_length(t1[['_links']], 7)
})



