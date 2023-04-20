parks_ppikka <- read.csv("../data/parks_ppikka.csv", fileEncoding = "UTF-8", 
                       col.names = c("cities", "dong", "gong_park", "min_park", "sum_park"))
# 각 구의 sum_park 데이터들은 행정동별로 나뉘어진 것임

View(parks_ppikka)
str(parks_ppikka)

### 광진구와 다른 구의 전체 주차장 면수는 차이가 있는가? 
# 1가지 요인으로 3개 이상 비교대상(one way ANOVA)


# 1) 정규분포 확인
out <- aov(sum_park ~ cities, data = parks_ppikka)
shapiro.test(resid(out)) # 정규분포 아님

# 1-2) 혹시 등분산?(그냥 혹시나 해서 구함)
bartlett.test(sum_park ~ cities, data = parks_ppikka) # 등분산도 아님

# 2) kruskal test확인 (정규분포 아니므로)
kruskal.test(sum_park ~ cities, data = parks_ppikka) # 차이가 있다.

# 사후검정(kruskalmc 사용)
library(pgirmess)
kruskalmc(parks_ppikka$sum_park, parks_ppikka$cities)
## 이중 광진구와 다른 주차장 차이를 확인
# 강남구-광진구     124.2469697     155.2089       FALSE
# 강동구-광진구      61.7122807     160.0994       FALSE
# 강북구-광진구      37.6358974     175.6445       FALSE
# 강서구-광진구      93.5833333     158.3238       FALSE
# 관악구-광진구      40.7238095     156.6999       FALSE
# 광진구-구로구      58.8208333     166.5896       FALSE
# 광진구-금천구       3.8833333     189.2331       FALSE
# 광진구-노원구      13.3438596     160.0994       FALSE
# 광진구-도봉구      26.3309524     172.2511       FALSE
# 광진구-동대문구    42.7761905     172.2511       FALSE
# 광진구-동작구       1.0333333     169.2552       FALSE
# 광진구-마포구      62.8833333     166.5896       FALSE
# 광진구-서대문구     0.6166667     172.2511       FALSE
# 광진구-서초구     124.9111111     162.0496       FALSE
# 광진구-성동구      28.6901961     164.2017       FALSE
# 광진구-성북구      31.7916667     158.3238       FALSE
# 광진구-송파구      63.5592593     149.2691       FALSE
# 광진구-양천구       5.2555556     162.0496       FALSE
# 광진구-영등포구     1.6444444     162.0496       FALSE
# 광진구-용산구      76.6791667     166.5896       FALSE
# 광진구-은평구      37.1958333     166.5896       FALSE
# 광진구-종로구     110.3372549     164.2017       FALSE
# 광진구-중구        60.4333333     169.2552       FALSE
# 광진구-중랑구      25.3041667     166.5896       FALSE

# 하지만 광진구와 다른구의 전체 주차장면수 차이는 없다는 결론




### 공용주차장과 민영주차장을 나누어 차이를 비교해볼까?
View(parks_ppikka)

# 결측치 확인 (-형태의 결측치)
parks_ppikka$gong_park <- ifelse(parks_ppikka$gong_park == "-", 0, parks_ppikka$gong_park)
parks_ppikka$gong_park

# 1) [공용주차장] 정규분포 확인
out <- aov(gong_park ~ cities, data = parks_ppikka)
shapiro.test(resid(out)) # 역시 정규분포 아님

# 2) [공용주차장] kuskal test
kruskal.test(gong_park ~ cities, data = parks_ppikka) # 차이가 있음

