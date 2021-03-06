% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getOperations_Account.R
\name{getOperations_Account}
\alias{getOperations_Account}
\title{Get an overview of account operations on the Stellar ledger.}
\usage{
getOperations_Account(public_key, cursor = NULL, limit = 10,
  order = "asc", data.table = TRUE)
}
\arguments{
\item{public_key}{character - your Stellar account/wallet address.}

\item{cursor}{numeric - optional, a paging token - where to start from. Can also be "now".}

\item{limit}{numeric - optional, the number of records to return. Default is 10.}

\item{order}{character - optional, "asc" or "desc"}

\item{data.table}{boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.}
}
\value{
data.table (default) or list
}
\description{
Returns all operations that were included in valid transactions that affected a particular account. Converts the JSON response to a list.
}
\note{
https://www.stellar.org/developers/horizon/reference/endpoints/operations-for-account.html
}
\examples{
\donttest{getOperations_Account("GsomeAccount", order = "asc")}
}
