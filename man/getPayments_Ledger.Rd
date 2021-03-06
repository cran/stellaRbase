% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getPayments_Ledger.R
\name{getPayments_Ledger}
\alias{getPayments_Ledger}
\title{Get an overview of payments on the Stellar ledger.}
\usage{
getPayments_Ledger(ledger, cursor = NULL, limit = 10, order = "asc",
  data.table = TRUE)
}
\arguments{
\item{ledger}{numeric - a ledger ID.}

\item{cursor}{numeric - optional, a paging token - where to start from. Can also be "now".}

\item{limit}{numeric - optional, the number of records to return. Default is 10.}

\item{order}{character - optional, "asc" or "desc"}

\item{data.table}{boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.}
}
\value{
data.table (by default) or list
}
\description{
Returns all payments from valid transactions that affected a particular ledger. Converts the JSON response to a list.
}
\note{
https://www.stellar.org/developers/horizon/reference/endpoints/payments-for-ledger.html
}
\examples{
\donttest{getPayments_Ledger(10000)}
}