# 3) [공용주차장] 사후검정(kruskalmc)
library(pgirmess)
kruskalmc(parks_ppikka$gong_park, parks_ppikka$cities) 
# 강남구-광진구      15.5787879     155.2089       FALSE
# 강동구-광진구       8.8614035     160.0994       FALSE
# 강북구-광진구      63.9282051     175.6445       FALSE
# 강서구-광진구      22.2833333     158.3238       FALSE
# 관악구-광진구       9.5619048     156.6999       FALSE
# 광진구-구로구      45.8145833     166.5896       FALSE
# 광진구-금천구      38.6666667     189.2331       FALSE
# 광진구-노원구      10.2964912     160.0994       FALSE
# 광진구-도봉구      40.1047619     172.2511       FALSE
# 광진구-동대문구    43.0380952     172.2511       FALSE
# 광진구-동작구      69.8000000     169.2552       FALSE
# 광진구-마포구      44.2166667     166.5896       FALSE
# 광진구-서대문구    17.4666667     172.2511       FALSE
# 광진구-서초구      18.1888889     162.0496       FALSE
# 광진구-성동구      18.9745098     164.2017       FALSE
# 광진구-성북구      13.5833333     158.3238       FALSE
# 광진구-송파구       6.8925926     149.2691       FALSE
# 광진구-양천구      42.7277778     162.0496       FALSE
# 광진구-영등포구    20.6722222     162.0496       FALSE
# 광진구-용산구      34.5958333     166.5896       FALSE
# 광진구-은평구      24.5020833     166.5896       FALSE
# 광진구-종로구     109.1215686     164.2017       FALSE
# 광진구-중구        62.0666667     169.2552       FALSE
# 광진구-중랑구      40.6541667     166.5896       FALSE

# 역시 광진구와 다른구의 공용주차장 면수의 차이는 없다



# 1) [민영주차장] 정규분포 확인
out <- aov(min_park ~ cities, data = parks_ppikka)
shapiro.test(resid(out)) # 정규분포 아님

# 2) [민영주차장] kuskal test
kruskal.test(min_park ~ cities, data = parks_ppikka) # 차이가 있음

# 3) [민영주차장] 사후검정(kruskalmc)
library(pgirmess)
kruskalmc(parks_ppikka$min_park, parks_ppikka$cities) 
# 역시 광진구와 다른구의 민영주차장 면수의 차이는 없다
# 강동구-광진구      58.2140351     160.0994       FALSE
# 강남구-광진구     119.0166667     155.2089       FALSE
# 강북구-광진구      43.9641026     175.6445       FALSE
# 강서구-광진구      92.0666667     158.3238       FALSE
# 관악구-광진구      43.4476190     156.6999       FALSE
# 광진구-구로구      59.1416667     166.5896       FALSE
# 광진구-금천구       1.3666667     189.2331       FALSE
# 광진구-노원구      17.7140351     160.0994       FALSE
# 광진구-도봉구      28.4476190     172.2511       FALSE
# 광진구-동대문구    40.5523810     172.2511       FALSE
# 광진구-동작구       2.2666667     169.2552       FALSE
# 광진구-마포구      60.0791667     166.5896       FALSE
# 광진구-서대문구     2.1619048     172.2511       FALSE
# 광진구-서초구     122.2666667     162.0496       FALSE
# 광진구-성동구      31.9098039     164.2017       FALSE
# 광진구-성북구      33.0833333     158.3238       FALSE
# 광진구-송파구      55.9333333     149.2691       FALSE
# 광진구-양천구       7.7333333     162.0496       FALSE
# 광진구-영등포구     6.5666667     162.0496       FALSE
# 광진구-용산구      78.3583333     166.5896       FALSE
# 광진구-은평구      36.8916667     166.5896       FALSE
# 광진구-종로구     112.4392157     164.2017       FALSE
# 광진구-중구        63.3333333     169.2552       FALSE
# 광진구-중랑구      40.6708333     166.5896       FALSE


# 결론 : 광진구와 다른 구의 주차장면수(전체, 공영, 민영) 차이가 없다는 결과, 광진구 이외에도 전체 지역구 비교를 해볼 때 몇몇개를 제외하곤 차이가 없다. 

