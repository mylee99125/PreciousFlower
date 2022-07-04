package com.pf.flower.dto;

import lombok.Data;

@Data
public class CartDto {
	private int c_num;
	private String c_mid;
	private String c_pcode;
	private int c_count;
	private String c_pname;
	private int c_pprice;
	
	//product
	private String p_name, pf_oriname, pf_sysname;
	private int p_price;
}
