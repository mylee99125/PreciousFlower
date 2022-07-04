package com.pf.flower.service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.mysql.cj.Session;
import com.pf.flower.dao.AdminDao;
import com.pf.flower.dao.MainDao;
import com.pf.flower.dto.CartDto;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.NoticeDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.ProductDto;
import com.pf.flower.dto.ReviewDto;
import com.pf.flower.dto.hnListDto;
import com.pf.flower.dto.pListDto;
import com.pf.flower.util.hnPagingUtil;
import com.pf.flower.util.pPagingUtil;

import lombok.extern.java.Log;

@Service
@Log
public class MainService {
	@Autowired
	private MainDao mDao;

	@Autowired
	private AdminDao aDao;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;

	private ModelAndView mv;

	private int plistCnt = 9; //상품목록 페이지 당 출력할 상품 개수
	private int hnlistCnt = 10; //공지사항 페이지 당 출력할 공지 개수

	//상품목록 가져오기
	public ModelAndView ProductList(pListDto plist,
			HttpSession session) {
		mv = new ModelAndView();

		int pnum = plist.getPpageNum();
		if(pnum == 0) pnum = 1;
		plist.setPpageNum((pnum-1)*plistCnt);
		plist.setPlistCnt(plistCnt);

		if(plist.getCodestr() == null) {
			plist.setCodestr("BO");
		}

		//상품 목록 가져오기(DB)
		List<ProductDto> pList = mDao.pListSelect(plist);

		//mv에 위 내용 추가
		mv.addObject("pList", pList);

		//페이징 처리
		plist.setPpageNum(pnum);
		String ppageHtml = getpPaging(plist);
		mv.addObject("ppaging", ppageHtml);

		//세션에 페이지번호 저장(글쓰기 또는 글 상세보기 화면에서 목록 화면으로
		//돌아 갈 때 사용할 페이지 번호를 저장)
		session.setAttribute("ppageNum", plist.getPpageNum());
		if(plist.getPcolname() != null) {
			session.setAttribute("plist", plist);
		}
		else {//검색이 아닐 경우는 세션의 ListDto를 제거.
			session.removeAttribute("plist");
		}

		mv.setViewName("f_product");

		return mv;
	}

	//상품목록 페이징
	private String getpPaging(pListDto plist) {
		String ppageHtml = null;

		//전체 글개수 구하기
		int pmaxNum = mDao.pcntSelect(plist);
		//한 페이지 당 보여질 페이지 번호의 개수
		int ppageCnt = 5;
		String plistName = "f_product?codestr=" + plist.getCodestr() + "&";

		pPagingUtil ppaging = new pPagingUtil(pmaxNum, 
				plist.getPpageNum(),
				plistCnt, ppageCnt, plistName);

		ppageHtml = ppaging.makePaging();

		return ppageHtml;
	}

	//상품 상세 불러오기
	public ModelAndView fcontents(String p_code, ProductDto product) {
		mv = new ModelAndView();

		//상품 상세 가져오기
		ProductDto fCon = mDao.fcontents(p_code);
		//리뷰 목록 가져오기
		List<ReviewDto> reList = mDao.reSelect(p_code);

		//mv에 추가
		mv.addObject("fCon", fCon);
		mv.addObject("reList", reList);

		//화면(jsp)이름 지정
		mv.setViewName("f_contents");

		return mv;
	}

	//공지사항 리스트
	public ModelAndView getHomenList(hnListDto hnlist, HttpSession session) {
		mv = new ModelAndView();

		int hnnum = hnlist.getHnpageNum();
		if(hnnum == 0) hnnum = 1;
		hnlist.setHnpageNum((hnnum - 1) * hnlistCnt);
		hnlist.setHnlistCnt(hnlistCnt);

		List<NoticeDto> hnList = aDao.hnListSelect(hnlist);

		mv.addObject("hnList", hnList);

		hnlist.setHnpageNum(hnnum);
		String hnpageHtml = gethnPaging(hnlist);
		mv.addObject("hnpaging", hnpageHtml);

		session.setAttribute("hnpageNum", hnlist.getHnpageNum());
		if(hnlist.getHncolname() != null) {
			session.setAttribute("hnlist", hnlist);
		}
		else {
			session.removeAttribute("hnlist");
		}
		mv.setViewName("notice");

		return mv;
	}

