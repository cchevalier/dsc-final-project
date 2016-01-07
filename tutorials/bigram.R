# Bigram from: 
#   http://stackoverflow.com/questions/8161167/what-algorithm-i-need-to-find-n-grams

# Timing in R from:
#   http://www.ats.ucla.edu/stat/r/faq/timing_code.htm
#   http://blog.snap.uaf.edu/2012/07/18/timing-your-r-code/


library("RWeka")
library("tm")

data("crude")


# Start the clock
ptm <- proc.time()

# Original bigram code
BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
tdm2 <- TermDocumentMatrix(crude, control = list(tokenize = BigramTokenizer))

# Stop the clock
proc.time() - ptm

inspect(tdm2[340:345, ])


# Other timing code
t1 <- Sys.time()

# Adaptation to n = 3
TrigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 3, max = 3))
tdm3 <- TermDocumentMatrix(crude, control = list(tokenize = TrigramTokenizer))

t2 <- Sys.time()
difftime(t2, t1)

inspect(tdm3[340:345, ])


# Other timing code
t1 <- Sys.time()

# Adaptation to n = 4
FourgramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 4, max = 4))
tdm4 <- TermDocumentMatrix(crude, control = list(tokenize = FourgramTokenizer))

t2 <- Sys.time()
difftime(t2, t1)

inspect(tdm4[340:345, ])


