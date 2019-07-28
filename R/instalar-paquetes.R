check_for <- c(
  "ggplot2", "datos", "rmarkdown", "rprojroot", "evaluate",
  "digest", "highr", "markdown",   "stringr", "yaml",
  "Rcpp", "htmltools", "knitr", "jsonlite", "base64enc",
  "mime", "tidyverse", "tidymodels", "fs", "skimr",
  "corrr", "babynames", "fueleconomy", "nycflights13",
  "nasaweather", "Lahman", "gapminder", "xaringan",
  "flexdashboard", "leaflet", "janitor", "tidytext", "fs"
)
installed_packages <- as.data.frame(installed.packages())
check_installed <- installed_packages[installed_packages$Package %in% check_for, ]
check_installed$version <- gsub("\\.", "", check_installed$Version)
check_installed$version <- gsub("\\-", "", check_installed$version)
check_installed$version <- as.numeric(check_installed$version)
cran_versions <- read.csv("R/versions.csv")
compare_vers <- sapply(
  check_for,
  function(x) {
    local_version <- check_installed[check_installed$Package == x, "version"]
    cran_version <- cran_versions[cran_versions$Package == x, "version"]
    cran_version > local_version
  }
)
compare_vers <- as.vector(compare_vers)
if(any(compare_vers)) {
  install_pkgs <- check_for[compare_vers]
  install.packages(install_pkgs)
}
cran_versions <- function() {
  packages <- tools::CRAN_package_db()
  check_installed <- packages[packages$Package %in% check_for, ]
  check_installed$version <- gsub("\\.", "", check_installed$Version)
  check_installed$version <- gsub("\\-", "", check_installed$version)
  check_installed$version <- as.numeric(check_installed$version)
  write.csv(check_installed[ , c("Package", "Version", "version")], "R/versions.csv")
}
rm(check_installed, installed_packages, check_for, compare_vers, cran_versions)

