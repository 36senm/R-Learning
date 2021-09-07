#impor data
install.packages("xlsx")
install.packages("readxl")
install.packages("rJava")
install.packages("RWeka")
install.packages("usethis")
install.packages("measurements")
install.packages("htmlwidgets")
install.packages("nycflights13")
install.packages("devtools")

library(measurements)
library(tidyverse)
library(xlsx)
library(htmlwidgets)
library(nycflights13)
library(haven)
library(keData)
df_1 <- read.csv(file = "datamarket_or.csv" , sep = ",") #first attempt
df_2 <- read_csv2(file = "datamarket_or.csv") #akses otomatis separator, jadi tidak bisa menggunakan separator

df <- read.csv(file = "diy.csv" , sep = ";") #real use dataset

list_ppl <- read.xlsx(file =  "SEAriously Awesome People List - Startup COVID-19 Layoffs.xlsx", sheetIndex = 2 )
#transformasi data

#tugas7
install.packages("devtools")
devtools::install_github("eppofahmi/keData")
daten <- keData ::dataAnime
dataku <- daten $`Starting season` 

#import stata
df_salary <- read_dta(file = "data/salary.dta")
#import spss
df_bike = read_sav(file = "data/PsychBike.sav")

#import sas
df_surveyhh = read_sas(data_file = "data/hhsurvey.sas7bdat")

#transformasi data
str(df_bike)
glimpse(df)



df_flights = flights
?flights
View(df_flights)

#filter month&date based
filter(flights, month == 3, day == 6)
df_filter6march = filter(flights, month == 3, day == 6)

# fyi 
#The | operator can be read as "or". This should be used when you'd like either of the different operations to be true.
#The %in% operator can be used to match conditions provided in a vector using the c() function.
#The ! operator can be read as "not." It is used to negate a condition.

#tugas filter mencari penerbangan di bulan januari dan februari
df_filter12 = filter(flights, month == 2 | month == 6, day <= 30 )

#konsep pipeline dalam filter
df_filter_ppline = df_flights %>% 
  filter(month == 1 | month == 2) %>%
  filter(origin == "EWR")
  
#arrange()
df_filter_ord <- df_filter12 %>%
  arrange(origin)

df_filter_delayed <- df_flights %>%
  arrange(desc(dep_delay))

df_filter_earlytake <- df_flights %>%
  arrange(dep_delay)

#select()
df_slcflight <- df_flights %>%
  select(1:10)
df_slcda <-  df_flights %>%
  select(day, month, origin)

#mutate()
df_hour_airtime <- df_flights %>%
  mutate(air_time_hour = air_time/60)

df_distance_km <- df_flights %>%
  mutate(distancekm = distance * 1.60934 ) %>%
  arrange(desc(distancekm))

#summ
#tanpa pipeline

by_day <- group_by(df_flights, year, month, day)
df_summarize <- summarise(by_day, delay = mean(dep_delay, na.rm = TRUE))

#pake pipeline
df_summ_byddm <- df_flights %>%
  group_by(day, month, year) %>%
  summarize(delay = mean(dep_delay, na.rm= TRUE))

#tanpa pipeline
by_origin <- group_by(df_distance_km, origin, dest)
df_sum_distance <- summarize(by_origin, distance_between = mean(distancekm))

#pake pipeline
df_sum_distance2 <- df_distance_km %>%
  group_by(origin, dest) %>%
  summarize(distance_between = mean(distancekm, na.rm= TRUE)) %>%
  arrange(desc(distance_between))

df_sum <- df_distance_km %>%
  group_by(distancekm, origin, dest) %>%
  summarize(distancebyfar = mean(distancekm, na.rm = TRUE)) #na.rm = not.avaiable artinya tidak ditunjuka


#str

df_strflights <- df_distance_km %>% 
  mutate(string_origin = str_length(origin))

df_flights_carrier <- df_flights %>%
  mutate(carrier_sub = str_sub(carrier,1,1))

#menggunakan RE untuk transformasi data
x <- c("apple","banana","anggur","mangga","asem")
str_view(x,"le")
#re untuk string awalan
str_view(x,"^a")
#re untuk match dengan string akhiran
str_view(x, "a$")

words <- stringr::words
str_view(words,"o$")
filter(words == "o$")

#re untuk match angka 
kata1 <- "33 juta penghuni lapas"
str_view(kata1, "\\d")

#re untuk match spasi
str_view(kata1, "\\s")

#re untuk match lebih dari satu value character
str_view(x, "[abm]")

#re untuk match kecuali karakter berikut
str_view(x,"[^amb]")

#re repetisi
# 0 / 1 : ?
# 1 atau lebih : +
# 0 atau lebih : *

xx1 <- "1888 is the longest year in Roman numerals: MDCCCLXXXVIII"
str_view(xx1, "CC+")
str_view(xx1, 'C[LX]+')
str_view(xx1, "CC?")
str_view(xx1, "p[no]+")




devtools::install_github("nurandi/katadasaR")
install.packages("tokenizers")
install.packages("stopwords")
install.packages("wordcloud")
#tugas 9
string1 <- "Informasi tata cara daftar ulang bagi mahasiswa baru TI kurang jelas. Sehingga ketika tanggal terakhir syarat penyerahan berkas daftar ulang, banyak mahasiswa baru yang tidak membawa salah satu syarat daftar ulangnya."
strsplit(string1, " ")[[1]]

string2 <- "Informasi cara daftar ulang mahasiswa baru TI kurang jelas. Tanggal terakhir syarat penyerahan berkas daftar ulang, banyak mahasiswa baru tidak membawa syarat daftar ulangnya"
stemming <- function(x){
  paste(lapply(x,katadasar),collapse = " ")}
strign2 <- lapply(tokenize_words(string2[]), stemming)
string2[1]
