# Spring Boot 게시판 CRUD API 프로젝트

## 1. 프로젝트 개요

본 프로젝트는 Spring Boot를 활용하여 기본적인 게시판 형태의 CRUD (Create, Read, Update, Delete) 기능을 제공하는 RESTful API 서버를 구현합니다. 데이터베이스는 MySQL을 사용하며, JPA(Java Persistence API)를 통해 데이터 영속성 관리를 수행합니다. 본 프로젝트는 백엔드 개발의 핵심 개념인 계층형 아키텍처(Layered Architecture), RESTful API 설계, 데이터베이스 연동, 트랜잭션 관리 등을 학습하고 실제 구현하는 것을 목표로 합니다.

## 2. 주요 기능

*   **게시글 생성 (Create)**: 새로운 게시글을 등록합니다.
*   **게시글 조회 (Read)**: 모든 게시글 목록 또는 특정 ID의 게시글을 상세 조회합니다. 제목 키워드를 통한 검색 기능을 제공합니다.
*   **게시글 수정 (Update)**: 특정 게시글의 내용을 수정합니다.
*   **게시글 삭제 (Delete)**: 특정 게시글을 삭제합니다.
*   **RESTful API**: HTTP 메서드(GET, POST, PUT, DELETE)와 URL을 통해 자원을 명확하게 표현하는 API를 설계하였습니다.
*   **데이터베이스 연동**: MySQL 데이터베이스에 게시글 데이터를 저장하고 관리합니다.
*   **JPA (Spring Data JPA)**: 객체-관계 매핑(ORM) 기술을 활용하여 SQL 코드 없이 객체 지향적으로 데이터베이스를 조작합니다.
*   **DTO 패턴**: 데이터 전송 객체(DTO)를 사용하여 Entity와 API 요청/응답 간의 데이터 노출 범위를 분리하고 유연성을 확보합니다.
*   **계층형 아키텍처**: Controller, Service, Repository 계층으로 역할을 분리하여 코드의 유지보수성 및 확장성을 높였습니다.

## 3. 기술 스택

*   **Java**: OpenJDK 17
*   **Spring Boot**: 3.5.6
*   **데이터베이스**: MySQL 8.0
*   **ORM**: Spring Data JPA (Hibernate)
*   **빌드 도구**: Gradle
*   **코드 생산성**: Project Lombok
*   **테스트 도구**: JUnit 5, Spring Boot Test
*   **API 테스트**: Postman

## 4. 사전 준비 사항

본 프로젝트를 실행하기 위해 다음 환경이 필요합니다.

*   **Java Development Kit (JDK) 17 이상**
*   **MySQL Server 8.0 이상**
*   **IDE**: Eclipse (STS 플러그인 권장) 또는 IntelliJ IDEA
*   **API 클라이언트**: Postman (API 테스트용)

## 5. 시작 가이드

### 5.1 프로젝트 Import

1.  `start.spring.io`에서 다음 설정을 포함하여 프로젝트 ZIP 파일을 다운로드합니다:
    *   **Project**: Gradle Project
    *   **Language**: Java
    *   **Spring Boot**: 3.5.6
    *   **Dependencies**: Spring Web, Spring Data JPA, MySQL Driver, Lombok
2.  다운로드한 ZIP 파일의 압축을 해제합니다.
3.  **Eclipse**:
    *   Eclipse를 실행합니다.
    *   `File` → `Import` → `Gradle` → `Existing Gradle Project`를 선택합니다.
    *   압축 해제한 프로젝트 폴더를 선택하고 `Finish`를 클릭합니다.
    *   IDE가 Gradle 빌드를 수행하고 의존성을 다운로드하는 것을 기다립니다.
    *   (만약 Lombok 관련 오류가 발생하면 Eclipse Marketplace에서 Lombok 플러그인을 설치하고 IDE를 재시작하십시오.)

### 5.2 데이터베이스 설정

1.  MySQL Server가 실행 중인지 확인합니다.
2.  MySQL 클라이언트(예: MySQL Workbench)를 사용하여 `board_db` 스키마(데이터베이스)를 생성합니다.
    ```sql
    CREATE SCHEMA board_db;
    USE board_db;
    ```
3.  스키마가 정상적으로 생성되었는지 확인합니다.

### 5.3 `application.properties` 설정

`src/main/resources/application.properties` 파일을 열어 다음 내용을 설정합니다.

