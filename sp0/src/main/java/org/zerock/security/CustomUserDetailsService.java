package org.zerock.security;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.zerock.account.MemberDTO;
import org.zerock.account.MemberMapper;

import lombok.extern.log4j.Log4j2;

@Log4j2
public class CustomUserDetailsService implements UserDetailsService {
    
	// MyBatis Mapper 주입 (DB에서 회원 정보 조회)
    @Autowired
    private MemberMapper memberMapper;
    
    // 로그인 시 Spring Security가 자동으로 부르는 메서드
    @Override
    public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
        
    	// 어떤 아이디로 로그인을 시도했는지 확인용 로그
        log.warn("Load User By Username: " + username);
        
        // DB에서 해당 아이디의 회원 정보 가져오기
        MemberDTO member = memberMapper.read(username);
        
        // DB에서 가져온 결과 확인
        log.warn("Queried Member: " + member);
        
        // 회원 정보가 없으면 (아이디가 틀린 경우)
        if (member == null) {
        	// 로그인 실패 처리
            throw new UsernameNotFoundException("User not found: " + username);
        }
    	// 회원 정보를 Spring Security가 이해할 수 있는 형태로 바꿔서 반환
        return new CustomUser(member);
    }
}
