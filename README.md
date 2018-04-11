
# stellaRbase - an R library for Stellar
![](man/figures/logo.png "Stellar Lumens logo")

## Disclaimer

**This is not a project maintained by or officially endorsed by the Stellar Development Foundation.**

## Why?

Community-developed SDKs exist for Python, C#, Java, Go and other languages of choice. This R library acts as an interface to Stellar's Horizon API and hopes to open up the Stellar network to avid R users interested in:

- Performing their own descriptive analytics of the data on the public ledger.
- Building predictive models through techiques such as machine learning models or neural networks, or performing prescriptive analytics.
- Building general or web (R shiny) applications that allow Stellar users to engage with the network and improve XLM adoption.

## Using stellaRbase

The library acts as a wrapper and allows you to call the full range of Horizon API endpoints and resources from your R project. All requests currently do not require you to have any special permissions to use the network, and there is no need to register an application beforehand.

You can use stellaRbase to:

- Create large data sets with data about ledgers, transactions, effects, operations and payments.
- Use the streaming capability to watch ledgers get confirmed in near to real-time, or monitor specific accounts.
- Get details about a specific transaction, account, payment etc.

## Data

Data is delivered as a structured tabular format (a `data.table`) or as a semi-structured list for you to work with the complete set of values. See the examples below for more information.

## Installing stellaRbase

To install directly from CRAN:

```r
install.packages("stellaRbase")
```

To install the beta version directly from this Github repo, install the `devtools` library and do the following:

```r
devtools::install_github("froocpu/stellaRbase") # install.packages("devtools")
```

## TODO
  
### Needs improving/further testing

- `getAssets()`
- `findPaymentPaths()`

### Known issues

- Fix the streaming capability to keep the stream open for longer than a second.

## Examples and walkthrough

