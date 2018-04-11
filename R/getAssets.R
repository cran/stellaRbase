#' Returns all assets.
#' @description Return all assets in the system with statistics.
#' @param asset_code character - (optional) code of the asset to filter by
#' @param asset_issuer character - (optional) issuer of the asset to filter by
#' @param cursor numeric - optional, a paging token - where to start from. Can also be "now".
#' @param limit numeric - optional, the number of records to return. Default is 10.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @return list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/assets-all.html
#' @examples
#' getAssets(limit = 10)

getAssets <- function(cursor = NULL, asset_code = NULL, asset_issuer = NULL, limit = 10, order = "asc", data.table = TRUE){
  return(
    .requestBuilder(
      endpoint = "ledgers",
      asset_code = asset_code,
      asset_issuer = asset_issuer,
      cursor = cursor,
      limit = limit,
      order = order,
      data.table = data.table
    )
  )
}
