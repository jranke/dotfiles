options(pdfviewer="okular")
options(browser="firefox")
options(menu.graphics=FALSE)

# R package repositories
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com"
  #r["CRAN"] <- "http://cran.at.r-project.org" # if https does not work
  #r["eddelbuettel"] <- "https://eddelbuettel.github.io/drat"
  #r["ghrr"] <- "https://ghrr.github.io/drat"
  options(repos = r)
})

# littler does not read .Renviron, therefore do this here
Sys.setenv(LANGUAGE = "en")
Sys.setenv(R_CHECK_CRAN_INCOMING_REMOTE = "false")
Sys.setenv(NOT_CRAN = "true")

if (interactive()) {
  suppressMessages(require(dplyr))
  suppressMessages(require(tidyr))
  suppressMessages(require(reprex))
  suppressMessages(require(usethis))
}
