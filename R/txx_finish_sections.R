#' Adds end tags to match start tags.
#' 
#' Splits a string into the (incomplete) tagged sections according to the split 
#' character, then identifies the start tag and adds a corresponding end tag,
#' and then recombines it into a single string.
#'
#' @param string The character string containing a single entry. Should have
#' already been through the xml-transforming process so should have start
#' sections identified and wrapped into a start tag.
#' @param split The character that is used to split the string
#'
#' @return A character string; a modified of \code{string}
#' 
#'
#' @examples
#' 
#' 
#' 
txx_finish_sections <- function(string, split = "\u00AC") {
  
  strings_split <- stringr::str_split(string, pattern = split)
  
  strings_ended <- purrr::modify(strings_split, txx_finish_tag)
  
  strings_rjoin <- purrr::modify(strings_ended, function(x){stringr::str_c(x, collapse = "")})
  
  purrr::flatten_chr(strings_rjoin)
  
}
