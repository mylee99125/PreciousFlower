package com.pf.flower.dao;

import java.util.List;

import com.pf.flower.dto.CartDto;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.ProductDto;
import com.pf.flower.dto.ReviewDto;
import com.pf.flower.dto.pListDto;

public interface MainDao {
	//상품목록 가져오기
	public List<ProductDto> pListSelect(pListDto plist);
	//전체 상품 개수 구하기
	public int pcntSelect(pListDto plist);
	//상품내용 가져오기
	public ProductDto fcontents(String p_code);
	//리뷰 가져오기
	public List<ReviewDto> reSelect(String p_code);
	//비밀번호 구하기
	public String pwdSelect(String mid);
	//회원 정보 불러오기
	public MemberDto bringMember(String m_id);
	//장바구니 상품 추가
	public void addcart(CartDto cart);
	//장바구니 목록 불러오기
	public List<CartDto> cartListSelect(String mid);
	//장바구니 삭제
	public void cartDelete(int c_num);
	//헤더용 회원정보 불러오기
	public MemberDto memberSelect(String mid);
	//회원 정보 수정
	public void memberUpdate(MemberDto member);
	//회원 탈퇴
	public void mdelete(MemberDto member);
	//최종 주문 추가
	public void fOrderInsert(OrderDto order);
	//주문상세(상품) 추가
	public void odInsert(OrderDto order);
	//히스토리 증가
	public void upHistory(MemberDto member);
	//최종 주문 시 카트삭제 
	public void deleteCart(String o_mid);
	//회원 - 주문 이력 불러오기
	public List<OrderDto> molistSelect(String o_mid);
	//회원 - 주문 상세 불러오기
	public OrderDto oddetail(String od_num);
	//회원 - 주문 상세(상품) 불러오기
	public List<OrderDto> odcontents(String od_num);
	//리뷰 작성
	public void reviewInsert(ReviewDto review);
	//환불 신청
	public void refsubmit(OrderDto order);
}
