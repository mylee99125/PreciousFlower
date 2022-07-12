package com.pf.flower.dao;

import java.util.List;
import java.util.Map;

import com.pf.flower.dto.ListDto;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.NoticeDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.PfileDto;
import com.pf.flower.dto.ProductDto;
import com.pf.flower.dto.RiderDto;
import com.pf.flower.dto.VisitDto;
import com.pf.flower.dto.apListDto;
import com.pf.flower.dto.hnListDto;
import com.pf.flower.dto.mListDto;
import com.pf.flower.dto.nListDto;
import com.pf.flower.dto.oListDto;
import com.pf.flower.dto.rmListDto;

public interface AdminDao {
	//Login
	//비밀번호 구하기
	public String pwdSelect(String a_id);
	
	//Product
	//코드 체크 메소드
	public int codeCheck(String p_code);
	//상품 등록
	public void pInsert(ProductDto product);
	//파일정보 저장하기
	public void fileInsert(Map<String, String> fmap);
	//상품 목록 가져오기
	public List<ProductDto> productListSelect(apListDto aplist);
	//전체 상품개수 구하기
	public int pcntSelect(apListDto aplist);
	//상품 내용 가져오기
	public ProductDto productSelect(String p_code);
	//파일 목록 가져오기
	public List<PfileDto> fileSelect(String p_code);
	//파일 삭제(개별-게시글 수정)
	public void fileDelete(String sysname);
	//상품 수정
	public void productUpdate(ProductDto product);
	//리뷰 삭제
	public void reviewDelete(String p_code);
	//파일목록 삭제
	public void fListDelete(String p_code);
	//상품 삭제
	public void productDelete(String p_code);
	
	//Admin Home
	//전체 방문자 수 증가
	public void setVisitTotalCount();
	//전체 방문자 수 조회
	public int getVisitTotalCount(VisitDto visit);
	//차트 데이터
	public int getTodayTotalCount();
	public int get1bdayTotalCount();
	public int get2bdayTotalCount();
	public int get3bdayTotalCount();
	public int get4bdayTotalCount();
	public int get5bdayTotalCount();
	
	//Order
	//주문목록 가져오기
	public List<OrderDto> orderListSelect(oListDto olist);
	//전체 주문수 구하기
	public int ocntSelect(oListDto olist);
	//전체 매출액 구하기
	public int ordersum(oListDto olist);
	//주문상태 업데이트
	public void upStatus(OrderDto order);
	//주문상세 가져오기
	public OrderDto orderSelect(String o_num);
	//주문상세-상품 가져오기
	public List<OrderDto> odlistSelect(OrderDto order);
	
	//Member
	//회원 목록 가져오기(일반)
	public List<MemberDto> memberListSelect(mListDto mlist);
	//전체 회원수 구하기(일반)
	public int mcntSelect(mListDto mlist);
	//회원 상세 페이지(일반)
	public MemberDto memberSelect(String m_id);
	//회원 삭제(일반)
	public void memberDelete(String m_id);
	//회원 정보 수정(일반)
	public void memberUpdate(MemberDto member);
	//주문 내역 가져오기(일반)
	public List<OrderDto> memberOlist(String m_id);
	
	//rider
	//회원 목록 가져오기(라이더)
	public List<RiderDto> rmemberListSelect(rmListDto rmlist);
	//전체 회원수 구하기(라이더)
	public int rmcntSelect(rmListDto rmlist);
	//회원 상세 페이지(라이더)
	public RiderDto rmemberSelect(String r_id);
	//회원 삭제(라이더)
	public void rmemberDelete(String r_id);
	//배송 이력 가져오기(라이더)
	public List<OrderDto> riderOlist(String r_id);
	
	//Notice
	//게시글 목록 가져오기
	public List<NoticeDto> noticeListSelect(nListDto nlist);
	//전체 글개수 구하기
	public int ncntSelect(nListDto nlist);
	//게시글 내용 가져오기
	public NoticeDto noticeSelect(Integer n_num);
	//게시글 작성
	public void noticeInsert(NoticeDto notice);
	//게시글 수정
	public void noticeUpdate(NoticeDto notice);	
	//게시글 삭제
	public void noticeDelete(Integer n_num);
	//조회수 증가
	public void viewCount(NoticeDto notice);
	//게시글 목록 가져오기(home)
	public List<NoticeDto> hnListSelect(hnListDto hnlist);
	//전체 글개수 구하기(home)
	public int hncntSelect(hnListDto hnlist);
}
