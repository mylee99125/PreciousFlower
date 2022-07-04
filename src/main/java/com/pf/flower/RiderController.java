package com.pf.flower;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.flower.dto.ListDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.RiderDto;
import com.pf.flower.dto.RoListDto;
import com.pf.flower.service.RiderService;


@Controller
public class RiderController {
	
	private static final Logger logger = LoggerFactory.getLogger(RiderController.class);
	
	@Autowired
	private RiderService rServ;
	
	private ModelAndView mv;
	
	@Autowired
	private JavaMailSender mailSender;
	
	
	
	@GetMapping("/r_main")
	public ModelAndView r_main(ListDto list, HttpSession session) {
		logger.info("r_main()");
		
		//DB에서 게시글의 목록을 가져와서 페이지로 전달
		mv = rServ.getRidingList(list, session);
		
		return mv;
	}
	
	@GetMapping("/rlist")
	public ModelAndView rlist(ListDto list, HttpSession session) {
		logger.info("rlist()");
		
		//DB에서 게시글의 목록을 가져와서 페이지로 전달
		mv = rServ.getRidingList(list, session);
		
		return mv;
	}
	
	
	@GetMapping("/r_joinFrm")
	public String rjoinFrm() {
		logger.info("r_joinFrm()"); {
			
			return "r_joinFrm"; 
		}
	}
	/*
	@GetMapping("/r_myPage")
	public String rmypage() {
		logger.info("r_mypage()"); {
			
			return "r_myPage"; 
		}
	}
	*/
	
	// 아이디 중복 검사 //
	
	@GetMapping(value = "/idCheck", 
			    produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String idCheck(String rid) {
		logger.info("idCheck() - rid : " + rid);
		
		String res = rServ.idCheck(rid);
		
		return res;
	}
	
	// 아이디 중복 검사 End//
	
	// 회원 가입 //
	
	@PostMapping("/rmemInsert") 
	public String rmemberJoin(RiderDto rider, RedirectAttributes rttr) {
		logger.info("rmemberJoin()");
		
		String view = rServ.rmemberInsert(rider, rttr);
		
		return view;
	}
	
	// 회원 가입 End //
	
								// ********* 이메일 인증 *************
	
	@GetMapping(value = "/remailCheck", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String remailCheck(String riderEmail) throws Exception {
		logger.info("라이더 이메일 데이터 전송 확인");
		logger.info("인증번호 : " + riderEmail);
		
		String keyStr = rServ.emailConfirm(riderEmail);
		
		return keyStr;
	}
	
	
	
	// 라이더 로그인 프로세스 //
	
	@PostMapping("/rloginProc")
	public String rloginProc(RiderDto rider, HttpSession session, RedirectAttributes rttr) {
		logger.info("rloginProc()");
		
		String view = rServ.rloginProc(rider, session, rttr);
		
		return view;
	}
	
	// 라이더 로그인 프로세스 End //
	
	@GetMapping("/r_loginFrm")
	public String rloginFrm() {
		logger.info("r_loginFrm()"); {
			
			return "r_loginFrm"; 
		}
	}
	
	@GetMapping("/r_contents")
	public ModelAndView ridingContents(String onum) {
		logger.info("ridingContents() : onum - " + onum);
		
		mv = rServ.getRcontent(onum);
		
		return mv;
	}
	
	@GetMapping("/r_lcontents")
	public ModelAndView ridinglContents(String onum) {
		logger.info("ridingContents() : onum - " + onum);
		
		mv = rServ.getRlcontent(onum);
		
		return mv;
	}
	
	@GetMapping("/r_modify")
	public ModelAndView r_modify(String rid) {
		logger.info("r_modify() : rid - " + rid);	
		
		mv = rServ.rmodify(rid);
		
		return mv;
	}
	
	@PostMapping("/rmemUpdate")
	public String riderUpdate (RiderDto rider, MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		logger.info("riderUpdate()");
		
		String view = rServ.riderUpdate(rider, multi, rttr);
		
		return view;
	}
	
	@GetMapping("/ridingInsert")
	public String ridingInsert(String onum, HttpSession session, RedirectAttributes rttr) {
		logger.info("ridingInsert()" + onum);
		
		String view = rServ.getRiding(onum, session, rttr);
		
		return view;
	}
	
	//배송 이력 목록 가져오기
	
	@GetMapping("r_dList")
	public ModelAndView rdList(RoListDto rolist, HttpSession session) {
		logger.info("roList()");
		
		mv = rServ.getRoList(rolist, session);
		
		return mv;
	}
	
	//배송 이력 목록 가져오기
	
	@GetMapping("rolist")
	public ModelAndView roList(RoListDto rolist, HttpSession session) {
		logger.info("roList()");
		
		mv = rServ.getRoList(rolist, session);
		
		return mv;
	}
	
	@GetMapping("/r_delete")
	public String rdeleteFrm() {
		logger.info("rdeleteFrm()"); {
			
			return "r_delete"; 
		}
	}
	
	//라이더 탈퇴 - 정보있는 아이디 탈퇴(외래키 이슈 해결)
	
	@PostMapping("/rdelete")
	public String rdelete(RiderDto rider, RedirectAttributes rttr, HttpSession session) {
		logger.info("rdelete");	
		
		String view = rServ.rdelete(rider, rttr, session);
		
		return view;
	}
	
	//라이더 로그아웃
	
	@GetMapping("/rlogout") //세션에 저장된 로그인 정보를 삭제
	public String mlogout(HttpSession session) {
		logger.info("rider_logout()");
		
		String view = rServ.rlogout(session);
		
		return view;
	}
	
	//배달 상태 수정
	
	@GetMapping("/rupdate")
	public String rOrderUpdate(OrderDto order, HttpServletRequest request, RedirectAttributes rttr) {
		logger.info("rOrderUpdate() - o_num : " + order.getO_num());
		
		String view = rServ.rOrderUpdate(order, request, rttr);
		
		return view;
	}
	
	
	
	
	
}
