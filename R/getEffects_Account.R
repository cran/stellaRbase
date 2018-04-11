#' Get an overview of account effects on the Stellar ledger.
#' @description Returns effects from the creation of the account to the current ledger. Converts the JSON response to a list.
#' @param public_key character - your Stellar account/wallet address.
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return data.table (by default) or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/accounts-single.html
#' @examples
#' getEffects_Account("GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC")

getEffects_Account <- function(public_key, cursor = NULL, limit = 10, order = "asc", data.table = TRUE){
  return(
    .requestBuilder(
      endpoint = "accounts",
      account = public_key,
      resource = "effects",
      cursor = cursor,
      limit = limit,
      order = order,
      data.table = data.table
    )
  )
}
