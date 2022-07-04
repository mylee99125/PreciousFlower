package com.pf.flower.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.mysql.cj.Session;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.RiderDto;

public interface RiderDao {

	//아이디 중복 검사 	
	public int idCheck(String id);
	
	//회원 가입 
	public void rmemberInsert(RiderDto rider);
	
	//비밀번호 구하기
	public String pwdSelect(String id);
	
	//라이더 정보 불러오기
	public RiderDto riderSelect(String rid);

	//라이더 정보 수정
	public void riderUpdate(RiderDto rider);

	//라이더 탈퇴 
	public void rdelete(RiderDto rider);
}
