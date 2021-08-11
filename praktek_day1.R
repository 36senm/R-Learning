#Dasar pemrogaman R 
#R as calculator 

#standar operator
kali <- 3*3
tambah <- 3+2
kurang<- 3-2
akar <- sqrt(100)
logaritma <- log10(100000)
logdua<- log(64)
mod <- 10%%3
5 < 3
6 > 2
6 >= 3 
7 <= 7
7 == 7
6 == 7 
6 != 7
5 ! 1
1 & 2
isTRUE(5)


num <- 3.4 
class(num)

word <- "udinus"
class(word)

logic <- TRUE
class(logic)

#struktur data
#skalar / atomic vector
a <- 3
b <- 4
c <- 5
d <- 6

a%%d
a*d
sqrt(b)
log(c)


var1 <- "a"
var2 <- "b"
var3 <- "c"

#vector
string <- c(a+b,b,c,d/a,a%%d)
string2 <- c('u','d','i','n','u','s')

#list
list_f1 <- list(nama = "Kappa", umur = 32, S2 = TRUE)

#list + vector
list_f2 <- list(nama = c("Kappa","Jebaited","4Head"), 
                umur = c(32,12,24), 
                Magister = c(TRUE,FALSE,FALSE))

list_f2[[1]][3] #ngambil list dari list ke 1 vektor ke 3
list_f2[[2]][2] #ngambil list dari list ke 2 vektor ke 2
list_f2[[3]][1] #ngambil list dari list ke 3 vektor ke 1

#matrix
my_mat <- matrix(1:16, nrow = 4, byrow = TRUE) #membuat matrix
my_mat

#data frame
#ex: data frame vaks
nama <- c("Kappa","Jebaited","4Head")
age <-  c(32,12,24)
s_vaks <- c(TRUE,FALSE,FALSE)
df_stvaks <- data.frame(nama = nama , 
                        umur = age , 
                        status_vaksin = s_vaks) #contoh data frame
df_stvaks
df_stvaks[1]
df_stvaks[2]
df_stvaks[3]

#library and package 
install.packages("tidyverse")

library(tidyverse)
