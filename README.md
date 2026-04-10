# Spring Framework Study

> Spring Framework 6 기반 웹 개발 학습 프로젝트 모음

---

## Tech Stack

![Java](https://img.shields.io/badge/Java-21-007396?style=flat-square&logo=openjdk&logoColor=white)
![Spring](https://img.shields.io/badge/Spring_Framework-6.2-6DB33F?style=flat-square&logo=spring&logoColor=white)
![MyBatis](https://img.shields.io/badge/MyBatis-3.5-000000?style=flat-square)
![MySQL](https://img.shields.io/badge/MySQL-9.4-4479A1?style=flat-square&logo=mysql&logoColor=white)
![Tomcat](https://img.shields.io/badge/Tomcat-10.x-F8DC75?style=flat-square&logo=apachetomcat&logoColor=black)
![Maven](https://img.shields.io/badge/Maven-C71A36?style=flat-square&logo=apachemaven&logoColor=white)

---

## Modules

| 모듈 | 주제 | 설명 |
|------|------|------|
| [`sp0`](./sp0) | 환경 설정 | Spring MVC 기본 세팅, IoC/DI 실습, 포트폴리오 페이지 |
| [`sp1`](./sp1) | 게시판 | 게시글 CRUD + Ajax 댓글 + 페이징 + 검색 |
| [`sp2`](./sp2) | 회원 관리 | 회원 CRUD, MyBatis Mapper 실습 |
| [`sp3`](./sp3) | 할 일 관리 | Todo CRUD, MVC 패턴 기초 |
| [`sp4`](./sp4) | 할 일 관리 (확장) | sp3 기반 기능 확장 실습 |
| [`sp_form`](./sp_form) | 폼 처리 | Spring MVC 폼 바인딩, 유효성 검사 |

---

## Project Highlights — sp1

sp1은 학습 프로젝트 중 가장 완성도 높은 **풀스택 게시판**입니다.

**기능**
- 게시글 목록 / 상세 / 등록 / 수정 / 삭제 (Soft Delete)
- 제목 · 내용 · 작성자 검색 및 페이징
- Ajax 기반 댓글 시스템 (Axios + REST API)
- 댓글 개수 실시간 표시

**구조**
```
sp1/src/main/java/org/zerock/
├── controller/   BoardController, ReplyController (REST)
├── service/      BoardService, ReplyService
├── mapper/       BoardMapper, ReplyMapper
└── dto/          BoardDTO, ReplyDTO, *PaginDTO
```

---

## Database Setup

```sql
-- 1. Database & User
CREATE DATABASE springdb;
CREATE USER 'springdbuser'@'%' IDENTIFIED BY '1234';
GRANT ALL PRIVILEGES ON springdb.* TO 'springdbuser'@'%';

-- 2. 게시판 테이블
USE springdb;
CREATE TABLE tbl_board (
    bno      INT           AUTO_INCREMENT PRIMARY KEY,
    title    VARCHAR(500)  NOT NULL,
    content  VARCHAR(2000) NOT NULL,
    writer   VARCHAR(50)   NOT NULL,
    regdate    TIMESTAMP DEFAULT NOW(),
    updatedate TIMESTAMP DEFAULT NOW(),
    delflag    BOOLEAN   DEFAULT FALSE
);

-- 3. 댓글 테이블
CREATE TABLE tbl_reply (
    rno       INT          AUTO_INCREMENT PRIMARY KEY,
    replyText VARCHAR(500) NOT NULL,
    replyer   VARCHAR(50)  NOT NULL,
    replydate  TIMESTAMP DEFAULT NOW(),
    updatedate TIMESTAMP DEFAULT NOW(),
    delflag    BOOLEAN   DEFAULT FALSE,
    bno        INT       NOT NULL,
    CONSTRAINT fk_reply_board FOREIGN KEY (bno) REFERENCES tbl_board(bno)
);
CREATE INDEX idx_reply_board ON tbl_reply (bno DESC, rno ASC);
```

---

## Getting Started

```bash
# 1. 저장소 클론
git clone <repo-url>

# 2. 원하는 모듈로 이동
cd sp1

# 3. 빌드
mvn clean package

# 4. Tomcat 10.x 에 WAR 배포
```

> **사전 요구사항**: Java 21, MySQL 9.x, Maven 3.x, Apache Tomcat 10.x

---

*Spring Framework 학습 목적으로 제작된 프로젝트입니다.*
