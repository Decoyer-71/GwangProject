#### 1.데이터 전처리 ####

## (1) 로드

# 1) 주차면수
park <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/park(수정본).csv",
                 fileEncoding= "utf-8")
park <- park[park$연도 == 2022,-c(1,2,5)]
head(park)

# 2) 인구밀도
den<- read.csv("../../../GwangProject/Data/회귀분석/인구밀도.csv",
               fileEncoding= "utf-8")
den<-den[den$연도 == 2022, -c(1,2)]
head(den)

# 3) 교통량 
traffic <- read.csv("../../../GwangProject/Data/회귀분석/교통량(수정).csv", 
                    fileEncoding= "utf-8")
traffic <-traffic[traffic$연도 == 2022,-c(1,4)]
head(traffic)

# 4) 유동인구
flowpop = read.csv("../../../GwangProject/Data/회귀분석/2018~2022유동인구.csv", fileEncoding= "utf-8")
flowpop <- flowpop[flowpop$연도 == 2022,-c(1,5)]
head(flowpop)
colnames(flowpop)<-c("구별","동별","평균유동인구")

# 5) 직장인구
jobpop = read.csv("../../../GwangProject/Data/회귀분석/2018~2022직장인구.csv", fileEncoding= "utf-8")
jobpop <- jobpop[jobpop$연도 == 2022,-c(1,5)]
head(jobpop)
colnames(jobpop)<-c("구별","동별","평균직장인구")

# 6) 거주인구
re_pop = read.csv("../../../GwangProject/Data/회귀분석/2018~2022거주인구.csv", fileEncoding= "utf-8")
re_pop<- re_pop[re_pop$연도 == 2022,-c(1,5)]
head(re_pop)
colnames(re_pop)<-c("구별","동별","평균거주인구")

# 7) 차량등록대수
car <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/동별차량(수정).csv", 
                fileEncoding= "utf-8")
car<-car[car$연도 == 2022,-3]
head(car)


# 8) 인구
pop<- read.csv("../../../GitTest/GwangProject/Data/회귀분석/pop(수정본).csv",
               fileEncoding= "utf-8")
pop <- pop[pop$연도 == 2022,-c(1,2,5)]
head(pop)

# 9) 면적
area <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/동별면적(수정).csv", 
                 fileEncoding= "utf-8")
area <- area[area$연도 == 2022,-c(3)]
head(area)

# 10) 승객수
passenger <- read.csv("../../../GwangProject/Data/회귀분석/동별대중교통이용승객수(수정).csv", 
                 fileEncoding= "utf-8")
passenger <- passenger[,-c(1)]
names(passenger)<-c("구별","동별","승객수")
head(passenger )

## (2) 병합

df <- merge(park, den, by = c("구별","동별"),all.x = T, all.y = T)
df <- merge(df, traffic, by = c("구별","동별"),all.x = T, all.y = T)
df <- merge(df, flowpop, by = c("구별","동별"), all.x = T, all.y = T)
df <- merge(df, jobpop, by = c("구별","동별"), all.x = T, all.y = T)
df <- merge(df, re_pop, by = c("구별","동별"), all.x = T, all.y = T)
df <- merge(df, car, by = c("구별","동별"), all.x = T, all.y = T)
df <- merge(df, pop, by = c("구별","동별"), all.x = T, all.y = T)
df <- merge(df, area, by = c("구별","동별"), all.x = T, all.y = T)
df <- merge(df, passenger, by = c("구별","동별"), all.x = T, all.y = T)
head(df)
str(df)

## (3) 컬럼 전처리

# 1) 타입 변경

df[,c(3:13)]<-lapply(df[,c(3:13)],as.numeric)
str(df)

# 2) 결측치 제거

df<- df[df$동별 !="일원2동",]
df<- df[df$동별 !="개포3동",]
df<- df[df$동별 !="항동",]
df<- df[df$동별 !="상일동",]

###### 관악구 신사동 교통량을 관악구 교통량으로 대체
df[df$구별 == "관악구" & df$동별 =="신사동","평균교통량"]=1044.853917

colSums(is.na(df))
View(df)

###### 평균거주인구가 0인 둔촌1동 제거 
df<- df[df$동별 !="둔촌1동",]

# 3) 구별 더미변수

