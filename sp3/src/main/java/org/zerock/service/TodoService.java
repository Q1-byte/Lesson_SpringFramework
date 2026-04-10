package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.TodoDTO;
import org.zerock.mapper.TodoMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TodoService {  // 클래스명 변경

    private final TodoMapper mapper;
    
    // 전체 목록 조회
    public List<TodoDTO> getList() {
        return mapper.getList();
    }
    
    // 단건 조회
    public TodoDTO selectById(int id) {  // 메서드명, 파라미터명 변경
        return mapper.selectById(id);
    }
    
    // 수정
    public void update(TodoDTO dto) {
        mapper.update(dto);
    }
    
    // 등록
    public void insert(TodoDTO dto) {
        mapper.insert(dto);
    }
    
    // 삭제
    public void delete(int id) {  // 파라미터명 변경
        mapper.delete(id);
    }
}