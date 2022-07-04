package com.pf.flower.util;

import lombok.AllArgsConstructor;

@AllArgsConstructor
public class mPagingUtil {
	private int mmaxNum;
	private int mpageNum;
	private int mlistCnt;
	private int mpageCnt;
	private String mlistName;
	
	//페이징용 html 코드 생성
	public String makePaging() {
		String page = null;
		StringBuffer sb = new StringBuffer();
		
		//1. 전체 페이지 개수
		int totalPage = (mmaxNum % mlistCnt) > 0 ?
				mmaxNum / mlistCnt + 1 :
				mmaxNum / mlistCnt;
		
		//2. 현재 페이지가 속해 있는 그룹 번호 구하기
		int curGroup = (mpageNum % mpageCnt) > 0 ?
				mpageNum / mpageCnt + 1 :
				mpageNum / mpageCnt;
		
		//3. 현재 보이는 페이지 그룹의 시작 번호
		int start = (curGroup * mpageCnt) - (mpageCnt - 1);
		
		//4. 현재 보이는 페이지 그룹의 마지막 번호
		int end = (curGroup * mpageCnt) >= totalPage ?
				totalPage : curGroup * mpageCnt;
		
		//이전 버튼
		if(start != 1) {
			sb.append("<a class='pno' href='./" + mlistName 
					+ "mpageNum=" + (start - 1) + "'>");
			sb.append("&nbsp;이전&nbsp;</a>");
		}
		
		//중간 페이지 번호 버튼
		for(int i = start; i <= end; i++) {
			if(mpageNum != i) {
				sb.append("<a class='pno' href='./" + mlistName
						+ "mpageNum=" + i + "'>");
				sb.append("&nbsp;" + i + "&nbsp;</a>");
			}
			else {
				sb.append("<font class='pno' style='color: red;'>");
				sb.append("&nbsp;" + i + "&nbsp;</font>");
			}
		}
		
		//다음 버튼 처리
		if(end != totalPage) {
			sb.append("<a class='pno' href='./" + mlistName
					+ "mpageNum=" + (end + 1) + "'>");
			sb.append("&nbsp;다음&nbsp;</a>");
		}
		page = sb.toString();
		
		return page;
	}
}//class end



