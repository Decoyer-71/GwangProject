#### 1.데이터 전처리 ####

## (1) 로드

# 1) 주차면수
park <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/park(수정본).csv",
           fileEncoding= "utf-8")
park <- park[,-c(1,2)]
head(park)

# 2) 인구
pop<- read.csv("../../../GitTest/GwangProject/Data/회귀분석/pop(수정본).csv",
           fileEncoding= "utf-8")
pop <- pop[,-c(1,2)]
head(pop)

# 3) 교통량  - 제외
traffic <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/교통량_18_22.csv", 
           fileEncoding= "utf-8",header = F,
           col.names = c("연도","구별","동별","평균교통량"))
head(traffic)
str(traffic)

# 4) 단속건수  - 제외
violence <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/불법단속건수_18_22.csv", 
                    fileEncoding= "utf-8",header = F,
                    col.names = c("구별","연도","단속건수"))
violence

# 5) 유동인구
flowpop = read.csv("../../../GwangProject/Data/회귀분석/2018~2022유동인구.csv", fileEncoding= "utf-8")
flowpop <- flowpop[,-1]
head(flowpop)
colnames(flowpop)<-c("구별","동별","평균유동인구","연도")

# 6) 직장인구
jobpop = read.csv("../../../GwangProject/Data/회귀분석/2018~2022직장인구.csv", fileEncoding= "utf-8")
jobpop <- jobpop[,-1]
head(jobpop)
colnames(jobpop)<-c("구별","동별","평균직장인구","연도")

# 7) 주거인구
re_pop = read.csv("../../../GwangProject/Data/회귀분석/2018~2022거주인구.csv", fileEncoding= "utf-8")
re_pop<- re_pop[,-1]
head(re_pop)
colnames(re_pop)<-c("구별","동별","평균거주인구","연도")

# 8) 차량등록대수
car <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/동별차량(수정).csv", 
           fileEncoding= "utf-8")
head(car)

# 9) 면적
area <- read.csv("../../../GitTest/GwangProject/Data/회귀분석/동별면적(수정).csv", 
           fileEncoding= "utf-8")
head(area)

## (2) 병합

df <- merge(park, pop, by = c("구별","동별","연도"), all.x = T, all.y = T)
# df <- merge(df, traffic, by.x = c("구별","동별","연도"),all.x = T, all.y = T)
df <- merge(df, flowpop, by = c("구별","동별","연도"), all.x = T, all.y = T)
df <- merge(df, jobpop, by = c("구별","동별","연도"), all.x = T, all.y = T)
df <- merge(df, re_pop, by = c("구별","동별","연도"), all.x = T, all.y = T)
df <- merge(df, car, by = c("구별","동별","연도"), all.x = T, all.y = T)
df <- merge(df, area, by = c("구별","동별","연도"), all.x = T, all.y = T)
head(df)
str(df)

## (3) 컬럼 전처리

# 1) 타입 변경
df$주차장면수<-as.numeric(df$주차장면수)
df$주민인구<-as.numeric(df$주민인구)
df$면적<-as.numeric(df$면적)
# df$평균교통량<-as.numeric(df$평균교통량)

# 2) 2022년 추출

df22<-df[df$연도== 2022,]
str(df22)
colSums(is.na(df22))

# 3) 결측치 제거

df22<- df22[!df22$동별 %in% c("상일동","일원2동","항동","둔촌1동","개포3동"),]
str(df22)
colSums(is.na(df22))
View(df22)


library(stringr)
str_extract_all(df22[,c(4:10)], '[^0-9.]')
# df22[,c(4:10)] <- str_replace_all(df22[,c(4:10)], '[^0-9.]', '')

str(df22)

# 4) 파일 저장 및 불러오기

write.csv(df22, file="../../../GwangProject/Data/회귀분석/회귀분석데이터프레임.csv", 
          fileEncoding="utf-8",row.names = F)

# df22<-read.csv("../../../GwangProject/Data/회귀분석/회귀분석데이터프레임.csv", 
#                fileEncoding="utf-8")

