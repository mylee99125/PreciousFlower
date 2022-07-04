package com.pf.flower.dao;

import java.util.List;

import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.mListDto;



public interface MemberDao {
	
	//회원 목록 가져오기
	public List<MemberDto> memberListSelect(mListDto mlist);
	
	//전체 회원수 구하기
	public int mcntSelect(mListDto mlist);
	
	//회원 상세 페이지
	public MemberDto memberSelect(String m_id);
	
	//회원 삭제
	public void memberDelete(String m_id);
	
	//아이디 중복 검사 	
	public int midCheck(String mid);
		
	//회원 가입 
	public void memberInsert(MemberDto member);
	
	//비밀번호 구하기
	public String pwdSelect(String mid);
	
	//회원 정보 불러오기
	public MemberDto bringMember(String mid);
	
	//회원 정보 수정
	public void memberUpdate(MemberDto member);

	//회원 탈퇴
	public void mdelete(MemberDto member);
	
	//헤더용 회원정보 불러오기
	public MemberDto hmemberSelect(String mid);
	
}//class end
