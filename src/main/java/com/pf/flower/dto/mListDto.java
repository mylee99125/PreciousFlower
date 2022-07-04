package com.pf.flower.dto;

import lombok.Data;

@Data
public class mListDto {
	private String mcolname;
	private String mkeyword;//검색단어.
	private int mpageNum;
	private int mlistCnt;
}//class end