View(df22)
str(df22)
colSums(is.na(df22))
lapply(lapply(test1,is.nan),sum)


#### 2. 분석 ####

## (1) 상관분석
attach(df22)
x <- cbind(주차장면수,주민인구,평균유동인구,평균직장인구,평균거주인구,
                차량등록대수,면적)
cor(x)
detach(df22)

## (2) 분산분석 

moonBook::densityplot(주차장면수 ~ 구별, data=df22)

## 정규성 분포 : 귀무 기각
out <- aov(주차장면수 ~ 구별, data=df22)
shapiro.test(resid(out))    

## 등분산성 : 귀무 기각
bartlett.test(주차장면수 ~ 구별, data=df22)   

## 분산분석
kruskal.test(주차장면수 ~ 구별, data=df22) # p<0.05

summary(out) # 정규, 등분산 가정 p<0.05


## 사후 검증

library(pgirmess)
kruskalmc(df22$주차장면수, df22$구별) 

TukeyHSD(out)


## (3) 다중회귀분석 

library(car)

# 1) 데이터 전처리

test1<-df22[,-c(1,2,3)]
View(test1)
summary(test1)
colSums(is.na(test1))
str(test1)
lapply(lapply(test1, is.infinite), sum)

# 2) backward

full.model <- lm(주차장면수 ~ . , data = test1)
back.model <- step(full.model, direction = "backward", trace=0)
back.model

reg <- lm(주차장면수 ~ 평균유동인구 + 평균직장인구 + 평균거주인구 + 
                 차량등록대수 + 면적, data = test1)

summary(reg)   # Adjusted R-squared:  0.7161

# 그래프

pairs(test1[, c("주차장면수","평균유동인구", "평균직장인구",
                "평균거주인구", "차량등록대수", "면적")])
abline(reg, col = "red")

str(test1)

par(mfrow=c(2,2))
plot(reg)
plot(reg1)
plot(reg2)

# 정규성  : p<0.05 정규성 기각
shapiro.test(resid(reg))

summary(powerTransform(test1$주차장면수))  # Est Power 0.0664

reg1 <- lm(주차장면수^(0.0664) ~ 평균유동인구 + 평균직장인구
                + 평균거주인구 + 차량등록대수 + 면적, data = test1)
summary(reg1)   # Adjusted R-squared:  0.6823

shapiro.test(resid(reg1))   # 정규 기각
ncvTest(reg1)      # 등분산 만족


# 다중공선성 : 2 이하로 만족 
library(car)

vif(reg)
sqrt(vif(reg))

sqrt(vif(reg1))

sqrt(vif(reg2))


# 등분산성 : p<0.05로 등분산성 기각
ncvTest(reg)
spreadLevelPlot(reg)  # Suggested power transformation:  0.06556948 

reg2 <- lm((주차장면수^0.0656) ~ 평균유동인구 + 평균직장인구 + 
             평균거주인구 + 차량등록대수 + 면적, data = test1)
summary(reg2)       # 등분산만 보정 Adjusted R-squared:  0.6821 

shapiro.test(resid(reg2))  # 정규 기각

ncvTest(reg2)       # 등분산 만족



# 선형성  : 에러('x' 내에 NA/NaN/Inf가 있습니다) 

boxTidwell(주차장면수 ~ 평균유동인구 + 평균직장인구 + 평균거주인구 + 
                  차량등록대수 + 면적, data = test1)


## (2) Forward
min.model <- lm(주차장면수 ~ 1, data=test1)
fwd.model <- step(min.model, direction = "forward",
                  scope = (주차장면수 ~ 주민인구 + 평균유동인구 +
                                  평균직장인구 +평균거주인구 +
                                  차량등록대수 + 면적), trace=0)
fwd.model





## (3) All Subset Regression
library(leaps)

leap <- regsubsets(주차장면수 ~ 주민인구 + 평균유동인구 + 평균직장인구 +
                          평균거주인구 + 차량등록대수 + 면적, data=test1,
                        nbest = 6)
leap

par(mfrow=c(1,1))
plot(leap, scale = "adjr2")


