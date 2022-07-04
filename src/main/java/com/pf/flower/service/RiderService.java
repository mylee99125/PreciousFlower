package com.pf.flower.service;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.flower.dao.RiderDao;
import com.pf.flower.dao.RiderOrderDao;
import com.pf.flower.dto.ListDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.RiderDto;
import com.pf.flower.dto.RiderOrderDto;
import com.pf.flower.dto.RoListDto;
import com.pf.flower.util.MailUtils;
import com.pf.flower.util.PagingUtil;
import com.pf.flower.util.RidingOPagingUtil;
import com.pf.flower.util.RidingPagingUtil;
import com.pf.flower.util.tempKey;

import lombok.extern.java.Log;

@Service
@Log
public class RiderService {

	@Autowired
	private RiderDao rDao;

	@Autowired
	private RiderOrderDao roDao;
	
	@Autowired
	private BCryptPasswordEncoder pwdEncoder;

	@Autowired
	private JavaMailSender mailSender;

	private ModelAndView mv;

	private int listCnt = 5; //페이지 당 출력할 게시글 개수  
	
	private int rolistCnt = 5; //라이더 오더 페이지 당 출력할 게시글 개수

	// 아이디 중복 //
	public String idCheck(String id) {
		String res = null;

		//아이디가 중복이면 1, 아니면 0.
		int cnt = rDao.idCheck(id);

		if(cnt == 0) {
			res = "ok";
		} else {
			res = "not";
		}

		return res;
	}
	// 아이디 중복 end //


	// 라이더 회원가입 //
	@Transactional
	public String rmemberInsert(RiderDto rider, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		String encpwd = pwdEncoder.encode(rider.getR_pwd());
		log.info("encpwd : " + encpwd);
		rider.setR_pwd(encpwd);


		try {
			rDao.rmemberInsert(rider);

			view = "redirect:/";
			msg = "가입 성공";
		} catch (Exception e) {
			e.printStackTrace();

			view = "redirect:/r_joinFrm";
			msg = "가입 실패";
		}

		rttr.addFlashAttribute("msg", msg);

		return view;
	}
	// 라이더 회원가입 end //

									// 라이더 이메일 인증 // 

