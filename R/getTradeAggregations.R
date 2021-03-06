#' Returns trade aggregations.
#' @description Gather historical trading data directly from the API.
#' @param start_time numeric - milliseconds since epoch
#' @param end_time numeric - milliseconds since epoch
#' @param resolution numeric - segment duration as millis since epoch. Supported values are 5 minutes (300000), 15 minutes (900000), 1 hour (3600000), 1 day (86400000) and 1 week (604800000).
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param base_asset_type	string - type of base asset
#' @param base_asset_code	string - code of base asset, not required if type is native
#' @param base_asset_issuer	string - issuer of base asset, not required if type is native
#' @param counter_asset_type	string - type of counter asset
#' @param counter_asset_code	string - code of counter asset, not required if type is native
#' @param counter_asset_issuer	string - issuer of counter asset, not required if type is native
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return data.table or list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/trade_aggregations.html
#' @examples
#' start_time="1512689100000"
#' end_time="1512775500000"
#' resolution="300000"
#' base_asset_type="native"
#' counter_asset_type="credit_alphanum4"
#' counter_asset_code="BTC"
#' counter_asset_issuer = "GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH"
#'
#' getTradeAggregations(start_time, end_time, resolution,
#' base_asset_type = base_asset_type, counter_asset_type = counter_asset_type,
#' counter_asset_code = counter_asset_code, counter_asset_issuer = counter_asset_issuer)

getTradeAggregations <- function(start_time, end_time, resolution,
                                 limit = 10, order = "asc",
                                 base_asset_type, base_asset_code = NULL, base_asset_issuer = NULL,
                                 counter_asset_type, counter_asset_code = NULL, counter_asset_issuer = NULL,
                                 data.table = FALSE){
  return(
    .requestBuilder(
      endpoint = "trade_aggregations",
      start_time = start_time,
      end_time = end_time,
      resolution = resolution,
      limit = limit,
      order = order,
      data.table = data.table,
      base_asset_type = base_asset_type,
      base_asset_code = base_asset_code,
      base_asset_issuer = base_asset_issuer,
      counter_asset_type = counter_asset_type,
      counter_asset_code	= counter_asset_code,
      counter_asset_issuer = counter_asset_issuer
    )
  )
}

