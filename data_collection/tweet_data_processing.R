library(readxl)
library(janitor)
library(skimr)
library(rtweet)
library(tidyverse)

# reading in the senate twitter sheet. I need to subset the link column so it is
# just the handle and not the full link

twitter_handles_senate <- read_excel("data_collection/data/congress_twitter_092721.xlsx",
                                  sheet = 1,
                                  skip = 1) %>%
  clean_names() %>%
  mutate(member = "senate")

# reading in the house twitter sheet

twitter_handles_house <- read_excel("data_collection/data/congress_twitter_092721.xlsx",
                                     sheet = 2,
                                     skip = 1) %>%
  clean_names() %>%
  mutate(member = "house")

# joining the data frames and cleaning the link col

twitter_handles <- twitter_handles_house %>%
  rbind(twitter_handles_senate) %>%
  mutate(handle = str_sub(link, start = 21)) %>%
  select(-link)

# save(twitter_handles, file = "data_collection/twitter_handles.RData")

# checking for missing values. Looks like 3 members do not have twitter
# accounts. Those people are Jake Ellzey, Chris Smith, and Jefferson Van Drew so
# I have to add them manually. Chris Smith deactivated his twitter account in
# January of 2021. Jeff Van Drew also deactivated his twitter account when Chris
# Smith did it. They said it was in repsonse to Trump's behavior. I think as of
# now I will drop them from the data. 

skim(twitter_handles)

twitter_handles <- twitter_handles %>%
  mutate(handle = case_when(name == "Ellzey, Jake" ~ "RepEllzey",
                            T ~ handle)) %>%
  drop_na()

# Now I am using the rtweets package to create the tweets data fram. Code
# adapted from Blake Robert Mills article. I keep on getting errors for hitting
# rate limits. I think to solve this I need to do it in smaller chunks. 

################ TWITTER SCRAPING SCRIPT ###################3
# chunk 1

handles_1 <- twitter_handles %>%
  arrange(name) %>%
  slice(1:50)

Tweets_1 <- vector()
for(i in handles_1$handle){
  df <- get_timeline(i, n = 3200)
  Tweets_1 <- rbind(Tweets_1, df)
 }

# save(Tweets_1, file = "tweets_1.RData")


# chunk 2

#handles_2 <- twitter_handles %>%
#  arrange(name) %>%
#  slice(51:100)

#Tweets_2 <- vector()
# for(i in handles_2$handle){
#  df <- get_timeline(i, n = 3200)
#  Tweets_2 <- rbind(Tweets_2, df)
# }

# save(Tweets_2, file = "tweets_2.RData")

# chunk 3

handles_3<- twitter_handles %>%
  arrange(name) %>%
  slice(101:150)

 # Tweets_3 <- vector()
 #for(i in handles_3$handle){
  #df <- get_timeline(i, n = 3200)
  #Tweets_3 <- rbind(Tweets_3, df)
 #}

 # save(Tweets_3, file = "tweets_3.RData")

# chunk 4

handles_4 <- twitter_handles %>%
  arrange(name) %>%
  slice(151:200)

# Tweets_4 <- vector()

#for(i in handles_4$handle){
#  df <- get_timeline(i, n = 3200)
#  Tweets_4 <- rbind(Tweets_4, df)
# }

# save(Tweets_4, file = "tweets_4.RData")


# chunk 5

handles_5 <- twitter_handles %>%
  arrange(name) %>%
  slice(201:250)

# Tweets_5 <- vector()

#for(i in handles_5$handle){
 # df <- get_timeline(i, n = 3200)
#  Tweets_5 <- rbind(Tweets_5, df)
# }

# save(Tweets_5, file = "tweets_5.RData")

# chunk 6

handles_6 <- twitter_handles %>%
  arrange(name) %>%
  slice(251:300)

# Tweets_6 <- vector()

for(i in handles_6$handle){
  df <- get_timeline(i, n = 3200)
  Tweets_6 <- rbind(Tweets_6, df)
}
# save(Tweets_6, file = "tweets_6.RData")


# chunk 7

handles_7 <- twitter_handles %>%
  arrange(name) %>%
  slice(301:350)

# Tweets_7 <- vector()

for(i in handles_7$handle){
  df <- get_timeline(i, n = 3200)
  Tweets_7 <- rbind(Tweets_7, df)
}

# save(Tweets_7, file = "tweets_7.RData")

# chunk 8

handles_8 <- twitter_handles %>%
  arrange(name) %>%
  slice(351:400)

Tweets_8 <- vector()

for(i in handles_8$handle){
  df <- get_timeline(i, n = 3200)
  Tweets_8 <- rbind(Tweets_8, df)
}

# save(Tweets_8, file = "tweets_8.RData")

# chunk 9

handles_9 <- twitter_handles %>%
  arrange(name) %>%
  slice(401:450)

# Tweets_9 <- vector()

for(i in handles_9$handle){
  df <- get_timeline(i, n = 3200)
  Tweets_9 <- rbind(Tweets_9, df)
}

# save(Tweets_9, file = "tweets_9.RData")

# chunk 10

handles_10 <- twitter_handles %>%
  arrange(name) %>%
  slice(451:500)

# Tweets_10 <- vector()

# for(i in handles_10$handle){
#  df <- get_timeline(i, n = 3200)
#  Tweets_10 <- rbind(Tweets_10, df)
# }

# save(Tweets_10, file = "tweets_10.RData")

# chunk 11

handles_11 <- twitter_handles %>%
  arrange(name) %>%
  slice(501:537)

Tweets_11 <- vector()

for(i in handles_11$handle){
  df <- get_timeline(i, n = 3200)
  Tweets_11 <- rbind(Tweets_11, df)
 }

# save(Tweets_11, file = "tweets_11.RData")

