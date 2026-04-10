package org.zerock.account;

public interface MemberMapper {
    
    // 회원 정보 조회 (권한 포함)
    MemberDTO read(String userid);
}
