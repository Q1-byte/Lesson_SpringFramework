package org.zerock.security;

import java.util.stream.IntStream;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.AccountDTO;
import org.zerock.dto.AccountRole;
import org.zerock.mapper.AccountMapper;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
public class AccountTests {

    @Autowired
    private AccountMapper accountMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    @Autowired
    private javax.sql.DataSource dataSource;

    // 테이블 생성 로직
    private void createTablesIfNotExist() {
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

        try (java.sql.Connection con = dataSource.getConnection();
                java.sql.PreparedStatement pstmt1 = con.prepareStatement(createAccount);
                java.sql.PreparedStatement pstmt2 = con.prepareStatement(createRoles)) {

            pstmt1.executeUpdate();
            pstmt2.executeUpdate();
            log.info("Tables created or already exist.");

        } catch (Exception e) {
            log.error("Table creation failed: " + e.getMessage());
        }
    }

    // 계정 생성 테스트
    @Test
    public void testInsert() {

        // 1. 테이블 생성
        createTablesIfNotExist();

        // 2. user0 ~ user10 생성
        IntStream.rangeClosed(0, 10).forEach(i -> {
            setupUser("user" + i, i);
        });

        // 3. user00 ~ user09 (게시글 작성자 패턴) 생성
        IntStream.rangeClosed(0, 9).forEach(i -> {
            setupUser("user0" + i, i);
        });
    }

    private void setupUser(String uid, int i) {
        try {
            if (accountMapper.selectOne(uid) != null) {
                log.info(uid + " already exists. skipping...");
                return;
            }
        } catch (Exception e) {
            log.warn("Check user failed: " + e.getMessage());
        }

        AccountDTO dto = AccountDTO.builder()
                .uid(uid)
                .upw(passwordEncoder.encode("1111"))
                .uname("USER_" + uid)
                .email(uid + "@aaa.com")
                .build();

        accountMapper.insert(dto);
        dto.addRole(AccountRole.USER);

        if (i >= 5)
            dto.addRole(AccountRole.MANAGER);
        if (i >= 9)
            dto.addRole(AccountRole.ADMIN);

        accountMapper.insertRoles(dto);
        log.info("Inserted: " + uid);
    }

    @Test
    public void testSelect() {
        String uid = "user00"; // user00 확인
        AccountDTO dto = accountMapper.selectOne(uid);
        log.info(dto);
    }
}
