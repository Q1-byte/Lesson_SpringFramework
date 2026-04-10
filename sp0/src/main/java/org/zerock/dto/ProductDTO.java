package org.zerock.dto;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;


@Setter
@Getter
@ToString
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class ProductDTO {

	private Integer num;              // AUTO_INCREMENT PK
    private String name;              // 메뉴 이름
    private String category;          // 카테고리
    private Integer price;            // 가격
    private String description;       // 설명
    private String pictureurl;        // 이미지 경로
    private String regid;             // 등록자 ID
    private LocalDateTime regdate;    // 등록일
    private LocalDateTime updateDate; // 수정일 (추가)

    // 등록일을 YYYY-MM-DD 형식 문자열로 반환
    public String getFormattedRegDate() {
        if (regdate == null) return "";
        return regdate.format(DateTimeFormatter.ISO_DATE);
    }

    // 수정일을 YYYY-MM-DD 형식 문자열로 반환
    public String getFormattedUpdateDate() {
        if (updateDate == null) return "";
        return updateDate.format(DateTimeFormatter.ISO_DATE);
        
    }
}






