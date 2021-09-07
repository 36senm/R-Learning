
library(tidyverse)
library(stringr)

df <- read.csv(file = "covid19_tweet.csv") 

df_covid19tw <- df %>%
  select(text, screen_name, verified)

S
df_covid19tw$lw_text <- str_to_lower(df_covid19tw$text)
df_covid19tw$remove_punc = str_remove_all(df_covid19tw$lw_text, "[,._;#@]" )




glimpse(df)


df_remove_punctuation <- str_remove_all((df$lw_text))

df_1 <- df %>% 
  select(screen_name, text)

df_1$removedpunctuation <- str_replace_all(df_1$text, "[:punct:]", "")
df_1$lowercase <- tolower(df_1$removedpunct)

