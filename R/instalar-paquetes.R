check_for <- c(
  "ggplot2", "datos", "rmarkdown", "rprojroot", "evaluate",
  "digest", "highr", "markdown",   "stringr", "yaml",
  "Rcpp", "htmltools", "knitr", "jsonlite", "base64enc",
  "mime", "tidyverse", "tidymodels", "fs", "skimr",
  "corrr", "babynames", "fueleconomy", "nycflights13",
  "nasaweather", "Lahman", "gapminder", "xaringan",
  "flexdashboard", "leaflet", "janitor"
)

packages <- tools::CRAN_package_db()
installed_packages <- as.data.frame(installed.packages())
check_package <- function(x) {
  cran <- packages[packages$Package == x, "Version"]
  local <- as.character(installed_packages[installed_packages$Package == x, "Version"])
  install <- FALSE
  if(length(local) == 0) {
    install = TRUE
  } else {
    if(local != cran) install = TRUE
  }
  list(
    cran = cran,
    local = local,
    install = install
  )
}
check_versions <- lapply(check_for, check_package)
check_versions <- setNames(check_versions, check_for)
to_install <- as.vector(sapply(check_versions, function(x) x$install))
update_packages <- names(check_versions[to_install])
install.packages(update_packages)
