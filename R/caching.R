#' Create a function that honours HTTP caching headers
#'
#' @param f A function that returns an [httr::response].
#' @param cache A cache object to control caching. See [cachem::cache_mem()].
#'
#' @return `f` with the response cached according to [httr::cache_info()]. The
#'   given `cache` object is available in the `"cache"` attribute.
#'
#' @seealso Pre-wrapped [httr] [verbs].
#'
#' @examples
#' # Use a disk cache for persistent caching across sessions
#' disk_cached_get <- caching(httr::GET, cachem::cache_disk())
#'
#' # Inspect the cache object
#' str(attr(disk_cached_get, "cache")$info())
#' @export
caching <- function(f, cache = cachem::cache_mem()) {
  g <- function(...) {
    cache_key <- rlang::hash(list(...))
    cached <- cache$get(cache_key)
    if (cachem::is.key_missing(cached)) {
      response <- f(...)
    } else {
      response <- rerequest(cached)
    }
    if (is_cacheable(response)) {
      cache$set(cache_key, response)
    }
    response
  }
  attr(g, "cache") <- cache
  g
}

rerequest <- function(response) {
  tryCatch(
    httr::rerequest(response),
    error = function(e) {
      # Work around "handle is dead" from disk storage
      hu <- httr::handle_find(response$url)
      response$handle <- hu$handle
      httr::rerequest(response)
    }
  )
}

is_cacheable <- function(response) {
  httr::cache_info(response)$cacheable
}
