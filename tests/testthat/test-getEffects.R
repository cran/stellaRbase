context("Effects only.")

t1 = getEffects(limit = 20, data.table = FALSE)
t2 = getEffects(limit = 20, data.table = TRUE)
t3 = getEffects(stream = TRUE)

test_that("Row counts consolidate for lists and data tables.", {
  expect_length(t1[['_embedded']][['records']], 20)
  expect_equal(nrow(t2), 20)
})

test_that("Data table is returned.", {
  expect_true(is.data.table(t2))
})

test_that("Streaming capability works as expected.", {
  expect_named(t3[1:3], c("retry", "event", "data"))
  expect_type(t3, "list")
  expect_equal(t3[[3]], '"hello"')
})

txt = content(GET(url = "https://horizon.stellar.org/effects?limit=10&order=asc&cursor=",
    add_headers(Accept = "text/event-stream", Application = "text/event-stream")))
