context("Account details only.")

test_address = "GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC"
bad_address = "qwerty"

t1 = getAccountDetail(test_address)
t2 = getAccountDetail(bad_address)

test_that("Good account has an account id, bad account returns a 404 status.", {
  expect_equal(t1[['account_id']], test_address)
  expect_equal(t2[['status']], 404)
})

