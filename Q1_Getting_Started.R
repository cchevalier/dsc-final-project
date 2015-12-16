
language <- "en_US"

pathData <- paste("./data/", language, "/", sep = "")

fileBlogs   <- paste(pathData, language, ".blogs.txt", sep = "")
fileNews    <- paste(pathData, language, ".news.txt", sep = "")
fileTwitter <- paste(pathData, language, ".twitter.txt", sep = "")

# files size in MB
file.info(fileBlogs)$size / 1024^2
file.info(fileNews)$size / 1024^2
file.info(fileTwitter)$size / 1024^2

# Reading files
dataBlogs <- readLines(fileBlogs)
dataNews <- readLines(fileNews)
dataTwitter <- readLines(fileTwitter)


nLove <- sum(grepl("love", dataTwitter))
nHate <- sum(grepl("hate", dataTwitter))
nLove / nHate
