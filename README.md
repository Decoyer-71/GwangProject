# GwangProject
[공모전 공고](https://gwangjin.go.kr/portal/bbs/B0000003/view.do?nttId=6034623&menuNo=200192)

## 팀원소개
🦝[윤진석](https://github.com/Decoyer-71/GwangProject/tree/master/Analysis%20(Notebook)/%EC%9C%A4%EC%A7%84%EC%84%9D) : 데이터 수집, 데이터 분석, 팀장, 발표

🐼[김정숙](https://github.com/Decoyer-71/GwangProject/tree/master/Analysis%20(Notebook)/%EA%B9%80%EC%A0%95%EC%88%99) : 데이터 분석, 데이터 전처리, 시각화

🦦[오원석](https://github.com/Decoyer-71/GwangProject/tree/master/Analysis%20(Notebook)/%EC%98%A4%EC%9B%90%EC%84%9D) : 데이터 수집, 데이터 분석, 전처리, 시각화

👻[김도연](https://github.com/Decoyer-71/GwangProject/tree/master/Analysis%20(Notebook)/%EA%B9%80%EB%8F%84%EC%97%B0) : 데이터 분석, 데이터 상관분석, 데이터 전처리

🦊[김이경](https://github.com/Decoyer-71/GwangProject/tree/master/Analysis%20(Notebook)/%EA%B9%80%EC%9D%B4%EA%B2%BD) : 데이터 수집, 데이터 전처리, 데이터 분석

## 사용언어
<a href="https://www.python.org/" target="_blank"><img src="https://img.shields.io/badge/Python-3776AB?style=flat&logo=python&logoColor=white"/></a>
<a href="https://www.r-project.org/" target="_blank"><img src="https://img.shields.io/badge/R-276DC3?style=flat&logo=r&logoColor=white"/></a>
<a href="https://jupyter.org/" target="_blank"><img src="https://img.shields.io/badge/Jupyter-F37626?style=flat&logo=jupyter&logoColor=white"/></a>

## 폴더 분류

[analysis](https://github.com/Decoyer-71/GwangProject/tree/master/Analysis%20(Notebook)) : 분석에 쓰인 jupyter, R 분석 파일들을 모아둔 곳

[Data](https://github.com/Decoyer-71/GwangProject/tree/master/Data) : 크롤링 및 데이터 수집에 쓰인 파일들을 모아둔 곳 

[PPT](https://github.com/Decoyer-71/GwangProject/tree/master/PPT) : PPT만든 것을 모아둔 곳

[회의록](https://github.com/Decoyer-71/GwangProject/tree/master/회의록) : 회의록 작성하는 곳

## 1. 프로젝트 소개

광진구 주차문제 해소를 통한 공공복지 증진과 광진구에서 추진하고 있는 주차문제 해결 사업 효과를 극대화하기 위하여

인구, 주차장 면수, 대중교통 등의 데이터를 토대로 행정동 기준 가장 적합한 사업적용방안 제시

## 2. 데이터 출처
[건축물](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EA%B1%B4%EC%B6%95%EB%AC%BC) : 건축물 면적 및 건축물대장 데이터

[교통량](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EA%B5%90%ED%86%B5%EB%9F%89) : 교통량 데이터

[기타](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EA%B8%B0%ED%83%80) : 기타자료 데이터

[대중교통](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EB%8C%80%EC%A4%91%EA%B5%90%ED%86%B5) : 지하철, 공공자전거 등 대중교통 데이터

[동별](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EB%8F%99%EB%B3%84) : 동별 데이터

[불법주정차](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EB%B6%88%EB%B2%95%EC%A3%BC%EC%A0%95%EC%B0%A8) : 구별 불법주정차 데이터

[상관분석](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EC%83%81%EA%B4%80%EB%B6%84%EC%84%9D) : 상관분석을 위한 데이터

[인구](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EC%9D%B8%EA%B5%AC) : 인구 데이터

[주차장이용률](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EC%A3%BC%EC%B0%A8%EC%9E%A5%EC%9D%B4%EC%9A%A9%EB%A5%A0) : 크롤링한 주차장 이용률

[주택](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EC%A3%BC%ED%83%9D)

[차,주차장](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%EC%B0%A8%2C%EC%A3%BC%EC%B0%A8%EC%9E%A5)

[회귀분석](https://github.com/Decoyer-71/GwangProject/tree/master/Data/%ED%9A%8C%EA%B7%80%EB%B6%84%EC%84%9D)

## 3. 데이터 분석
### 1) 여유면적 분석
    담장허물기 사업이 가능한 여유면적을 많이 보유한 지역을 알아내기 위해 
    서울시 건축물대장 정보를 이용하여 아파트를 제외한 광진구 동별 평균 여유면적을 분석
    ![제목 없음](https://user-images.githubusercontent.com/127808901/235425878-730be5f2-809d-4b1e-b74b-5eb505f0bdd3.png)

    
### 2) 주차장 수요 분석
    ① 회귀분석
        주차장면수에 영향을 주는 요인 분석
        -> 주요회귀변수: 평균직장인구, 차량등록대수, 대중교통 승객수
    
    ② 장소분석
        - 광진구 동별 유동인구, 직장인구, 거주인구를 비교하여 주차 수요가 많은 동 분석
            -> 자양동, 중곡동, 구의동
       
        - 대중교통 이용량, 차량등록대수, 주민등록인구, 불법주차 단속건수를 비교하여 주차 수요가 많은 동 분석
            -> 구의동, 중곡동, 자양동
            
    ③ 주차장 이용률 분석
        실시간 주차가능면을 제공하는 주차장을 크롤링하여 일주일간 주차장 이용률 계산
        
## 4. 결론
- 여유면적 분석결과, 구의동이 담장허물기 사업을 진행하기에 가장 적합하고,
- 주차수요 분석결과, 구의동, 중곡동, 자양동 중심의 그린파킹 사업 추진 시 주차문제를 효율적으로 해결할 수 있다.
  
