package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.MemberDTO;
import org.zerock.mapper.MemberMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MemberService {

	private final MemberMapper mapper;
	
	public List<MemberDTO> getList() {
		return mapper.getList();
	}
	
	public MemberDTO memberById(int mno) {
		return mapper.memberById(mno);
	} //단건조회
	
	public void update(MemberDTO dto) {
		 mapper.update(dto);
	} //수정
	
	public void insert(MemberDTO dto) {
		mapper.insert(dto);
	} //상세보기
	
	public void delete(int mno) {
		mapper.delete(mno);
	} //삭제
}



