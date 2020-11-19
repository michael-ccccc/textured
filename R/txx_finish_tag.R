

txx_finish_tag <- function(string) {
  
  tag <- stringr::str_extract(string, pattern = "<.*>")
  
  end_tag <- tag
  
  stringr::str_sub(end_tag, start = 2, end = 1) <- "/"
  
  stringr::str_c(string, end_tag, sep = "")
  
}