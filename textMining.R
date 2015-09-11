libraries <- c("tm", "SnowballCC", "RColorBrewer", "ggplot2", "wordcloud", "biclust", "cluster", "igraph", "fpc")
install.packages(libraries, dependencies=TRUE)
cname <- file.path("~", "Desktop", "texts")

library(tm)
library(SnowballC)

docs <- Corpus(DirSource(cname))
summary(docs) #shows you a summary of your documents

docs <- tm_map(docs, removePunctuation)
docs <- tm_map(docs, removeNumbers)
docs <- tm_map(docs, tolower)
docs <- tm_map(docs, removeWords, stopwords("english"))

docs <- tm_map(docs, stemDocument)
docs <- tm_map(docs, stripWhitespace)

dtm <- DocumentTermMatrix(docs)
tdm <- TermDocumentMatrix(docs)
dtms <- removeSparseTerms(dtm, 0.1)
findFreqTerms(dtm, lowfreq=50)
wf <- data.frame(word=names(freq), freq=freq)
head(wf)

library(ggplot2) #Make a histogram with words that appear more than 50 times.
p <- ggplot(subset(wf, freq>50), aes(word, freq))
p <- p + geom_bar(stat="identity")
p <- p + theme(axis.text.x=element_text(angle=45, hjust=1))
p
 
#Make a wordcloud of the top 100 words
> library(wordcloud)
> set.seed(142)
> dark2 <- brewer.pal(6, "Dark2")
> wordcloud(names(freq), freq, max.words=100, rot.per=0.2, colors=dark2)
