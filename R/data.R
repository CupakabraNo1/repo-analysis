# read csv file safely
read_csv_safe <- function(path, ...) {
  if (!file.exists(path)) {
    stop("File not found: ", path)
  }
  readr::read_csv(path, ...)
}

# count data that need to be fixed
count_bad <- function(df, col_name) {
  x <- as.character(df[[col_name]])
  
  sum(check_bad(x))
}

# check is bad data
check_bad <- function(value) {
  x <- as.character(value)
  
  is.na(x) | trimws(x) == "" | x == "[]"

}

rename_column <- function(col_name) {
  full_change_data <- gsub(' ', '_', tolower(col_name)) 
}

normalize_topic_value <- function(col_name) {
  full_change_data <- gsub(' ', '-', tolower(col_name)) 
}

# convert bytes to MB
bytes_to_mb <- function(bytes) {
  bytes / 1e6
}
