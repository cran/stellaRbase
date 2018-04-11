#' Returns details on the current state of the order book
#' @description Return a summary of assets bought and sold on the ledger.
#' @param selling_asset_type	required, character - Type of the Asset being sold	native
#' @param selling_asset_code	optional, character - code of the Asset being sold	USD
#' @param selling_asset_issuer	optional, character - account ID of the issuer of the Asset being sold	GA2HGBJIJKI6O4XEM7CZWY5PS6GKSXL6D34ERAJYQSPYA6X6AI7HYW36
#' @param buying_asset_type	required, character - type of the Asset being bought	credit_alphanum4
#' @param buying_asset_code	optional, character - code of the Asset being bought	BTC
#' @param buying_asset_issuer	optional, character - account ID of the issuer of the Asset being bought
#' @param limit optional, numeric - the number of records to return.
#' @return list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/orderbook-details.html
#' @examples
#' \donttest{getOrderbook(selling_asset_type = "native", buying_asset_type = "credit_alphanum4")}

getOrderbook <- function(selling_asset_type,
                         selling_asset_code = NULL,
                         selling_asset_issuer = NULL,
                         buying_asset_type,
                         buying_asset_code = NULL,
                         buying_asset_issuer = NULL,
                         limit = 10) {
  return(
    .requestBuilder(
      endpoint = "order_book",
      limit = limit,
      selling_asset_type = selling_asset_type,
      selling_asset_code = selling_asset_code,
      selling_asset_issuer = selling_asset_issuer,
      buying_asset_type = buying_asset_type,
      buying_asset_code	= buying_asset_code,
      buying_asset_issuer = buying_asset_issuer
    )
  )
}


