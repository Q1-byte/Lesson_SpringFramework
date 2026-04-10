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

	// localhost:8080/todo/list
	// ->
	@GetMapping("/list")
	public void list(Model model) {
		List<TodoDTO> todoList = service.getList();

		model.addAttribute("todoList", todoList);
	}

	@GetMapping("/register")
	public void registerGet() {
		log.info("register get");
	}

	@PostMapping("/register")
	public String registerPost(TodoDTO dto) {
		service.insert(dto);
		return "redirect:/todo/list";
	}

	@GetMapping("/read/{id}")
	public String read(@PathVariable("id") int id, Model model) {

		TodoDTO todo = service.selectById(id);
		model.addAttribute("todo", todo);

		return "/todo/read";

	}

	@PostMapping("/modify")
	public String modifyGet(TodoDTO dto, Model model) {
		TodoDTO todo = service.selectById(dto.getId());
		model.addAttribute("todo", todo);
		return "/todo/modify";
	}

	@PostMapping("/modifyPost")
	public String modifyPost(TodoDTO dto) {
		service.update(dto);
		return "redirect:/todo/list";
	}

	@PostMapping("/delete/{id}")
	public String deletePost(@PathVariable("id") int id) {
		service.delete(id);
		return "redirect:/todo/list";
	}
}
