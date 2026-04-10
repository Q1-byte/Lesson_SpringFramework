package org.zerock.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.zerock.dto.ProductDTO;
import org.zerock.dto.ProductListPaginDTO;
import org.zerock.mapper.ProductMapper;

import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Service
@Log4j2
@RequiredArgsConstructor
public class ProductService {

    private final ProductMapper mapper;

    // 1. 신규 상품 등록
    public int register(ProductDTO dto) {
        int cnt = mapper.insert(dto);
        log.info("Inserted rows: " + cnt);
        return cnt;
    }

    // 2. 회원 조회
    public ProductDTO get(Integer num) {
        return mapper.selectOne(num);
    }

    // 3. 상품 삭제
    public void remove(Integer num) {
        mapper.remove(num);
    }

    // 4. 상품 수정
    public void modify(ProductDTO dto) {
        mapper.update(dto);
    }

    // 5. 전체 상품 조회
    public List<ProductDTO> getList() {
        return mapper.list();
    }

    // 6. 페이징 조회
    public ProductListPaginDTO getList(int page, int size, String keyword, String type, String order, String dir) {
        page = page <= 0 ? 1 : page;
        size = (size <= 10 || size > 100) ? 10 : size;
        int skip = (page - 1) * size;

        List<ProductDTO> list = mapper.list2(skip, size, keyword, type, order, dir);
        int total = mapper.listCount(keyword, type);

        return new ProductListPaginDTO(list, total, page, size);
    }

    // 7. 전체 개수 조회
    public int getTotalCount() {
        return mapper.listCount();
    }
}
