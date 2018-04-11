#' Returns all operations.
#' @description Return all operations that are a part of a valid transaction.
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @param stream boolean - if TRUE, a data.table is overwritten and the server-side streaming capability is utilised. A list will be returned.
#' @return data.table or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/operations-all.html
#' @examples
#' getOperations(limit = 33)

getOperations <- function(cursor = NULL, limit = 10, order = "asc", data.table = TRUE, stream = FALSE){
  return(
    .requestBuilder(
      endpoint = "operations",
      cursor = cursor,
      limit = limit,
      order = order,
      data.table = ifelse(stream, FALSE, data.table),
      stream = stream
    )
  )
}