df$구별_더미<-ifelse(df$구별=="강남구",1,ifelse(df$구별=="강동구",2,
                    ifelse(df$구별=="강북구",3,ifelse(df$구별=="강서구",4,
                    ifelse(df$구별=="관악구",6,ifelse(df$구별=="광진구",6,
                    ifelse(df$구별=="구로구",7,ifelse(df$구별=="금천구",8,
                    ifelse(df$구별=="노원구",9,ifelse(df$구별=="도봉구",10,
                    ifelse(df$구별=="동대문구",11,ifelse(df$구별=="동작구",12,
                    ifelse(df$구별=="마포구",13,ifelse(df$구별=="서대문구",14,
                    ifelse(df$구별=="서초구",15,ifelse(df$구별=="성동구",16,
                    ifelse(df$구별=="성북구",17,ifelse(df$구별=="송파구",18,
                    ifelse(df$구별=="양천구",19,ifelse(df$구별=="영등포구",20,
                    ifelse(df$구별=="용산구",21,ifelse(df$구별=="은평구",22,
                    ifelse(df$구별=="종로구",23,ifelse(df$구별=="중구구",24,
                    25))))))))))))))))))))))))


# 4) 파일 저장 및 불러오기

write.csv(df, file="../../../GwangProject/Data/회귀분석/회귀분석데이터프레임2.csv", 
          fileEncoding="utf-8",row.names = F)

df<-read.csv("../../../GwangProject/Data/회귀분석/회귀분석데이터프레임2.csv", 
               fileEncoding="utf-8")
str(df)


#### 2. 분석 ####

## (1) 분산분석 

moonBook::densityplot(주차장면수 ~ 구별, data=df)

# 정규성 분포 : 귀무 기각
out <- aov(주차장면수 ~ 구별, data=df)
shapiro.test(resid(out))    

# 등분산성 : 귀무 기각
bartlett.test(주차장면수 ~ 구별, data=df)   

# 분산분석
kruskal.test(주차장면수 ~ 구별, data=df) # p<0.05

# summary(out) # 정규, 등분산 가정 p<0.05


## 사후 검증

# library(pgirmess)
# kruskalmc(df$주차장면수, df$구별) 

# TukeyHSD(out)


## (2) 상관분석
attach(df)  
x <- cbind(인구밀도, 평균교통량, 
                평균유동인구,평균직장인구,평균거주인구,
                차량등록대수, 승객수, 주민인구,면적, 구별_더미)
cor(x)  
cor(주차장면수,x)  
detach(df)



## (3) 다중회귀분석 

library(car)

## 1) 데이터 전처리

test1<-df[,-c(1,2)]    
View(test1)
# summary(test1)
# colSums(is.na(test1))
str(test1)
# lapply(lapply(test1, is.infinite), sum)


## 구별더미변수

## 2) backward

full.model <- lm(주차장면수 ~ . , data = test1)
back.model <- step(full.model, direction = "backward", trace=0)
back.model

## 회귀모델
reg_b <- lm(주차장면수 ~ 인구밀도 + 평균유동인구 + 평균직장인구 + 
              평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
              data = test1)

summary(reg_b)   # Adjusted R-squared: 0.7358 

## 그래프
par(mfrow=c(1,1))
influencePlot(reg_b, id=list(method="identify"))

qqPlot(reg_b,id.method="identify",simulate=TRUE,main="Q-Q_ plot")

par(mfrow=c(2,2))
plot(reg_b)

## 정규성  : p<0.05 정규성 기각
shapiro.test(resid(reg_b))

## 다중공선성 : 
library(car)

vif(reg_b)
sqrt(vif(reg_b))   # 인구밀도, 평균거주인구 > 2 이상 

## 등분산성 : p<0.05 등분산성 기각
ncvTest(reg_b)

## 선형성  : 에러

boxTidwell(주차장면수 ~ 인구밀도 + 평균유동인구 + 평균직장인구 + 
                평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
                data = test1)

## 3) Forward  : 모델 동일

min.model <- lm(주차장면수 ~ 1, data=test1)
fwd.model <- step(min.model, direction = "forward",
                  scope = (주차장면수 ~ 인구밀도+평균교통량+ 
                                평균유동인구+평균직장인구+평균거주인구+
                                차량등록대수+승객수+주민인구+면적+구별_더미), 
                  trace=0)
fwd.model

