#' Sanitize a tag section within an XML document
#'
#' 
#'
#' @param string 
#'
#' @return
#' @export
#'
#' @examples
txx_sanitize_tag_sections <- function(string) {
  
  stringr::str_replace_all(string = string,
                  pattern = regex("(?<=>).*", dotall = TRUE),
                  replacement = txx_sanitize_text)
  
  
}
