
#' Returns the number of times a string has appeared in the vector in the
#' values before it (as part of the \code{\link{txx_rename_dup_tags}} process)
#'
#' @param strings A character vector of strings
#'
#' @return A numeric vector containing the cumulative number of times the
#' string (in the strings character vector), has appeared in the values before
#' it
#' 
#'
#'
txx_number_seen <- function(strings){
  
  seen <- numeric(length = length(strings))
  
  for(i in seq_along(strings)){
    
    string_i <- strings[i]
    
    seen_up_to_i <- strings[1:i]
    
    seen[i] <- sum(string_i == seen_up_to_i)
    
  }
  
  seen
  
}