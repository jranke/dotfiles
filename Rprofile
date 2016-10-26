options(pdfviewer="okular")
options(browser="firefox")

# R package repositories
local({
  r <- getOption("repos")
  r["CRAN"] <- "https://cran.rstudio.com"
  #r["CRAN"] <- "http://cran.at.r-project.org" # if https does not work
  #r["eddelbuettel"] <- "https://eddelbuettel.github.io/drat"
  #r["ghrr"] <- "https://ghrr.github.io/drat"
  options(repos = r)
})

if (interactive()) {
  library(colorout)
  library(setwidth)
  # vimcom will generally only be installed on boxes where this is necessary
  if (requireNamespace("vimcom")) options(vimcom.verbose = 1)
  # However, vimcom does not get in the way of Nvim-R if it is loaded
}
