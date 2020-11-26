#' Transform semi-structured text into an XML structure
#' 
#' Transforms a character string into an XML structure by identifying (known) 
#' words or phrases that indicates that a new section has started. These words
#' or phrases (known as tags) need to be entered beforehand. Outputs can then
#' be analyzed in other packages such as \code{XML} or \code{xml2}, to extract
#' the interested sections.
#' 
#' @param strings A vector of character strings containing the semi-structured 
#' text. Each string should represent a single entry (e.g. a single letter).
#' @param tags The character strings that identify that a section has started, 
#' e.g. "Diagnosis:" or "SUMMARY:". This may be variable from letter to letter,
#' in which include all variants. Order matters - if there are tags that are
#' contained within larger tags, put the larger tag first so that it is
#' used in the string searches first.
#'
#' @return A vector of character strings with the text transformed into an
#' XML structure.
#'
#'
#' @examples
#' 
#' 
#' @export
txx_text_to_xml <- function(strings, 
                            tags, 
                            # remove = ":"
                            # split_character = "\u00AC"
                            ){

  # TODO: add check for "\u00AC" (or custom split character) in the string and 
  #       warn if there any pre-exising in the strings
  
  # add a <start> to each string
  stringr::str_sub(strings, start = 0, end = 0) <- "<start>"
  
  # use tags to identify sections in text
  strings_tagged <- txx_identify_sections(strings, tags)
  
  # sanitize text outside of tags
  strings_clean <- txx_sanitize_sections(strings_tagged)

  # rename duplicate tags
  strings_deduped <- purrr::map(strings_clean, txx_rename_dup_tags)
  
  # add end tags
  strings_finish <- txx_finish_sections(strings_deduped)
  
  return(strings_finish)

  }