reg_f<- lm(주차장면수 ~ 차량등록대수 + 승객수 + 평균직장인구 + 
              평균거주인구 + 인구밀도 + 면적 + 평균유동인구 + 구별_더미, 
              data = test1)
summary(reg_f)


## 4) All Subset Regression  : 모델 동일

library(leaps)

leap <- regsubsets(주차장면수 ~ 인구밀도+평균교통량+ 
                          평균유동인구+평균직장인구+평균거주인구+
                          차량등록대수+승객수+주민인구+면적+구별_더미, 
                        data=test1, nbest = 10)
leap

par(mfrow=c(1,1))
plot(leap, scale = "adjr2")

reg_a <- lm(주차장면수 ~ 인구밀도 + 평균유동인구 + 평균직장인구 + 
                   평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
                data = test1)
summary(reg_a)

#### 4. 다중공선성 해결 ####  

## 1) 다중공선성 문제 해결을 위해 유의성이 낮은 인구밀도 삭제

reg1 <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 평균거주인구 + 
                  차량등록대수 + 면적 + 승객수 + 구별_더미, 
                  data = test1)

summary(reg1)   # Adjusted R-squared: 0.7314

## 그래프
par(mfrow=c(1,1))
influencePlot(reg, id=list(method="identify"))

qqPlot(reg,id.method="identify",simulate=TRUE,main="Q-Q_ plot")

par(mfrow=c(2,2))
plot(reg1)

## 정규성  : p<0.05 정규성 기각
shapiro.test(resid(reg))

## 다중공선성 : 2 이하

vif(reg1)
sqrt(vif(reg1))   

## 등분산성 : p<0.05 등분산성 기각
ncvTest(reg1)

## 선형성  : Pr(>F) = 0.000102 변환필요

boxTidwell(주차장면수 ~평균유동인구 + 평균직장인구 + 평균거주인구 + 
                  차량등록대수 + 면적 + 승객수 + 구별_더미,  
                  data = test1)


#### 5. 모델교정 ####

## 정규보완
summary(powerTransform(test1$주차장면수))  # Est Power 0.0682

reg2 <- lm(주차장면수^0.068 ~ 평균유동인구 + 평균직장인구 + 
             평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
           data = test1) 

summary(reg2)   # 0.7008 

par(mfrow=c(2,2))
plot(reg2)

shapiro.test(resid(reg2))   # 정규 기각
ncvTest(reg2)      
sqrt(vif(reg2)) 

boxTidwell(주차장면수^0.068 ~ 평균유동인구 + 평균직장인구 + 
                평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
                data = test1)   # 에러


## 등분산 보정   
spreadLevelPlot(reg1)  # Suggested power transformation:   0.2214113  

reg3 <- lm(주차장면수^0.221 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
                data = test1) 

summary(reg3)   # 0.7256 

shapiro.test(resid(reg3))   # 정규 기각
ncvTest(reg3)               # 등분산 기각

## 선형성 보정 

test2<-test1
test2$평균유동인구<-test1$평균유동인구^43.34    # 43.34086
test2$평균직장인구<-test1$평균직장인구^0.241    # 0.24139
test2$평균거주인구<-test1$평균거주인구^-1.322   # -1.32225
test2$차량등록대수<-test1$차량등록대수^1.715   # 1.71565   
test2$면적적<-test1$면적^0.557                 # 0.55718
test2$승객수<-test1$승객수^0.755               # 0.75531
test2$구별_더미<-test1$구별_더미^1.711         # 1.71153      

reg4 <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
             평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
             data = test1) 

summary(reg4)   # Adjusted R-squared:   0.7314

par(mfrow=c(2,2))
plot(reg4)

shapiro.test(resid(reg4))   # 정규 기각
ncvTest(reg4)      
sqrt(vif(reg4)) 

boxTidwell(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
             평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
             data = test2)   # 에러  

## 종합보정

reg5 <- lm((주차장면수^0.068) ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
                data = test2) 

summary(reg5)   # 0.6331 

par(mfrow=c(2,2))
plot(reg5)     # 에러

shapiro.test(resid(reg5))   # 정규 기각
ncvTest(reg5)               
sqrt(vif(reg5))             # 에러



#### 6. 적합값 ####
df
df$적합값<-predict(reg1)
df$필요주차면수 <- df$적합값 - df$주차장면수

View(df)

