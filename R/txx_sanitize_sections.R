#' Sanitizes the text as part of the txx_text_to_xml process
#' 
#' Splits the text into sections and applies the appropriate sanitize text 
#' functions to each part, then joins it up again.
#' 
#' @param string The full text string
#' @param split The character indicating a section
#' 
#' @return The text string, with each part being sansitized with the appropriate
#' function
#'
#'
txx_sanitize_sections <- function(string, split = "\u00AC") {
  
  strings_split <- stringr::str_split(string, pattern = split)
  
  strings_clean <- purrr::modify(strings_split, function(x){purrr::modify(x, txx_sanitize_tag_sections)})
  
  strings_rjoin <- purrr::modify(strings_clean, function(x){stringr::str_c(x, collapse = split)})
  
  purrr::flatten_chr(strings_rjoin)
  
}