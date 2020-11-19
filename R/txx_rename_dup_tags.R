

txx_rename_dup_tags <- function(string){
  
  tags <- stringr::str_extract_all(string, pattern = "(?<=<).*?(=>)")[[1]]
  
  tags_seen <- txx_number_seen(tags)
  
  tags_positions <- stringr::str_locate_all(string, pattern = "(?<=<).*?(?=>)")[[1]][,2]
  
  tags_replace <- !tags_seen == 1
  
  tags_labels <- tags_seen[tags_replace]
  
  tags_replace_positions <- tags_positions[tags_replace]
  
  tags_order <- order(tags_replace_positions, decreasing = TRUE)
  
  for(i in tags_order){
    
    tags_replace_position_i <- tags_replace_positions[i]
    
    tags_label_i <- tags_labels[i]
    
    stringr::str_sub(string,
                     start = tags_replace_position_i + 1,
                     end = tags_replace_position_i) <- tags_label_i
    
  }
  
}