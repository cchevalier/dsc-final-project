# Q1_Getting_Started.R


# Set Filenames
setFilename <- function(filetype, folderData="./data", LOCALE="en_US") {
  file.path(folderData, LOCALE, paste(LOCALE, filetype, sep = ""))
}

LOCALE <- "en_US"
folderData <- "./data"

fileBlogs   <- setFilename(".blogs.txt",   folderData)
fileNews    <- setFilename(".news.txt",    folderData)
fileTwitter <- setFilename(".twitter.txt", folderData)


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
readFile <- function(filename) {
  con <- file(filename, open="rb")
  result <- readLines(con, skipNul = TRUE, encoding="UTF-8")
  close(con)
  return(result)
}

dataBlogs <- readFile(fileBlogs)
dataNews <- readFile(fileNews)
dataTwitter <- readFile(fileTwitter)


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


