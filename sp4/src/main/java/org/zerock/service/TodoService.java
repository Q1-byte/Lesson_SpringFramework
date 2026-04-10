package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.TodoDTO;
import org.zerock.mapper.TodoMapper;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class TodoService {

    private final TodoMapper mapper;
    
    // getList
    public List<TodoDTO> getList() {
    	return mapper.getList();
    }
    
    // selectById
    public TodoDTO selectById(int id) {
    	return mapper.selectById(id);
    }
    
    // update
    public void update(TodoDTO dto) {
    	mapper.update(dto);
    }
    
    // insert
    public void insert(TodoDTO dto) {
    	mapper.insert(dto);
    }
    
    // delete
    public void delete(int id) {
    	mapper.delete(id);
    }
}