	//공지사항 페이징
	private String gethnPaging(hnListDto hnlist) {
		String hnpageHtml = null;

		int hnmaxNum = aDao.hncntSelect(hnlist);
		int hnpageCnt = 5;
		String hnlistName = "hnlist?";

		if(hnlist.getHncolname() != null) {
			hnlistName += "hncolname=" + hnlist.getHncolname()
			+ "&hnkeyword=" + hnlist.getHnkeyword() + "&";
		}

		hnPagingUtil hnpaging = new hnPagingUtil(hnmaxNum,
				hnlist.getHnpageNum(),
				hnlistCnt, hnpageCnt, hnlistName);

		hnpageHtml = hnpaging.makePaging();

		return hnpageHtml;
	}

	//게시글 내용 가져오기
	public ModelAndView gethnContents(Integer n_num) {
		mv = new ModelAndView();

		NoticeDto notice = aDao.noticeSelect(n_num);

		int view = notice.getN_views() + 1;
		notice.setN_views(view);
		aDao.viewCount(notice);

		mv.addObject("notice", notice);

		mv.setViewName("n_contents");
		return mv;
	}

	// 로그인 프로세스 //
	public String mloginProc(MemberDto member, HttpSession session, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		String encPwd = mDao.pwdSelect(member.getM_id());

		if(encPwd != null) {
			//존재하는 아이디
			if(encPwd.matches(member.getM_pwd())) {
			/*if(pwdEncoder.matches(member.getM_pwd(), encPwd)) {*/
				//로그인 성공 -> 세션에 로그인 정보를 저장
				//회원 정보(이름, 포인트, 등급이름) : mem 재활용
				member = mDao.memberSelect(member.getM_id());
				//세션에 DTO 저장.
				session.setAttribute("mb", member);

				//로그인 성공 후 게시판의 목록 페이지로 이동.
				//*************** 수정 필요 ******************* 리다이렉트 뷰 수정 !
				view = "redirect:/";
				msg = "로그인 성공";
			}
			else {
				//로그인 실패(비번 오류)
				view = "redirect:/login";
				msg = "비밀번호 오류";
			}
		}
		else {
			//아이디가 존재하지 않는 경우(회원이 아닌 경우)
			view = "redirect:/login";
			msg = "없는 아이디";
		}

		rttr.addFlashAttribute("msg", msg);

		return view;
	}

	// 로그인 프로세스 end //

	//장바구니 불러오기
	public ModelAndView getCartList(CartDto cart, HttpSession session) {
		mv = new ModelAndView();
		
		//session에서 데이터 추출
		MemberDto mb = (MemberDto)session.getAttribute("mb");
		String mid = mb.getM_id();
		cart.setC_mid(mid);
		
		List<CartDto> cartList = mDao.cartListSelect(mid);
		
		mv.addObject("cartList", cartList);
		
		return mv;
	}
	
