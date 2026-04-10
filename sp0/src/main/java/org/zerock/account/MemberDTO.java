package org.zerock.account;

import java.time.LocalDateTime;
import java.util.List;

import lombok.Data;

@Data
public class MemberDTO {
    
    private String userid;
    private String userpw;
    private String username;
    private boolean enabled;
    private LocalDateTime regdate;
    private LocalDateTime updatedate;
    
    private List<AuthDTO> authList;
}
