context("Test the ledgers collection functionality.")

t1 = expect_message(collect(endpoint = "ledgers", n = 1, order = "desc"),
                    "If you just want a single page of ledgers")

t2 = collect(endpoint = "ledgers", n = 5, order = "desc", data.table = TRUE)
t3 = collect(endpoint = "ledgers", n = 3, order = "asc", data.table = FALSE)
t4 = collect(endpoint = "ledgers", n = 3, order = "asc", data.table = TRUE)
t5 = collect(endpoint = "payments", n = 3, order = "asc", data.table = TRUE)
t6 = collect(endpoint = "payments", n = 3, order = "desc", data.table = FALSE)

test_that("Check row counts:", {
  expect_equal(nrow(t1), 200)
  expect_equal(nrow(t2), 1000)
})

test_that("Types are correct:", {
  expect_true(is.data.table(t1))
  expect_true(is.data.table(t2))
  expect_type(t3, "list")
})

test_that("Data makes sense:", {
  expect_equal(min(as.numeric(t4$sequence)), 1)
  expect_equal(max(as.numeric(t4$sequence)), nrow(t4))
})



