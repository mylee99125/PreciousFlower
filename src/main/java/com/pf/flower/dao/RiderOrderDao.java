package com.pf.flower.dao;

import java.util.List;

import com.pf.flower.dto.ListDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.RiderOrderDto;
import com.pf.flower.dto.RoListDto;


public interface RiderOrderDao {
	
	//게시글 목록 가져오기
	public List<OrderDto> ridingListSelect(ListDto list);
	
	//전체 글 개수 구하기
	public int rcntSelect(ListDto list);
	
	//라이더 배송 확인
	public void ridingInsert(RiderOrderDto ro);
	public void ridingUpdate(OrderDto order);
		
	//라이더 오더 목록 가져오기
	public List<OrderDto> roListSelect(RoListDto rolist);
	
	//라이더 오더 글 개수 구하기
	public int rocntSelect(RoListDto rolist);
	
	//라이더 오더 상태 업데이트
	public void rupdateStatus(OrderDto order);
	
	//olist 내용 가져오기
	public OrderDto orderSelect(String onum);

	//odlist 내용 가져오기
	public List<OrderDto> odlistSelect(String onum);
	
	//ordertbl r_num 업데이트
	public void roUpdate(OrderDto order);


	
		

}
