# 📋 Spring Board Project (SP1)

## 프로젝트 개요

Spring Framework 기반의 **게시판 시스템**입니다. 게시글 CRUD, 댓글 기능, 페이징, 검색 등 완전한 게시판 기능을 제공합니다.

## ✨ 주요 기능

### 📝 게시판 (Board)
- ✅ 게시글 목록 조회 (페이징 처리)
- ✅ 게시글 상세 조회
- ✅ 게시글 등록
- ✅ 게시글 수정
- ✅ 게시글 삭제 (Soft Delete)
- ✅ 검색 기능 (제목/내용/작성자)

### 💬 댓글 (Reply)
- ✅ 댓글 목록 조회 (Ajax, 페이징)
- ✅ 댓글 등록 (Ajax)
- ✅ 댓글 수정 (Ajax)
- ✅ 댓글 삭제 (Ajax, Soft Delete)
- ✅ 실시간 댓글 갱신

## 🛠️ 기술 스택

### Backend
- **Framework**: Spring Framework 6.2.14
- **ORM**: MyBatis 3.5.19
- **Database**: MySQL 9.4.0
- **Connection Pool**: HikariCP 7.0.2
- **Build Tool**: Maven
- **Java Version**: 21

### Frontend
- **View**: JSP (JSTL 3.0)
- **CSS Framework**: Bootstrap 5
- **JavaScript**: Vanilla JS + Axios
- **AJAX**: Axios for REST API calls

### Libraries
- **Lombok**: 1.18.42
- **Jackson**: 2.20.0 (JSON 처리)
- **Log4j2**: 2.25.2
- **JUnit**: 6.0.1

## 📂 프로젝트 구조

```
sp1/
├── src/main/java/org/zerock/
│   ├── controller/          # Spring MVC Controllers
│   │   ├── BoardController.java
│   │   └── ReplyController.java (REST API)
│   ├── service/            # Business Logic
│   │   ├── BoardService.java
│   │   ├── ReplyService.java
│   │   └── exception/
│   ├── mapper/             # MyBatis Mappers
│   │   ├── BoardMapper.java
│   │   └── ReplyMapper.java
│   └── dto/                # Data Transfer Objects
│       ├── BoardDTO.java
│       ├── ReplyDTO.java
│       ├── BoardListPaginDTO.java
│       └── ReplyListPaginDTO.java
│
├── src/main/webapp/
│   └── WEB-INF/views/
│       ├── board/
│       │   ├── list.jsp       # 게시글 목록
│       │   ├── read.jsp       # 게시글 상세 + 댓글
│       │   ├── register.jsp   # 게시글 등록
│       │   └── modify.jsp     # 게시글 수정
│       └── includes/
│           ├── header.jsp
│           └── footer.jsp
│
└── pom.xml
```

## 🚀 시작하기

### 사전 요구사항
- Java 21 이상
- MySQL 9.x
- Maven 3.x
- Apache Tomcat 10.x (Jakarta EE 지원)

### 설치 및 실행

1. **저장소 클론**
```bash
git clone <repository-url>
cd sp1
```

2. **데이터베이스 설정**
```sql
CREATE DATABASE board_db;
USE board_db;

-- 게시판 테이블
CREATE TABLE tbl_board (
    bno BIGINT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    content TEXT,
    writer VARCHAR(100) NOT NULL,
    created_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    modified_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    del_flag BOOLEAN DEFAULT FALSE
);

-- 댓글 테이블
CREATE TABLE tbl_reply (
    rno INT AUTO_INCREMENT PRIMARY KEY,
    bno BIGINT NOT NULL,
    reply_text VARCHAR(500) NOT NULL,
    replyer VARCHAR(100) NOT NULL,
    reply_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    del_flag BOOLEAN DEFAULT FALSE,
    FOREIGN KEY (bno) REFERENCES tbl_board(bno)
);
```

3. **데이터베이스 연결 설정**
   - `src/main/resources/` 경로에 데이터베이스 설정 파일 확인
   - MySQL 연결 정보 수정

4. **빌드 및 실행**
```bash
mvn clean package
# WAR 파일을 Tomcat에 배포
```

## 📡 API 엔드포인트

### Board (일반 MVC)
- `GET /board/list` - 게시글 목록
- `GET /board/read/{bno}` - 게시글 상세
- `GET /board/register` - 게시글 등록 폼
- `POST /board/register` - 게시글 등록 처리
- `GET /board/modify/{bno}` - 게시글 수정 폼
- `POST /board/modify` - 게시글 수정 처리
- `POST /board/remove` - 게시글 삭제

### Reply (REST API)
- `POST /replies` - 댓글 등록
- `GET /replies/{bno}/list?page=1&size=10` - 특정 게시글의 댓글 목록
- `GET /replies/{rno}` - 댓글 조회
- `PUT /replies/{rno}` - 댓글 수정
- `DELETE /replies/{rno}` - 댓글 삭제

## 🎯 주요 기능 설명

### 페이징 처리
- 게시글 목록과 댓글 모두 페이징 지원
- 페이지당 항목 수 조절 가능
- 이전/다음 페이지 네비게이션

### 검색 기능
- 제목(T), 내용(C), 작성자(W) 개별 검색
- 복합 검색 지원 (TC, TW, TCW)
- 검색 조건 유지

### Ajax 댓글 시스템
- 페이지 새로고침 없이 댓글 CRUD
- Axios를 이용한 REST API 통신
- 실시간 댓글 목록 갱신
- 모달을 이용한 댓글 수정/삭제

### Soft Delete
- 게시글과 댓글 모두 물리적 삭제 대신 논리적 삭제
- `del_flag` 필드로 삭제 상태 관리
- 삭제된 항목은 조회 불가

## 🔧 개발 중 해결한 이슈

### ✅ 수정 완료된 버그들
1. **read.jsp의 replyModForm 변수명 오타** - 수정 완료
2. **ReplyController의 read 메서드 경로 오류** (`/rno` → `/{rno}`) - 수정 완료
3. **댓글 수정 기능 미구현** - 완전 구현
4. **댓글 등록 후 목록 자동 갱신 누락** - 추가 완료
5. **list.jsp의 중복 footer include** - 제거 완료
6. **ReplyController의 @RequestBody 누락** - 추가 완료
7. **ReplyMapper.xml의 SQL 문법 오류** (콤마 누락) - 수정 완료
8. **read.jsp의 querySelector 선택자 오류** - 수정 완료
9. **read.jsp의 JSP EL과 템플릿 리터럴 충돌** - 이스케이프 처리 완료
10. **BoardDTO에 replyCnt 필드 추가** - 댓글 개수 표시 완료

### ✨ 추가된 기능
- **댓글 개수 표시**: 게시글 목록에서 각 게시글의 댓글 개수를 파란색으로 표시
- **삭제된 댓글 제외**: 댓글 개수 계산 시 삭제된 댓글은 제외

## 📝 라이선스

이 프로젝트는 교육 목적으로 제작되었습니다.

## 👨‍💻 개발자

Spring Framework 학습 프로젝트

---

**프로젝트 완성일**: 2025-12-23
