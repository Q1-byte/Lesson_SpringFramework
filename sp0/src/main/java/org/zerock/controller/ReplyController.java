package org.zerock.controller;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.zerock.dto.ReplyDTO;
import org.zerock.service.ReplyService;

import java.util.List;

@Controller
@RequiredArgsConstructor
@RequestMapping("/reply")
public class ReplyController {

    private final ReplyService replyService;

    // 댓글 목록
    @GetMapping("/list/{num}")
    @ResponseBody
    public List<ReplyDTO> list(@PathVariable("num") Integer num) {
        return replyService.getListByNum(num);
    }

    // 댓글 등록
    @PostMapping("/register")
    @ResponseBody
    public int register(@RequestBody ReplyDTO dto) {
        return replyService.register(dto);
    }

    // 댓글 삭제
    @PostMapping("/remove/{rno}")
    @ResponseBody
    public int remove(@PathVariable("rno") Integer rno) {
        return replyService.remove(rno);
    }

    // 댓글 수정
    @PostMapping("/modify")
    @ResponseBody
    public int modify(@RequestBody ReplyDTO dto) {
        return replyService.modify(dto);
    }
}
