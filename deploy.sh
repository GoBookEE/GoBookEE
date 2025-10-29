#!/bin/bash

# GoBookEE 라즈베리파이 배포 스크립트

echo "🚀 GoBookEE 라즈베리파이 배포 시작..."

# 1. 프로젝트 빌드
echo "📦 프로젝트 빌드 중..."
mvn clean package -DskipTests

if [ $? -ne 0 ]; then
    echo "❌ 빌드 실패!"
    exit 1
fi

echo "✅ 빌드 완료!"

# 2. 기존 컨테이너 정리
echo "🧹 기존 컨테이너 정리 중..."
docker-compose down

# 3. Docker 이미지 빌드
echo "🐳 Docker 이미지 빌드 중..."
docker-compose build --no-cache

if [ $? -ne 0 ]; then
    echo "❌ Docker 빌드 실패!"
    exit 1
fi

# 4. 컨테이너 실행
echo "🚀 컨테이너 실행 중..."
docker-compose up -d

# 5. 상태 확인
echo "⏳ 서비스 시작 대기 중..."
sleep 30

# 6. 서비스 상태 확인
echo "📊 서비스 상태 확인..."
docker-compose ps

# 7. 로그 확인
echo "📝 최근 로그 확인..."
docker-compose logs --tail=20 gobookee-app

# 8. 접속 정보 출력
RASPBERRY_IP=$(hostname -I | awk '{print $1}')

echo "🎉 GoBookEE 배포 완료!"
echo "📋 접속 정보:"
echo "  - 웹 애플리케이션: http://$RASPBERRY_IP:8080"
echo "  - Nginx 프록시: http://$RASPBERRY_IP:8081"
echo ""
echo "⚠️  외부 오라클 데이터베이스 연결 설정 필요:"
echo "  - docker-compose.yml에서 DB_HOST, DB_USERNAME, DB_PASSWORD 수정"
echo "  - 또는 환경변수로 설정: export DB_HOST=your-oracle-host.com"
echo ""
echo "🔧 유용한 명령어:"
echo "  - 로그 확인: docker-compose logs -f"
echo "  - 서비스 중지: docker-compose down"
echo "  - 서비스 재시작: docker-compose restart"
echo "  - 컨테이너 접속: docker-compose exec gobookee-app bash"
