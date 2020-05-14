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

# For (re)installing PythonInR
#Sys.setenv(USESPECIALPYTHONVERSION="python3.5")
