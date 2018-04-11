#' Returns a single ledger.
#' @description Return a single ledger by providing a sequence id.
#' @param sequence character - (required) a ledger id.
#' @return list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/ledgers-single.html
#' @examples
#' getLedgerDetail("1")

getLedgerDetail <- function(sequence) {
  if (typeof(sequence) == "double")
    warning(
      sprintf(
        "Operation id being passed: [%s] Use a character string for operation ids, as you may lose precision.",
        sequence
      )
    )
  return(.requestBuilder(endpoint = "ledgers", ledger = sequence))
}
