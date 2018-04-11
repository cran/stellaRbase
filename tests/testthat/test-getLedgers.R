context("Ledgers only.")

expected_names = c("self", "transactions", "operations", "payments", "effects")

t1 = getLedgers(limit = 12, data.table = FALSE)
t2 = getLedgers(limit = 12, data.table = TRUE)
t3 = getLedgers(stream = TRUE)

t1_sample_record = t1[['_embedded']][['records']][[1]]

test_that("The object has returned with the correct links.", {
  expect_named(t1_sample_record[['_links']], expected_names)
})

test_that("The row counts are as expected.", {
  expect_equal(nrow(t2), 12)
})

test_that("The streaming capability is returning the correct data.", {
  expect_named(t3[1:3], c("retry", "event", "data"))
  expect_type(t3, "list")
  expect_equal(t3[[3]], '"hello"')
})


