package org.zerock.mapper;

import org.zerock.dto.ReplyDTO;
import java.util.List;

public interface ReplyMapper {
    
    // 특정 상품(num)에 달린 댓글 목록
    List<ReplyDTO> getListByNum(Integer num);

    // 댓글 등록
    int insert(ReplyDTO dto);

    // 댓글 삭제(실제 삭제가 아니라 delflag=true로 업데이트)
    int delete(Integer rno);

    // 댓글 수정
    int update(ReplyDTO dto);
}
