package org.zerock.security;

import java.util.Collection;
import java.util.stream.Collectors;

import org.springframework.security.core.GrantedAuthority;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;
import org.zerock.account.MemberDTO;

import lombok.Getter;

@Getter
public class CustomUser extends User {
    
    private static final long serialVersionUID = 1L;
    
    private MemberDTO member;
    
    public CustomUser(String username, String password, 
            Collection<? extends GrantedAuthority> authorities) {
    	// 부모 클래스(User)에 아이디, 비밀번호, 권한 전달
        super(username, password, authorities);
    }
    
    // MemberDTO를 받아서 CustomUser를 만드는 생성자
    public CustomUser(MemberDTO member) {
    	
        // Spring Security User 생성자 호출
        // 1. 아이디
        // 2. 비밀번호
        // 3. 권한 목록
        super(member.getUserid(),	// 로그인 아이디
        	  member.getUserpw(), 	// 비밀번호
              member.getAuthList()	// DB에 있는 권한 목록
              	.stream()
              	  // 권한 문자열을 Spring Security 권한 객체로 변환
                  .map(auth -> new SimpleGrantedAuthority(auth.getAuth()))
                  // List 형태로 변환
                  .collect(Collectors.toList())
        	  );
        	  this.member = member;
    }
}
