#exploratory data analis

library(tidyverse)
library(nycflights13)

df_flights <- flights
glimpse(df_flights)
view(df_flights)


summary(as.factor(df_flights$origin)) #same result as ggplot but only show the integer


df_flights %>%
  ggplot()+
  geom_bar(mapping = aes(x= origin))


df_flights %>%
  filter( tailnum == c("N14228", "N24211", "N619AA")) %>%
  ggplot()+
  geom_bar(mapping = aes(x = tailnum))+
  coord_flip()
  
#variasi menggunakan numerik
#pertanyaan: carrier apa yang sering dipakai?

df_flights %>%
  ggplot()+
  geom_bar(mapping = aes(x=carrier))+
  coord_flip()

#numerik
df_flights %>%
  ggplot()+
  geom_histogram(mapping = aes(x= dep_delay))+
  coord_cartesian(xlim = c(0.360)) #melihat sumbu x

df_flights %>%
  ggplot()+
  geom_histogram(mapping = aes(x= dep_delay))+
  coord_cartesian(ylim = c(0.200)) #melihat sumbu y

#bagaimana distribusi jarak terbang?
df_flights %>%
  ggplot()+
  geom_histogram(mapping = aes(x= distance), binwidth = 100)+
  coord_flip(xlim = c(0,1000))

#eda untuk 2 variabel (kovariasi) numerik v numerik, numerik v kategorik, kategorik v kategorik
#kat v numerik
#pertanyaan: bagaimana distribusi distance daris setiap bandara asal

df_flights %>%
  ggplot()+
  geom_boxplot(mapping = aes(x= origin, y= distance))

#pertanyaan: bagaimana distribusi angka air time dari setiap airport asal/origin
df_flights %>%
  ggplot()+
  geom_boxplot(mapping = aes(x= air_time, y= origin))

#pilih 2 kolom dan sertakan pertanyaan
#pertanyaan: airport yang sering delay

df_flights %>%
  ggplot()+
  geom_boxplot(mapping = aes(x= carrier, y= arr_delay))

#kat v kat
df_flights %>%
  count(carrier, origin) %>%
  ggplot()+
  geom_tile(mapping = aes (x = carrier, y = origin, fill = n) )

#pilih 2 kolom dan sertakan pertanyaan
#pertanyaan: distribusi dest dan carrier

df_flights %>%
  filter(dest == c("ORD","ATL","BOS")) %>%
  count(dest, carrier) %>%
  ggplot()+
  geom_tile(mapping = aes(x= dest, y = carrier, fill = n))

#num v num

df_flights %>%
  ggplot()+
  geom_point(mapping = aes(x = dep_delay, y = arr_delay), alpha = 1/100 )+
  coord_cartesian(ylim = c(0,100), xlim = c(0,100))

#pilih 2 kolom dan sertakan pertanyaan
#pertanyaan: apakah jauhnya jarak mempengaruhi lamanya waktu penerbangan

df_flights %>% 
  ggplot()+
  geom_point(mapping = aes(x = air_time, y = distance, color=origin))

