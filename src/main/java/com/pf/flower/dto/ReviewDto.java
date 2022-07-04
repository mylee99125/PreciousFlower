package com.pf.flower.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ReviewDto {
	private int re_num;
	private String re_pcode;
	private float re_score;
	private String re_contents;
	private Date re_date;
	private String re_mid;
}
