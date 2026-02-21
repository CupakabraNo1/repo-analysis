install_and_load <- function(pkg) {
  if (!requireNamespace(pkg, quietly = TRUE)) {
    install.packages(pkg, dependencies = TRUE)
  }
  library(pkg, character.only = TRUE)
}

install_and_load("readr")
install_and_load("ggplot2")
install_and_load("hexbin")
