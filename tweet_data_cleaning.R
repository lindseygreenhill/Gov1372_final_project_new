library(readxl)
library(janitor)
library(skimr)
library(rtweet)
library(caTools)
library(tidyverse)
set.seed(1121)


load("tweets_1.RData")
load("tweets_2.RData")
load("tweets_3.RData")
load("tweets_4.RData")
load("tweets_5.RData")
load("tweets_6.RData")
load("tweets_7.RData")
load("tweets_8.RData")
load("tweets_9.RData")
load("tweets_10.RData")
load("tweets_11.RData")


tweets_full <- Tweets_1 %>%
  rbind(Tweets_2) %>%
  rbind(Tweets_3) %>%
  rbind(Tweets_4) %>%
  rbind(Tweets_5) %>%
  rbind(Tweets_6) %>%
  rbind(Tweets_7) %>%
  rbind(Tweets_8) %>%
  rbind(Tweets_9) %>%
  rbind(Tweets_10) %>%
  rbind(Tweets_11)


# save(tweets_full, file = "tweets_full.RData")
# making into one big data frame

# I still don't have complete data frame but I am going to clean it anyways

tweets_tidy <- tweets_full %>%
  select(created_at, screen_name, text, is_retweet, hashtags)

# save(tweets_tidy, file = "tweets_complete.RData")

# creating training and testing sets

smp_size <- floor(.7*nrow(tweets_tidy))
train_ind <- sample(seq_len(nrow(tweets_tidy)), size = smp_size)

training_data <- tweets_tidy[train_ind, ]
testing_data <- tweets_tidy[-train_ind, ]

save(training_data, file = "tweets_training_data.RData")
save(testing_data, file = "tweets_testing_data.RData")


# Do we want to keep retweets? I am going to clean for emojies. Not sure if I
# have to deal with hashtags but I think quanteda will do this for me. 

# this code is adapted from Blake Robert Mills replication code. He replaced it
# with description but I am just going to delete them. 




