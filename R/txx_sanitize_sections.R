#' Sanitizes the text as part of the txx_text_to_xml process
#'
#'
#'
txx_sanitize_sections <- function(string, split = "\u00AC") {
  
  strings_split <- stringr::str_split(string, pattern = split)
  
  strings_clean <- purrr::modify(strings_split, function(x){purrr::modify(x, txx_sanitize_tag_sections)})
  
  strings_rjoin <- purrr::modify(strings_clean, function(x){stringr::str_c(x, collapse = split)})
  
  purrr::flatten_chr(strings_rjoin)
  
}