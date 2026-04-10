package org.zerock.service;

import static org.junit.jupiter.api.Assertions.*;

import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit.jupiter.SpringExtension;
import org.zerock.dto.MemberDTO;

import lombok.extern.log4j.Log4j2;

@ExtendWith(SpringExtension.class)
@ContextConfiguration("file:src/main/webapp/WEB-INF/spring/root-context.xml")
@Log4j2
class MemberServiceTest {
	
	@Autowired
	private MemberService memberService;
	
	@Test
	void testGetList() {
		memberService.getList()
		.forEach(member-> log.info(member));
	} //전체 데이터
	
	@Test
	void testInsert() {
		MemberDTO dto = MemberDTO.builder()
				.name("김길동")
				.email("tes@test.com")
				.password("1234")
				.build();
		
		memberService.insert(dto);
	} // 추가 create
	
	@Test
	void testMemberById() {
		MemberDTO dto = memberService.memberById(6);
		
		log.info(dto);
	} // 단건 조회 read
	
	@Test
	void testUpdate() {
		MemberDTO dto = MemberDTO.builder()
				.name("유길동")
				.password("0000")
				.email("aaaa@test.com")
				.mno(6)
				.build();
		
		memberService.update(dto);
		
	} // 수정 update
	
	@Test
	void testDelete() {
		memberService.delete(7);
	} // 삭제 delete

}
