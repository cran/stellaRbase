#' Get an overview of account data on the Stellar ledger.
#' @description Every account can have an extra data associated with it, such as multiple keys or user-ids. Use this comand to return key value pairs for a specific account. Converts the JSON response to a list.
#' @param public_key character - (required) your Stellar account/wallet address.
#' @param key character - (required) a user id
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return data.table (by default) or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/data-for-account.html
#' @examples
#' \donttest{getData_Account(public_key = "Gsomekey", key = "user-id")}

getData_Account <- function(public_key, key, data.table = TRUE){
  return(
    .requestBuilder(
      endpoint = "accounts",
      account = public_key,
      key = key,
      resource = "data",
      data.table = data.table
    )
  )
}
