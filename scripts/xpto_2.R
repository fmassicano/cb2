data("airquality")

r <- vector() ; 

for (i in 1:ncol(airquality)) { r[i] <- sum(airquality[!is.na(airquality[,i]),i])  }