

#' Create an XML element from a string
#'
#' @param string 
#' @param tag 
#'
#' @return
#' 
#'
#' @examples
#' 
#' @export
txx_create_element <- function(string, tag){
  
  tag_start <- stringr::str_c("<", tag, ">")
  
  tag_end <- stringr::str_c("</", tag, ">")
  
  stringr::str_c(tag_start, string, tag_end)
  
}