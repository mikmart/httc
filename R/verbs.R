#' Caching versions of httr verbs
#'
#' Memory-caching versions of [httr] verbs that honour cache control headers. If
#' you need more control over the caching, create your own with [caching()].
#'
#' @param ... Arguments passed on to the corresponding [httr] verb.
#' @return Result of original verb, but from a cache if applicable.
#'
#' @examples
#' # Response header specifies two seconds of caching
#' cached_request <- function() {
#'   try(httc::GET("https://httpbin.org/cache/2"))
#' }
#'
#' system.time(cached_request()) # First response from server
#' system.time(cached_request()) # Second uses cached result
#' Sys.sleep(2)
#' system.time(cached_request()) # Re-requested from server
#'
#' @name verbs
NULL

#' @rdname verbs
#' @export
BROWSE <- caching(httr::BROWSE)

#' @rdname verbs
#' @export
DELETE <- caching(httr::DELETE)

#' @rdname verbs
#' @export
GET <- caching(httr::GET)

#' @rdname verbs
#' @export
HEAD <- caching(httr::HEAD)

#' @rdname verbs
#' @export
PATCH <- caching(httr::PATCH)

#' @rdname verbs
#' @export
POST <- caching(httr::POST)

#' @rdname verbs
#' @export
PUT <- caching(httr::PUT)

#' @rdname verbs
#' @export
VERB <- caching(httr::VERB)
