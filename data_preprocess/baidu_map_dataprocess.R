setwd("D:\\Files\\XJTLU\\surf\\computer_version")
gps  = read.csv(file = "gps_0.csv", sep = ",",header = T)
latitude=gps$Latitude
longitude=gps$Longitude
for (i in c(1:length(latitude))){ 
  print(latitude[i])
  latitude[i] =as.numeric(substring(latitude[i],1,2))+(as.numeric(substring(latitude[i],4,11))/60)
  print(latitude[i])
  }
for (i in c(1:length(longitude))){ 
  print(longitude[i])
  longitude[i] =as.numeric(substring(longitude[i],1,3))+(as.numeric(substring(longitude[i],5,12))/60)
  print(longitude[i])
}
  #print(substring(i,1,2))
  #print(substring(i,3,11))
  #i =as.numeric(substring(i,1,2))+(as.numeric(substring(i,3,11))/60)
  #print(i)

gps$Latitude = latitude
gps$Longitude = longitude
write.csv(gps,"gps_new.csv")
