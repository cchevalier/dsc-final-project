#R1 Analysis


# Set Data Filename
setDataFilename <- function(fileType, dataFolder="./data", LOCALE="en_US") {
  file.path(dataFolder, 
            LOCALE, 
            paste(LOCALE, ".", fileType, ".txt", sep = ""))
}


# Set Data Sample Filename
setDataSampleFilename <- function(fileType, sampleRatio, dataSampleFolder="./data-samples", LOCALE="en_US" ) {
  file.path(dataSampleFolder, 
            LOCALE, 
            paste(LOCALE, ".", fileType, "_", sampleRatio, ".txt", sep = ""))
}


# Reading Data file
readDataFile <- function(filename) {
  con <- file(filename, open="rb")
  result <- readLines(con, skipNul = TRUE, encoding="UTF-8")
  close(con)
  return(result)
}


# Get File Stats
getFileStats <- function(filename) {
  filesize <- file.info(filename)$size / 1024^2
  # result <- list(name = filename, size = filesize)
  return(round(filesize))
}


# Resample function
resample <- function(data, sampleRatio, sampleFilename) {
  dataSample <- sample(data, round(sampleRatio/100 * length(data)))
  write(dataSample, sampleFilename)
  
  return(dataSample)
}


# Pre-Process
preprocess <- function(fileType, dataFolder, LOCALE, dataSampleFolder, sampleRatio) {
  
  typeFilename <- setDataFilename(fileType, dataFolder, LOCALE)
  typeData <- readDataFile(typeFilename)

  # Basic summary 
  print(paste("File:", typeFilename))
  print(paste("     ", getFileStats(typeFilename), "Mb"))
  print(paste("     ", length(unlist(strsplit(typeData, "\\s+", perl = T))), "words"))
  print(paste("     ", length(typeData), "lines"))
  
#   typeSampleFilename <- setDataSampleFilename(fileType, sampleRatio, dataSampleFolder, LOCALE)
#   typeSampleData <- resample(typeData, sampleRatio, typeSampleFilename)
  
  return()
}



#

LOCALE <- "en_US"
dataFolder <- "./data"
dataSampleFolder <- "./data-samples"
sampleRatio <- 1
types <- c("blogs", "news", "twitter")

set.seed(12345)
for (fileType in types) {
  #print(fileType)
  preprocess(fileType, dataFolder, LOCALE, dataSampleFolder, sampleRatio )
}


library(tm)
library(RWeka)

library(wordcloud)
library(RColorBrewer)


# corpus_all <- Corpus(DirSource(file.path(".", dataFolder, LOCALE)),
#                         readerControl=list(reader=readPlain, language="en_US"))

corpus_sample <- Corpus(DirSource(file.path(".", dataSampleFolder, LOCALE)),
                        readerControl=list(reader=readPlain, language="en_US"))




#
plotWordCloud <- function(tdm, plotFilename) {
  
m <- as.matrix(tdm)
v <- sort(rowSums(m), decreasing=TRUE)
d <- data.frame(word = names(v), freq=v)


pal <- brewer.pal(8, "Set2")
pal <- pal[-(1:2)]
#png(plotFilename, width=1280, height=800)
wordcloud(d$word, d$freq, 
          scale=c(8,.3),
          min.freq=2, 
          max.words=50, 
          random.order=F, 
          rot.per=.15, 
          colors=pal, 
          vfont=c("sans serif","plain"))
#dev.off()

}


corpus_sample_cleaned <- tm_map(corpus_sample, removePunctuation)
corpus_sample_cleaned <- tm_map(corpus_sample_cleaned, tolower)
corpus_sample_cleaned <- tm_map(corpus_sample_cleaned, function(x) removeWords(x, stopwords("english")))

# Fix to "Error: inherits(doc, "TextDocument") is not TRUE"
corpus_sample_cleaned <- tm_map(corpus_sample_cleaned, PlainTextDocument)


tdm <- TermDocumentMatrix(corpus_sample_cleaned)
plotWordCloud(tdm, "plot1b.png")
title(main = "With removing english stopwords")


bigramTokenizer <- function(x) {
  NGramTokenizer(x, Weka_control(min=2, max=2))
}

tdm_bigram <- TermDocumentMatrix(corpus_sample_cleaned, control = list(tokenize=bigramTokenizer))

plotWordCloud(tdm, "plot2b.png")
title(main = "With removing english stopwords")
