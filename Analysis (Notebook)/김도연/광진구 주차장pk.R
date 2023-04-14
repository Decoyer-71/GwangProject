install.packages('rJava')
install.packages('DBI')
install.packages('RMySQL')

library(RMySQL)

conn <- dbConnect(MySQL(), dbname= 'testdb', user='root', '1111')
conn

result <- dbGetQuery(conn, 'select * from emp')
result

dbListFields(conn, 'emp')

# DML
dbSendQuery(conn, 'delete from tbla')
dbGetQuery(conn, 'select * from tbla')

# 파일로부터 데이터를 읽어들여 DB에 저장
file_score<- read.csv(file.choose(), header=T)
file_score                      
?dbWriteTable
dbWriteTable(conn, 'parking_pk', file_score, row.names=F)
result<- dbGetQuery(conn, 'select * from parking_pk')
result

dbDisconnect(conn)