```properties
# 서버 포트 설정
server.port=8080

# MySQL 데이터베이스 연결 정보 (본인의 MySQL 환경에 맞게 수정)
spring.datasource.url=jdbc:mysql://localhost:3306/board_db?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8
spring.datasource.username=root
spring.datasource.password=본인의_MySQL_비밀번호  # !!! 본인의 MySQL 비밀번호를 입력하십시오 !!!
spring.datasource.driver-class-name=com.mysql.cj.jdbc.Driver

# JPA 및 Hibernate 설정
spring.jpa.hibernate.ddl-auto=update  # 개발 단계에서 Entity 기반으로 테이블 자동 생성/업데이트
spring.jpa.show-sql=true               # 콘솔에 실행되는 SQL 쿼리 표시
spring.jpa.properties.hibernate.dialect=org.hibernate.dialect.MySQL8Dialect
spring.jpa.properties.hibernate.format_sql=true

# 로그 레벨 설정 (JPA/Hibernate SQL 로깅 활성화)
logging.level.org.hibernate.SQL=DEBUG
logging.level.org.hibernate.type.descriptor.sql.BasicBinder=TRACE

주의: spring.datasource.password는 반드시 본인의 MySQL 비밀번호로 대체해야 합니다.
```

### 5.4 애플리케이션 실행

IDE의 프로젝트 탐색기에서 src/main/java/com/example/board/BoardApplication.java 파일을 찾습니다.
BoardApplication.java 파일을 우클릭하고 Run As → Spring Boot App (또는 Java Application)을 선택하여 애플리케이션을 실행합니다.
콘솔 창에 Started BoardApplication in X.XXX seconds와 같은 메시지가 출력되면 애플리케이션이 정상적으로 시작된 것입니다.
MySQL Workbench에서 USE board_db; SHOW TABLES; 명령을 실행하여 board 테이블이 자동으로 생성되었는지 확인합니다.

## 6. API 명세

애플리케이션이 정상적으로 실행되면 Postman과 같은 툴을 사용하여 다음 API 엔드포인트들을 테스트할 수 있습니다. 기본 URL은 http://localhost:8080/api/boards 입니다.

Method	URL	설명	Request Body (Content-Type: application/json)	Response Body (예시)	HTTP Status
POST	/api/boards	새 게시글 생성	{"title": "제목", "content": "내용", "author": "작성자"}	{id: 1, title: "제목", ...}	201 Created
GET	/api/boards	모든 게시글 조회	(없음)	[{id: 1, ...}, {id: 2, ...}]	200 OK
GET	/api/boards/{id}	특정 게시글 조회	(없음)	{id: 1, title: "제목", ...}	200 OK
GET	/api/boards/search?keyword=VALUE	제목으로 검색	(없음)	[{id: 1, ...}, {id: 3, ...}]	200 OK
PUT	/api/boards/{id}	특정 게시글 수정	{"title": "새 제목", "content": "새 내용", "author": "작성자"}	{id: 1, title: "새 제목", ...}	200 OK
DELETE	/api/boards/{id}	특정 게시글 삭제	(없음)	(응답 본문 없음)	204 No Content

## 7. 문제 해결 가이드 (Troubleshooting)

Port 8080 already in use 오류: 8080 포트가 다른 애플리케이션에 의해 사용 중인 경우 발생합니다.
해결: 점유 중인 프로세스를 종료하거나, application.properties 파일에서 server.port=8081 등으로 포트 번호를 변경하십시오.
MySQL 연결 실패: 데이터베이스 접속 정보 불일치, MySQL Server 미실행 등의 경우 발생합니다.
해결: application.properties 파일의 spring.datasource.username 및 spring.datasource.password가 올바른지 확인하고, MySQL Server가 정상적으로 실행 중인지 점검하십시오.
Lombok 동작 안 함 (Getter/Setter 관련 오류): IDE에 Lombok 플러그인이 설치되지 않았거나 제대로 활성화되지 않은 경우 발생합니다.
해결: Eclipse Marketplace에서 "Lombok" 플러그인을 설치하고 IDE를 재시작하십시오. 또한, 프로젝트의 Annotation Processing 설정이 활성화되어 있는지 확인하십시오.
테이블이 생성되지 않음: application.properties의 spring.jpa.hibernate.ddl-auto 설정 문제 또는 MySQL 접속 실패 시 발생합니다.
해결: ddl-auto=update로 설정되어 있는지 확인하고, MySQL 접속이 원활한지 점검하십시오.

## 8. 향후 개선 및 확장 제안

본 프로젝트는 기본적인 기능을 구현하였으며, 다음 기능들을 추가하여 확장할 수 있습니다.

사용자 인증/인가: Spring Security, JWT (JSON Web Token)를 활용한 로그인/회원가입 기능 추가.
검색 기능 확장: 작성자, 내용 등 다양한 기준으로 게시글을 검색하는 기능 구현.
페이징 및 정렬: 게시글 목록 조회 시 페이징 처리 및 특정 기준으로 정렬 기능 추가.
댓글 기능: 게시글에 댓글을 추가하고 관리하는 기능 구현.
프론트엔드 연동: React, Vue.js, Angular 등의 프론트엔드 프레임워크를 사용하여 사용자 인터페이스 구현.
배포: AWS EC2, Heroku, Vercel 등의 클라우드 플랫폼에 애플리케이션 배포.

## 9. 감사 인사

본 프로젝트를 통해 Spring Boot 기반 백엔드 개발의 기본적인 흐름과 핵심 기술을 이해하는 데 도움이 되기를 바랍니다.
