#read all dataset and merge all
ndata1 <- read.csv('n20190416.csv', header=T, na.strings = "NA")
ndata2 <- read.csv('n20190417.csv', header=T, na.strings = "NA")
ndata3 <- read.csv('n20190418.csv', header=T, na.strings = "NA")
ndata4 <- read.csv('n20190419.csv', header=T, na.strings = "NA")
ndata <- rbind(ndata1, ndata2, ndata3, ndata4)
#write.csv(ndata, file = "ndata.csv", row.names=FALSE)
ssdata1 <- read.csv('s20190416.csv', header=T, na.strings = "NA")
ssdata2 <- read.csv('s20190417.csv', header=T, na.strings = "NA")
ssdata3 <- read.csv('s20190418.csv', header=T, na.strings = "NA")
ssdata4 <- read.csv('s20190419.csv', header=T, na.strings = "NA")
ssdata <- rbind(ssdata1, ssdata2,ssdata3,ssdata4)
scdata1 <- read.csv('sv20190416.csv', header=T, na.strings = "NA")
scdata2 <- read.csv('sv20190417.csv', header=T, na.strings = "NA")
scdata3 <- read.csv('sv20190418.csv', header=T, na.strings = "NA")
scdata4 <- read.csv('sv20190419.csv', header=T, na.strings = "NA")
scdata <- rbind(scdata1, scdata2, scdata3, scdata4)

#set timestamp format
ndata$timestamp=as.POSIXct(ndata$timestamp, format="%Y-%m-%d %H:%M:%S")
ssdata$timestamp=as.POSIXct(ssdata$timestamp, format="%Y-%m-%d %H:%M:%S")
scdata$timestamp=as.POSIXct(scdata$timestamp, format="%Y-%m-%d %H:%M:%S")

#remove Null in Activity dataset
ndata <-ndata[!is.na(ndata[,2]),]

#join with Sensor dataset and Activity dataset, 
#tss: time base sliding window
#tsc: count base sliding window
tssdata <- merge(ndata,ssdata,by="timestamp",all.x=T)
tscdata <- merge(ndata,scdata,by="timestamp",all.x=T)

#remove Null and timestamp in sensor dataset
tscdata <- tscdata[!is.na(tscdata[,3]),]
tscdata <- tscdata[,-3]

#remove idle state
tssdata = subset(tssdata, state!='idle')
write.csv(tssdata, file = "tssdata.csv", row.names=FALSE)
tssdata <- read.csv('tssdata.csv', header=T, na.strings = "NA")
tscdata = subset(tscdata, state!='idle')
write.csv(tscdata, file = "tscdata.csv", row.names=FALSE)
tscdata <- read.csv('tscdata.csv', header=T, na.strings = "NA")
##################


library(randomForest)

#random forest modeling, trainset 80%, testset 20%
##time base sliding window
train1 <- sample(nrow(tssdata), 0.8*nrow(tssdata), replace = FALSE)
TrainSet1 <- tssdata[train1,-1]
TestSet1 <- tssdata[-train1,-1]
model1 <- randomForest(state~ ., data = TrainSet1, importance = TRUE)
model1
predValid1 <- predict(model1, TestSet1, type = "class")
mean(predValid1 == TestSet1$state)                    
table(predValid1,TestSet1$state)

##time base sliding window
train2 <- sample(nrow(tscdata), 0.8*nrow(tscdata), replace = FALSE)
TrainSet2 <- tscdata[train2,-1]
TestSet2 <- tscdata[-train2,-1]
model2 <- randomForest(state~ ., data = TrainSet2, importance = TRUE)
model2
predValid2 <- predict(model2, TestSet2, type = "class")
mean(predValid2 == TestSet2$state)                    
table(predValid2,TestSet2$state)
