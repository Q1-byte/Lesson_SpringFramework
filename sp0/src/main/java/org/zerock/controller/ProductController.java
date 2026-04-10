package org.zerock.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.zerock.dto.ProductDTO;
import org.zerock.dto.ProductListPaginDTO;
import org.zerock.service.ProductService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;

@Controller
@Log4j2
@RequestMapping("/product")
@RequiredArgsConstructor
public class ProductController {

    private final ProductService service;

    // 1. 상품 목록/검색/페이징 통합 조회
    @GetMapping("/list")
    public void list(
        @RequestParam(name = "page", defaultValue = "1") int page,
        @RequestParam(name = "size", defaultValue = "10") int size,
        @RequestParam(name = "keyword", required = false) String keyword,
        @RequestParam(name = "type", required = false) String type,
        @RequestParam(name = "order", required = false, defaultValue = "num") String order,
        @RequestParam(name = "dir", required = false, defaultValue = "desc") String dir,
        Model model) {

        // 허용된 정렬 컬럼과 방향만 허용
        String[] allowedOrders = {"num", "name", "price", "regdate"};
        String[] allowedDirs = {"asc", "desc"};
        boolean validOrder = false, validDir = false;
        for (String o : allowedOrders) {
            if (o.equalsIgnoreCase(order)) {
                validOrder = true;
                break;
            }
        }
        for (String d : allowedDirs) {
            if (d.equalsIgnoreCase(dir)) {
                validDir = true;
                break;
            }
        }
        if (!validOrder) order = "num";
        if (!validDir) dir = "desc";

        ProductListPaginDTO dto = service.getList(page, size, keyword, type, order, dir);

        log.info("---------------------------------------");
        model.addAttribute("dto", dto);
        model.addAttribute("keyword", keyword);
        model.addAttribute("type", type);
        model.addAttribute("order", order);
        model.addAttribute("dir", dir);
    }

    // 2. 등록 화면
    @GetMapping("/register")
    public void register() {
        log.info("product register page");
    }

    // 3. 등록 처리 (파일 업로드 포함)
    @PostMapping("/register")
    public String registerPost(ProductDTO dto,
                               @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                               HttpServletRequest request,
                               RedirectAttributes rttr) {
        log.info("product register post");
        log.info(dto);

        // 파일 업로드 처리
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                // 저장 경로 설정 (webapp/resources/images)
                String uploadPath = request.getServletContext().getRealPath("/resources/images");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // 고유한 파일명 생성 (UUID + 원본 파일명)
                String originalFilename = imageFile.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String savedFilename = uuid + "_" + originalFilename;

                // 파일 저장
                File saveFile = new File(uploadPath, savedFilename);
                imageFile.transferTo(saveFile);

                // DTO에 파일명 설정
                dto.setPictureurl(savedFilename);
                log.info("파일 업로드 완료: " + savedFilename);

            } catch (IOException e) {
                log.error("파일 업로드 실패", e);
            }
        }

        // 등록일 설정
        dto.setRegdate(java.time.LocalDateTime.now());

        service.register(dto);

        rttr.addFlashAttribute("result", dto.getNum() + "번 상품이 등록되었습니다.");

        return "redirect:/product/list";
    }

    // 4. 단일 상품 조회
    @GetMapping("/read/{num}")
    public String read(@PathVariable("num") Integer num,
            Model model) {

        ProductDTO dto = service.get(num);
        model.addAttribute("product", dto);

        return "/product/read";
    }

    // 5. 수정 폼
    @GetMapping("/modify/{num}")
    public String modifyGet(@PathVariable("num") Integer num, Model model) {
        ProductDTO dto = service.get(num);
        model.addAttribute("product", dto);
        return "/product/modify";
    }

    // 6. 수정 처리 (파일 업로드 포함)
    @PostMapping("/modify")
    public String modifyPost(@ModelAttribute ProductDTO dto,
                             @RequestParam(value = "imageFile", required = false) MultipartFile imageFile,
                             HttpServletRequest request) {
        log.info("product modify post");

        // 파일 업로드 처리
        if (imageFile != null && !imageFile.isEmpty()) {
            try {
                // 저장 경로 설정 (webapp/resources/images)
                String uploadPath = request.getServletContext().getRealPath("/resources/images");
                File uploadDir = new File(uploadPath);
                if (!uploadDir.exists()) {
                    uploadDir.mkdirs();
                }

                // 고유한 파일명 생성 (UUID + 원본 파일명)
                String originalFilename = imageFile.getOriginalFilename();
                String uuid = UUID.randomUUID().toString();
                String savedFilename = uuid + "_" + originalFilename;

                // 파일 저장
                File saveFile = new File(uploadPath, savedFilename);
                imageFile.transferTo(saveFile);

                // DTO에 새 파일명 설정
                dto.setPictureurl(savedFilename);
                log.info("파일 업로드 완료: " + savedFilename);

            } catch (IOException e) {
                log.error("파일 업로드 실패", e);
            }
        }

        service.modify(dto);
        return "redirect:/product/read/" + dto.getNum();
    }

    // 7. 삭제 처리
    @PostMapping("/remove")
    public String remove(@RequestParam("num") Integer num,
            RedirectAttributes rttr) {
        log.info("product remove post: " + num);
        service.remove(num);
        rttr.addFlashAttribute("result", num + "번 상품이 삭제되었습니다.");
        return "redirect:/product/list";

    }
}
