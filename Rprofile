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
  # Load vimcom only if R was started by vim
  if(Sys.getenv("VIMRPLUGIN_TMPDIR") != "") {
    options(vimcom.verbose = 1)
    library(vimcom)
  }
}
