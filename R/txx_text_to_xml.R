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
                            # split_character = "\u00AC"
                            ){

  # TODO: add check for "\u00AC" in the string
  
  # add a <start> to each string
  stringr::str_sub(strings, start = 0, end = 0) <- "<start>"
  
  # use tags to identify sections in text
  strings_tagged <- txx_identify_sections(strings, tags, remove = remove)
  
  # sanitize text outside of tags
  strings_clean <- txx_sanitize_sections(strings_tagged)

  # rename duplicate tags
  strings_deduped <- purrr::map(strings_clean, txx_rename_dup_tags)
  
  # add end tags
  strings_finish <- txx_finish_sections(strings_deduped)
  
  return(strings_finish)

  }