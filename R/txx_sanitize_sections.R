txx_sanitize_sections <- function(string, split = "¬") {
  
  strings_split <- stringr::str_split(string, "¬")
  
  strings_clean <- purrr::modify(strings_split, function(x){purrr::modify(x, txx_sanitize_tag_sections)})
  
  strings_rjoin <- purrr::modify(strings_clean, function(x){stringr::str_c(x, collapse = "¬")})
  
  purrr::flatten_chr(strings_rjoin)
  
}