	//장바구니 상품 삭제
	@Transactional
	public String cartDelete(int c_num,
			RedirectAttributes rttr, HttpSession session) {
		String view = null;
		String msg = null;
		
		try {
			mDao.cartDelete(c_num);
			
			view = "redirect:/cart";
			msg = "상품 삭제를 성공했습니다.";
		} catch(Exception e) {
			e.printStackTrace();
			
			view = "redirect:/cart";
			msg = "상품 삭제를 실패했습니다. 관리자에게 문의하세요.";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
	//장바구니 상품 추가
	@Transactional
	public String addcart(HttpServletRequest request, 
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		//세션에 들어가 있는 접속자의 정보 갱신
		HttpSession session = request.getSession();
		
		//multi에서 데이터 추출
		String id = request.getParameter("mid");
		String pcode = request.getParameter("pcode");
		int ccount = Integer.parseInt(request.getParameter("product-quanity"));
		String pname = request.getParameter("pname");
		int price = Integer.parseInt(request.getParameter("pprice"));
		
		int pprice = price * ccount;
		
		//추출한 데이터 dto에 삽입
		CartDto cart = new CartDto();
		cart.setC_mid(id);
		cart.setC_pcode(pcode);
		cart.setC_count(ccount);
		cart.setC_pname(pname);
		cart.setC_pprice(pprice);
		
		try {
			mDao.addcart(cart);
			log.info("addcart - pcode : "+cart.getC_pcode());
			
			if(request.getHeader("Referer") != null) {
				//카트 버튼 누르기 전 페이지로 redirect
				view = "redirect:" + request.getHeader("Referer");
			} else {
				view = "redirect:/f_product";
			}
			msg = "장바구니에 상품이 추가되었습니다.";
		} catch(Exception e) {
			e.printStackTrace();
			
			if(request.getHeader("Referer") != null) {
				//카트 버튼 누르기 전 페이지로 redirect
				view = "redirect:" + request.getHeader("Referer");
			} else {
				view = "redirect:/f_product";
			}
			msg = "오류가 발생하였습니다. 관리자에게 문의하세요";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
	//로그아웃 처리 메소드
	public String logout(HttpSession session) {
		String view = "redirect:/";
		
		session.invalidate();
		
		return view;
	}
	
	//회원정보 불러오기(마이페이지)
	public ModelAndView mypage(String m_id, MemberDto member) {
		mv = new ModelAndView();
		
		MemberDto md = mDao.bringMember(m_id);
		
		mv.addObject("md", md);
		
		mv.setViewName("mypage");
		
		return mv;
	}
	
	//홰원정보 수정
	@Transactional 
    public String memberUpdate(MultipartHttpServletRequest multi, RedirectAttributes rttr) {
       String view = null;
       String msg = null;

       //getparameter는 name 값을 가져올 수 있음
       MemberDto member = new MemberDto();
       member.setM_id(multi.getParameter("m_id"));
       member.setM_pwd(multi.getParameter("m_pwd"));
       member.setM_phone(multi.getParameter("m_phone"));
       member.setM_email(multi.getParameter("m_email"));
       member.setM_addr1(multi.getParameter("m_addr1"));
       member.setM_addr2(multi.getParameter("m_addr2"));
       member.setM_addr3(multi.getParameter("m_addr3"));

       try {

          mDao.memberUpdate(member);

          view = "redirect:/";
          msg = "수정 성공";

       } catch (Exception e) {
          e.printStackTrace();

          view = "redirect:/";
          msg = "회원정보 수정을 실패하였습니다. 관리자에게 문의하세요.";
       }

       rttr.addFlashAttribute("msg", msg);

       return view;
    }
	
	//회원탈퇴 메소드
	@Transactional
	public String mdelete(MemberDto member, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		String encPwd = mDao.pwdSelect(member.getM_id());

		if(pwdEncoder.matches(member.getM_pwd(), encPwd)) {

			try {

				mDao.mdelete(member);

				view = "redirect:/";
				msg = "탈퇴되셨습니다. 감사합니다.";

			} catch (Exception e) {
				e.printStackTrace();

				view = "redirect:/m_delete";
				msg = "관리자에게 문의해주세요";
			}

		} else {
			view = "redirect:/m_delete";
			msg = "비밀번호를 다시 확인해주세요";
		}   

		rttr.addFlashAttribute("msg", msg);

		return view;

	}

	//주문페이지에서 정보 불러오기
	public ModelAndView selectCorder(MemberDto member, CartDto cart, HttpSession session) {

		MemberDto mb = (MemberDto)session.getAttribute("mb");
		String mid = mb.getM_id();
		
		MemberDto md = mDao.bringMember(mid);
		List<CartDto> corder = mDao.cartListSelect(mid);
		log.info("오더정보 받아오기");
		
		mv.addObject("md", md);
		mv.addObject("corder", corder);

		//화면(jsp)이름 지정
		mv.setViewName("order");

		return mv;
	}
	
	//최종 주문
	@Transactional
	public String finalOrder(OrderDto order, String o_mid, 
			HttpServletRequest request, RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		//세션에 들어가있는 접속자 정보 갱신
		HttpSession session = request.getSession();

		try {
			//주문번호 생성(현재 날짜 + 시간)
			LocalDateTime now = LocalDateTime.now();
			DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyyMMddHHmm");
			String ordernum = now.format(formatter);
			
			order.setO_num(ordernum);
			
			//ordertbl insert
			mDao.fOrderInsert(order);
			//orderdetail insert
			mDao.odInsert(order);
			//cart delete
			mDao.deleteCart(o_mid);
			
			//회원의 history 정보 변경 및 세션 데이터 변경
			MemberDto mb = (MemberDto)session.getAttribute("mb");
			int history = mb.getM_history();
			if(history < 11) {
				history += 1;
				mb.setM_history(history);
				mDao.upHistory(mb);
			}
			session.setAttribute("history", mb);
			
			view = "redirect:/ordersuccess";
		} catch (Exception e) {
			e.printStackTrace();

			view = "redirect:/Order?submit=order";
			msg = "관리자에게 문의 부탁드립니다";
		}

		rttr.addFlashAttribute("msg", msg);

		return view;
	}
	
	public ModelAndView getMoList(OrderDto order, HttpSession session) {
		mv = new ModelAndView();
		
		MemberDto mb = (MemberDto)session.getAttribute("mb");
		String mid = mb.getM_id();
		order.setO_mid(mid);
		
		List<OrderDto> moList = mDao.molistSelect(mid);
		
		//주문 이력 게시판
		mv.addObject("moList", moList);

		return mv;
	}
	
	//주문 상세 줄러오기
	public ModelAndView odcontents(String od_onum, OrderDto order) {
		mv = new ModelAndView();
		
		OrderDto odDet = mDao.oddetail(od_onum);
		List<OrderDto> odCon = mDao.odcontents(od_onum);
		
		mv.addObject("odDet", odDet);
		mv.addObject("odCon", odCon);
		
		mv.setViewName("o_contents");
		
		return mv;
	}

	public ModelAndView selectProduct(String p_code, ProductDto product, HttpSession session) {
		mv = new ModelAndView();
		
		MemberDto mb = (MemberDto)session.getAttribute("mb");
		String mid = mb.getM_id();
		product.setM_id(mid);
		
		//상품 상세 가져오기
		ProductDto fCon = mDao.fcontents(p_code);
		
		mv.addObject("fCon", fCon);
		
		mv.setViewName("review");
		
		return mv;
	}
	
	//리뷰 작성
	@Transactional
	public String reviewWrite(ReviewDto review, RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		try {
			
			mDao.reviewInsert(review);
			
			view = "redirect:/orderList";
			msg = "소중한 리뷰 감사합니다!";
			
			
		} catch (Exception e) {
			e.printStackTrace();
			
			view = "redirect:/reivew";
			msg = "리뷰 작성이 되지 않았습니다.";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
	//환불 내용 불러오기
	public ModelAndView refundcontents(String od_onum, String od_mid,
			MemberDto member, OrderDto order) {
		mv = new ModelAndView();
		
		//회원정보 가져오기
		MemberDto minfo = mDao.bringMember(od_mid);
		//주문상세 가져오기
		List<OrderDto> odCon = mDao.odcontents(od_onum);
		
		mv.addObject("minfo", minfo);
		mv.addObject("odCon", odCon);
		
		mv.setViewName("refund");
		
		return mv;
	}
	
	//환불 접수
	@Transactional
	public String refsubmit(OrderDto order, HttpServletRequest request,
			RedirectAttributes rttr) {
		String view = null;
		String msg = null;
		
		try {
			mDao.refsubmit(order);
			
			view = "redirect:/orderList";
			msg = "환불이 접수되었습니다.";
		} catch(Exception e) {
			e.printStackTrace();
			
			view = "redirect:/orderList";
			msg = "오류가 발생하였습니다. 관리자에게 문의해주세요.";
		}
		
		rttr.addFlashAttribute("msg", msg);
		
		return view;
	}
	
}//class end



















