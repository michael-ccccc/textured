
txx_finish_sections <- function(string, split = "¬") {
  
  strings_split <- stringr::str_split(string, pattern = split)
  
  strings_ended <- purrr::modify(strings_split, txx_finish_tag)
  
  strings_rjoin <- purrr::modify(strings_ended, function(x){stringr::str_c(x, collapse = "")})
  
  purrr::flatten_chr(strings_rjoin)
  
}
