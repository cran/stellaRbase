#' Get an overview of an account on the Stellar ledger.
#' @description Query the accounts endpoint, specifying no extra resources. Converts the JSON response to a list.
#' @param public_key character - your Stellar account/wallet address.
#' @return list
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/accounts-single.html
#' @examples
#' getAccountDetail("GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC")

getAccountDetail <- function(public_key){
  return(.requestBuilder(endpoint = "accounts", account = public_key))
}
