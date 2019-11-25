#시간 센서의 On/Off로 들어오는 로우 데이터를 
#행:시간, 열: 각 센서의 On/Off 여부(0 or 1) 인 데이터셋으로 변환함
#10초 단위의 슬라이딩 윈도우 방식으로 각 센서의 On 값을 카운팅함

#read raw sensor data
rdata = read.csv('sensor/20190416_sensor.csv', header=F)
#set col name
names(rdata) = c("timestamp","sensor")

#set timestramp format
rdata$timestamp = as.POSIXct(rdata$timestamp, format="%Y-%m-%d %H:%M:%S")
rdata$sensor = as.character(rdata$sensor)

#데이터가 시작하는 첫번째 시간과 마지막 시간을 찾음
ftime = rdata$timestamp[1]
etime = rdata$timestamp[dim(rdata)[1]]
#슬라이딩 윈도우의 시작시간과 끝시간을 정함
starttime = seq(from=ftime, to=etime-9, by=10)
endtime = seq(from=ftime+9, to=etime, by=10)
ndata = data.frame()

#슬라이딩 윈도우를 1초씩 이동함. 슬라이딩 윈도 시간 범위 내에서 로우 데이터의 센서값 On의 갯수를 카운트함

#Ex) 00:00:00 Senor1 On, 00:00:02 Senor1 On, 00:00:10 Senor1 On, 00:00:11 Senor2 On,

# -> | start   |  end     |  Sensor1 | Sensor2 |
#    |00:00:01 | 00:00:10 |    3     |    0    |
#    |00:00:02 | 00:00:11 |    2     |    1    |

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

#생성된 데이터셋과 슬라이딩 윈도 끝시간을 결합함
ndata = cbind(endtime,ndata)

#set column name
names(ndata) = c("timestamp","LR0","LR1","LR2","LR3","LR4","LR5","LR6","LR7","LR8","LR9"
                 ,"LR10","LR11","LR12","LR13","LR14","LP0","LP1","LP2","LD"
                 ,"BeR0","BeR1","BeR2","BeR3","BeR4","BeR5","BeR6","BeR7","BeR8"
                 ,"BeP0","BeP1","BeP2","BeD"
                 ,"BathR0","BathR1","BathR2","BathP0","BathD")

#save csv file
write.csv(ndata, file = "ts20190416.csv", row.names=FALSE)