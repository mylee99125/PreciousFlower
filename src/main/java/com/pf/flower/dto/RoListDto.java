package com.pf.flower.dto;

import lombok.Data;

@Data
public class RoListDto {
	private String rocolname; //b_title, b_contents 중 하나 저장.
	private String rokeyword; //검색단어
	private int ropageNum; 
	private int rolistCnt;
	private String ro_rid;
}
