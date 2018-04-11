context("Orderbook details only.")

start_time <- "1512689100000"
end_time <- "1512775500000"
resolution <- "300000"

base_asset_type <- "native"

counter_asset_type <- "credit_alphanum4"
counter_asset_code <- "BTC"
counter_asset_issuer <- "GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH"

t1 = getTradeAggregations(start_time, end_time, resolution,
                     base_asset_type = base_asset_type,
                     counter_asset_type = counter_asset_type,
                     counter_asset_code = counter_asset_code,
                     counter_asset_issuer = counter_asset_issuer)

t2 = getTradeAggregations(start_time, end_time, resolution,
                     base_asset_type = base_asset_type,
                     counter_asset_type = counter_asset_type,
                     counter_asset_code = counter_asset_code,
                     counter_asset_issuer = counter_asset_issuer,
                     data.table = TRUE)

test_that("The object headers returned are as expected.", {
  expect_named(t1, c("_links", "_embedded"))
})

test_that("Row counts are as expected.", {
  expect_length(t1[['_embedded']][['records']], 3)
  expect_equal(nrow(t2), 3)
})