	public String emailConfirm(String rideremail) {
		String key = null;

		try {
			// 인증키 생성
			key = new tempKey().getKey(10, false); //위에서 String 선언해주면 밑에서 다시 선언할 필요가 없다. 
			log.info("인증번호 : " + key);


			// 메일 발송
			MailUtils sendMail = new MailUtils(mailSender);

			sendMail.setSubject("[회원가입 서비스 이메일 인증 입니다.]");
			sendMail.setText(new StringBuffer().append("<h1>라이더 가입 메일인증 입니다</h1>")
					.append("<br><br>")
					.append("홈페이지를 방문해주셔서 감사합니다")
					.append("<br><br>")
					.append("인증번호는 ").append(key) .append("입니다.")
					.append("<br><br>")
					.append("해당 인증번호를 인증번호 확인란에 기입해주세요.").toString());
			sendMail.setFrom("glc0420@gmail.com", "PreciousFlower");
			sendMail.setTo(rideremail);
			sendMail.send();

			log.info("이메일 : " + rideremail);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return key;
	}

									// 라이더 이메일 인증 End //

	// 라이더 로그인 프로세스 //
	public String rloginProc(RiderDto rider, HttpSession session, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		String encPwd = rDao.pwdSelect(rider.getR_id());

		if(encPwd != null) {
			//존재하는 아이디
			if(pwdEncoder.matches(rider.getR_pwd(), encPwd)) {
				//로그인 성공 -> 세션에 로그인 정보를 저장
				//회원 정보(이름, 포인트, 등급이름) : mem 재활용
				rider = rDao.riderSelect(rider.getR_id());
				//세션에 DTO 저장.
				session.setAttribute("rb", rider);

				//로그인 성공 후 게시판의 목록 페이지로 이동.
				//*************** 수정 필요 ******************* 리다이렉트 뷰 수정 !
				view = "redirect:/r_main";
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

	// 라이더 로그인 프로세스 end //

	// 라이더 배송 요청 //

	public ModelAndView getRidingList(ListDto list, HttpSession session) {
		mv = new ModelAndView();

		int num = list.getPageNum();
		if(num == 0) num = 1;
		list.setPageNum((num - 1) * listCnt);
		list.setListCnt(listCnt);

		List<OrderDto> rList = roDao.ridingListSelect(list);

		mv.addObject("rList", rList);

		//페이징 처리
		list.setPageNum(num);
		String pageHtml = getPaging(list);

		mv.addObject("ridingpaging", pageHtml);
		//addObject(String name, Object value)
		//뷰에 전달할 값을 설정

		session.setAttribute("pageNum", list.getPageNum());
		if(list.getColname() != null ) {
			session.setAttribute("list", list);
		}
		else {
			session.removeAttribute("list");
		}

		mv.setViewName("r_main");

		return mv;

	}

	// 라이더 배송목록 페이징 //
	
	private String getPaging(ListDto list) {
		String pageHtml = null;

		//전체 글 개수 구하기
		int maxNum = roDao.rcntSelect(list);
		//한 페이지 당 보여질 페이지 번호의 개수
		int pageCnt = 5;
		String listName = "rlist?";

		//검색 용 컬럼명과 검색어를 추가
		if(list.getColname() != null) {
			listName += "colname=" + list.getColname()
			+ "&keyword=" + list.getKeyword() + "&";
		}

		PagingUtil ridingpaging = new PagingUtil(maxNum, list.getPageNum(),	listCnt, pageCnt, listName);

		pageHtml = ridingpaging.makePaging();

		return pageHtml;
	}

	public ModelAndView getRcontent(String onum) {
		mv = new ModelAndView(); 

		//olist 내용 가져오기
		OrderDto olist = roDao.orderSelect(onum);
		
		//odlist 내용 가져오기
		List<OrderDto> odlist = roDao.odlistSelect(onum);

		mv.addObject("olist", olist);
		mv.addObject("odlist", odlist);
		
		mv.setViewName("r_contents");

		return mv;
	}
	
	public ModelAndView getRlcontent(String onum) {
		mv = new ModelAndView(); 

		//olist 내용 가져오기
		OrderDto olist = roDao.orderSelect(onum);
		
		//odlist 내용 가져오기
		List<OrderDto> odlist = roDao.odlistSelect(onum);

		mv.addObject("olist", olist);
		mv.addObject("odlist", odlist);
		
		mv.setViewName("r_lcontents");

		return mv;
	}


	public ModelAndView rmodify(String rid) {
		mv = new ModelAndView();

		RiderDto riderList = rDao.riderSelect(rid);

		mv.addObject("riderList", riderList);

		mv.setViewName("r_modify");

		return mv;
	}

	@Transactional 
	public String riderUpdate(RiderDto rider, MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		//String rid = multi.getParameter("rid");

		//getparameter는 name 값을 가져올 수 있음
		rider.setR_id(multi.getParameter("r_id"));
		rider.setR_pwd(multi.getParameter("r_pwd"));
		rider.setR_phone(multi.getParameter("r_phone"));
		rider.setR_email(multi.getParameter("r_email"));
		rider.setR_addr1(multi.getParameter("r_addr1"));
		rider.setR_addr2(multi.getParameter("r_addr2"));
		rider.setR_addr3(multi.getParameter("r_addr3"));
		rider.setR_insurance(multi.getParameter("r_insurance"));
		
		
		String encPwd = rDao.pwdSelect(rider.getR_id());
		
		if(pwdEncoder.matches(rider.getR_pwd(), encPwd)) {

		try {

			rDao.riderUpdate(rider);

			view = "redirect:/r_modify";
			msg = "수정 성공";

		} catch (Exception e) {
			e.printStackTrace();

			view = "redirect:/r_modify";
			msg = "수정 실패";
		}
		} else {
			view = "redirect:/r_modify";
			msg = "비밀번호를 다시 확인해주세요";
		}	

		rttr.addFlashAttribute("msg", msg);

		return view;
	}


	//배송확인 
		public String getRiding(String onum, HttpSession session, RedirectAttributes rttr) {
			String view = null;
			String msg = null;
			
			//session에서 데이터를 추출
			RiderDto rb = (RiderDto)session.getAttribute("rb");
			String ro_rid = rb.getR_id();
			int o_rnum = rb.getR_num();
		
			
			//dto에 삽입
			RiderOrderDto ro = new RiderOrderDto();
			ro.setRo_rid(ro_rid);
			ro.setRo_onum(onum);
			
			OrderDto order = new OrderDto();
			order.setO_num(onum);
			order.setO_rnum(o_rnum);
			
			try {
				roDao.ridingInsert(ro);
				roDao.roUpdate(order);
				
				log.info("배송확인 성공, onum : "+ onum);
				
				view = "redirect:/r_dList";
				msg = "배송 확인";
				
			} catch (Exception e) {
				e.printStackTrace();
				
				view = "redirect:/r_contents?onum=" + onum;
				msg = "배송 확인 오류";
			}
			
			rttr.addFlashAttribute("msg", msg);
			
			return view;
			
		}


	public ModelAndView getRoList(RoListDto rolist, HttpSession session) {
		mv = new ModelAndView();
		
		int ronum = rolist.getRopageNum();
		if(ronum == 0) ronum = 1;
		rolist.setRopageNum((ronum - 1) * rolistCnt);
		rolist.setRolistCnt(rolistCnt);
		
		//session에서 데이터를 추출
		RiderDto rb = (RiderDto)session.getAttribute("rb");
		String ro_rid = rb.getR_id();
		rolist.setRo_rid(ro_rid);
		
		List<OrderDto> roList = roDao.roListSelect(rolist);
		
		
		//라이더 오더 게시판
		mv.addObject("roList", roList);
		
		
		//페이징 처리
				rolist.setRopageNum(ronum);
				String ropageHtml = getRopaging(rolist, session);

				mv.addObject("RidingOpaging", ropageHtml);
				//addObject(String name, Object value)
				//뷰에 전달할 값을 설정

				session.setAttribute("ropageNum", rolist.getRopageNum());
				if(rolist.getRocolname() != null ) {
					session.setAttribute("rolist", rolist);
				}
				else {
					session.removeAttribute("rolist");
				}

				mv.setViewName("r_dList");

				return mv;

	}
	
	private String getRopaging(RoListDto rolist, HttpSession session) {
		String ropageHtml = null;
		
		//session에서 데이터를 추출
		RiderDto rb = (RiderDto)session.getAttribute("rb");
		String ro_rid = rb.getR_id();
		rolist.setRo_rid(ro_rid);
		//전체 글 개수 구하기
		int romaxNum = roDao.rocntSelect(rolist);
		//한 페이지 당 보여질 페이지 번호의 개수
		int ropageCnt = 5;
		String rolistName = "rolist?";

		//검색 용 컬럼명과 검색어를 추가
		if(rolist.getRocolname() != null) {
			rolistName += "rocolname=" + rolist.getRocolname()
			+ "&rokeyword=" + rolist.getRokeyword() + "&";
		}

		RidingOPagingUtil RidingOpaging = new RidingOPagingUtil (romaxNum, ropageCnt, romaxNum, ropageCnt, rolistName);

		ropageHtml = RidingOpaging.makePaging();

		return ropageHtml;
	}

	@Transactional
	public String rdelete(RiderDto rider, RedirectAttributes rttr, HttpSession session) {
		String view = null;
		String msg = null;
		
		String encPwd = rDao.pwdSelect(rider.getR_id());
		
		if(pwdEncoder.matches(rider.getR_pwd(), encPwd)) {
		
		   try {
		 	
		 	 rDao.rdelete(rider);
		 	
		 	 session.invalidate();
		     view = "redirect:/"; //최종 수정은 메인 홈페이지 메인으로
			 msg = "탈퇴되셨습니다. 감사합니다.";
			
		 } catch (Exception e) {
			e.printStackTrace();
			
			 view = "redirect:/r_delete";
			 msg = "관리자에게 문의해주세요";
		 }
		
		} else {
			view = "redirect:/r_delete";
			msg = "비밀번호를 다시 확인해주세요";
		}	
		
			rttr.addFlashAttribute("msg", msg);
		
			return view;
	}


	//로그아웃 처리 메소드
	
	public String rlogout(HttpSession session) {
		String view = "redirect:/";
				
		session.invalidate(); //세션을 비활성화
				
	return view;
	}

	 //배달 상태 수정
	
	@Transactional
	public String rOrderUpdate(OrderDto order, HttpServletRequest request, RedirectAttributes rttr) {
		
			String view = null;
			String msg = null;
			
			try {
				roDao.rupdateStatus(order);
				
				view = "redirect:/r_main";
				msg = "수정 성공";
			} catch(Exception e) {
				e.printStackTrace();
				
				view = "redirect:/r_dList";
				msg = "수정 실패";
			}
			
			rttr.addFlashAttribute("msg", msg);
			
			return view;
	}



}
