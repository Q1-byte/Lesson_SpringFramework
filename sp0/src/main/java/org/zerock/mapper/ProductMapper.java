package org.zerock.mapper;

import java.util.List;
import org.apache.ibatis.annotations.Param;
import org.zerock.dto.ProductDTO;

public interface ProductMapper {

    int insert(ProductDTO dto);                                 // 신규 상품 등록
    
    ProductDTO selectOne(@Param("num") Integer num);            // PK로 단일 조회
    
    int remove(@Param("num") Integer num);                      // PK로 삭제
    
    int update(ProductDTO dto);                                 // PK 기준 수정
    
    List<ProductDTO> list();                                    // 전체 조회
    
    int listCount();                                            // 전체 개수

    List<ProductDTO> list2(@Param("skip") int skip,             // 건너뛸 행
                            @Param("count") int count,          // 조회할 행
                            @Param("keyword") String keyword,   // 검색어
                            @Param("type") String type,        // 검색 타입
                            @Param("order") String order,      // 위 정렬
                            @Param("dir") String dir);          // 아래 정렬

    int listCount(@Param("keyword") String keyword,             // 검색어
                    @Param("type") String type);                // 검색타입
    
}
