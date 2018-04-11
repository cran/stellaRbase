context("Testing ledger details.")

test_id = "1"
test_id_bad_input = 17003007

t1 = getLedgerDetail(test_id)
t2 = expect_warning(getLedgerDetail(test_id_bad_input), "character|precision")

test_that("The sequences returned are as expected.", {
  expect_equal(t1$sequence, as.double(test_id))
  expect_equal(t2$sequence, test_id_bad_input)
})

test_that("The number of links returned is as expected.", {
  expect_length(t1[['_links']], 5)
})
