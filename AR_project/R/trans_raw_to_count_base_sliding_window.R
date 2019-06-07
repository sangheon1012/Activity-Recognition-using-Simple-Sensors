#read csv file
rdata = read.csv('sensor/20190416_sensor.csv', header=F)
names(rdata) = c("timestamp","sensor")

#set timestamp format
rdata$timestamp = as.POSIXct(rdata$timestamp, format="%Y-%m-%d %H:%M:%S")
rdata$sensor = as.character(rdata$sensor)

Ondata = rdata[grepl('On',rdata[,2]),]
ndata = data.frame()

#transform from raw sensor data to count base sliding window dataset
##v1: firing time, v2: last firing time, v3: time differ, v4~: sensor count
for(i in 1:(nrow(Ondata)-9)){
  print(i/(nrow(Ondata)-9)*100)
  ndata[i,1] = difftime(Ondata[i+9,1], Ondata[i,1], units =c("secs"))
  ndata[i,2] = sum(Ondata[i:(i+9),2]=='LR0 On')
  ndata[i,3] = sum(Ondata[i:(i+9),2]=='LR1 On')
  ndata[i,4] = sum(Ondata[i:(i+9),2]=='LR2 On')
  ndata[i,5] = sum(Ondata[i:(i+9),2]=='LR3 On')
  ndata[i,6] = sum(Ondata[i:(i+9),2]=='LR4 On')
  ndata[i,7] = sum(Ondata[i:(i+9),2]=='LR5 On')
  ndata[i,8] = sum(Ondata[i:(i+9),2]=='LR6 On')
  ndata[i,9] = sum(Ondata[i:(i+9),2]=='LR7 On')
  ndata[i,10] = sum(Ondata[i:(i+9),2]=='LR8 On')
  ndata[i,11] = sum(Ondata[i:(i+9),2]=='LR9 On')
  ndata[i,12] = sum(Ondata[i:(i+9),2]=='LR10 On')
  ndata[i,13] = sum(Ondata[i:(i+9),2]=='LR11 On')
  ndata[i,14] = sum(Ondata[i:(i+9),2]=='LR12 On')
  ndata[i,15] = sum(Ondata[i:(i+9),2]=='LR13 On')
  ndata[i,16] = sum(Ondata[i:(i+9),2]=='LR14 On')
  ndata[i,17] = sum(Ondata[i:(i+9),2]=='LP0 On')
  ndata[i,18] = sum(Ondata[i:(i+9),2]=='LP1 On')
  ndata[i,19] = sum(Ondata[i:(i+9),2]=='LP2 On')
  ndata[i,20] = sum(Ondata[i:(i+9),2]=='LD On')
  ndata[i,21] = sum(Ondata[i:(i+9),2]=='BeR0 On')
  ndata[i,22] = sum(Ondata[i:(i+9),2]=='BeR1 On')
  ndata[i,23] = sum(Ondata[i:(i+9),2]=='BeR2 On')
  ndata[i,24] = sum(Ondata[i:(i+9),2]=='BeR3 On')
  ndata[i,25] = sum(Ondata[i:(i+9),2]=='BeR4 On')
  ndata[i,26] = sum(Ondata[i:(i+9),2]=='BeR5 On')
  ndata[i,27] = sum(Ondata[i:(i+9),2]=='BeR6 On')
  ndata[i,28] = sum(Ondata[i:(i+9),2]=='BeR7 On')
  ndata[i,29] = sum(Ondata[i:(i+9),2]=='BeR8 On')
  ndata[i,30] = sum(Ondata[i:(i+9),2]=='BeP0 On')
  ndata[i,31] = sum(Ondata[i:(i+9),2]=='BeP1 On')
  ndata[i,32] = sum(Ondata[i:(i+9),2]=='BeP2 On')
  ndata[i,33] = sum(Ondata[i:(i+9),2]=='BeD On')
  ndata[i,34] = sum(Ondata[i:(i+9),2]=='BathR0 On')
  ndata[i,35] = sum(Ondata[i:(i+9),2]=='BathR1 On')
  ndata[i,36] = sum(Ondata[i:(i+9),2]=='BathR2 On')
  ndata[i,37] = sum(Ondata[i:(i+9),2]=='BathP0 On')
  ndata[i,38] = sum(Ondata[i:(i+9),2]=='BathD On')
}

#add timestamp and first firing time
ndata = cbind(Ondata[1:(nrow(Ondata)-9),1],Ondata[10:nrow(Ondata),1],ndata)

#set col name
names(ndata) = c("firingtime","timestamp","timediff","LR0","LR1","LR2","LR3","LR4","LR5","LR6","LR7","LR8","LR9"
                 ,"LR10","LR11","LR12","LR13","LR14","LP0","LP1","LP2","LD"
                 ,"BeR0","BeR1","BeR2","BeR3","BeR4","BeR5","BeR6","BeR7","BeR8"
                 ,"BeP0","BeP1","BeP2","BeD"
                 ,"BathR0","BathR1","BathR2","BathP0","BathD")

#save csv file
write.csv(ndata, file = "sv20190416.csv", row.names=FALSE)
