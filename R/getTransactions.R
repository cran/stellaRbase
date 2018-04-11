#' Returns all valid transactions.
#' @description Return all valid transactions in pages or stream them to R.
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @param stream boolean - if TRUE, a data.table is overwritten and the server-side streaming capability is utilised. A list will be returned.
#' @return data.table (by default) or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/transactions-all.html
#' @examples
#' getTransactions(limit = 10)

getTransactions <- function(cursor = NULL, limit = 10, order = "asc", data.table = TRUE, stream = FALSE){
  return(.requestBuilder(endpoint = "transactions",
                         cursor = cursor,
                         limit = limit,
                         order = order,
                         data.table = ifelse(stream, FALSE, data.table),
                         stream = stream))
}
