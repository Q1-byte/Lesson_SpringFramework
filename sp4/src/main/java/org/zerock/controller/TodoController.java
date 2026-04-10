package org.zerock.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.zerock.dto.TodoDTO;
import org.zerock.service.TodoService;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@RequestMapping("/todo")
@RequiredArgsConstructor
@Log4j2
public class TodoController {

	private final TodoService service;
	
	//리스트
	@GetMapping("/list")
	public void list(Model model) {
		List<TodoDTO> todoList = service.getList();
		model.addAttribute("todoList", todoList);
	}
	
	//등록
	@GetMapping("/register")
	public void registerGet() {}
	
	@PostMapping("/register")
	public String registerPost(TodoDTO dto) {
		service.insert(dto);
		return "redirect:/todo/list";
	}
	
	//상세보기
	@GetMapping("/read/{id}")
	public String read(@PathVariable("id") int id, Model model) {
		TodoDTO todo = service.selectById(id);
		model.addAttribute("todo", todo);
		return "/todo/read";
	}
	
	//수정창
	@PostMapping("/modify")
	public String modify(TodoDTO dto, Model model) {
		TodoDTO todo = service.selectById(dto.getId());
		model.addAttribute("todo", todo);
		return "/todo/modify";
	}
	
	//수정_업뎃
	@PostMapping("/modifyPost")
	public String modifyPost(TodoDTO dto) {
		service.update(dto);
		return "redirect:/todo/list";
	}
	
	//삭제
	@PostMapping("/delete/{id}")
	public String deletePost(@PathVariable("id") int id) {
		service.delete(id);
		return "redirect:/todo/list";
	}
}