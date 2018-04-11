context("Assets only.")

t1 = getAssets(limit = 200, data.table = TRUE)
t2 = getAssets(limit = 200, data.table = FALSE)

test_that("Row numbers consolidate when returned as a list or a data table.", {
  expect_equal(nrow(t1), 200)
  expect_length(t2[['_embedded']][['records']], 200)
})

