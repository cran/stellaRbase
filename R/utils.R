#' Utilities
#' @description internal functions essential for other functions.

.checkLength <- function(arg) {
  return(ifelse(length(arg) > 0, as.character(arg), ""))
}

.getRequest <- function(url, debug = FALSE, stream = FALSE) {
  if (debug)
    print(url)
  if (stream)
    return(.parseStream(content(GET(
      url, add_headers(Accept = "text/event-stream")
    ))))
  return(fromJSON(content(GET(url), as = "text")))
}

.collectParams <- function(order, data) {
  row_count = length(data[['_embedded']][['records']])
  paging_tokens = sapply(data[['_embedded']][['records']], function(i) {
    i[['paging_token']]
  })
  paging_token_marker = ifelse(order == "asc", max(paging_tokens), min(paging_tokens))

  return(c(row_count, paging_token_marker))
}

.collectRequest <- function(endpoint, ...) {
  kwargs = list(...)
  accepted_endpoints = c("effects",
                         "payments",
                         "transactions",
                         "ledgers",
                         "operations")

  if (endpoint %in% accepted_endpoints) {
    switch(
      endpoint,
      "effects" = {
        return(
          getEffects(
            cursor = kwargs$cursor,
            limit = kwargs$limit,
            order = kwargs$order,
            data.table = FALSE
          )
        )
      },

      "payments" = {
        return(
          getPayments(
            cursor = kwargs$cursor,
            limit = kwargs$limit,
            order = kwargs$order,
            data.table = FALSE
          )
        )
      },

      "transactions" = {
        return(
          getTransactions(
            cursor = kwargs$cursor,
            limit = kwargs$limit,
            order = kwargs$order,
            data.table = FALSE
          )
        )
      },

      "ledgers" = {
        return(
          getLedgers(
            cursor = kwargs$cursor,
            limit = kwargs$limit,
            order = kwargs$order,
            data.table = FALSE
          )
        )
      },

      {
        return(
          getOperations(
            cursor = kwargs$cursor,
            limit = kwargs$limit,
            order = kwargs$order,
            data.table = FALSE
          )
        )
      }
    )

  } else {
    stop("Incorrect endpoint specified.")
  }
}

.parseStream <- function(txt) {
  split_txt = strsplit(txt, "\n")[[1]]
  filtered_txt = split_txt[split_txt != ""]

  key_value_pairs = lapply(filtered_txt, function(i) {
    # Get the key.
    first_colon = gregexpr("[:]", i)[[1]][1]
    key = substr(i, 1, first_colon - 1)
    # Get the value.
    value = trimws(substring(i, first_colon + 1))
    # If the key is data, return JSON.
    #return(value)
    parsed_value = ifelse(key == "data" && value != '"hello"',
                          fromJSON(value),
                          value)

    names(parsed_value) = key
    return(parsed_value)
  })

  return(unlist(key_value_pairs, recursive = FALSE))

}

.checkArguments <- function(kwargs) {
  if (length(kwargs$order) > 0) {
    if (!(kwargs$order %in% c("asc", "desc"))) {
      stop(sprintf(
        "\"%s\" is not a valid value for the order parameter.",
        kwargs$order
      ))
    }
  }

  if (length(kwargs$limit) > 0) {
    parsed_limit = try(as.double(kwargs$limit), silent = TRUE)

    if (is(parsed_limit, "try-error"))
      stop(
        sprintf(
          "The value \"%s\" passed to limit is not a valid numeric value.",
          parsed_limit
        )
      )

    if (suppressWarnings(parsed_limit %% 1 != 0))
      stop(sprintf(
        "The value \"%s\" passed to limit is not a valid integer.",
        parsed_limit
      ))

    if (parsed_limit == 0) {
      warning(
        "You have requested 0 records. Be wary that it's possible that this will result in a bad request (depending on the resource.)"
      )
    }

    if (parsed_limit < 0) {
      stop("You can't request less than 0 records on the Horizon API.")
    }

  }

  if (length(kwargs$cursor) > 0) {
    if (kwargs$cursor != "now") {
      parsed_cursor = try(as.double(kwargs$cursor), silent = TRUE)

      if (is(parsed_cursor, "try-error"))
        stop(sprintf(
          "The value \"%s\" passed to cursor is not a valid integer.",
          parsed_cursor
        ))

      if (suppressWarnings(parsed_cursor %% 1 != 0))
        stop(sprintf(
          "The value \"%s\" passed to cursor is not a valid integer.",
          parsed_cursor
        ))

      if (parsed_cursor == 0) {
        message(
          "You have requested to pull records from the 0 cursor. Be wary that it's possible that this will result in a bad request (depending on the resource.)"
        )
      }

      if (parsed_cursor < 0) {
        stop("You can't request less a cursor that's less than 0 on the Horizon API.")
      }

    }

  }

  return(kwargs)

}

.parseStream <- function(txt) {
  split_txt = strsplit(txt, "\n")[[1]]
  filtered_txt = split_txt[split_txt != ""]

  key_value_pairs = lapply(filtered_txt, function(i) {
    first_colon = gregexpr("[:]", i)[[1]][1]
    key = as.character(substr(i, 1, first_colon - 1))

    value = trimws(substring(i, first_colon + 1))
    parsed_value = ifelse(key == "data" && value != '"hello"',
                          fromJSON(value),
                          value)

    names(parsed_value) = key
    return(parsed_value)
  })

  return(unlist(key_value_pairs, recursive = FALSE))

}
