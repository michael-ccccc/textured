#' Title
#'
#' @param strings 
#' @param tags 
#' @param remove 
#'
#' @return
#' @export
#'
#' @examples
#' 
#' 
#' 
txx_text_to_xml <- function(strings, 
                            tags, 
                            remove = ":", 
                            # split_character = "¬"
                            ){

  # add a <start> to each string
  stringr::str_sub(strings, start = 0, end = 0) <- "<start>"
  
  # use tags to identify sections in text
  strings_tagged <- txx_identify_sections(strings, tags, remove = remove)
  
  # sanitize text outside of tags
  strings_clean <- txx_sanitize_sections(strings_tagged)

  # rename duplicate tags
  strings_deduped <- map(strings_clean, txx_rename_dup_tags)
  
  # add end tags
  strings_finish <- txx_strings_finish(strings_deduped)
  
  return(strings_finish)

  }