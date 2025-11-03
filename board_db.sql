CREATE SCHEMA board_db;
USE board_db;

# ========================================
# 서버 설정
# ========================================
server.port=8080

# ========================================
# MySQL 데이터베이스 연결 설정
# ========================================
spring.datasource.url=jdbc:mysql://localhost:3306/board_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8
spring.datasource.username=root
spring.datasource.password=eoullim123!
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# ========================================
# JPA 설정
# ========================================
# 자동으로 테이블 생성/수정
spring.jpa.hibernate.ddl-auto=update

# SQL 쿼리 콘솔 출력
spring.jpa.show-sql=true

# SQL 쿼리 포맷팅
spring.jpa.properties.hibernate.format_sql=true

# MySQL 8 방언 설정
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect

# ========================================
# 로깅 설정 (개발 시 유용)
# ========================================
# SQL 로그 레벨
logging.level.org.hibernate.SQL=DEBUG

# 바인딩 파라미터 값 출력
logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE

# Spring 로그 레벨
logging.level.org.springframework.web=INFO