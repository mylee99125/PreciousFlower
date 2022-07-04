package com.pf.flower.dto;

import lombok.Data;

@Data
public class ListDto {
	private String colname;
	private String keyword;
	private int pageNum;
	private int listCnt;
}
