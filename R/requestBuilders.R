#' requestBuilders
#' @description Child functions for the parent requestBuilder function.
#' @param domain string - Testnet or mainnet
#' @param kwargs list - a list of parameters to append to the HTTP request.
#' @return character

.requestBuilder_Account <- function(kwargs, domain) {
  if (length(kwargs$resource) > 0) {
    if (kwargs$resource == "data" && length(kwargs$key) == 1) {
      url = sprintf("https://%s/accounts/%s/data/%s",
                    domain,
                    kwargs$account,
                    kwargs$key)
      return(url)
    }

    if (kwargs$resource %in% c("effects",
                               "offers",
                               "operations",
                               "payments",
                               "transactions")) {
      url = sprintf(
        "https://%s/accounts/%s/%s?limit=%s&order=%s&cursor=%s",
        domain,
        kwargs$account,
        kwargs$resource,
        .checkLength(kwargs$limit),
        .checkLength(kwargs$order),
        .checkLength(kwargs$cursor)
      )

      return(url)
    }

  }

  return(sprintf("https://%s/accounts/%s", domain, kwargs$account))

}

.requestBuilder_Assets <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/assets?limit=%s&order=%s&cursor=%s&asset_code=%s&asset_issuer=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor),
      .checkLength(kwargs$asset_code),
      .checkLength(kwargs$asset_issuer)
    )
  )
}

.requestBuilder_Effects <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/effects?limit=%s&order=%s&cursor=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor)
    )
  )
}

.requestBuilder_Ledger <- function(kwargs, domain) {
  if (length(kwargs$ledger) > 0) {
    if (length(kwargs$resource) > 0) {
      if (kwargs$resource %in% c("effects", "operations", "payments", "transactions")) {
        url = sprintf(
          "https://%s/ledgers/%s/%s?limit=%s&order=%s&cursor=%s",
          domain,
          kwargs$ledger,
          kwargs$resource,
          .checkLength(kwargs$limit),
          .checkLength(kwargs$order),
          .checkLength(kwargs$cursor)
        )
        return(url)
      }

    }

    return(sprintf("https://%s/ledgers/%s", domain, kwargs$ledger))

  } else {
    url = sprintf(
      "https://%s/ledgers?limit=%s&order=%s&cursor=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor)
    )

    return(url)

  }

}

.requestBuilder_Operations <- function(kwargs, domain) {
  if (length(kwargs$id) > 0) {
    return(sprintf("https://%s/operations/%s", domain, kwargs$id))
  }

  return(
    sprintf(
      "https://%s/operations?limit=%s&order=%s&cursor=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor)
    )
  )
}

.requestBuilder_Orderbook <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/order_book?selling_asset_type=%s&selling_asset_code=%s&selling_asset_issuer=%s&buying_asset_type=%s&buying_asset_code=%s&buying_asset_issuer=%s&limit=%s",
      domain,
      .checkLength(kwargs$selling_asset_type),
      .checkLength(kwargs$selling_asset_code),
      .checkLength(kwargs$selling_asset_issuer),
      .checkLength(kwargs$buying_asset_type),
      .checkLength(kwargs$buying_asset_code),
      .checkLength(kwargs$buying_asset_issuer),
      .checkLength(kwargs$limit)
    )
  )
}

.requestBuilder_Paths <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/paths?destination_account=%s&source_account=%s&destination_asset_type=%s&destination_asset_code=%s&destination_asset_issuer=%s&destination_amount=%s",
      domain,
      .checkLength(kwargs$destination_account),
      .checkLength(kwargs$source_account),
      .checkLength(kwargs$destination_asset_type),
      .checkLength(kwargs$destination_asset_code),
      .checkLength(kwargs$destination_asset_issuer),
      .checkLength(kwargs$destination_amount)
    )
  )
}

.requestBuilder_Payments <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/payments?limit=%s&order=%s&cursor=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor)
    )
  )
}

.requestBuilder_TradeAggregations <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/trade_aggregations?limit=%s&order=%s&start_time=%s&end_time=%s&resolution=%s&base_asset_type=%s&base_asset_code=%s&base_asset_issuer=%s&counter_asset_type=%s&counter_asset_code=%s&counter_asset_issuer=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$start_time),
      .checkLength(kwargs$end_time),
      .checkLength(kwargs$resolution),
      .checkLength(kwargs$base_asset_type),
      .checkLength(kwargs$base_asset_code),
      .checkLength(kwargs$base_asset_issuer),
      .checkLength(kwargs$counter_asset_type),
      .checkLength(kwargs$counter_asset_code),
      .checkLength(kwargs$counter_asset_issuer)
    )
  )
}

.requestBuilder_Trades <- function(kwargs, domain) {
  return(
    sprintf(
      "https://%s/trades?limit=%s&order=%s&cursor=%s&base_asset_type=%s&base_asset_code=%s&base_asset_issuer=%s&counter_asset_type=%s&counter_asset_code=%s&counter_asset_issuer=%s&offer_id=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor),
      .checkLength(kwargs$base_asset_type),
      .checkLength(kwargs$base_asset_code),
      .checkLength(kwargs$base_asset_issuer),
      .checkLength(kwargs$counter_asset_type),
      .checkLength(kwargs$counter_asset_code),
      .checkLength(kwargs$counter_asset_issuer),
      .checkLength(kwargs$offer_id)
    )
  )
}

.requestBuilder_Transaction <- function(kwargs, domain) {
  if (length(kwargs$hash) > 0) {
    if (length(kwargs$resource) > 0) {
      if (kwargs$resource %in% c("effects", "operations", "payments")) {
        url = sprintf(
          "https://%s/transactions/%s/%s?limit=%s&order=%s&cursor=%s",
          domain,
          kwargs$hash,
          kwargs$resource,
          .checkLength(kwargs$limit),
          .checkLength(kwargs$order),
          .checkLength(kwargs$cursor)
        )
        return(url)
      }

    }

    return(sprintf("https://%s/transactions/%s", domain, kwargs$hash))

  } else {
    url = sprintf(
      "https://%s/transactions?limit=%s&order=%s&cursor=%s",
      domain,
      .checkLength(kwargs$limit),
      .checkLength(kwargs$order),
      .checkLength(kwargs$cursor)
    )

    return(url)

  }

}
