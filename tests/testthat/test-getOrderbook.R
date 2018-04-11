context("Orderbook details only.")

t1 = getOrderbook(selling_asset_type = "native",
                  buying_asset_type = "credit_alphanum4",
                  buying_asset_code = "BTC",
                  buying_asset_issuer = "GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC")

test_that("The fields returned are as expected.", {
  expect_named(t1, c("bids", "asks", "base", "counter"))
})
