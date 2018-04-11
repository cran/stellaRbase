context("Testing the internal response builder.")

order = "asc"
limit = 100
cursor = "now"
domain = "horizon.stellar.org"
account = "GCEZWKCA5VLDNRLN3RPRJMRZOX3Z6G5CHCGSNFHEYVXM3XOJMDS674JZ"
txn = "6391dd190f15f7d1665ba53c63842e368f485651a53d8d852ed442a446d1c69a"

account_basename = "https://horizon.stellar.org/accounts/"
txns_basename = "https://horizon.stellar.org/transactions"

kwargs = list(
  endpoint = "accounts",
  account = account,
  order = order,
  limit = limit,
  cursor = cursor,
  resource = NULL,
  key = NULL
)

expected_url_account_single = paste0(account_basename, "GCEZWKCA5VLDNRLN3RPRJMRZOX3Z6G5CHCGSNFHEYVXM3XOJMDS674JZ")
expected_url_account_effects = paste0(account_basename, "GCEZWKCA5VLDNRLN3RPRJMRZOX3Z6G5CHCGSNFHEYVXM3XOJMDS674JZ/effects?limit=100&order=asc&cursor=now")
expected_url_account_payments = paste0(account_basename, "GCEZWKCA5VLDNRLN3RPRJMRZOX3Z6G5CHCGSNFHEYVXM3XOJMDS674JZ/payments?limit=100&order=asc&cursor=now")
expected_url_account_data = paste0(account_basename, "GCEZWKCA5VLDNRLN3RPRJMRZOX3Z6G5CHCGSNFHEYVXM3XOJMDS674JZ/data/id")
expected_url_transactions_all = paste0(txns_basename, "?limit=100&order=asc&cursor=")
expected_url_transactions_single = paste0(txns_basename, "/6391dd190f15f7d1665ba53c63842e368f485651a53d8d852ed442a446d1c69a")
expected_url_transactions_effects = paste0(txns_basename, "/6391dd190f15f7d1665ba53c63842e368f485651a53d8d852ed442a446d1c69a/effects?limit=100&order=asc&cursor=")

test_that("URL returned is in a valid format and is as expected for accounts.", {
  test_address = stellaRbase:::.requestBuilder_Account(kwargs, domain)
  expect_equal(test_address, expected_url_account_single)

  kwargs[6] <- "effects"
  test_address = stellaRbase:::.requestBuilder_Account(kwargs, domain)
  expect_equal(test_address, expected_url_account_effects)

  kwargs[6] <- "payments"
  test_address = stellaRbase:::.requestBuilder_Account(kwargs, domain)
  expect_equal(test_address, expected_url_account_payments)

  kwargs[6] <- "data"
  kwargs[7] <- "id"

  test_address = stellaRbase:::.requestBuilder_Account(kwargs, domain)
  expect_equal(test_address, expected_url_account_data)
})

test_that("URL returned is in a valid format and is as expected for transactions.", {
  kwargs = list(
    endpoint = "transactions",
    hash = NULL,
    order = order,
    limit = limit,
    cursor = NULL,
    resource = NULL
  )

  test_txn = stellaRbase:::.requestBuilder_Transaction(kwargs, domain)
  expect_equal(test_txn, expected_url_transactions_all)

  kwargs[2] = txn

  test_txn = stellaRbase:::.requestBuilder_Transaction(kwargs, domain)
  expect_equal(test_txn, expected_url_transactions_single)

  kwargs[6] = "effects"

  test_txn = stellaRbase:::.requestBuilder_Transaction(kwargs, domain)
  expect_equal(test_txn, expected_url_transactions_effects)
})




