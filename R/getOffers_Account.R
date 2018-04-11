#' Get an overview of offers on the Stellar ledger.
#' @description Returns offers with a particular account. Converts the JSON response to a list.
#' @param public_key character - your Stellar account/wallet address.
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/offers-for-account.html
#' @examples
#' \donttest{getOffers_Account("GsomeAccount")}

getOffers_Account <- function(public_key, cursor = NULL, limit = NULL, order = "asc", data.table = TRUE){
  return(
    .requestBuilder(
      endpoint = "accounts",
      account = public_key,
      resource = "offers",
      cursor = cursor,
      limit = limit,
      order = order,
      data.table = data.table
    )
  )
}
