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
languages_other <- data.frame(language = "Other",
                              Freq = sum(languages_other$count)
                              )
names(languages_other)[names(languages_other) == 'Var1'] <- 'language'
names(languages_other)[names(languages_other) == 'Freq'] <- 'count'
languages_other$percent <- sum(languages_other$count) / total_data * 100

## combine top and other data frame
languages_all <- rbind(languages_top, languages_other)

## create barplot of language frequency
png("outputs/images/top_languages.png", width = 800, height = 600, res = 100) #
barplot(languages_all$count,
        names.arg = languages_all$language,
        las = 2,
        cex.names = 0.5,
        col = "steelblue",
        main = "Top languages",
        ylab = "Count"
        )
dev.off()

# projects without maintenance

## calculate days inactive
data$updated_at_date <- as.Date(data$updated_at)
data$days_inactive <- as.numeric(as.Date("2023-12-31") - data$updated_at_date)

## create hist of data
png("outputs/images/days_inactive.png", width = 800, height = 600, res = 100)
hist(data$days_inactive,
     breaks = 50,
     col = "lightgreen",
     main = "Days since last repository update",
     xlab = "Days inactive"
     )
dev.off()

	
# size vs watchers

png("outputs/images/size_x_watchers.png", width = 800, height = 600, res = 100) #

plot(bytes_to_mb(data$size),
  (data$watchers/1000),
  col = "salmon",
  xlab = "Project size (in MB) ",
  ylab = "Watchers (in K)",
  main = "Project size vs watchers"
)
dev.off()

# watchers density
png("outputs/images/watchers_normal.png", width = 800, height = 600, res = 100) 

## adjust watcher data
x <- log10(data$watchers + 1)

hist(log_watchers,
     breaks = 50,
     probability = TRUE,
     col = "lightgray",
     border = "white",
     main = "Distribution of Log10(Watchers + 1)",
     xlab = "Log10(Watchers + 1)")

mu <- mean(x)
sigma <- sd(x)


curve(dnorm(x, mean = mu, sd = sigma),
      col = "red",
      lwd = 2,
      add = TRUE)

dev.off()

# size density

png("outputs/images/sizes_normal.png", width = 800, height = 600, res = 100) 
size_s <- bytes_to_mb(data$size)
hist(size_s,
     breaks = 50,
     col = "steelblue",
     border = "white",
     main = "Size distribution",
     xlab = "Size (MB)")

qqnorm(size_s,
       main = "Q-Q normality plot",
       pch = 16,
       col = "darkblue")

qqline(size_s,
       col = "red",
       lwd = 2)

dev.off()


# data about top languages

## calculate average star by language
calculated_data <- data[data$language %in% languages_top$language, ]
?aggregate
avg_stars_by_language <- aggregate(
  stars ~ language,
  data = calculated_data,
  FUN = mean,
  na.rm = TRUE
)

## order descending
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
