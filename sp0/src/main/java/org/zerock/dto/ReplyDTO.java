package org.zerock.dto;

import lombok.Data;
import lombok.Getter;
import lombok.Setter;
import lombok.ToString;
import lombok.AllArgsConstructor;
import lombok.NoArgsConstructor;
import lombok.Builder;
import java.sql.Timestamp;

@Getter
@Setter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Data
public class ReplyDTO {
    private Integer rno;
    private String replyText;
    private String replyer;
    private Timestamp replydate;
    private Timestamp updatedate;
    private Boolean delflag;
    private Integer num;
}
