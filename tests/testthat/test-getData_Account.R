context("Testing the data resource for a specific account.")

expected_correct_links_length = 3
test_address = "GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC"

test_key = "user-id"
test_invalid_key = "plumbus"

t1 = getData_Account(test_address, test_key, data.table = FALSE)
t2 = getData_Account(test_address, test_invalid_key, data.table = FALSE)
