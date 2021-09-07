library(tidyverse)
install.packages("tidytext")
library(tidytext)


teks <- c("saya makan buah - ",
          "makan buah di rumah saja - ",
          "buah mangga rasa durian - ",
          "aku suka manggis.")

teks
text_df <- data_frame(line = 1 : 4, text = teks)

text_df %>%
  unnest_tokens(word, text)

df_covid19 <- read.csv( file = "covid19_tweet.csv"  )
df_covid19_text <- df_covid19 %>% 
  select(text)
df_covid19_text <- head(df_covid19_text, 100) #how to select amount of row

df_covid19_text2 <- df_covid19 %>%
  select(text)

#cara pertama unnest token
df_covid19_text<- df_covid19_text %>% 
  unnest_tokens(teks, text)

#cara kedua unnest token
df_teks_covid19 <- df_covid19_text %>%
  slice(1:100) %>%
  unnest_tokens(word, text)
  
df_covid19_text[c(1,3,4),] # memilih kolom tertentu

#pertanyaan, kata apa yang paling banyak muncul? 
count_df_teks_covid19 <- df_teks_covid19 %>%
  count(word) %>%
  arrange(desc(n))

#tokenisasi bigram
token_bigram_covid <- df_covid19_text %>%
  unnest_tokens(word, text, token = "ngrams", n =2)

token_bigram_covid2 <- df_covid19_text2 %>%
  unnest_tokens(word, text, token = "ngrams", n =2)
count_bigram_covid2 <- token_bigram_covid2 %>%
  count(word) %>%
  arrange(desc(n))

count_bigram_covid2 %>%
  filter(n>10000) %>%
  mutate(word = reorder(word, n)) %>%
  ggplot(mapping = aes(word,n)) +
  geom_col()+ 
  coord_flip()

count_bigram_covid192 <- 