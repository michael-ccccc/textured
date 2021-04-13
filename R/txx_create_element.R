

#' Create an XML element from a string
#' 
#' Converts a string into an XML element by adding start and end tags. The
#' string can also be an XML element, allowing for easy nesting of XML
#' elements.
#' 
#' @param string A character string
#' @param tag The character string used in the start and end tags.
#'
#' @return A character string wrapped in the tag start and end tags.
#' 
#' @examples
#' txx_create_element(string = "Alice", tag = "name")
#' 
#' txx_create_element(string = "<name>Alice</name><age>53</age>",
#'                    tag = "patient")
#' 
#' 
#' @export
txx_create_element <- function(string, tag){
  
  # TODO: add check on valid tag name - alphanumeric and _ only, first character
  # can't be a number.
  
  tag_start <- stringr::str_c("<", tag, ">")
  
  tag_end <- stringr::str_c("</", tag, ">")
  
  stringr::str_c(tag_start, string, tag_end)
  
}