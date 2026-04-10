package org.zerock.db;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
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
}