### Loading the library
To use the libary in your R code (once you've successfully downloaded it):

```r
library(stellaRbase)
```
### Making requests

You can use the `data.table` parameter on a number of functions to toggle whether you received a list object or a tabular format. `data.table = TRUE` will return a `data.table` for you to work with. `FALSE` will return a list, parsed using the `fromJSON` function.

For example, you can get Effects events as a table:

```r
getEffects(limit = 5)[, c(1,2,4,5,6)]
#                               id  paging_token             type type_i starting_balance
#1: 0000000012884905985-0000000001 12884905985-1  account_created      0       20.0000000
#2: 0000000012884905985-0000000002 12884905985-2  account_debited      3               NA
#3: 0000000012884905985-0000000003 12884905985-3   signer_created     10               NA
#4: 0000000012884905986-0000000001 12884905986-1 account_credited      2               NA
#5: 0000000012884905986-0000000002 12884905986-2  account_debited      3               NA
```

Or as a list:

```r
getEffects(limit = 1, data.table = FALSE)[['_embedded']][['records']]

#[[1]]$id
#[1] "0000000012884905985-0000000001"

#[[1]]$paging_token
#[1] "12884905985-1"

#[[1]]$account
#[1] "GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB"

#[[1]]$type
#[1] "account_created"

#[[1]]$type_i
#[1] 0

#[[1]]$starting_balance
#[1] "20.0000000"
```

### The `collect` function

If you need more than 200 ledger records to work with, you can call a function from the "collect" family of functions native to stellaRbase, or in this case the `collect()` function. Like so:

```r
ledgers = collect(endpoint = "ledgers", n = 100) # This will make multiple calls to the API, collecting 200 rows at a time.
str(ledgers[, 4:12, with=FALSE]) # get an overview of the data frame (minus the hashes, ids etc.)

# Classes ‘data.table’ and 'data.frame':	19528 obs. of  9 variables:
# $ sequence               : int  1 2 3 4 5 6 7 8 9 10 ...
# $ transaction_count      : int  0 0 1 0 0 0 0 0 0 0 ...
# $ operation_count        : int  0 0 3 0 0 0 0 0 0 0 ...
# $ closed_at              : Factor w/ 19528 levels "1970-01-01T00:00:00Z",..: 1 2 3 4 5 6 7 8 9 10 ...
# $ total_coins            : Factor w/ 4 levels "100000000000.0000000",..: 1 1 1 1 1 1 1 1 1 1 ...
# $ fee_pool               : num  0 0 0.00003 0.00003 0.00003 0.00003 0.00003 0.00003 0.00003 0.00003 ...
# $ base_fee_in_stroops    : int  100 100 100 100 100 100 100 100 100 100 ...
# $ base_reserve_in_stroops: int  100000000 100000000 100000000 100000000 100000000 100000000 100000000 100000000 100000000 100000000 ...
# $ max_tx_set_size        : int  100 500 500 500 500 500 500 500 500 500 ...
```
If you would rather with the list object (and treat it like semi-structured data) then you can pass the parameter `data.table = FALSE`.

### Streams

You can stream events in real time from the Horizon server by passing a `stream = TRUE` to a number of functions. For example, this will produce a live stream of ledgers and new records will appear as they are created:

```
getLedgers(stream = TRUE)

# $retry
# [1] "1000"
#
# $event
# [1] "open"
#
# $data
# [1] "\"hello\""
#
# $id
# [1] "4294967296"
#
# $data
# $data$self
#                                   href 
# "https://horizon.stellar.org/ledgers/1" 
#
# $data$transactions
# $data$transactions$href
# [1] "https://horizon.stellar.org/ledgers/1/transactions{?cursor,limit,order}"

# $data$transactions$templated
# [1] TRUE
```

The result will always be a list. **TODO:** Work out how the streaming connection can be kept open for a longer period of time. Passing headers like `Connection: keep-alive` do not seem to work.

### Transactions

Get the latest 10 transactions:

```r
getTransactions(limit = 10)
```

Or get details about a specific transaction:

```r
hash = "b957fd83d5377402ee995d1c3ff4834357f48cbe9a6d42477baad52f1351c155"
getTransactionDetail(hash)
```

Or pull all of the transactions connected to an address:

```r
address = "GCO2IP3MJNUOKS4PUDI4C7LGGMQDJGXG3COYX3WSB4HHNAHKYV5YL3VC"
getTransactions_Account(address)
```

### Trades

Get the latest trade events:

```r
getTrades(limit = 10, order = "desc")
```

### Accounts

Get information about a particular account on the ledger:

```r
getAccount(address)
```

### Ledgers

Get the latest n ledgers in a single, one-off call:

```r
getLedgers(limit = 10, order = "desc")
```

Or you can get the transactions appended to a specific ledger:

```r
getTransactions_Ledger(17008514)
```

### Trades and trade aggregations

Get the latest trades:

```r
getTrades()
```

Or trade aggregations, direct from the API:

```r
start_time <- "1512689100000"
end_time <- "1512775500000"
resolution <- "300000"

base_asset_type <- "native"

counter_asset_type <- "credit_alphanum4"
counter_asset_code <- "BTC"
counter_asset_issuer <- "GATEMHCCKCY67ZUCKTROYN24ZYT5GK4EQZ65JJLDHKHRUZI3EUEKMTCH"

getTradeAggregations(start_time, end_time, resolution,
                     base_asset_type = base_asset_type,
                     counter_asset_type = counter_asset_type,
                     counter_asset_code = counter_asset_code,
                     counter_asset_issuer = counter_asset_issuer,
                     data.table = TRUE)
```

### Payments

Get payments data:

```r
getPayments(limit = 20, order = "desc")
```

Or payments from a specific account:

```r
test_address = "GA2HGBJIJKI6O4XEM7CZWY5PS6GKSXL6D34ERAJYQSPYA6X6AI7HYW36"

getPayments_Account(test_address, data.table = TRUE)
```

Using the `collect` function:

```r
collect(endpoint = "payments", n = 15)
```

### Sample data sets

You can experiment with sample responses from the Horizon data sets with the .rda files in the `/data` directory. They are exported with the main functions in the R package, so you can reference them like so:

```r
summary(stellaRbase::test_effects)

#          Length Class  Mode
#_links    3      -none- list
#_embedded 1      -none- list

summary(listToDF(stellaRbase::test_ledgers)[, 4:12, with=FALSE])

#    sequence     transaction_count operation_count                closed_at               total_coins
# Min.   : 1.00   Min.   :0.0       Min.   :0.0     1970-01-01T00:00:00Z:1   100000000000.0000000:10  
# 1st Qu.: 3.25   1st Qu.:0.0       1st Qu.:0.0     2015-09-30T16:46:54Z:1                            
# Median : 5.50   Median :0.0       Median :0.0     2015-09-30T17:15:54Z:1                            
# Mean   : 5.50   Mean   :0.1       Mean   :0.3     2015-09-30T17:15:59Z:1                            
# 3rd Qu.: 7.75   3rd Qu.:0.0       3rd Qu.:0.0     2015-09-30T17:16:04Z:1                            
# Max.   :10.00   Max.   :1.0       Max.   :3.0     2015-09-30T17:16:09Z:1                            
                                                   (Other)             :4                            
#    fee_pool        base_fee_in_stroops base_reserve_in_stroops max_tx_set_size
# Min.   :0.000000   Min.   :100         Min.   :100000000       Min.   :100    
# 1st Qu.:0.000030   1st Qu.:100         1st Qu.:100000000       1st Qu.:500    
# Median :0.000030   Median :100         Median :100000000       Median :500    
# Mean   :0.000024   Mean   :100         Mean   :100000000       Mean   :460    
# 3rd Qu.:0.000030   3rd Qu.:100         3rd Qu.:100000000       3rd Qu.:500    
# Max.   :0.000030   Max.   :100         Max.   :100000000       Max.   :500
```

