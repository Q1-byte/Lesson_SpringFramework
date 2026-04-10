package org.zerock.dto;

import java.sql.Timestamp;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;


@Data
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class TodoDTO {
    private int id;
    private String title;
    private String description;
    private Boolean done;
    private Timestamp created_at;
}