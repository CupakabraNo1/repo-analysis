
# popularity and maintenance

## define maintenance variables
vars <- c("forks", "days_inactive", "issues")

## apply function over a list of vectors
results <- lapply(vars, function(v) {
  ### execute test
  test <- cor.test(data$stars, data[[v]], method = "pearson")
  
  ### write result to dataframe row
  data.frame(
    variable = v,
    correlation = round(test$estimate, 4),
    p_value = signif(test$p.value, 3),
    ci_lower = round(test$conf.int[1], 4),
    ci_upper = round(test$conf.int[2], 4)
  )
})

## clean data and write to file
results_table <- do.call(rbind, results)
rownames(results_table) <- NULL
results_table
write.table(
  results_table,
  file = "outputs/results/popularity_and_maintenance.csv",
  sep = ",",
  row.names = FALSE,
  quote = FALSE
)

# popularity and size

## tests Pearson
correlation_size_p <- cor.test(data$stars, data$size, method = "pearson")

correlation_size_p

sink("outputs/results/correlation_size_p.txt")
print(correlation_size_p)
sink()


## test Spearman
correlation_size_s <- cor.test(data$stars, data$size, method = "spearman")

correlation_size_s

sink("outputs/results/correlation_size_s.txt")
print(correlation_size_s)
sink()


## combine results
results <- data.frame(  test = c("Pearson", "Spearman"),
  correlation = c(correlation_size_p$estimate,
                  correlation_size_s$estimate),
  p_value = c(correlation_size_p$p.value,
              correlation_size_s$p.value),
  conf_low = c(correlation_size_p$conf.int[1], NA),
  conf_high = c(correlation_size_p$conf.int[2], NA)
)

rownames(results) <- NULL

write.table(
  results,
  file = "outputs/results/popularity_size.csv",
  sep = ",",
  row.names = FALSE,
  quote = FALSE
)

# popularity and popularity of language
languages_sorted <- languages[languages$language != 'No main language', ]
data_with_language <- data[data$language != 'No main language', ]

languages_sorted$popularity <- nrow(languages_sorted):1

data_with_language$popularity_of_language <- languages_sorted$popularity[match(data_with_language$language, languages_sorted$language)]

## H0 -> repository with more popular language is also more stared
correlation_language_popularity <- cor.test(data_with_language$stars, data_with_language$popularity_of_language, method = 'pearson')
correlation_language_popularity

png("outputs/images/stars_vs_language_popularity.png", width = 800, height = 600, res = 100) #
ggplot(data_with_language, 
       aes(x = popularity_of_language, 
           y = log10(stars + 1))) +
  geom_hex(bins = 50) +
  geom_smooth(method = "lm", 
              color = "white", 
              se = FALSE) +
  scale_fill_viridis_c() +
  labs(
    title = "Stars vs Language Popularity (Hexbin Density)",
    x = "Language Popularity",
    y = "Log10(Stars + 1)",
    fill = "Count"
  ) +
  theme_minimal()
dev.off()
