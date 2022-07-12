package com.pf.flower.service;

import java.io.File;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.flower.dao.AdminDao;
import com.pf.flower.dto.AdminDto;
import com.pf.flower.dto.ListDto;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.NoticeDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.PfileDto;
import com.pf.flower.dto.ProductDto;
import com.pf.flower.dto.RiderDto;
import com.pf.flower.dto.VisitDto;
import com.pf.flower.dto.apListDto;
import com.pf.flower.dto.mListDto;
import com.pf.flower.dto.nListDto;
import com.pf.flower.dto.oListDto;
import com.pf.flower.dto.rmListDto;
import com.pf.flower.util.PagingUtil;
import com.pf.flower.util.apPagingUtil;
import com.pf.flower.util.mPagingUtil;
import com.pf.flower.util.nPagingUtil;
import com.pf.flower.util.oPagingUtil;
import com.pf.flower.util.rmPagingUtil;

import lombok.extern.java.Log;

@Service
@Log
public class AdminService {
	@Autowired
	private AdminDao aDao;
	
	private ModelAndView mv;
	
	private int aplistCnt = 5; //관리자 상품목록 페이지 당 풀력할 상품 개수
	private int olistCnt = 5; //주문목록 페이지 당 출력할 주문 개수
	private int mlistCnt = 5; //일반회원목록 페이지 당 출력할 회원 수
	private int rmlistCnt = 5; //라이더회원목록 페이지 당 출력할 회원 수
	private int nlistCnt = 5; //공지목록 페이지 당 출력할 공지 개수
	