# 즉, 서울시 또는 정부차원에서 계획하고 집행하는 서울시에 대한 주차장 공급계획은 특정구의 편중됨이 없이 고르게 지원되고 있음을 유추해 볼 수 있다. 

# 그러나, 이렇게 차이가 없다고 결론은 무리가 있어보임(정숙씨의 파이썬 파일과 대조해보면 명확한 차이가 보임)

# 추가변수를 선정하여 데이터에 추가하고, 다중회귀분석을 이용해 정확한 인과관계를 분석할 필요성이 있음


## 2. 다중회귀분석
gu_result <- read.csv("../data/gu_result.csv", fileEncoding = "UTF-8", 
                         col.names = c("cities", "car_tot", "park_tot", "traffic_hour", 
                                       "subway_tot", "bike_sum", "p_transfort_tot", "pop"))
View(gu_result)
# 1)결측치 처리
# 강북구의 교통량(traffic_hour) = NA : 전체 교통량의 평균값을 적용하자
library(dplyr)
gu_result[3, "traffic_hour"] <- gu_result %>% summarize(traffic_mean = mean(traffic_hour, na.rm = TRUE))
View(gu_result)

# 종속변수 : 주차장 면수(park_tot)
# 주차장 면수는 어떤 요인을 고려해야하는가? 

# 2) 각 독립변수 상관관계 분석
str(gu_result)

attach(gu_result)
x <- cbind(car_tot, traffic_hour, subway_tot, bike_sum, pop)
cor(x)
cor(x, park_tot)

reg <- lm(park_tot ~ car_tot + traffic_hour + subway_tot + bike_sum + pop, data = gu_result)
summary(reg) # 설명력 : 93.7%

#reg1 <- lm(park_tot ~ car_tot + traffic_hour + subway_tot + bike_sum + pop + traffic_hour:car_tot, data = gu_result)
#summary(reg1)

# 3) 다중공선성 확인
library(car)
vif(reg) # 전체 연속변수 : 10이상 수치 없음
sqrt(vif(reg)) # but, car_tot, pop는 2보다 큰 수치

# 4) 회귀모형 교정(설명력 검증 그래프)
par(mfrow = c(2, 2))
plot(fit)
# 정규분포가 아닌 것으로 보여짐(선형성, 등분산은 충족해 보임)

# fitting1) / 정규성
powerTransform(gu_result$park_tot)
summary(powerTransform(gu_result$park_tot))
reg1 <- lm(park_tot^-0.8 ~ car_tot + traffic_hour + subway_tot + bike_sum + pop, data = gu_result)
summary(reg1) # 설득력 : 84%

powerTransform(gu_result$traffic_hour)
summary(powerTransform(gu_result$traffic_hour))
reg2 <- lm(park_tot ~ car_tot + traffic_hour^0.4 + subway_tot + bike_sum + pop, data = gu_result)
summary(reg2) # 설득력 : 49%

# fitting2) / 선형성
boxTidwell(park_tot ~ car_tot + traffic_hour + subway_tot + bike_sum + pop, data = gu_result) # 왜안됌?

# fitting3) / 등분산성
ncvTest(reg)


# (1) 정규분포 확인
shapiro.test(resid(reg)) # 71퍼/ 정규분포네?

# (2) 선형성 확인 (어케함?)

# (3) 등분산 확인 (어케함?)


# 5) 이상 관측치 확인
# 큰 지레점
(5 + 1) / 25 # 0.24
# 영향관측치
5 / (25 - 5 - 1) # 0.26
library(car)
influencePlot(reg, id = list(method = "identify"))


# 6) 회귀모형 선택(변수 선택)
library(leaps)

leap <- regsubsets(park_tot ~ car_tot + traffic_hour + subway_tot + bike_sum + pop, 
                   data = gu_result, nbest = 5)
summary(leap)

par(mfrow = c(1, 1))
plot(leap,scale = "adjr2")

