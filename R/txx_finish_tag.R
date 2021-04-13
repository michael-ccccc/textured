#' Create the finish tag (part of the txx_finish_tag process)
#' 
#' Extracts the start tag, and uses it to create the end tag (see
#' \code{\link{txx_finish_sections}} for the full process).
#'
#' @param string A text string containing only one start tag
#'
#' @return A text string of the end tag
#'
txx_finish_tag <- function(string) {
  
  tag <- stringr::str_extract(string, pattern = "<.*>")
  
  end_tag <- tag
  
  stringr::str_sub(end_tag, start = 2, end = 1) <- "/"
  
  stringr::str_c(string, end_tag, sep = "")
  
}