	//로그인 처리 서비스 메소드
	public String loginProc(AdminDto adm, HttpSession session,
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		//회원의 비밀번호 구하기
		String pwd = aDao.pwdSelect(adm.getA_id());
		
		if(pwd != null) {
			if(pwd.matches(adm.getA_pwd())) {
				//로그인 성공
				//세션에 DTO 저장
				session.setAttribute("ad", adm);
				
				//로그인 성공 후 관리자 메인 페이지로 이동
				view = "redirect:/aa_main";
			}
			else {
				//로그인 실패(비번 오류)
				msg = "비밀번호 오류";
			}
		}
		else {
			//아이디, 비밀번호 모두 불일치
			view = "redirect:/aa_login";
			msg = "관리자만 접근이 가능한 페이지입니다.";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}//loginProc end
	
	//상품코드 중복체크 메소드
	public String codeCheck(String p_code) {
		String res = null;
		
		//코드가 중복이면 1, 아니면 0
		int cnt = aDao.codeCheck(p_code);
		
		if(cnt == 0) {
			res = "ok";
		}
		else {
			res = "not";
		}
		
		return res;
	}
	
	
	//로그아웃 처리 메소드
	public String alogout(HttpSession session) {
		String view = "redirect:/aa_login";
		
		session.invalidate();
		
		return view;
	}
	
	//상품등록 메소드
	@Transactional
	public String productInsert(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		//multi에서 데이터를 추출
		String code = multi.getParameter("p_code");
		String name = multi.getParameter("p_name");
		int price = Integer.parseInt(multi.getParameter("p_price"));
		String detail = multi.getParameter("p_detail");
		String fcheck = multi.getParameter("filecheck");
		
		//textarea 공백(노이즈) -> trim
		detail = detail.trim();
		
		//추출한 데이터를 dto에 삽입
		ProductDto product = new ProductDto();
		product.setP_code(code);
		product.setP_name(name);
		product.setP_price(price);
		product.setP_detail(detail);
		
		try {
			//1. 상품을 DB에 저장
			aDao.pInsert(product);
			log.info("상품등록 성공, 상품코드 : "+product.getP_code());
			
			//2. 업로드 파일이 있을 경우 파일 저장 및 DB에 정보 저장
			if(fcheck.equals("1")) {
				fileUpload(multi, product.getP_code());
			}
			
			view = "redirect:/aa_plist";
			msg = "상품등록 성공";
		} catch (Exception e) {
			e.printStackTrace();
			
			view = "redirect:/aa_pinsert";
			msg = "상품등록 실패";
		}
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}

	private void fileUpload(MultipartHttpServletRequest multi,
			String p_code) throws Exception {
		//request의 서버 정보에서 프로젝트 폴더의 절대 위치 정보 구하기
		String realPath = multi.getServletContext().getRealPath("/");
		
		//파일을 저장할 경로를 절대경로에 추가
		realPath += "resources/upload/";
		log.info(realPath);
		
		//upload 폴더가 없을 경우 새로 생성
		File folder = new File(realPath);
		if(folder.isDirectory() == false) {
			folder.mkdir(); //폴더 생성
		}
		
		//1. 파일 정보를 DB(productfile) 테이블에 저장(상품코드, 원래이름, 변경이름)
		//파일 정보는 HashMap을 사용하여 저장
		Map<String, String> fmap = new HashMap<String, String>();
		fmap.put("p_code", String.valueOf(p_code));
		
		//multi에서 file 태그의 name 값 꺼내기
		Iterator<String> files = multi.getFileNames();
		
		while(files.hasNext()) {
			String fn = files.next();
			
			//multiple 선택 파일 처리 -> 파일 목록 가져오기
			List<MultipartFile> fList = multi.getFiles(fn);
			
			//각각의 파일을 처리(파일명 추출, 파일을 폴더에 저장)
			for(int i=0; i<fList.size(); i++) {
				MultipartFile mf = fList.get(i);
				
				//파일명 추출
				String oriname = mf.getOriginalFilename();
				
				//변경할 이름 생성
				String sysname = System.currentTimeMillis()
						+ oriname.substring(oriname.lastIndexOf("."));
				
				fmap.put("oriname", oriname);
				fmap.put("sysname", sysname);
				
				//upload 폴더 파일 저장
				File ff = new File(realPath + sysname);
				mf.transferTo(ff);
				
				//DB에 파일정보 저장
				aDao.fileInsert(fmap);
			}
		}
	}//fileUpload end
	
	//상품목록 가져오기
	public ModelAndView getProductList(apListDto aplist, 
			HttpSession session) {
		mv = new ModelAndView();
		
		int num = aplist.getAppageNum();
		if(num == 0) num = 1;
		aplist.setAppageNum((num-1)*aplistCnt);
		aplist.setAplistCnt(aplistCnt);
		
		//상품 목록 가져오기(DB)
		List<ProductDto> pList = aDao.productListSelect(aplist);
		
		//mv에 위 내용 추가
		mv.addObject("pList", pList);
		
		//페이징 처리
		aplist.setAppageNum(num);
		String appageHtml = getAppaging(aplist);
		mv.addObject("appaging", appageHtml);
		
		//세션에 페이지번호 저장(글쓰기 또는 글 상세보기 화면에서 목록 화면으로
		//돌아 갈 때 사용할 페이지 번호를 저장)
		session.setAttribute("appageNum", aplist.getAppageNum());
		if(aplist.getApcolname() != null) {
			session.setAttribute("aplist", aplist);
		}
		else {//검색이 아닐 경우는 세션의 ListDto를 제거.
			session.removeAttribute("aplist");
		}
		
		mv.setViewName("aa_plist");

		return mv;
	}

	//상품목록 페이징
	private String getAppaging(apListDto aplist) {
		String appageHtml = null;
		
		//전체 글개수 구하기
		int apmaxNum = aDao.pcntSelect(aplist);
		//한 페이지 당 보여질 페이지 번호의 개수
		int appageCnt = 5;
		String aplistName = "aa_plist?";
		
		//검색 용 컬럼명과 검색어를 추가
		if(aplist.getApcolname() != null) {
			aplistName += "colname="+ aplist.getApcolname()
			+ "&keyword=" + aplist.getApkeyword() + "&";
		}

		apPagingUtil appaging = new apPagingUtil(apmaxNum, 
				aplist.getAppageNum(),
				aplistCnt, appageCnt, aplistName);

		appageHtml = appaging.makePaging();
		
		return appageHtml;
	}
	
	//상품수정 화면
	public ModelAndView updateFrm(String p_code) {
		mv = new ModelAndView();
		
		//상품 내용 가져오기
		ProductDto product = aDao.productSelect(p_code);
		
		//상품 파일 가져오기(DB)
		List<PfileDto> fList = aDao.fileSelect(p_code);
		
		//mv에 위 내용 추가
		mv.addObject("product", product);
		mv.addObject("fList", fList);
		
		//화면(jsp) 이름 지정
		mv.setViewName("aa_pupdate");
		
		return mv;
	}
	
	//파일 삭제(게시글 수정-개별)
	@Transactional
	public Map<String, List<PfileDto>> fileDelete(String sysname,
			String p_code, HttpSession session) {
		Map<String, List<PfileDto>> fMap = null;
		
		//파일 삭제(실제 파일 + 파일 정보 DB 삭제)
		//실제 파일 경로
		String realPath = session.getServletContext().getRealPath("/");
		realPath += "resources/upload/" + sysname;
		log.info(realPath);
		
		try {
			aDao.fileDelete(sysname);
			
			File file = new File(realPath);
			
			if(file.exists()) { //파일이 있을 경우
				if(file.delete()) { //파일 삭제에 성공한 경우
					//파일 목록 다시 가져오기
					List<PfileDto> fList = aDao.fileSelect(p_code);
					fMap = new HashMap<String, List<PfileDto>>();
					//파일 목록 맵에 삽입
					fMap.put("fList", fList);
				}
				else {
					fMap = null;
				}
			}
		} catch(Exception e) {
			e.printStackTrace();
			fMap = null;
		}
		
		return fMap;
	}
	
	//상품 수정
	@Transactional
	public String productUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		String p_code = multi.getParameter("p_code");
		
		//multi에서 데이터 추출 및 Dto에 삽입
		ProductDto product = new ProductDto();
		product.setP_code(multi.getParameter("p_code"));
		product.setP_name(multi.getParameter("p_name"));
		product.setP_price(Integer.parseInt(multi.getParameter("p_price")));
		product.setP_detail(multi.getParameter("p_detail"));
		String fcheck = multi.getParameter("filecheck");
		
		try {
			aDao.productUpdate(product);
			
			if(fcheck.equals("1")) {
				fileUpload(multi, product.getP_code());
			}
			
			view = "redirect:/aa_pupdate?p_code=" + p_code;
			msg ="수정 성공";
		} catch(Exception e) {
			e.printStackTrace();
			
			view = "redirect:/aa_pupdate?p_code=" + p_code;
			msg ="수정 실패";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
	//상품 삭제
	@Transactional
	public String productDelete(String p_code, RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		try {
			//리뷰 삭제
			aDao.reviewDelete(p_code);
			//파일목록(정보) 삭제
			aDao.fListDelete(p_code);
			//게시글 삭제
			aDao.productDelete(p_code);
			
			view = "redirect:/aa_plist?pageNum=1";
			msg = "삭제 성공";
		} catch(Exception e) {
			e.printStackTrace();
			
			view = "redirect:/aa_pupdate?p_code=" + p_code;
			msg = "삭제 실패";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
	//홈페이지 방문자 수 카운트
	@Transactional
	public String visitCount(VisitDto visit) {
		try {
			aDao.setVisitTotalCount();
		} catch(Exception e) {
			e.printStackTrace();
		}
		
		return null;
	}
	
	//관리자 메인 리스트 불러오기 메소드
	public ModelAndView getAdminList(VisitDto visit) {
		mv = new ModelAndView();
		//전체 조회수 가져오기
		int vTotal = aDao.getVisitTotalCount(visit);
		//매출액 가져오기
		int tTotal = aDao.getTodayTotalCount();
		int obdTotal = aDao.get1bdayTotalCount();
		int tbdTotal = aDao.get2bdayTotalCount();
		int thbdTotal = aDao.get3bdayTotalCount();
		int fbdTotal = aDao.get4bdayTotalCount();
		int fibdTotal = aDao.get5bdayTotalCount();
		
		
		//가져온 데이터를 mv에 추가
		mv.addObject("vTotal", vTotal);
		mv.addObject("tTotal", tTotal);
		mv.addObject("obdTotal", obdTotal);
		mv.addObject("tbdTotal", tbdTotal);
		mv.addObject("thbdTotal", thbdTotal);
		mv.addObject("fbdTotal", fbdTotal);
		mv.addObject("fibdTotal", fibdTotal);
		mv.setViewName("aa_main");
		
		return mv;
	}
	
	//주문목록 가져오기
	public ModelAndView getOrderList(oListDto olist, 
			HttpSession session) {
		mv = new ModelAndView();
		
		int onum = olist.getOpageNum();
		if(onum == 0) onum = 1;
		olist.setOpageNum((onum-1)*olistCnt);
		olist.setOlistCnt(olistCnt);
		
		//주문 목록 가져오기(DB)
		List<OrderDto> oList = aDao.orderListSelect(olist);
		//전체 주문 수 가져오기
		int ototal = aDao.ocntSelect(olist);
		//전체 매출액 가져오기
		int ordersum = aDao.ordersum(olist);
		
		//mv에 위 내용 추가
		mv.addObject("oList", oList);
		mv.addObject("ototal", ototal);
		mv.addObject("ordersum", ordersum);
		
		//페이징 처리
		olist.setOpageNum(onum);
		String opageHtml = getoPaging(olist);
		mv.addObject("opaging", opageHtml);
		
		//세션에 페이지번호 저장(글쓰기 또는 글 상세보기 화면에서 목록 화면으로
		//돌아 갈 때 사용할 페이지 번호를 저장)
		session.setAttribute("opageNum", olist.getOpageNum());
		if(olist.getOcolname() != null) {
			session.setAttribute("olist", olist);
		}
		else {//검색이 아닐 경우는 세션의 ListDto를 제거.
			session.removeAttribute("olist");
		}
		
		mv.setViewName("aa_olist");

		return mv;
	}
	
	//주문목록 페이징
	private String getoPaging(oListDto olist) {
		String opageHtml = null;
		
		//전체 주문수 구하기
		int omaxNum = aDao.ocntSelect(olist);
		//한 페이지 당 보여질 페이지 번호의 개수
		int opageCnt = 5;
		String olistName = "aa_olist?";
		
		//검색 용 컬럼명과 검색어를 추가
		if(olist.getOcolname() != null) {
			olistName += "ocolname="+ olist.getOcolname()
			+ "&okeyword=" + olist.getOkeyword() + "&";
		}

		oPagingUtil opaging = new oPagingUtil(omaxNum, 
				olist.getOpageNum(),
				olistCnt, opageCnt, olistName);

		opageHtml = opaging.makePaging();
		
		return opageHtml;
	}
	
	//주문 수정(주문 상태)
	@Transactional
	public String orderUpdate(OrderDto order, HttpServletRequest request, 
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		try {
			aDao.upStatus(order);
			
			view = "redirect:/aa_olist";
			msg = "수정 성공";
		} catch(Exception e) {
			e.printStackTrace();
			
			view = "redirect:/aa_olist";
			msg = "수정 실패";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
	//주문 상세 불러오기
	public ModelAndView orderSelect(String o_num, OrderDto order) {
		mv = new ModelAndView();
		
		//주문 목록 가져오기(DB)
		OrderDto oCon = aDao.orderSelect(o_num);
		List<OrderDto> od = aDao.odlistSelect(order);
		
		//mv에 추가
		mv.addObject("oCon", oCon);
		mv.addObject("od", od);
		
		//화면(jsp) 이름 지정
		mv.setViewName("aa_ocontents");
		
		return mv;
	}
	
	
	/* Member */
	
	//회원 목록
		public ModelAndView getMemberList(mListDto mlist, HttpSession session) {
			mv = new ModelAndView();
			
			int mnum = mlist.getMpageNum();
			if(mnum == 0) mnum = 1;
			mlist.setMpageNum((mnum - 1) * mlistCnt);
			mlist.setMlistCnt(mlistCnt);
			
			List<MemberDto> mList = aDao.memberListSelect(mlist);
			
			mv.addObject("mList", mList);
			
			mlist.setMpageNum(mnum);
			String mpageHtml = getMpaging(mlist);
			mv.addObject("mpaging", mpageHtml);
			
			session.setAttribute("mpageNum", mlist.getMpageNum());
			if(mlist.getMcolname() != null) {
				session.setAttribute("mlist", mlist);
			}
			else {//검색이 아닐 경우는 세션의 ListDto를 제거.
				session.removeAttribute("mlist");
			}
			
			mv.setViewName("aa_mlist");
			
			return mv;
		}
		
		//회원목록 페이징
		private String getMpaging(mListDto mlist) {
			String mpageHtml = null;
			
			int mmaxNum = aDao.mcntSelect(mlist);
			int mpageCnt = 5;
			String mlistName = "mlist?";
			
			if(mlist.getMcolname() != null) {
				mlistName += "mcolname=" + mlist.getMcolname()
					+ "&mkeyword=" + mlist.getMkeyword() + "&";
			}
			
			mPagingUtil mpaging = new mPagingUtil(mmaxNum,
					mlist.getMpageNum(),
					mlistCnt, mpageCnt, mlistName);
			
			mpageHtml = mpaging.makePaging();
			
			return mpageHtml;
		}
		
		// 회원 상세 페이지
		public ModelAndView getmContents(String m_id, OrderDto order) {
			mv = new ModelAndView();

			MemberDto member = aDao.memberSelect(m_id);
			
			order.setO_mid(m_id);
			
			List<OrderDto> orderList = aDao.memberOlist(m_id);

			mv.addObject("member", member);
			mv.addObject("oList", orderList);

			mv.setViewName("aa_mcontents");

			return mv;
		}
		
		//회원 삭제
		@Transactional
		public String memberDelete(String m_id, RedirectAttributes rttr) {
			String view = null;
			String msg = null;
			
			try {
				aDao.memberDelete(m_id);
				
				view = "redirect:/mlist?mpageNum=1";

			} catch (Exception e) {
				e.printStackTrace();
				msg = "'${member.m_name}'회원이 삭제되었습니다.";
				view = "redirect:/memberContents?m_id=" + m_id;
				msg = "회원 삭제에 실패했습니다.";
			}
			rttr.addFlashAttribute("msg", msg);
			
			return view;
		}
		
		//회원 정보 수정
		@Transactional
		public String memberUpdate(MemberDto member, String m_id, RedirectAttributes rttr) {
			String view = null;
			String msg = null;
			
			try {
				aDao.memberUpdate(member);
				
				view = "redirect:/mypage?m_id=" + m_id;
				msg = "수정되었습니다.";
			} catch (Exception e) {
				e.printStackTrace();
				
				view = "redirect:/mypage?m_id=" + m_id;
				msg = "수정에 실패하였습니다.";
			}
			rttr.addFlashAttribute("msg", msg);
			
			return view;
		}
		
		//회원 목록(라이더)
		public ModelAndView getRmemberList(rmListDto rmlist, HttpSession session) {
			mv = new ModelAndView();
			
			int rmnum = rmlist.getRmpageNum();
			if(rmnum == 0) rmnum = 1;
			rmlist.setRmpageNum((rmnum - 1) * rmlistCnt);
			rmlist.setRmlistCnt(rmlistCnt);
				
			List<RiderDto> rmList = aDao.rmemberListSelect(rmlist);
				
			mv.addObject("rmList", rmList);
				
			rmlist.setRmpageNum(rmnum);
			String rmpageHtml = getRmpaging(rmlist);
			mv.addObject("rmpaging", rmpageHtml);
				
			session.setAttribute("rmpageNum", rmlist.getRmpageNum());
			if(rmlist.getRmcolname() != null) {
					session.setAttribute("rmlist", rmlist);
			}
			else {//검색이 아닐 경우는 세션의 ListDto를 제거.
				session.removeAttribute("rmlist");
			}
				
			mv.setViewName("aa_rmlist");
			
			return mv;
		}
			
		//회원목록 페이징(라이더)
		private String getRmpaging(rmListDto rmlist) {
			String rmpageHtml = null;
			
			int rmmaxNum = aDao.rmcntSelect(rmlist);
			int rmpageCnt = 5;
			String rmlistName = "rmlist?";
				
			if(rmlist.getRmcolname() != null) {
				rmlistName += "rmcolname=" + rmlist.getRmcolname()
					+ "&rmkeyword=" + rmlist.getRmkeyword() + "&";
			}
			
			rmPagingUtil rmpaging = new rmPagingUtil(rmmaxNum,
					rmlist.getRmpageNum(),
					rmlistCnt, rmpageCnt, rmlistName);
				
			rmpageHtml = rmpaging.makePaging();
				
			return rmpageHtml;
		}
			
		//회원 상세 페이지(라이더)
		public ModelAndView getrmContents(String r_id, OrderDto order) {
			mv = new ModelAndView();
			
			RiderDto rmember = aDao.rmemberSelect(r_id);
			
			order.setR_id(r_id);
			
			List<OrderDto> orderList = aDao.riderOlist(r_id);
				
			mv.addObject("rmember", rmember);
			mv.addObject("oList", orderList);
				
			mv.setViewName("aa_rmcontents");
				
			return mv;
		}
		
		//회원 삭제(라이더)
		@Transactional
		public String rmemberDelete(String r_id, RedirectAttributes rttr) {
			String view = null;
			String msg = null;
				
			try {
				aDao.rmemberDelete(r_id);
					
				view = "redirect:/rmlist?rmpageNum=1";

			} catch (Exception e) {
				e.printStackTrace();
				msg = "'${rmember.r_name}'회원이 삭제되었습니다.";
					view = "redirect:/rmemberContents?r_id=" + r_id;
				msg = "회원 삭제에 실패했습니다.";
			}
			rttr.addFlashAttribute("msg", msg);
				
			return view;
		}

		
		/* Notice */
		
		//공지사항 리스트
		public ModelAndView getNoticeList(nListDto nlist, HttpSession session) {
			mv = new ModelAndView();
			
			int nnum = nlist.getNpageNum();
			if(nnum == 0) nnum = 1;
			nlist.setNpageNum((nnum - 1) * nlistCnt);
			nlist.setNlistCnt(nlistCnt);
			
			List<NoticeDto> nList = aDao.noticeListSelect(nlist);
			
			mv.addObject("nList", nList);
			
			nlist.setNpageNum(nnum);
			String npageHtml = getnPaging(nlist);
			mv.addObject("npaging", npageHtml);
			
			session.setAttribute("npageNum", nlist.getNpageNum());
			if(nlist.getNcolname() != null) {
				session.setAttribute("nlist", nlist);
			}
			else {
				session.removeAttribute("nlist");
			}
			mv.setViewName("aa_notice");
			
			return mv;
		}
		
		//공지사항 페이징
		private String getnPaging(nListDto nlist) {
			String npageHtml = null;
			
			int nmaxNum = aDao.ncntSelect(nlist);
			int npageCnt = 5;
			String nlistName = "nlist?";
			
			if(nlist.getNcolname() != null) {
				nlistName += "ncolname=" + nlist.getNcolname()
					+ "&nkeyword=" + nlist.getNkeyword() + "&";
			}
			
			nPagingUtil npaging = new nPagingUtil(nmaxNum,
					nlist.getNpageNum(),
					nlistCnt, npageCnt, nlistName);
			
			npageHtml = npaging.makePaging();
			
			return npageHtml;
		}
		
		//게시글 내용 가져오기
		public ModelAndView getnContents(Integer n_num) {
			mv = new ModelAndView();
			
			NoticeDto notice = aDao.noticeSelect(n_num);
			
			mv.addObject("notice", notice);
			
			mv.setViewName("aa_ncontents");
			
			return mv;
		}
		
		//게시글 작성
		@Transactional
		public String noticeInsert(NoticeDto notice, RedirectAttributes rttr) {
			String view = null;
			String msg = null;
			
			String id = notice.getN_aid();
			String title = notice.getN_title();
			String contents = notice.getN_contents();
			
			notice.setN_aid(id);
			notice.setN_title(title);
			notice.setN_contents(contents);
			
			try {
				aDao.noticeInsert(notice);
				
				view = "redirect:/nlist?npageNum=1";
				msg = "작성 성공";
			} catch (Exception e) {
				e.printStackTrace();
				
				view = "redirect:/aa_ninsert";
				msg = "작성 실패";
			}
			
			rttr.addFlashAttribute("msg", msg);
			
			return view;
		}
		
		//수정할 게시글 불러오기
		public ModelAndView aa_nupdate(int n_num) {
			mv = new ModelAndView();
			
			NoticeDto notice = aDao.noticeSelect(n_num);
			
			mv.addObject("notice", notice);
			
			mv.setViewName("aa_nupdate");
			
			return mv;
		}
		
		//게시글 수정
		@Transactional
		public String noticeUpdate(NoticeDto notice, int n_num, RedirectAttributes rttr) {
			String view = null;
			String msg = null;

			try {
				aDao.noticeUpdate(notice);
				
				view = "redirect:/noticeContents?n_num=" + n_num;
				msg = "수정되었습니다.";
			} catch (Exception e) {
				e.printStackTrace();
				
				view = "redirect:/aa_nupdate?n_num=" + n_num;
				msg = "수정에 실패하였습니다.";
			}
			
			rttr.addFlashAttribute("msg", msg);
			
			return view;
		}

		//게시글 삭제
		@Transactional
		public String noticeDelete(int n_num, RedirectAttributes rttr) {
			String view = null;
			String msg = null;
			
			try {
				aDao.noticeDelete(n_num);
				
				view = "redirect:/nlist?npageNum=1";
				msg = "게시글을 삭제했습니다.";
			} catch (Exception e) {
				e.printStackTrace();
				
				view = "redirect:/noticeContents?n_num=" + n_num;
				msg = "게시글을 삭제하는 데 실패했습니다.";
			}
			rttr.addFlashAttribute("msg", msg);
			
			return view;
		}
	
}//class end


















