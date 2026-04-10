package org.zerock.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class CreateSchemaTests {

    @Autowired
    private DataSource dataSource;

    @Test
    public void createTables() throws Exception {

        String createAccount = "CREATE TABLE IF NOT EXISTS tbl_account (" +
                "  uid VARCHAR(50) NOT NULL," +
                "  upw VARCHAR(100) NOT NULL," +
                "  uname VARCHAR(50) NOT NULL," +
                "  email VARCHAR(100)," +
                "  regdate TIMESTAMP DEFAULT now()," +
                "  updatedate TIMESTAMP DEFAULT now()," +
                "  PRIMARY KEY (uid)" +
                ")";

        String createRoles = "CREATE TABLE IF NOT EXISTS tbl_account_roles (" +
                "  roleId INT AUTO_INCREMENT," +
                "  uid VARCHAR(50) NOT NULL," +
                "  rolename VARCHAR(50) NOT NULL," +
                "  PRIMARY KEY (roleId)," +
                "  FOREIGN KEY (uid) REFERENCES tbl_account(uid)" +
                ")";

        try (Connection con = dataSource.getConnection();
                PreparedStatement pstmt1 = con.prepareStatement(createAccount);
                PreparedStatement pstmt2 = con.prepareStatement(createRoles)) {

            pstmt1.executeUpdate();
            log.info("tbl_account created");

            pstmt2.executeUpdate();
            log.info("tbl_account_roles created");
        }
    }
    
    @Test
    public void createMemberTables() throws Exception {
        
        String createMember = "CREATE TABLE IF NOT EXISTS tmember (" +
                "  userid VARCHAR(50) PRIMARY KEY," +
                "  userpw VARCHAR(100) NOT NULL," +
                "  username VARCHAR(100) NOT NULL," +
                "  regdate DATETIME DEFAULT CURRENT_TIMESTAMP," +
                "  updatedate DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP," +
                "  enabled CHAR(1) DEFAULT '1'" +
                ")";
        
        String createMemberAuth = "CREATE TABLE IF NOT EXISTS tmember_auth (" +
                "  userid VARCHAR(50) NOT NULL," +
                "  auth VARCHAR(50) NOT NULL," +
                "  FOREIGN KEY (userid) REFERENCES tmember(userid)" +
                ")";
        
        String createPersistentLogins = "CREATE TABLE IF NOT EXISTS persistent_logins (" +
                "  username VARCHAR(64) NOT NULL," +
                "  series VARCHAR(64) PRIMARY KEY," +
                "  token VARCHAR(64) NOT NULL," +
                "  last_used TIMESTAMP NOT NULL" +
                ")";
        
        try (Connection con = dataSource.getConnection();
                PreparedStatement pstmt1 = con.prepareStatement(createMember);
                PreparedStatement pstmt2 = con.prepareStatement(createMemberAuth);
                PreparedStatement pstmt3 = con.prepareStatement(createPersistentLogins)) {
            
            pstmt1.executeUpdate();
            log.info("tbl_member created");
            
            pstmt2.executeUpdate();
            log.info("tbl_member_auth created");
            
            pstmt3.executeUpdate();
            log.info("persistent_logins created");
        }
    }
    
    @Test
    public void insertTestMembers() throws Exception {
        
        BCryptPasswordEncoder encoder = new BCryptPasswordEncoder();
        String encodedPw = encoder.encode("1234");
        
        log.info("Encoded Password for 1234: " + encodedPw);
        
        // 관리자 계정 삽입
        String insertAdmin = "INSERT IGNORE INTO tmember (userid, userpw, username) VALUES (?, ?, ?)";
        String insertAdminAuth1 = "INSERT IGNORE INTO tmember_auth (userid, auth) VALUES (?, ?)";
        
        // 일반 사용자 계정 삽입
        String insertUser = "INSERT IGNORE INTO tmember (userid, userpw, username) VALUES (?, ?, ?)";
        String insertUserAuth = "INSERT IGNORE INTO tmember_auth (userid, auth) VALUES (?, ?)";
        
        try (Connection con = dataSource.getConnection()) {
            
            // Admin
            try (PreparedStatement pstmt = con.prepareStatement(insertAdmin)) {
                pstmt.setString(1, "admin");
                pstmt.setString(2, encodedPw);
                pstmt.setString(3, "관리자");
                pstmt.executeUpdate();
                log.info("Admin member inserted");
            }
            
            try (PreparedStatement pstmt = con.prepareStatement(insertAdminAuth1)) {
                pstmt.setString(1, "admin");
                pstmt.setString(2, "ROLE_ADMIN");
                pstmt.executeUpdate();
                
                pstmt.setString(1, "admin");
                pstmt.setString(2, "ROLE_USER");
                pstmt.executeUpdate();
                log.info("Admin auth inserted");
            }
            
            // User1
            try (PreparedStatement pstmt = con.prepareStatement(insertUser)) {
                pstmt.setString(1, "user1");
                pstmt.setString(2, encodedPw);
                pstmt.setString(3, "홍길동");
                pstmt.executeUpdate();
                log.info("User1 member inserted");
            }
            
            try (PreparedStatement pstmt = con.prepareStatement(insertUserAuth)) {
                pstmt.setString(1, "user1");
                pstmt.setString(2, "ROLE_USER");
                pstmt.executeUpdate();
                log.info("User1 auth inserted");
            }
        }
    }
}
