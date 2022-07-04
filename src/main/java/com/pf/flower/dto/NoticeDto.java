package com.pf.flower.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class NoticeDto {
	private int n_num;
	private String n_aid;
	private String n_title;
	private String n_contents;
	private Timestamp n_date;
	private int n_views;
	
}
