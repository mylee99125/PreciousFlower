package com.pf.flower.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class ProductDto {
	private String p_code;
	private String p_name;
	private int p_price;
	private String p_detail;
	private String m_id;
	
	//attach(PfileDto)
	private String pf_oriname;
	private String pf_sysname;
	
}
