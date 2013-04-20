
library(ggplot2)
set.seed(1234)
df <- data.frame(cond = factor( rep(c("A","B"), each=200) ), 
                   rating = c(rnorm(200),rnorm(200, mean=.8)))

library(plyr)
cdf <- ddply(df, .(cond), summarise, rating.mean=mean(rating))

plot <- ggplot(df, aes(x=rating, fill=cond)) +
    geom_histogram(binwidth=.5, alpha=.5, position="identity") +
    geom_vline(data=cdf, aes(xintercept=rating.mean,  colour=cond),
               linetype="dashed", size=1)

ggsave('rexample.png', plot = plot)
