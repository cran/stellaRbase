% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/getEffects.R
\name{getEffects}
\alias{getEffects}
\title{Returns all effects.}
\usage{
getEffects(cursor = NULL, limit = 10, order = "asc", data.table = TRUE,
  stream = FALSE)
}
\arguments{
\item{cursor}{numeric - optional, a paging token - where to start from. Can also be "now".}

\item{limit}{numeric - optional, the number of records to return. Default is 10.}

\item{order}{character - optional, "asc" or "desc"}

\item{data.table}{boolean - if TRUE, a data.table is returned. If FALSE or NULL, a list is returned.}

\item{stream}{boolean - if TRUE, a data.table is overwritten and the server-side streaming capability is utilised. A list will be returned.}
}
\value{
data.table or list
}
\description{
Return all effects. Not all are visible on the public ledger.
}
\note{
https://www.stellar.org/developers/horizon/reference/resources/effect.html
}
\examples{
getEffects(limit = 20, order = "asc")
}
