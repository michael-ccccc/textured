

txx_wrap_tag <- function(tag, start = "¬<", end = ">"){
  
  tag <- txx_sanitize_tag_name(tag)
  
  stringr::str_replace_all(tag, pattern = c("^" = start, "$" = end))
  
}