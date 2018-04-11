#' Build requests to send to the Horizon API
#' @description A generic function to build requests before querying the API.
#' @param endpoint string - The name of the Horizon endpoint. https://www.stellar.org/developers/reference/
#' @param ... params - a list of parameters to append to the HTTP request.
#' @return list or data.table

.requestBuilder <- function(endpoint, ...) {
  testnet_url = "horizon-testnet.stellar.org"
  public_url = "horizon.stellar.org"

  kwargs = .checkArguments(list(...))
  stream = ifelse(is.null(kwargs$stream), FALSE, kwargs$stream)
  domain = public_url

  switch(
    endpoint,
    "accounts" = {
      if (length(kwargs$account) > 0) {
        response = .getRequest(.requestBuilder_Account(kwargs, domain))

        if (length(kwargs$data.table) > 0 &&
            length(kwargs$resource) > 0) {
          if (kwargs$data.table && kwargs == "offers") {
            if (length(response[['_embedded']][['records']]) == 0) {
              return(data.table())

            } else {
              response[['_embedded']][['records']] = lapply(response[['_embedded']][['records']], unlist)

              df = listToDF(response)[,-1:-2]

              return(setNames(df, gsub("\\.", "_", names(df))))

            }
          }
        }
      }
    },

    "transactions" = {
      response = .getRequest(.requestBuilder_Transaction(kwargs, domain), stream = stream)

    },

    "effects" = {
      response = .getRequest(.requestBuilder_Effects(kwargs, domain), stream = stream)

    },

    "ledgers" = {
      response = .getRequest(.requestBuilder_Ledger(kwargs, domain), stream = stream)

    },

    "payments" = {
      response = .getRequest(.requestBuilder_Payments(kwargs, domain), stream = stream)

    },

    "operations" = {
      response = .getRequest(.requestBuilder_Operations(kwargs, domain), stream = stream)

    },

    "trades" = {
      response = .getRequest(.requestBuilder_Trades(kwargs, domain))

      if (length(kwargs$data.table > 0)) {
        if (kwargs$data.table) {
          response[['_embedded']][['records']] = lapply(response[['_embedded']][['records']], unlist)

          df = listToDF(response)[,-1:-3]

          return(setNames(df, gsub("\\.", "_", names(df))))
        }
      }

    },

    "trade_aggregations" = {
      test_args = c(
        "base_asset_type",
        "counter_asset_type",
        "start_time",
        "end_time",
        "resolution"
      )
      test_args_present = sapply(test_args, function(i) {
        length(kwargs[[i]]) > 0
      })

      if (all(test_args_present)) {
        response = .getRequest(.requestBuilder_TradeAggregations(kwargs, domain))

        if (length(kwargs$data.table > 0)) {
          if (kwargs$data.table) {
            response[['_embedded']][['records']] = lapply(response[['_embedded']][['records']], unlist)

            df = listToDF(response)[,-1:-3]

            return(setNames(df, gsub("\\.", "_", names(df))))
          }
        }

      } else {
        stop(
          sprintf(
            "Error: some essential arguments weren't supplied. You need to supply: [%s]",
            paste0(names(test_args_present)[!test_args_present], collapse = ", ")
          )
        )
      }

    },

    "order_book" = {
      if (length(kwargs$selling_asset_type) > 0 &&
          length(kwargs$buying_asset_type) > 0) {
        if (kwargs$selling_asset_type %in% c("native", "credit_alphanum4", "credit_alphanum12") &&
            kwargs$buying_asset_type %in% c("native", "credit_alphanum4", "credit_alphanum12")) {
          response = .getRequest(.requestBuilder_Orderbook(kwargs, domain))
        } else {
          stop(
            "Error: selling/buying asset type is not valid. Must be one of: native, credit_alphanum4, credit_alphanum12"
          )

        }
      }

    },

    "assets" = {
      response = .getRequest(.requestBuilder_Assets(kwargs, domain))

      if (length(kwargs$data.table > 0)) {
        if (kwargs$data.table) {
          response[['_embedded']][['records']] = lapply(response[['_embedded']][['records']], unlist)

          df = listToDF(response)[,-1:-3]

          return(setNames(df, gsub("\\.", "_", names(df))))
        }
      }

    },

    "paths" = {
      test_args = c(
        "destination_account",
        "destination_asset_type",
        "destination_asset_code",
        "destination_asset_issuer",
        "destination_amount",
        "source_account"
      )

      test_args_present = sapply(test_args, function(i) {
        length(kwargs[[i]]) > 0
      })

      if (all(test_args_present)) {
        response = .getRequest(.requestBuilder_Paths(kwargs, domain))

      } else {
        stop(
          sprintf(
            "Error: some essential arguments weren't supplied. You need to supply: [%s]",
            paste0(names(test_args_present)[!test_args_present], collapse = ", ")
          )
        )
      }


    }
  )

  if (length(kwargs$data.table > 0)) {
    if (kwargs$data.table)
      return(listToDF(response))

  }

  return(response)

}
