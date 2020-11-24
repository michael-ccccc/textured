#' Sanitize text for use as an XML tag
#'
#' This function takes a character string, and returns a 'sanitized' version
#' of it for use as an XML tag (following XML specifications - more details 
#' below). This function is called internally, however is useful in searching
#' for a specific text tag(s).
#' 
#' 
#' Changes made to the text (in this order): 
#' \enumerate{
#'    \item Trims any white space around the tag, 
#'    \item Changes text to title case, 
#'    \item Replaces all ' ' with '_', 
#'    \item Removes any non-alphanumeric characters (aside from '_'), 
#'    \item Prefixes a '_' if the text starts with a number.
#' }
#' @param tag_name A character string
#'
#' @return The character string, modified to be suitable for use as an XML tag
#'
#' @examples
#' 
#'
txx_sanitize_tag_name <- function(tag_name){
  # TODO: workout a better order for all this
    
  tag_name <- stringr::str_trim(tag_name)
  
  tag_name <- stringr::str_to_title(tag_name)
  # note str_to_title() treats '_' as not a space, other symbols as a space

  tag_name <- stringr::str_replace_all(tag_name, " ", "_")
  
  tag_name <- stringr::str_remove_all(tag_name, "[^A-Za-z0-9_]")
  
  tag_name <- stringr::str_replace_all(tag_name, "^[0-9]", replacement = function(x){paste0("_", x)})
  
  tag_name
  
}
