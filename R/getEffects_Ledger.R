#' Get an overview of account effects on the Stellar ledger.
#' @description Returns effects from the a specific ledger. Converts the JSON response to a list.
#' @param ledger numeric - a ledger ID.
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return data.table (by default) or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/effects-for-ledger.html
#' @examples
#' \donttest{getEffects_Ledger("25000")}

getEffects_Ledger <- function(ledger, cursor = NULL, limit = 10, order = "asc", data.table = TRUE){
  return(
    .requestBuilder(
      endpoint = "ledgers",
      ledger = ledger,
      resource = "effects",
      cursor = cursor,
      limit = limit,
      order = order,
      data.table = data.table
    )
  )
}
