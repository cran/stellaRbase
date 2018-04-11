#' Convert parsed JSON responses to a tabular format.
#' @description Takes a successful response containing multiple records and converts it into a table format.
#'     It works by flattening semi-structured lists into a table where it can.
#'     For example, if there are multiple signatures to a transaction then it will warn the user before converting those values into a delimited list.
#' @param data list
#' @return data.table
#' @export
#' @examples
#' txns = listToDF(stellaRbase::test_effects); summary(txns)

listToDF <- function(data){
  if (length(data[['_embedded']]) > 0)
    data = list(data)

  records = lapply(seq_along(data), function(i) {
    recs = data[[i]][['_embedded']][['records']]
    any_uniform_lists = length(unique(unlist(lapply(recs, function(j) {
      sapply(j[-1], length)
    })))) > 1

    if (any_uniform_lists) {
      warning(
        "Warning: contains columns with non-uniform lists. They will be concatenated using a pipe symbol.\r\nFor example, a row with multiple signitures like this:\r\nc(1,2,3)\r\nWill be concatenated to:\r\n\"1|2|3\""
      )
    }

    flattened_records = lapply(recs, function(record) {
      lapply(record[-1], function(vals)
        paste(vals, collapse = "|"))
    })

    pivoted = lapply(seq_along(flattened_records), function(j) {
      these = unlist(flattened_records[[j]])
      return(data.table(
        row_id = paste0(i, "-", j),
        variable = names(these),
        value = unname(these)
      ))
    })

    return(rbindlist(pivoted))

  })

  data_bind = rbindlist(records)
  data_casted = dcast.data.table(data_bind, row_id ~ variable, fun.aggregate = min)
  data_casted[] = lapply(data_casted, function(col) {
    type.convert(as.character(col), numerals = "no.loss")
  })

  return(unique(data_casted[,-1, with = FALSE]))

}

