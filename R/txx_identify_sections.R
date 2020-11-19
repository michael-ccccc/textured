#' Identify sections within text, and wrap in tags
#'
#' This function identifies the tags within a character string, and then wraps
#' the identified text in XML tag syntax. Generally not used outside of the
#' \code{txx_text_to_xml} function, but has its uses.
#' 
#' Note that tag order is important - the first tags are identified first and
#' modify the string. If there is another tag that would have identified a
#' section within that string before the first tag, it would not identify it
#' after.
#' 
#' Tags can be regular expressions - use with caution to avoid mis-identifying
#' sections.
#'
#'
#' @param string A character string of the document to be searched
#' @param tags A vector of character strings - strings used to identify a 
#' section of text
#' @param ignore_case Logic value of whether you want to ignore the case when
#' identifying the sections
#'
#' @return A character string with sections identified and wrapped in an XML tag.
#' 
#'
#' @examples
#' 
#' 
txx_identify_sections <- function(string, tags, ignore_case = TRUE){
  
  for(i in tags){
    
    string <- str_replace_all(string, pattern = regex(i, ignore_case = ignore_case), replacement = txx_wrap_tag)
    
  }
  
  string
  
}