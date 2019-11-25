# Activity-Recognition-using-Simple-Sensors
 
 PIR, Photo, Senser 데이터를 이용하여 수면, 휴식, 요리, 식사 등 재실자의 행동을 예측하는 테스트배드를 만든 프로젝트입니다.
 시연영상:
 https://youtu.be/yatGb-Bhv4w
 
 아두이노를 이용하여 Wifi로 센서값을 서버로 전송, 다시 클라이언트인 노트북으로 데이터를 받아 Ramdom Forest로 실시간 행동을 예측합니다.
 
 데이터 설명:
 sensor폴더의 데이터는 센서값의 로우 데이터입니다. 시간, 센서이름, On/Off 여부로 4일간 운영을 통해 센서값을 저장했습니다.
 servay폴더의 데이터는 재실자의 행동을 저장한 데이터입니다. 시간, 행동, 시작/끝 여부로 4일간 운영을 통해 저장했습니다.
 ndata_16_19.csv는 servay폴더의 재실자 행동 데이터를 데이터셋의 라벨에 적합하도록 변환한 데이터셋입니다.
 tscdata_16_19.csv는 sensor폴더의 센서 데이터를 카운트 기반 슬라이딩 윈도우(센서값 10개) 방법으로 변환한 데이터셋입니다.
 tssdata_16_19.csv는 sensor폴더의 센서 데이터를 시간 기반 슬라이딩 윈도우(윈도우 크기 10초) 방법으로 변환한 데이터셋입니다.
 
 arduino 폴더에는 센서값을 수집하기 위한 아두이노 코드가 작성되어 있습니다.
 python 폴데에는 Ramdom Forest를 학습한 코드(learning_RF_count_sliding_window.ipynb, learning_RF_time_sliding_window.ipynb)와
 학습된 모델을 바탕으로 실시간으로 데이터셋 변환 후 예측하는 코드(10se_data_save.ipynb, count_sliding_window_realtime.ipynb,
 time_sliding_window_realtime.ipynb)가 있습니다.
 
 파이썬 폴더의 learning_RF_count_sliding_window.ipynb, learning_RF_time_sliding_window.ipynb,
 스파크 폴더의 10seWindow_pyspark_Randomforest.ipynb를 실행하시면 모델링의 결과를 볼 수 있습니다.


 관련연구
 http://casas.wsu.edu/
 https://courses.media.mit.edu/2004fall/mas622j/04.projects/home/
