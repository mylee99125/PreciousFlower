package com.pf.flower;

import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.mListDto;
import com.pf.flower.service.MemberService;



@Controller
public class MemberController {
	private static final Logger logger = LoggerFactory.getLogger(MemberController.class);
	
	@Autowired
	private MemberService mServ;
	
	private ModelAndView mv;
	
	@GetMapping("/m_joinFrm")
	public String mjoinFrm() {
		logger.info("m_joinFrm()"); {
			
			return "m_joinFrm"; 
		}
	}
	
	// 아이디 중복 검사 //
	
	@GetMapping(value = "/midCheck", 
			    produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String midCheck(String mid) {
		logger.info("midCheck() - mid : " + mid);
		
		String res = mServ.midCheck(mid);
		
		return res;
	}
		
	// 아이디 중복 검사 End//
		
	// 회원 가입 //
		
	@PostMapping("/memInsert") 
	public String memberJoin(MemberDto member, RedirectAttributes rttr) {
		logger.info("memberJoin()");
		
		String view = mServ.memberInsert(member, rttr);
		
		return view;
	}
		
	// 회원 가입 End //
	
	// 회원 이메일 인증 
	
	@GetMapping(value = "/memailCheck", produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String remailCheck(String memberEmail) throws Exception {
		logger.info("회원 이메일 데이터 전송 확인");
		logger.info("인증번호 : " + memberEmail);
		
		String keyStr = mServ.memailConfirm(memberEmail);
		
		return keyStr;
	}
	
	// 회원 로그인 프로세스 //
	
	@PostMapping("/mloginProc")
	public String mloginProc(MemberDto member, HttpSession session, RedirectAttributes rttr) {
		logger.info("mloginProc()");
		
		String view = mServ.mloginProc(member, session, rttr);
		
		return view;
	}
		
	// 회원 로그인 프로세스 End //
	
	
	// 마이페이지 회원 정보 불러오기
		
	@GetMapping("/mypage")
	public ModelAndView mypage(String m_id, MemberDto member) {
		logger.info("mypage():m_id - "+m_id);
		
		mv = mServ.mypage(m_id, member);
		
		return mv;
	}
	
	// 마이페이지 회원 정보 수정
	
	@PostMapping("/memUpdate")
	public String memberUpdate (MemberDto member, MultipartHttpServletRequest multi, RedirectAttributes rttr) {
		logger.info("memberUpdate()");
		
		String view = mServ.memberUpdate(member, multi, rttr);
		
		return view;
	}
	
	
	//회원 탈퇴 - 정보있는 아이디 탈퇴(외래키 이슈 해결 필요***********)
	
	@GetMapping("/m_delete")
	public String mdeleteFrm() {
		logger.info("mdeleteFrm()"); {
			
			return "m_delete"; 
		}
	}
	
	
	@PostMapping("/mdelete")
	public String rdelete(MemberDto member, RedirectAttributes rttr, HttpSession session) {
		logger.info("mdelete");	
		
		String view = mServ.mdelete(member, rttr, session);
		
		return view;
	}
		

	
} //class end
