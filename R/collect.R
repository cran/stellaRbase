#' Runs multiple calls against an endpoint to create a larger data set.
#' @description Get the first n records, most recent n records or records from a range.
#' @param endpoint character - one of: payments, operations, effects, trades, transactions, ledgers.
#' @param n numeric - the number of *pages* of records to return.
#'     Default is 1, maximum is currently 3600 due to the rate limit for the Horizon API.
#'     Each "page" will return 200 records.
#' @param order character - optional, "asc" or "desc"
#' @param data.table boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.
#' @param verbose boolean - if TRUE, the results and number of rows returned will be printed to the console.
#' @return data.table
#' @export
#' @note https://www.stellar.org/developers/horizon/reference/paging.html
#' @examples
#' collect(endpoint = "ledgers", n = 3)

collect <- function(endpoint, n = 11, order = "asc", data.table = TRUE, verbose = FALSE){

  max_limit = 200
  records = n * max_limit

  if (n >= 3600)
    warning(
      sprintf(
        "Too many pages requested - you will hit the rate limit and be unable to make requests for an hour. But who am I to tell you what you can and can't do with a computer? Pulling %s records...",
        records
      )
    )
  if (n >= 1000 &&
      n < 2000)
    warning(sprintf("Requesting %s ledgers, this may take a while:", records))
  if (n >= 2000 &&
      n < 3600)
    warning(
      sprintf(
        "Requesting %s ledgers, you will be pushing the rate limit of the API unless you cancel:",
        records
      )
    )

  req_start = as.numeric(Sys.time())
  firstRequest = .collectRequest(endpoint,
                                 order = order,
                                 limit = max_limit,
                                 data.table = FALSE)
  req_end = as.numeric(Sys.time())

  if (n == 1) {
    message(
      sprintf(
        "If you just want a single page of %s, the maximum records returned will be 200. You might be better off using the other get requests.",
        endpoint
      )
    )
    return(listToDF(firstRequest))
  }

  params = .collectParams(order = order, data = firstRequest)

  if (verbose)
    print(sprintf(
      "#1: rows returned: %s, time taken to complete request: %s s",
      params[1],
      round(req_end - req_start, 3)
    ))

  row_count = as.numeric(params[1])
  collect_data = list(firstRequest)

  for (request in 2:n) {
    req_start = as.numeric(Sys.time())
    this_request = .collectRequest(endpoint,
                                   cursor = params[2],
                                   order = order,
                                   limit = max_limit)
    req_end = as.numeric(Sys.time())

    params = .collectParams(order = order, data = this_request)
    row_count = as.numeric(params[1]) + row_count

    if (verbose)
      print(
        sprintf(
          "#%s: %s returned: %s, time taken to complete request: %s seconds.",
          request,
          endpoint,
          row_count,
          round(req_end - req_start, 3)
        )
      )

    collect_data[[request]] = this_request

  }

  if (data.table) {
    return(listToDF(collect_data))
  } else {
    list_records = lapply(collect_data, function(i) {
      i[['_embedded']][['records']]
    })
    return(unlist(list_records, recursive = FALSE))
  }

}

