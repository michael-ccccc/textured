#' Test test test
#' 
#' test test test
#' 
#' @param strings 
#' @param tags 
#' @param remove 
#'
#' @return
#'
#'
#' @examples
#' 
#' 
#' @export
txx_text_to_xml <- function(strings, 
                            tags, 
                            remove = ":"
                            # split_character = "¬"
                            ){

  # add a <start> to each string
  stringr::str_sub(strings, start = 0, end = 0) <- "<start>"
  
  #message(strings)
  
  # use tags to identify sections in text
  strings_tagged <- txx_identify_sections(strings, tags, remove = remove)
  
  #message(strings_tagged)
  
  # sanitize text outside of tags
  strings_clean <- txx_sanitize_sections(strings_tagged)

  #message(strings_clean)
  
  # rename duplicate tags
  strings_deduped <- purrr::map(strings_clean, txx_rename_dup_tags)
  
  #message(strings_deduped)
  
  # add end tags
  strings_finish <- txx_finish_sections(strings_deduped)
  
  #message(strings_finish)
  
  return(strings_finish)

  }