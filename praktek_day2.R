#impor data
install.packages("xlsx")
install.packages("readxl")
install.packages("rJava")
install.packages("RWeka")
install.packages("usethis")
library(tidyverse)
library(xlsx)
df_1 <- read.csv(file = "datamarket_or.csv" , sep = ",") #first attempt
df_2 <- read_csv2(file = "datamarket_or.csv") #akses otomatis separator, jadi tidak bisa menggunakan separator

df <- read.csv(file = "diy.csv" , sep = ";") #real use dataset

list_ppl <- read.xlsx(file =  "SEAriously Awesome People List - Startup COVID-19 Layoffs.xlsx", sheetIndex = 2 )
#transformasi data

#tugas7
install.packages("devtools")
devtools::install_github("eppofahmi/keData")
library(keData)
daten <- keData ::dataAnime
dataku <- daten $`Starting season` 

#import stata
library(haven)
df_salary <- read_dta(file = "data/salary.dta")
#import spss
df_bike = read_sav(file = "data/PsychBike.sav")

#import sas
df_surveyhh = read_sas(data_file = "data/hhsurvey.sas7bdat")

#transformasi data
str(df_bike)
glimpse(df)

install.packages("nycflights13")
library(nycflights13)

df_flights = flights
?flights

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
  filter(month == 1 | month == 2)
  
