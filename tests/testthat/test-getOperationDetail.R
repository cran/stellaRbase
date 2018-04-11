context("Testing operation details.")

test_id = "73026049033637889"
test_id_bad_input = 73026049033637889

t1 = getOperationDetail(test_id)
t2 = expect_warning(getOperationDetail(test_id_bad_input), "character|precision")

test_that("IDs match for the 'good' call.", {
  expect_equal(t1$id, test_id)
})

test_that("The number of links returned is as expected.", {
  expect_length(t1[['_links']], 5)
})

test_that("The 'bad' call returns a server-side error.", {
  expect_equal(t2$status, 404)
})


