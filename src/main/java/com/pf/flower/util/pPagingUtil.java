package com.pf.flower.util;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class pPagingUtil {
	private int pmaxNum;//전체 글 개수를 저장하는 변수
	private int ppageNum;//현재 보이는 페이지의 번호 저장 변수
	private int plistCnt;//한 페이지 당 보일 게시글의 개수 저장 변수
	private int ppageCnt;//보여질 페이지 번호 개수 저장 변수
	private String plistName;//여러개의 게시판이 있을 경우 해당 게시판의
							//url을 저장
	
	//페이징용 html 코드를 만드는 메소드
	public String makePaging() {
		String page = null;
		StringBuffer sb = new StringBuffer();
		
		//1. 전체 페이지 개수 구하기(페이지 당 listCnt(10개) 만큼 출력)
		//전체 게시글 9개 : 1 페이지
		//전체 게시글 11개 : 2 페이지
		int totalPage = (pmaxNum % plistCnt) > 0 ?
				pmaxNum / plistCnt + 1 :
				pmaxNum / plistCnt;
		//2. 현재 페이지가 속해 있는 그룹 번호 구하기
		int curGroup = (ppageNum % ppageCnt) > 0 ?
				ppageNum / ppageCnt + 1 :
				ppageNum / ppageCnt;
		//3. 현재 보이는 페이지 그룹의 시작 번호 구하기
		int start = (curGroup * ppageCnt) - (ppageCnt - 1);
		//두번째 그룹 시작번호 = pageCnt(5) * 2 - (5 - 1) = 6
		
		//4. 현재 보이는 페이지 그룹의 마지막 번호 구하기
		int end = (curGroup * ppageCnt) >= totalPage ?
				totalPage : curGroup * ppageCnt;
		
		
		//이전 버튼 처리
		if(start != 1) {
			sb.append("<li class='page-item'>");
			sb.append("<a class='page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark' href='./" + plistName 
					+ "pageNum=" + (start - 1) + "'>");
			sb.append("&lt;</a>");
			sb.append("</li>");
		}//<a class='pno' herf='./list?pageNum=5'> 이전 </a>
		//페이지 번호를 5개씩 보여주는 경우,
		//6페이지가 보이는 화면에서 이전 버튼이 보이게 되고
		//그 이전 버튼의 링크는 5페이지가 된다.
		
		/*
		<li class='page-item disabled'>
        <a class='page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0' href="#">1</a>
	    </li>
	    */
		
		//중간 페이지 번호 버튼 처리
		for(int i = start; i <= end; i++) {
			if(ppageNum != i) {//현재 페이지가 아닌 페이지 번호
				sb.append("<li class='page-item'>");
				sb.append("<a class='page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark' href='./" + plistName
						+ "ppageNum=" + i + "'>");
				sb.append(i + "</a>");
				sb.append("</li>");
			}//<a class='pno' href='./list?pageNum=3> 3 </a>
			else {//현재 보이는 페이지
				//현재 보이는 페이지 번호에는 링크를 걸지 않는다.
				sb.append("<li class='page-item disabled'>");
				sb.append("<a class='page-link active rounded-0 mr-3 shadow-sm border-top-0 border-left-0' href='./" + plistName
						+ "ppageNum=" + i + "'>");
				sb.append(i + "</a>");
				sb.append("</li>");
			}//<font class='pno' style='color: red;'> 2 </font>
		}
		
		//다음 버튼 처리
		if(end != totalPage) {
			sb.append("<li class='page-item'>");
			sb.append("<a class='page-link rounded-0 shadow-sm border-top-0 border-left-0 text-dark' href='./" + plistName
					+ "ppageNum=" + (end + 1) + "'>");
			sb.append("&gt;</a>");
			sb.append("</li>");
		}//<a class='pno' href='./list?pageNum=6'> 다음 </a>
		
		//StringBuffer에 저장된 내용을 문자열로 변환
		page = sb.toString();
		
		return page;
	}
}
