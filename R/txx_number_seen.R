
#' Title
#'
#' @param strings 
#'
#' @return
#' @export
#'
#' @examples
txx_number_seen <- function(strings){
  
  seen <- numeric(length = length(strings))
  
  for(i in seq_along(strings)){
    
    string_i <- strings[i]
    
    seen_up_to_i <- strings[1:i]
    
    seen[i] <- sum(string_i == seen_up_to_i)
    
  }
  
  seen
  
}