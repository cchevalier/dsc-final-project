# Word Cloud in R
# http://www.r-bloggers.com/word-cloud-in-r/

# Part 1: XKCD example
library(RXKCD)
library(tm)
library(wordcloud)
library(RColorBrewer)

path <- system.file("xkcd", package = "RXKCD")
datafiles <- list.files(path)

xkcd.df <- read.csv(file.path(path, datafiles))

xkcd.corpus <- Corpus(DataframeSource(data.frame(xkcd.df[, 3])))
xkcd.corpus <- tm_map(xkcd.corpus, removePunctuation)
xkcd.corpus <- tm_map(xkcd.corpus, tolower)
xkcd.corpus <- tm_map(xkcd.corpus, function(x) removeWords(x, stopwords("english")))

# Fix to "Error: inherits(doc, "TextDocument") is not TRUE"
xkcd.corpus <- tm_map(xkcd.corpus, PlainTextDocument)

tdm <- TermDocumentMatrix(xkcd.corpus)
m <- as.matrix(tdm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)

pal <- brewer.pal(9, "Set2")
pal <- pal[-(1:2)]
#png("wordCloudR.png", width=1280,height=800)
wordcloud(d$word,d$freq, scale=c(8,.3),min.freq=2,max.words=50, random.order=T, rot.per=.15, colors=pal, vfont=c("sans serif","plain"))
#dev.off()
