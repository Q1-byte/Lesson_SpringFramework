package org.zerock.service;

import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.zerock.dto.ReplyDTO;
import org.zerock.mapper.ReplyMapper;
import java.util.List;

@Service
@RequiredArgsConstructor
public class ReplyService {
    private final ReplyMapper replyMapper;

    // 특정 상품(num)에 달린 댓글 목록
    public List<ReplyDTO> getListByNum(Integer num) {
        return replyMapper.getListByNum(num);
    }

    // 댓글 등록
    public int register(ReplyDTO dto) {
        return replyMapper.insert(dto);
    }

    // 댓글 삭제(실제 삭제가 아니라 delflag=true로 업데이트)
    public int remove(Integer rno) {
        return replyMapper.delete(rno);
    }

    // 댓글 수정
    public int modify(ReplyDTO dto) {
        return replyMapper.update(dto);
    }
}
