package com.pf.flower.dto;

import java.sql.Timestamp;

import lombok.Data;

@Data
public class OrderDto {
	//ordertbl
	private String o_num;
	private String o_mid;
	private int o_rnum;
	private String o_date;
	private String o_rdate;
	private String o_rec;
	private String o_phone;
	private String o_addr1;
	private String o_addr2;
	private String o_addr3;
	private int o_price;
	private String o_type;
	private String o_pay;
	private String o_status;
	
	//orderdetail
	private int od_num;
	private String od_onum;
	private String od_mid;
	private String od_pcode;
	private int od_count;
	private String od_pname;
	private int od_price;
	
	//product(+attach)
	private String p_name;
	private int p_price;
	private int p_stock;
	private String pf_oriname;
	private String pf_sysname;
	
	//rider
	private String r_id;
	private String r_name;
	private String r_phone;
	private String r_addr1;
	private String r_addr2;
	private String r_addr3;
	private String r_insurance;

	//cart
	private int c_num;
	private String c_mid;
	private String c_pcode;
	private int c_count;
	
	//riderOrder
	private String ro_rid;
	private String ro_date;

}
