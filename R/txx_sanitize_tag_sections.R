#' Sanitize a tag section within an XML document
#' 
#' Identifies the section within a tag (actually after a tag once split), and
#' sanitizes the text of the section (see \code{txx_sanitize_text})
#' 
#'
#' @param string String consisting of \code{<tag>section}
#'
#' @return String with \code{section} sanitized for use in an XML document
#' 
#'
#' 
#' 
txx_sanitize_tag_sections <- function(string) {
  
  stringr::str_replace_all(string = string,
                  pattern = stringr::regex("(?<=>).*", dotall = TRUE),
                  replacement = txx_sanitize_text)
  
  
}
