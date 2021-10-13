
<!-- README.md is generated from README.Rmd. Please edit that file -->

# httc

<!-- badges: start -->

[![Lifecycle:
experimental](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
<!-- badges: end -->

httc makes it easy to quickly cache HTTP responses according to cache
control headers with drop in wrappers for
[httr](https://httr.r-lib.org/) verbs. For more control over caching
behaviour, `caching()` lets you customize your own cached function.

## Installation

httc is not on CRAN. You can install the development version on GitHub
with:

``` r
remotes::install_github("mikmart/httc")
```

## Example

Drop in a `httc::GET` instead of `httr::GET` to honour cache control
headers:

``` r
# Response header specifies two seconds of caching
cached_request <- function() {
  try(httc::GET("https://httpbin.org/cache/2"))
}

system.time(cached_request()) # First response from server
#>    user  system elapsed 
#>    0.12    0.09    1.21
system.time(cached_request()) # Second uses cached result
#>    user  system elapsed 
#>    0.01    0.00    0.01
Sys.sleep(2)
system.time(cached_request()) # Re-requested from server
#>    user  system elapsed 
#>    0.02    0.00    0.13
```
