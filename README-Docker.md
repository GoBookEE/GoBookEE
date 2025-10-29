# GoBookEE 라즈베리파이 Docker 배포 가이드

## 📋 개요

GoBookEE 웹 애플리케이션을 라즈베리파이에서 Docker를 사용하여 톰캣으로 실행하는 방법을 설명합니다.

## 🏗️ 아키텍처

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   Nginx (80)    │────│  GoBookEE App   │────│  외부 Oracle DB  │
│   (리버스 프록시)  │    │   (톰캣:8080)   │    │   (외부 호스트)   │
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🚀 빠른 시작

### 1. 환경변수 설정

```bash
# 환경변수 파일 생성
cp env.example .env

# .env 파일 편집 (실제 값으로 수정)
nano .env
```

### 2. 자동 배포 (권장)

```bash
# 배포 스크립트 실행
./deploy.sh
```

### 3. 수동 배포

```bash
# 1. 프로젝트 빌드
mvn clean package -DskipTests

# 2. Docker Compose 실행
docker-compose up -d

# 3. 상태 확인
docker-compose ps
```

## 📁 파일 구조

```
GoBookEE/
├── Dockerfile              # Docker 이미지 빌드 설정
├── docker-compose.yml      # 서비스 오케스트레이션
├── nginx.conf              # Nginx 설정
├── .dockerignore           # Docker 빌드 제외 파일
├── deploy.sh               # 자동 배포 스크립트
└── README-Docker.md        # 이 파일
```

## 🔧 설정 파일

### Dockerfile

- **Multi-stage build** 사용으로 최적화
- **Java 17** + **Tomcat 10.1** 기반
- **ARM64** 아키텍처 지원

### docker-compose.yml

- **GoBookEE 앱**: 톰캣 컨테이너
- **외부 Oracle DB**: 환경변수로 연결 설정
- **Nginx**: 리버스 프록시
- **볼륨**: 업로드 파일 및 로그 영구 저장

## 🌐 접속 정보

### 웹 애플리케이션

- **URL**: `http://라즈베리파이IP:8080`
- **Nginx**: `http://라즈베리파이IP:8081` (포트 8081)

### 외부 데이터베이스 설정

- **Oracle 호스트**: 환경변수 `DB_HOST`로 설정
- **포트**: 환경변수 `DB_PORT`로 설정 (기본: 1521)
- **SID**: 환경변수 `DB_SID`로 설정 (기본: XE)
- **사용자명**: 환경변수 `DB_USERNAME`로 설정
- **비밀번호**: 환경변수 `DB_PASSWORD`로 설정

## 📊 모니터링

### 컨테이너 상태 확인

```bash
# 모든 서비스 상태
docker-compose ps

# 리소스 사용량
docker stats

# 로그 확인
docker-compose logs -f gobookee-app
docker-compose logs -f oracle-db
```

### 애플리케이션 로그

```bash
# 톰캣 로그
docker-compose exec gobookee-app tail -f /usr/local/tomcat/logs/catalina.out

# Nginx 로그
docker-compose logs -f nginx
```

## 🔄 관리 명령어

### 서비스 관리

```bash
# 서비스 시작
docker-compose up -d

# 서비스 중지
docker-compose down

# 서비스 재시작
docker-compose restart

# 특정 서비스만 재시작
docker-compose restart gobookee-app
```

### 데이터베이스 관리

```bash
# Oracle 접속
docker-compose exec oracle-db sqlplus system/oracle123@localhost:1521/XE

# 데이터베이스 백업
docker-compose exec oracle-db expdp system/oracle123@XE schemas=SYSTEM directory=DATA_PUMP_DIR dumpfile=backup.dmp
```

### 파일 관리

```bash
# 업로드 파일 확인
docker-compose exec gobookee-app ls -la /usr/local/tomcat/webapps/ROOT/resources/upload/

# 설정 파일 수정
docker-compose exec gobookee-app vi /usr/local/tomcat/webapps/ROOT/WEB-INF/classes/config/db.properties
```

## ⚠️ 주의사항

### 메모리 관리

- **최소 요구사항**: 4GB RAM
- **권장사항**: 8GB RAM
- Oracle 에뮬레이션으로 인한 높은 메모리 사용

### 성능 최적화

- **SSD 사용** 권장 (SD카드 대신)
- **쿨링 시스템** 구비
- **정기적인 로그 정리**

### 보안 설정

- **방화벽 설정** 확인
- **데이터베이스 비밀번호** 변경
- **SSL 인증서** 설정 (프로덕션)

## 🚨 문제 해결

### 일반적인 문제들

#### 1. 메모리 부족

```bash
# 메모리 사용량 확인
free -h
docker stats

# Oracle 메모리 제한 조정
docker-compose down
# docker-compose.yml에서 memory 제한 수정
docker-compose up -d
```

#### 2. 포트 충돌

```bash
# 포트 사용 확인
sudo netstat -tulpn | grep :8080
sudo netstat -tulpn | grep :1521

# 기존 프로세스 종료
sudo kill -9 PID
```

#### 3. 데이터베이스 연결 실패

```bash
# Oracle 로그 확인
docker-compose logs oracle-db

# 네트워크 연결 확인
docker-compose exec gobookee-app ping oracle-db
```

#### 4. 애플리케이션 시작 실패

```bash
# 톰캣 로그 확인
docker-compose logs gobookee-app

# 컨테이너 내부 접속
docker-compose exec gobookee-app bash
```

## 📈 성능 모니터링

### 시스템 리소스

```bash
# CPU 사용률
htop

# 메모리 사용률
free -h -s 1

# 디스크 I/O
iostat -x 1

# 네트워크 사용량
iftop
```

### 애플리케이션 성능

```bash
# 톰캣 JMX 모니터링 (설정 필요)
# JVM 힙 메모리 사용량
docker-compose exec gobookee-app jstat -gc 1

# 활성 세션 확인
docker-compose exec oracle-db sqlplus system/oracle123@localhost:1521/XE
```

## 🔄 백업 및 복원

### 데이터베이스 백업

```bash
# 백업 실행
docker-compose exec oracle-db expdp system/oracle123@XE schemas=SYSTEM directory=DATA_PUMP_DIR dumpfile=backup_$(date +%Y%m%d).dmp

# 백업 파일 복사
docker cp gobookee-oracle:/opt/oracle/admin/XE/dpdump/backup_$(date +%Y%m%d).dmp ./
```

### 애플리케이션 백업

```bash
# 업로드 파일 백업
docker-compose exec gobookee-app tar -czf /tmp/uploads.tar.gz /usr/local/tomcat/webapps/ROOT/resources/upload/
docker cp gobookee-app:/tmp/uploads.tar.gz ./
```

## 🎯 최적화 팁

1. **정기적인 로그 정리**
2. **불필요한 컨테이너 정리**
3. **메모리 사용량 모니터링**
4. **디스크 공간 관리**
5. **네트워크 최적화**

이제 GoBookEE를 라즈베리파이에서 Docker로 실행할 수 있습니다! 🎉
