# LIBS AND HELPERS
source("R/load_packages.R")

source("R/data.R")

# PROCESSING
data <- read_csv_safe("data/raw/repositories.csv")

source("R/processing.R")

write.csv(data, file = "data/processed/clean_repositories.csv", row.names = FALSE)
# VISUALISATION

source("R/visualization.R")

# STATISTICAL ANALYSIS

source("analysis/statistical_analysis.R")

# DATA MINING
source("analysis/data_mining.R")
