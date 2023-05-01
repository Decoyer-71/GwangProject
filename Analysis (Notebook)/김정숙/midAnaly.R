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
df[,c(3:13)]<-lapply(df[,c(3:13)],as.numeric)
str(df)

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


## 4) All Subset Regression  

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

#### 4. 모델 보완  ####  

## 최초 모델

reg1 <- lm(주차장면수 ~ 인구밀도 + 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
                data = test1)
summary(reg1)   #  0.7358 

shapiro.test(resid(reg1))  # 귀무 기각
sqrt(vif(reg1))   # 인구밀도, 평균거주인구 2 이상
ncvTest(reg1)    # 귀무기각
boxTidwell(주차장면수 ~ 인구밀도 + 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
                data = test1)  # 에러

## All Subset Regression에서 인구밀도와 평균거주인구 택일 모델 중 
## 설명력이 높은 모델 선택

reg2 <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
                data = test1)

summary(reg2)   #  0.7314
shapiro.test(resid(reg2))  # 귀무 기각
ncvTest(reg2)    # 귀무기각
sqrt(vif(reg2))  

boxTidwell(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미, 
                data = test1)  # p=0.000102

## 유의성이 상대적으로 낮은(p>=0.05) 구별_더미, 면적 제외 모델 : 확정

reg3 <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 승객수, 
                data = test1)

summary(reg3)   #  0.7292 
shapiro.test(resid(reg3))  # 귀무 기각(정규성 기각)
ncvTest(reg3)    # 귀무기각(등분산성 기각)
sqrt(vif(reg3))  

boxTidwell(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 +  승객수 , 
                data = test1)  # p=0.0004268(선형성 기각)

## 그래프
library(car)
par(mfrow=c(1,1))
influencePlot(reg3, id=list(method="identify"))

qqPlot(reg3,id.method="identify",simulate=TRUE,main="Q-Q_ plot")

par(mfrow=c(2,2))
plot(reg3)

## 이상치  : 틈 변화가 없으므로 제거 안함
outlierTest(reg3)   # 잔차만을 고려한 Bonferroni검정 : 208,123,114,406

influencePlot(reg3)  # 표본의 영향력을 고려 : 10,123,202,208,215
6/422
plot(reg3, which=4)  # CookD : 10,202,208
5/(422-1-1)

test2<-test1[-c(10,123,202,208,215),]

fit1 <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 평균거주인구 + 
                  차량등록대수 +  승객수, data = test2)

summary(fit1)  # 0.7567 

shapiro.test(resid(fit1))  # 귀무 기각(정규성 기각)
ncvTest(fit1)             # 귀무 기각(등분산성 기각)
# boxTidwell(주차장면수 ~ 평균유동인구 + 평균직장인구 + 평균거주인구 + 
#                 차량등록대수 +  승객수, data = test2) # 에러
sqrt(vif(fit1))


## 정규보완

summary(powerTransform(test1$주차장면수))  # Est Power 0.0682

fit2 <- lm(주차장면수^0.068 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 +승객수,
                data = test1) 

summary(fit2)   # 0.6942

shapiro.test(resid(fit2))   # 정규 기각
ncvTest(fit2)      
sqrt(vif(fit2)) 

boxTidwell(주차장면수^0.068 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
                data = test1)   # 에러


## 등분산 보정   
spreadLevelPlot(reg3)  # Suggested power transformation:   0.154443  

fit3 <- lm(주차장면수^0.154 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 승객수,
                data = test1) 

summary(fit3)   # 0.7098 

shapiro.test(resid(fit3))   # 정규 기각
ncvTest(fit3)               # 0.17537

## 선형성 보정 

test3<-test1
test3$평균유동인구<-test1$평균유동인구^0.012    # 27.33371 / 0.012466 
test3$평균직장인구<-test1$평균직장인구^0.305   # 0.30597 / 0.080592
test3$평균거주인구<-test1$평균거주인구^0.035   # 0.35379 / 0.035335
test3$차량등록대수<-test1$차량등록대수^1.44   # 1.44822 / 0.002236
test3$승객수<-test1$승객수^0.695            #  0.69551 / 0.349067


fit4 <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 + 승객수 ,
                data = test3) 

summary(fit4)   # Adjusted R-squared:   0.7321 

shapiro.test(resid(fit4))   # 정규 기각
ncvTest(fit4)               # 등분산 기각  
sqrt(vif(fit4)) 

boxTidwell(주차장면수 ~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 +승객수 ,
                data = test3)   # 에러  

## 종합보정

fit5 <- lm((주차장면수^0.068) ~ 평균유동인구 + 평균직장인구 + 
             평균거주인구 + 차량등록대수 + 면적 + 승객수 + 구별_더미,
           data = test3) 

summary(fit5)   # 0.6773 

par(mfrow=c(2,2))
plot(fit5)     # 에러

shapiro.test(resid(fit5))   # 정규 기각
ncvTest(fit5)               
sqrt(vif(fit5))            

boxTidwell(주차장면수^0.068~ 평균유동인구 + 평균직장인구 + 
                  평균거주인구 + 차량등록대수 +승객수 ,
                data = test3)  # 에러러

#### 6. 적합값 ####
df
df$적합값<-predict(reg3)
df$필요주차면수 <- df$적합값 - df$주차장면수

View(df)

