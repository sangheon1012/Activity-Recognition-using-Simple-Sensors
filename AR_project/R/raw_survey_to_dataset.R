#read csv file
rdata=read.csv('servay/20190416.csv', header=T)

#set timestamp format as "%Y.%m.%d %H:%M:%S"
rdata$timestamp=as.POSIXct(rdata$timestamp, format="%Y.%m.%d %H:%M:%S")
rdata$state=as.character(rdata$state)
ftime = rdata$timestamp[1]
etime = rdata$timestamp[dim(rdata)[1]]

#make timestamp columns that increase every second
timestamp = seq(from=ftime, to=etime, by=1)
ntimestamp = data.frame(timestamp, stringsAsFactors=FALSE)

#join timestamp and survey
ndata <- merge(ntimestamp,rdata,by="timestamp",all=TRUE)

#change null to state refer to the above rows
for ( i in 2:dim(ndata)[1]){
  print(i/dim(ndata)[1]*100)
  if (is.na(ndata[i,2])&grepl('start',ndata[i-1,2])){
    ndata[i,2] = ndata[i-1,2]
  }
}

#remove 'start' and 'end'
ndata[,2] <- sapply(strsplit(ndata[,2], split=' ', fixed=TRUE), function(x) (x[1]))
#add idle class
ndata[is.na(ndata[,2]),2] = 'idle'

#save new csv file
write.csv(ndata, file = "n20190416.csv", row.names=FALSE)
