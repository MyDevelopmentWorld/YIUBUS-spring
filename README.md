# YIUBUS-spring

스쿨버스 실시간 위치 조회 시스템

## 📋 프로젝트 개요

YIUBUS는 스쿨버스의 실시간 위치를 추적하고 웹 지도상에 표시하는 시스템입니다. 안드로이드 공기계가 설치된 버스의 GPS 위치 정보를 서버 데이터베이스에 저장하고, 웹 인터페이스를 통해 사용자들이 실시간으로 버스 위치를 확인할 수 있습니다.

## 🏗️ 시스템 아키텍처

- **프론트엔드**: JSP + JavaScript (네이버 지도 API)
- **백엔드**: Spring Framework 4.3.8
- **데이터베이스**: MySQL
- **위치 수집**: 안드로이드 공기계 GPS
- **실시간 통신**: WebSocket
- **지도 서비스**: 네이버 지도 API

## ⚙️ 기술 스택

### Backend
- **Java**: 1.6
- **Spring Framework**: 4.3.8.RELEASE
  - Spring MVC
  - Spring WebSocket
  - Spring JDBC
- **MyBatis**: 3.3.1
- **MySQL Connector**: 5.1.37
- **Jackson**: JSON 처리

### Frontend
- **JSP**: 서버 사이드 렌더링
- **JavaScript**: 클라이언트 사이드 로직
- **jQuery**: 1.12.4
- **네이버 지도 API**: 지도 표시 및 위치 마킹

### Build Tool
- **Maven**: 의존성 관리 및 빌드

## 📁 프로젝트 구조

```
cambus/
├── src/main/java/com/co/kr/
│   ├── HomeController.java          # 메인 컨트롤러
│   ├── dao/
│   │   ├── YbusDao.java            # 데이터 접근 계층
│   │   └── YbusMapper.xml          # MyBatis 매퍼
│   ├── logic/
│   │   └── LocationLogic.java      # 위치 계산 로직 (거리 계산)
│   ├── vo/                         # Value Objects
│   │   ├── NewLocationBean.java    # 위치 정보 객체
│   │   ├── BusMapBean.java         # 버스 지도 정보
│   │   ├── BusScheduleBean.java    # 버스 시간표 정보
│   │   └── BusStopBean.java        # 버스 정류장 정보
│   ├── ws/                         # WebSocket
│   │   ├── ChatWebSocketHandler.java # 웹소켓 핸들러
│   │   └── WebSocketController.java
│   ├── filter/
│   │   └── SimpleCORSFilter.java   # CORS 필터
│   └── util/
│       └── ServiceUtil.java       # 서비스 유틸리티
├── src/main/webapp/
│   └── ybus/
│       ├── jsp/                    # JSP 뷰 페이지
│       │   ├── main.jsp           # 메인 페이지
│       │   ├── bsMap.jsp          # 버스 지도 페이지
│       │   ├── busSchedule.jsp    # 시간표 페이지
│       │   └── timeLine.jsp       # 타임라인 페이지
│       └── exchangeJson/          # JSON API 응답 페이지
└── pom.xml                        # Maven 설정
```

## 🚀 주요 기능

### 1. 실시간 위치 추적
- 안드로이드 공기계에서 GPS 좌표 수집
- 서버로 위치 데이터 전송 (`/ybus/exchangeJson/setLocation.do`)
- 실시간 위치 정보 데이터베이스 저장

### 2. 지도 기반 위치 표시
- 네이버 지도 API를 활용한 지도 표시
- 버스 실시간 위치 마커 표시
- 정류장 위치 정보 표시

### 3. 버스 노선 관리
- **시내순환 버스**: 상행/하행 자동 판별
- **노란 버스**: 단일 노선 운행
- 가장 가까운 정류장 자동 계산 (1500m 반경)

### 4. 시간표 서비스
- 평일/주말 시간표 구분
- 학기/방학 시간표 구분
- 실시간 버스 도착 예정 시간 계산
- 5분 이내/9분 이내 알림 시스템

### 5. 타임라인 기능
- 버스 노선별 실시간 위치 타임라인
- 정류장별 버스 도착 정보

### 6. 실시간 채팅
- WebSocket 기반 실시간 채팅
- 목적지별 채팅방 구분
- 사용자 목록 실시간 갱신

## 🔧 설치 및 실행

### 사전 요구사항
- Java 1.6 이상
- Maven 3.x
- MySQL 5.x
- Apache Tomcat

### 설치 과정
1. 레포지토리 클론
```bash
git clone [repository-url]
cd YIUBUS-spring
```

2. 의존성 설치
```bash
cd cambus
mvn clean install
```

3. 데이터베이스 설정
- MySQL 데이터베이스 생성
- 설정 파일에서 데이터베이스 연결 정보 수정

4. 애플리케이션 배포
```bash
mvn package
# target/cambus.war를 Tomcat에 배포
```

## 📡 API 엔드포인트

### 위치 관련
- `POST /ybus/exchangeJson/setLocation.do` - 안드로이드에서 위치 정보 전송
- `POST /ybus/exchangeJson/getPositions.do` - 지도용 버스 위치 조회
- `POST /ybus/exchangeJson/getBsList.do` - 버스 정보 조회

### 페이지 관련
- `GET /ybus/jsp/getMainInfo.do` - 메인 페이지 정보
- `GET /ybus/jsp/BusSchedule.do` - 버스 시간표 조회
- `GET /ybus/jsp/circlebus.do` - 시내순환 타임라인
- `GET /ybus/jsp/yellowbus.do` - 노란버스 타임라인
- `GET /ybus/jsp/bsLoadView.do` - 정류장 로드뷰

### 기타
- `POST /ybus/jsp/viewCount.do` - 페이지 조회수 업데이트

## 🔍 핵심 알고리즘

### 거리 계산 (LocationLogic.java:5)
```java
public double distance(double lat1, double lon1, double lat2, double lon2)
```
- Haversine 공식을 사용한 두 지점 간 거리 계산
- 결과값은 미터 단위

### 가장 가까운 정류장 찾기 (HomeController.java:172)
- 1500m 반경 내에서 가장 가까운 정류장 탐색
- 노선별(시내순환/노란버스) 다른 로직 적용

### 상행/하행 자동 전환 (HomeController.java:192)
- 시내순환 버스의 종점 도달 시 자동으로 운행 방향 전환

## 🌐 지도 기능

- **네이버 지도 API** 사용 (bsMap.jsp:9)
- 실시간 버스 위치 마커 표시
- 정류장 위치 표시
- 사용자 상호작용 (확대/축소, 드래그)

## 💬 실시간 채팅 시스템

- **WebSocket** 기반 실시간 통신 (ChatWebSocketHandler.java)
- 목적지별 채팅방 분리
- 사용자 입장/퇴장 알림
- 실시간 사용자 목록 갱신

## 📊 데이터베이스 스키마 주요 테이블

- **위치 정보 테이블**: 버스별 실시간 GPS 좌표 저장
- **버스 정보 테이블**: 버스별 기본 정보 및 노선 정보
- **정류장 테이블**: 정류장별 위치 및 노선 정보
- **시간표 테이블**: 평일/주말, 학기/방학별 운행 시간표
- **조회수 테이블**: 페이지별 일일 조회수 통계

## 🤝 기여 방법

1. 이슈 등록
2. Fork 후 브랜치 생성
3. 변경사항 커밋
4. Pull Request 생성

## 📄 라이선스

이 프로젝트는 용인대학교 재학생의 편의를 위해 개발되었습니다.
