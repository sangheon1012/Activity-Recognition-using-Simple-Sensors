#시간, 행동의 시작과 끝으로 저장된 로우 서베이 데이터를
#1초당 행동인 데이터셋으로 변환함

#read csv file
rdata=read.csv('servay/20190416.csv', header=T)

#타임스탬프 포멧을 설정 "%Y.%m.%d %H:%M:%S"
rdata$timestamp=as.POSIXct(rdata$timestamp, format="%Y.%m.%d %H:%M:%S")
rdata$state=as.character(rdata$state)
ftime = rdata$timestamp[1]
etime = rdata$timestamp[dim(rdata)[1]]

#1초 단위로 증가하는 타임스템프 피쳐를 생성함
timestamp = seq(from=ftime, to=etime, by=1)
ntimestamp = data.frame(timestamp, stringsAsFactors=FALSE)

#생성한 타임스템프 피쳐와 서베이 데이터를 타임스템프로 조인함
ndata <- merge(ntimestamp,rdata,by="timestamp",all=TRUE)

#행을 하나씩 검사하며 행동 Start와 행동 End 사이의 빈 시간에 행동을 채워넣음
for ( i in 2:dim(ndata)[1]){
  print(i/dim(ndata)[1]*100)
  if (is.na(ndata[i,2])&grepl('start',ndata[i-1,2])){
    ndata[i,2] = ndata[i-1,2]
  }
}

#Start와 End를 지움
ndata[,2] <- sapply(strsplit(ndata[,2], split=' ', fixed=TRUE), function(x) (x[1]))
#비어있는 시간에는 확인되지 않음을 뜻하는 idle를 채워넣음
ndata[is.na(ndata[,2]),2] = 'idle'

#save new csv file
write.csv(ndata, file = "n20190416.csv", row.names=FALSE)
