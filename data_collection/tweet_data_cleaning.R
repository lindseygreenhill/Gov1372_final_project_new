library(readxl)
library(janitor)
library(skimr)
library(rtweet)
library(lubridate)
library(caTools)
library(tidyverse)
set.seed(1121)


load("data_collection/tweets_1.RData")
load("data_collection/tweets_2.RData")
load("data_collection/tweets_3.RData")
load("data_collection/tweets_4.RData")
load("data_collection/tweets_5.RData")
load("data_collection/tweets_6.RData")
load("data_collection/tweets_7.RData")
load("data_collection/tweets_8.RData")
load("data_collection/tweets_9.RData")
load("data_collection/tweets_10.RData")
load("data_collection/tweets_11.RData")


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
  select(created_at, screen_name, text, is_retweet, hashtags) %>%
  filter(is_retweet == FALSE) %>%
  mutate(date = ymd(str_sub(created_at, 1, 10))) %>%
  filter(date >= as.Date("2020-11-03"))

save(tweets_tidy, file = "data_collection/tweets_complete.RData")

# creating training and testing sets

smp_size <- floor(.75*nrow(tweets_tidy))
train_ind <- sample(seq_len(nrow(tweets_tidy)), size = smp_size)

training_data <- tweets_tidy[train_ind, ]
testing_data <- tweets_tidy[-train_ind, ]

save(training_data, file = "data_collection/tweets_training_data.RData")
save(testing_data, file = "data_collection/tweets_testing_data.RData")


# Do we want to keep retweets? I am going to clean for emojies. Not sure if I
# have to deal with hashtags but I think quanteda will do this for me. 

# this code is adapted from Blake Robert Mills replication code. He replaced it
# with description but I am just going to delete them. 




