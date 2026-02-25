# GitHub repository popularity

## Project Overview

**Repo Analysis** is a data analysis project focused on exploring the characteristics and popularity of GitHub repositories.  
The dataset contains approximately **215,000 unique repositories** and includes metadata such as stars, forks, issues, size, language, activity, and repository features.

The project performs:

- Statistical analysis  
- Data preprocessing and cleaning  
- Data mining techniques  
- Data visualization  

---

## Project Structure

```
repo-analysis/
│
├── main.R                     # Main script – runs the entire analysis pipeline
├── README.md                  # Project documentation
│
├── analysis/                  # Analysis scripts
│   ├── statistical_analysis.R # Statistical tests and correlation analysis
│   └── data_mining.R          # Data mining techniques and modeling
│
├── R/                         # Helper scripts
│   ├── load_packages.R        # Safe installation and loading of required packages
│   ├── data.R                 # Shared data utility functions
│   ├── processing.R           # Data cleaning and preprocessing
│   └── visualization.R        # Data visualization functions
│
├── data/
│   ├── raw/                   # Original dataset (.csv)
│   └── processed/             # Cleaned and processed dataset (.csv)
│
└── output/
├── images/                # Generated visualizations (.png)
└── results/               # Statistical results (.txt, .csv)
```

---

## Dataset

The dataset used in this project was obtained from Kaggle:

 https://www.kaggle.com/datasets/donbarbos/github-repos  

It contains approximately **215,000 observations**, where each row represents a single GitHub repository.

### Key Variables

The most important variables include:

- **NAME** – Unique repository name  
- **DESCRIPTION** – Short textual description of the project  
- **CREATED_AT / UPDATED_AT** – Timestamps (ISO 8601 format)  
- **SIZE** – Repository size in bytes  
- **STARS** – Popularity indicator (number of stars)  
- **FORKS** – Number of repository forks  
- **ISSUES** – Number of open issues  
- **WATCHERS** – Number of users watching the repository  
- **LANGUAGE** – Primary programming language  
- **LICENSE** – License type  
- **TOPICS** – Repository tags  
- Feature flags (TRUE/FALSE):  
  - **HAS_ISSUES**  
  - **HAS_PROJECTS**  
  - **HAS_DOWNLOADS**  
  - **HAS_WIKI**  
  - **HAS_PAGES**  
  - **HAS_DISCUSSIONS**  
  - **IS_FORK**  
  - **IS_ARCHIVED**  
  - **IS_TEMPLATE**  

---

## How to Run

1. Open the project in R or RStudio.
2. Set working directory to root folder of project.
3. Execute:

```r

source("main.R")

```

This will:
- Load the dataset
- Process and clean the data
- Perform statistical and data mining analysis
- Generate visualizations
- Export results to the output/ directory

---

## Project Goals
	
- Analyze relationships between repository characteristics and popularity (stars)
- Identify statistically significant correlations
- Explore structural and activity-based factors influencing GitHub repository success
- Apply statistical and data mining techniques on a large real-world dataset

---

## Output

After running the project:
- Visualizations are saved in output/images/
- Statistical results are saved in output/results/
- Processed datasets are saved in data/processed/

---

## License

This project uses publicly available data from Kaggle.
All credit for the original dataset belongs to the dataset author.