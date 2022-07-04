package com.pf.flower.dto;

import java.sql.Date;

import lombok.Data;

@Data
public class MemberDto {
	private String	m_pwd;
	private String	m_name;
	private Date	m_birth;
	private String 	m_phone;
	private String	m_addr1;
	private String	m_addr2;
	private String 	m_addr3;
	private String	m_email;
	private int 	m_history;
	private String 	g_name;
	private String 	m_id;
	private int 	cartsum;
}
