car_ssibal <- read.csv("../data/car1.csv", fileEncoding = "UTF-8", 
                       col.names = c("cities", "car_sum"))
# 각 구의 car_sum 데이터들은 행정동별로 나뉘어진 것임
View(car_ssibal)
str(car_ssibal)

### 광진구와 다른 구의 전체 주차장 면수는 차이가 있는가? 
# 1가지 요인으로 3개 이상 비교대상(one way ANOVA)

# 결측치 확인
is.na(car_ssibal$car_sum) # 없음


# 1) 정규분포 확인
out <- aov(car_sum ~ cities, data = car_ssibal)
shapiro.test(resid(out)) # 정규분포 아님

# 2) kruskal - test
kruskal.test(car_sum ~ cities, data = car_ssibal) # 차이가 있음

# 3) 사후검정 (kruskalmc)
library(pgirmess)
kruskalmc(car_ssibal$car_sum, car_ssibal$cities)
# 강남구-광진구     116.109135     448.3796       FALSE
# 강동구-광진구      50.485345     463.3425       FALSE
# 강북구-광진구     107.344262     496.8418       FALSE
# 강서구-광진구     130.624415     461.5805       FALSE
# 관악구-광진구       4.060109     463.3425       FALSE
# 광진구-구로구     162.032483     484.7332       FALSE
# 광진구-금천구      65.823425     552.1296       FALSE
# 광진구-노원구     118.603332     469.6531       FALSE
# 광진구-도봉구      74.597466     510.2121       FALSE
# 광진구-동대문구    74.840164     496.8418       FALSE
# 광진구-동작구     106.239036     502.1219       FALSE
# 광진구-마포구      96.123706     471.6899       FALSE
# 광진구-서대문구    85.761425     506.6381       FALSE
# 광진구-서초구     167.576557     473.0880       FALSE
# 광진구-성동구      28.984992     479.0280       FALSE
# 광진구-성북구      59.176178     467.6852       FALSE
# 광진구-송파구     108.200036     434.6208       FALSE
# 광진구-양천구     194.882781     478.2534       FALSE
# 광진구-영등포구    43.817493     467.6852       FALSE
# 광진구-용산구     157.314495     486.4603       FALSE
# 광진구-은평구     207.155338     495.8309       FALSE
# 광진구-종로구     266.242363     481.4110       FALSE
# 광진구-중구       313.477359     478.2534       FALSE
# 광진구-중랑구      78.715932     490.9849       FALSE

# 결론 : 광진구는 다른구와 차량등록대수의 차이가 없다는 결론. 전체 지역구 비교를 보아도 5개 지역구 비교를 제외한 나머지 모두 차이가 없음을 보여줌. 
# 즉, 어떤 지역구에 살던 등록된 차량은 균등한 분포를 보임. 광진구만 유별나게 차량이 많다고 보기 어려움