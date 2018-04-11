#' Returns a single operation.
#' @description Return a single operation by providing an id.
#' @param id character - (required) an operation id.
#' @return list
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/endpoints/operations-single.html
#' @examples
#' \donttest{getOperationDetail("77309415424")}

getOperationDetail <- function(id){
  if (typeof(id) == "double")
    warning(
      sprintf(
        "Operation id being passed: [%s] Use a character string for operation ids, as you may lose precision.",
        id
      )
    )
  return(.requestBuilder(endpoint = "operations", id = id))
}
