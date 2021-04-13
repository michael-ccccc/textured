#' Sanitize text to be stored as data in an XML document
#'
#' This function takes a character string and returns a 'sanitized' version,
#' suitable for storage as text within an XML document.
#'
#' This function replaces any special characters within XML, and replaces them
#' with the relevant XML escaped characters. As they are read in as XML, they
#' should be transformed back into the proper version.
#'
#' @param text A character string
#'
#' @return A modified character string
#'
#' @examples
#' txx_sanitize_text("Alice & Bob have been in \"Charlie's\" house for >5 minutes.")
#'
#' @export
txx_sanitize_text <- function(text) {
  
  # stopifnot(class(text) == "character", )
  
  stringr::str_replace_all(text,
                       pattern = c(
                         "&" = "&amp;",
                         "<" = "&lt;",
                         ">" = "&gt;",
                         "'" = "&apos;",
                         "\"" = "&quot;"
                       ))
  
  
}