package org.zerock.dto;

import java.util.List;
import java.util.stream.IntStream;

import lombok.Data;

@Data
public class ProductListPaginDTO {

    private List<ProductDTO> list; // 현재 페이지 상품 목록

    private int totalCount; // 전체 상품 갯수

    private int page, size; // 현재 페이지, 페이지당 갯수

    private int start, end; // 블록 시작 번호, 끝 번호
    private boolean prev, next; // 이전, 다음 여부

    private List<Integer> pageNums; // 페이지 번호 리스트

    public ProductListPaginDTO(List<ProductDTO> list, int totalCount,
            int page, int size) {

        this.list = list;
        this.totalCount = totalCount;
        this.page = page;
        this.size = size;

        // 🔹 페이징 계산
        // ex) page=7 → tempEnd=10 / page=13 → tempEnd=20
        int tempEnd = (int) (Math.ceil(page / 10.0)) * 10;
        this.start = tempEnd - 9;

        int realEnd = (int) (Math.ceil(totalCount / (double) size));

        if (realEnd < tempEnd) {
            this.end = realEnd;
        } else {
            this.end = tempEnd;
        }

        this.prev = this.start > 1;
        this.next = this.end < realEnd;

        this.pageNums = IntStream.rangeClosed(start, end)
                .boxed()
                .toList();
    }
}
