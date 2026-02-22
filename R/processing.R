# COLUMN NAME FIX

## rename columns 
for (name in names(data)) {
  names(data)[names(data) == name] <- rename_column(name)
}

# FIX MISSING DATA

## total number of data form mandatory field
total_data <- length(data$url)
cat('Total number of data: ', total_data)

## check bad data in data set
for (name in names(data)) {
  cat(name, count_bad(data, name), '\n')
}

## remove rows where name is empty
data <- data[!is.na(data$name), ]

## turn NA to 'No description' for description column
data$description[is.na(data$description)] <- "No description"

## turn NA to 'No homepage' for homepage column
data$homepage[is.na(data$homepage)] <- "No homepage"

## turn NA to 'No main language' for language column
data$language[is.na(data$language)] <- "No main language"

## turn NA to 'No license' for license column
data$license[is.na(data$license)] <- "No license"

## fix topics column
idx <- check_bad(data$topics)

data$topics[idx] <-
  ifelse(
    check_bad(data$language[idx]),
    "[]",
    paste0("[ '", normalize_topic_value(data$language[idx]), "' ]")
  )