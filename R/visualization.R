# most popular language

## count language frequency in data-set and arange them
languages <- as.data.frame(table(data$language))
names(languages)[names(languages) == 'Var1'] <- 'language'
names(languages)[names(languages) == 'Freq'] <- 'count'
languages <- languages[order(-languages$count), ]
languages$percent <- languages$count / total_data * 100

## split into top 20 and combine rest into one observation
languages_top <- head(languages, 20)

languages_other <- languages[-(1:20), ]
languages_other <- data.frame(
  language = "Other",
  Freq = sum(languages_other$count)
)
names(languages_other)[names(languages_other) == 'Var1'] <- 'language'
names(languages_other)[names(languages_other) == 'Freq'] <- 'count'
languages_other$percent <- sum(languages_other$count) / total_data * 100

## combine top and other data frame
languages_all <- rbind(languages_top, languages_other)

## create barplot of language frequency
png("outputs/images/top_languages.png", width = 800, height = 600, res = 100) #
barplot(
  languages_all$count,
  names.arg = languages_all$language,
  las = 2,
  cex.names = 0.5,
  col = "steelblue",
  main = "Top languages",
  ylab = "Count"
)
dev.off()

# projects without maintenance
data$updated_at_date <- as.Date(data$updated_at)
data$days_inactive <- as.numeric(as.Date("2023-12-31") - data$updated_at_date)
png("outputs/images/days_inactive.png", width = 800, height = 600, res = 100) #
hist(
  data$days_inactive,
  breaks = 50,
  col = "lightgreen",
  main = "Days since last repository update",
  xlab = "Days inactive"
)
dev.off()

# size vs watchers
getwd()
png("outputs/images/size_x_watchers.png", width = 800, height = 600, res = 100) #
plot(
  bytes_to_mb(data$size),
  (data$watchers/1000),
  col = "salmon",
  xlab = "Project size (in MB) ",
  ylab = "Watchers (in K)",
  main = "Project size vs watchers"
)
dev.off()

# data about top languages
calculated_data <- data[data$language %in% languages_top$language, ]
avg_stars_by_language <- aggregate(
  stars ~ language,
  data = calculated_data,
  FUN = mean,
  na.rm = TRUE
)

avg_stars_by_language <- avg_stars_by_language[
  order(-avg_stars_by_language$stars),
]

png("outputs/images/stars_by_language.png", width = 800, height = 600, res = 100) #
barplot(
  avg_stars_by_language$stars,
  names.arg = avg_stars_by_language$language,
  las = 2,
  col = "steelblue",
  main = "Average stars by top languages",
  ylab = "Average stars"
)
dev.off()
