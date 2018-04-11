context("Path finder.")

destination_account = "GAOKCV6MIEO3MVOYCR3P4LGJJOIZAJU3WSVJOZJPHWO7RNAA7VAO7EVH"
destination_asset_type = "credit_alphanum4"
destination_asset_code = "ETC"
destination_asset_issuer = destination_account
destination_amount = 0.1

source_account = "GCQVSEUAGTMLLJKU2NKCAZKCHKS665G3ZKHEQJPQH4FTDJEKI5SZFQME"

t1 = findPaymentPaths(destination_account = destination_account,
                      destination_asset_type = destination_asset_type,
                      destination_asset_code = destination_asset_code,
                      destination_asset_issuer = destination_asset_issuer,
                      destination_amount = destination_amount,
                      source_account = source_account)

test_that("Object returned contains 'embedded' structures.", {
  expect_named(t1, c("_embedded"))
})

