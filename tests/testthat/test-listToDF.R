context("Testing the list to table converter.")

test_address = "GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC"
test_hash = "b957fd83d5377402ee995d1c3ff4834357f48cbe9a6d42477baad52f1351c155"

t01 = expect_warning(listToDF(stellaRbase::test_txns), "non-uniform lists")
t02 = listToDF(stellaRbase::test_effects)
t03 = listToDF(stellaRbase::test_ledgers)
t04 = expect_warning(listToDF(stellaRbase::test_txns_desc), "non-uniform lists")
t05 = listToDF(stellaRbase::test_effects_desc)
t06 = listToDF(stellaRbase::test_ledgers_desc)
t07 = listToDF(stellaRbase::test_txns_acc)
t08 = listToDF(stellaRbase::test_effects_acc)
t09 = listToDF(stellaRbase::test_payments_acc)
t10 = listToDF(stellaRbase::test_effects_txn)

test_that("Row counts are as expected.", {
  expect_equal(nrow(t01), 20)
  expect_equal(nrow(t02), 10)
  expect_equal(nrow(t03), 10)
  expect_equal(nrow(t04), 10)
  expect_equal(nrow(t05), 10)
  expect_equal(nrow(t06), 10)
  expect_equal(nrow(t07), 20)
  expect_equal(nrow(t08), 20)
  expect_equal(nrow(t09), 20)
  expect_equal(nrow(t10), 2)
})
