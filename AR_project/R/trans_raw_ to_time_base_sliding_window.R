#read raw sensor data
rdata = read.csv('sensor/20190416_sensor.csv', header=F)
#set col name
names(rdata) = c("timestamp","sensor")

#set timestramp format
rdata$timestamp = as.POSIXct(rdata$timestamp, format="%Y-%m-%d %H:%M:%S")
rdata$sensor = as.character(rdata$sensor)

#find dataset's first time and last time
ftime = rdata$timestamp[1]
etime = rdata$timestamp[dim(rdata)[1]]
starttime = seq(from=ftime, to=etime-9, by=10)
endtime = seq(from=ftime+9, to=etime, by=10)

ndata = data.frame()

#transform from raw dataset to time base sliding window dataset
for (i in 1:length(endtime)){
  print(i/length(endtime)*100)
  ndata[i,1] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR0 On')
  ndata[i,2] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR1 On')
  ndata[i,3] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR2 On')
  ndata[i,4] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR3 On')
  ndata[i,5] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR4 On')
  ndata[i,6] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR5 On')
  ndata[i,7] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR6 On')
  ndata[i,8] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR7 On')
  ndata[i,9] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR8 On')
  ndata[i,10] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR9 On')
  ndata[i,11] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR10 On')
  ndata[i,12] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR11 On')
  ndata[i,13] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR12 On')
  ndata[i,14] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR13 On')
  ndata[i,15] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LR14 On')
  ndata[i,16] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LP0 On')
  ndata[i,17] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LP1 On')
  ndata[i,18] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LP2 On')
  ndata[i,19] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='LD On')
  ndata[i,20] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR0 On')
  ndata[i,21] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR1 On')
  ndata[i,22] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR2 On')
  ndata[i,23] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR3 On')
  ndata[i,24] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR4 On')
  ndata[i,25] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR5 On')
  ndata[i,26] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR6 On')
  ndata[i,27] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR7 On')
  ndata[i,28] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeR8 On')
  ndata[i,29] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeP0 On')
  ndata[i,30] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeP1 On')
  ndata[i,31] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeP2 On')
  ndata[i,32] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BeD On')
  ndata[i,33] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BathR0 On')
  ndata[i,34] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BathR1 On')
  ndata[i,35] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BathR2 On')
  ndata[i,36] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BathP0 On')
  ndata[i,37] = sum(rdata[,1]>=starttime[i]&rdata[,1]<=endtime[i]&rdata[,2]=='BathD On')
}

ndata = cbind(endtime,ndata)

#set column name
names(ndata) = c("timestamp","LR0","LR1","LR2","LR3","LR4","LR5","LR6","LR7","LR8","LR9"
                 ,"LR10","LR11","LR12","LR13","LR14","LP0","LP1","LP2","LD"
                 ,"BeR0","BeR1","BeR2","BeR3","BeR4","BeR5","BeR6","BeR7","BeR8"
                 ,"BeP0","BeP1","BeP2","BeD"
                 ,"BathR0","BathR1","BathR2","BathP0","BathD")

#save csv file
write.csv(ndata, file = "ts20190416.csv", row.names=FALSE)
