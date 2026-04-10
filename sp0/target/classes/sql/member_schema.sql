-- 회원 테이블
CREATE TABLE IF NOT EXISTS tmember (
    userid VARCHAR(50) PRIMARY KEY,
    userpw VARCHAR(100) NOT NULL,
    username VARCHAR(100) NOT NULL,
    regdate DATETIME DEFAULT CURRENT_TIMESTAMP,
    updatedate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    enabled CHAR(1) DEFAULT '1'
);

-- 회원 권한 테이블
CREATE TABLE IF NOT EXISTS tmember_auth (
    userid VARCHAR(50) NOT NULL,
    auth VARCHAR(50) NOT NULL,
    FOREIGN KEY (userid) REFERENCES tmember(userid)
);

-- Remember-Me 테이블 (Spring Security)
CREATE TABLE IF NOT EXISTS persistent_logins (
    username VARCHAR(64) NOT NULL,
    series VARCHAR(64) PRIMARY KEY,
    token VARCHAR(64) NOT NULL,
    last_used TIMESTAMP NOT NULL
);

-- 테스트 데이터 삽입
-- 비밀번호: 1234 (BCrypt 암호화)
-- 관리자 계정
INSERT INTO tmember (userid, userpw, username) VALUES 
('admin', '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO/BTk76klW', '관리자');

INSERT INTO tmember_auth (userid, auth) VALUES 
('admin', 'ROLE_ADMIN'),
('admin', 'ROLE_USER');

-- 일반 사용자 계정
INSERT INTO tmember (userid, userpw, username) VALUES 
('user1', '$2a$10$GRLdNijSQMUvl/au9ofL.eDwmoohzzS7.rmNSJZ.0FxO/BTk76klW', '홍길동');

INSERT INTO tmember_auth (userid, auth) VALUES 
('user1', 'ROLE_USER');

-- ============================================
-- 실행 전 확인사항:
-- 1. MySQL에서 springdb 데이터베이스에 접속
-- 2. 위 SQL을 순서대로 실행
-- 
-- 계정 정보:
-- - admin / 1234 : 관리자 (ROLE_ADMIN, ROLE_USER)
-- - user1 / 1234 : 일반사용자 (ROLE_USER)
-- ============================================

-- 조회 테스트
-- SELECT * FROM tmember;
-- SELECT * FROM tmember_auth;
-- SELECT m.*, a.auth FROM tmember m LEFT JOIN tmember_auth a ON m.userid = a.userid;
