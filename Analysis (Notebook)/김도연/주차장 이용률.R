install.packages('rJava')
install.packages('DBI')
install.packages('RMySQL')

library(RMySQL)

conn <- dbConnect(MySQL(), dbname= 'testdb', user='root', '1111')
conn

#result <- dbGetQuery(conn, 'select * from emp')
#result

#dbListFields(conn, 'emp')

# DML
#dbSendQuery(conn, 'delete from tbla')
#dbGetQuery(conn, 'select * from tbla')

# 1. 파일로부터 데이터를 읽어들여 DB에 저장

file_score<- read.csv(file.choose(), header=T)
file_score                      
?dbWriteTable
dbWriteTable(conn, 'parking_pk', file_score, row.names=F)
result<- dbGetQuery(conn, 'select * from parking_pk')
result

dbDisconnect(conn)


# 2. 주차장 이용률 시계열 분석
getwd()
setwd('C:\\Users\\acorn\\Documents\\GwangProject\\Analysis (Notebook)\\김도연')
df <- read.csv('부설주차장 이용량.csv')

View(df)
library(dygraphs)
library(xts)
library(ggplot2)

?xts
# 시간 간격을 나타내는 POSIXct 객체를 생성합니다.
timestamps <- seq(as.POSIXct("2023-04-15 8:00:00"), as.POSIXct("2023-04-21 18:00:00"), by="hour")
timestamps
# 임의의 데이터를 생성합니다.
data <- rnorm(length(timestamps))
# xts 객체를 만듭니다.
my_xts <- xts(data, order.by = timestamps)

건국대학교병원<-xts(df$건국대학교병원, order.by =timestamps)
뚝섬1주차장 <-xts(df$뚝섬1주차장, order.by =timestamps)
뚝섬2주차장 <-xts(df$뚝섬2주차장, order.by =timestamps)
뚝섬3주차장 <-xts(df$뚝섬3주차장, order.by =timestamps)
뚝섬4주차장<-xts(df$뚝섬4주차장, order.by =timestamps)
실로암사우나중곡점주차장 <-xts(df$실로암사우나중곡점주차장, order.by =timestamps)
연한빌딩<-xts(df$연한빌딩, order.by =timestamps)
와이엠프라젠스파 <-xts(df$와이엠프라젠스파, order.by =timestamps)
편안한요양병원<-xts(df$편안한요양병원, order.by =timestamps)
date <- cbind(건국대학교병원,뚝섬1주차장 ,뚝섬2주차장 ,뚝섬3주차장 ,뚝섬4주차장,실로암사우나중곡점주차장,연한빌딩,와이엠프라젠스파,편안한요양병원)
gg<-dygraph(date) %>% dyLegend(labelsSeparateLines = T)
dyRangeSelector(gg)


