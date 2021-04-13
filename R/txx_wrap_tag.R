#' Turn text into an XML tag
#'
#' Turns some text into an XML tag sanitizing the text to be suitable for
#' use as an XML tag, then wrapping it in \code{<} and \code{>}.
#'
#' @param tag The text to turn into a tag
#' @param start The first character to wrap the text in
#' @param end The last character to wrap the text in
#' @param split_character For use in the structuring process. Should be a 
#' character that is not seen in the document.
#'
#' @return A character string of the text as an XML tag
#'
#' 
txx_wrap_tag <- function(tag, split_character = "\u00AC", start = "<", end = ">"){
  
  start <- stringr::str_c(split_character, start, collapse = "")
  
  tag <- txx_sanitize_tag_name(tag)
  
  stringr::str_replace_all(tag, pattern = c("^" = start, "$" = end))
  
}
