# Q1_Getting_Started.R


# Set Filenames
setFilename <- function(filetype, dataFolder="./data", LOCALE="en_US") {
  file.path(dataFolder, LOCALE, paste(LOCALE, filetype, sep = ""))
}

LOCALE <- "en_US"
dataFolder <- "./data"

fileBlogs   <- setFilename(".blogs.txt",   dataFolder)
fileNews    <- setFilename(".news.txt",    dataFolder)
fileTwitter <- setFilename(".twitter.txt", dataFolder)


# Get File Stats
getFileStats <- function(filename) {
  filesize <- file.info(filename)$size / 1024^2
  result <- list(name = filename, size = filesize)
  return(result)
}

getFileStats(fileBlogs)
getFileStats(fileNews)
getFileStats(fileTwitter)


# Reading files
dataBlogs <- readLines(fileBlogs)
dataNews <- readLines(fileNews)
dataTwitter <- readLines(fileTwitter)


# Data Stats
getDataStats <- function(data) {
  nLines <- length(data)
  maxChar <- max(nchar(data))
  
  result <- list(nLines = nLines, maxChar = maxChar)
  return(result)
}

getDataStats(dataBlogs)
getDataStats(dataNews)
getDataStats(dataTwitter)


# About love and hate in Twitter feeds
nLove <- sum(grepl("love", dataTwitter))
nHate <- sum(grepl("hate", dataTwitter))
nLove / nHate


# About biostats on Twitter
iBiostats <- grep("biostats", dataTwitter)
dataTwitter[iBiostats]


# About chess on Twitter
grep("A computer once beat me at chess, but it was no match for me at kickboxing", dataTwitter)


