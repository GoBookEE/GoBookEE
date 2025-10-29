# GoBookEE 라즈베리파이용 Dockerfile
# Multi-stage build를 사용하여 최적화

# 1단계: 빌드 스테이지
FROM maven:3.9.6-openjdk-17-slim AS builder

# 작업 디렉토리 설정
WORKDIR /app

# Maven 설정 파일 복사
COPY pom.xml .

# 의존성 다운로드 (캐시 최적화)
RUN mvn dependency:go-offline -B

# 소스 코드 복사
COPY src ./src

# 프로젝트 빌드
RUN mvn clean package -DskipTests

# 2단계: 실행 스테이지
FROM tomcat:10.1-jdk17-openjdk-slim

# ARM64 아키텍처 지원을 위한 플랫폼 설정
# (라즈베리파이에서 실행 시 필요)

# 톰캣 설정
ENV CATALINA_HOME=/usr/local/tomcat
ENV PATH=$CATALINA_HOME/bin:$PATH

# 포트 설정
EXPOSE 8080

# 기존 ROOT 웹앱 제거
RUN rm -rf $CATALINA_HOME/webapps/ROOT

# 빌드된 WAR 파일을 톰캣에 배포
COPY --from=builder /app/target/gobooke.war $CATALINA_HOME/webapps/ROOT.war

# 업로드 디렉토리 생성
RUN mkdir -p $CATALINA_HOME/webapps/ROOT/resources/upload/book
RUN mkdir -p $CATALINA_HOME/webapps/ROOT/resources/upload/place
RUN mkdir -p $CATALINA_HOME/webapps/ROOT/resources/upload/study
RUN mkdir -p $CATALINA_HOME/webapps/ROOT/resources/upload/user

# 권한 설정
RUN chmod -R 755 $CATALINA_HOME/webapps/ROOT/resources/upload

# 톰캣 실행
CMD ["catalina.sh", "run"]
