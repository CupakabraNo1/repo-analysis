# clustering k-means popularity x size x inactivity

## data adjustments
data$log_stars <- log10(data$stars + 1)
data$log_size <- log10(data$size + 1)

features <- data[ , c("log_stars", "log_size", "days_inactive")]
features[1:5, ]

features_scaled <- scale(features)
summary(features_scaled)
features_scaled[1:5, ]

## apply scaling
apply(features_scaled, 2, mean)
apply(features_scaled, 2, sd)

## initial clustering
wss <- numeric(10)
for(k in 1:10) {
  km <- kmeans(features_scaled, center = k, nstart = 25)
  wss[k] <- km$tot.withinss
}
png("outputs/images/k-mean_clustering_initial.png", width = 800, height = 600, res = 100) #
plot(1:10, wss, 
     type = "b",
     xlab = "Cluster number (k)",
     ylab = "Within-cluster sum of squares"
)
dev.off()

## clustering with 4
set.seed(123)
km <- kmeans(features_scaled, centers = 4, nstart = 50)
data$cluster <- km$cluster

table(data$cluster)

aggregate(
  data[, c("stars", "size", "days_inactive")],
  by = list(cluster = data$cluster),
  FUN = mean
)

# cluster 1 -> highly popular and active
# cluster 2 -> small but still popular
# cluster 3 -> biggest but stale
# cluster 4 -> inactive and unpopular

## plot graph
png("outputs/images/k-mean_clustering.png", width = 800, height = 600, res = 100) #
ggplot(data, aes(x = log_size,
                 y = log_stars,
                 color = factor(cluster))) +
  geom_point(alpha = 0.5, size = 1.2) +
  scale_color_manual(
    values = c("blue", "green", "yellow", "red"),
    labels = c("Flagship",
               "Small and Popular",
               "Big and Stale",
               "Inactive")
  ) +
  labs(
    title = "K-Means Clustering of GitHub Repositories",
    x = "Log(Size)",
    y = "Log(Stars)",
    color = "Cluster Type"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold")
  )
dev.off()

## plot hexbin graph
png("outputs/images/k-mean_clustering_hexbin.png", width = 1000, height = 700, res = 110)

ggplot(data, aes(x = log_size, y = log_stars)) +
  geom_hex(bins = 45) +
  facet_wrap(~ factor(cluster),
             labeller = as_labeller(c(
               "1" = "Flagship",
               "2" = "Small and Popular",
               "3" = "Big and Stale",
               "4" = "Inactive"
             ))) +
  labs(
    title = "K-Means Clustering (Hexbin density per cluster)",
    x = "Log(Size)",
    y = "Log(Stars)",
    fill = "Count"
  ) +
  theme_minimal(base_size = 14) +
  theme(
    legend.position = "top",
    plot.title = element_text(face = "bold")
  )

dev.off()





