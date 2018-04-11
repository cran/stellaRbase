#' Returns a single valid transactions.
#' @description Return a single transaction using a transaction id.
#' @param hash character - a transaction id/hash.
#' @return list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/transactions-single.html
#' @examples
#' \donttest{getTransactionDetail("someHash")}

getTransactionDetail <- function(hash){
  return(.requestBuilder(endpoint = "transactions", hash = hash))
}
