#' Returns all trades.
#' @description Return all partially fulfilled trades to buy or sell assets on the ledger.
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param base_asset_type	optional, string - type of base asset
#' @param base_asset_code	optional, string - code of base asset, not required if type is native
#' @param base_asset_issuer	optional, string - issuer of base asset, not required if type is native
#' @param counter_asset_type	optional, string - type of counter asset
#' @param counter_asset_code	optional, string - code of counter asset, not required if type is native
#' @param counter_asset_issuer	optional, string - issuer of counter asset, not required if type is native
#' @param offer_id	optional, string - filter for by a specific offer id
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return data.table or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/trades.html
#' @examples
#' getTrades(limit = 20)

getTrades <- function(cursor = NULL, limit = 10, order = "asc", data.table = TRUE,
                      base_asset_type = NULL, base_asset_code = NULL, base_asset_issuer = NULL,
                      counter_asset_type  = NULL, counter_asset_code = NULL,
                      counter_asset_issuer = NULL, offer_id = NULL){
  return(
    .requestBuilder(
      endpoint = "trades",
      cursor = cursor,
      limit = limit,
      order = order,
      data.table = data.table,
      base_asset_type = base_asset_type,
      base_asset_code = base_asset_code,
      base_asset_issuer = base_asset_issuer,
      counter_asset_type = counter_asset_type,
      counter_asset_code	= counter_asset_code,
      counter_asset_issuer = counter_asset_issuer,
      offer_id	= offer_id
    )
  )
}

