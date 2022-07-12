package com.pf.flower.service;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.flower.dao.MainDao;
import com.pf.flower.dao.MemberDao;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.mListDto;
import com.pf.flower.util.MailUtils;
import com.pf.flower.util.mPagingUtil;
import com.pf.flower.util.tempKey;

import lombok.extern.java.Log;

@Service
@Log
public class MemberService {
	@Autowired
	private MemberDao mDao;
	
	private ModelAndView mv;

	private int mlistCnt = 5;

	@Autowired
	private BCryptPasswordEncoder pwdEncoder;

	@Autowired
	private JavaMailSender mailSender;

	// 회원 목록
	public ModelAndView getMemberList(mListDto mlist, HttpSession session) {
		mv = new ModelAndView();

		int mnum = mlist.getMpageNum();
		if (mnum == 0)
			mnum = 1;
		mlist.setMpageNum((mnum - 1) * mlistCnt);
		mlist.setMlistCnt(mlistCnt);

		List<MemberDto> mList = mDao.memberListSelect(mlist);

		mv.addObject("mList", mList);

		mlist.setMpageNum(mnum);
		String mpageHtml = getMpaging(mlist);
		mv.addObject("mpaging", mpageHtml);

		session.setAttribute("mpageNum", mlist.getMpageNum());
		if (mlist.getMcolname() != null) {
			session.setAttribute("mlist", mlist);
		} else {// 검색이 아닐 경우는 세션의 ListDto를 제거.
			session.removeAttribute("mlist");
		}

		mv.setViewName("aa_mlist");

		return mv;
	}

	// 회원목록 페이징
	private String getMpaging(mListDto mlist) {
		String mpageHtml = null;

		int mmaxNum = mDao.mcntSelect(mlist);
		int mpageCnt = 5;
		String mlistName = "mlist?";

		if (mlist.getMcolname() != null) {
			mlistName += "mcolname=" + mlist.getMcolname() + "&mkeyword=" + mlist.getMkeyword() + "&";
		}

		mPagingUtil mpaging = new mPagingUtil(mmaxNum, mlist.getMpageNum(), mlistCnt, mpageCnt, mlistName);

		mpageHtml = mpaging.makePaging();

		return mpageHtml;
	}
	
	// 아이디 중복 //
	public String midCheck(String mid) {
		String res = null;

		// 아이디가 중복이면 1, 아니면 0.
		int cnt = mDao.midCheck(mid);

		if (cnt == 0) {
			res = "ok";
		} else {
			res = "not";
		}

		return res;
	}
	// 아이디 중복 end //

	// 라이더 회원가입 //
	@Transactional
	public String memberInsert(MemberDto member, RedirectAttributes rttr) {
		String view = null;
		String msg = null;

		String encpwd = pwdEncoder.encode(member.getM_pwd());
		log.info("encpwd : " + encpwd);
		member.setM_pwd(encpwd);

		try {
			mDao.memberInsert(member);

			view = "redirect:/";
			msg = "가입 성공";
		} catch (Exception e) {
			e.printStackTrace();

			view = "redirect:/m_joinFrm";
			msg = "가입 실패";
		}

		rttr.addFlashAttribute("msg", msg);

		return view;
	}
	// 라이더 회원가입 end //

	// 라이더 이메일 인증 //

	public String memailConfirm(String memberemail) {
		String key = null;

		try {
			// 인증키 생성
			key = new tempKey().getKey(10, false); // 위에서 String 선언해주면 밑에서 다시 선언할 필요가 없다.
			log.info("인증번호 : " + key);

			// 메일 발송
			MailUtils sendMail = new MailUtils(mailSender);

			sendMail.setSubject("[회원가입 서비스 이메일 인증 입니다.]");
			sendMail.setText(new StringBuffer().append("<h1>회원 가입 메일인증 입니다</h1>").append("<br><br>")
					.append("홈페이지를 방문해주셔서 감사합니다").append("<br><br>").append("인증번호는 ").append(key).append("입니다.")
					.append("<br><br>").append("해당 인증번호를 인증번호 확인란에 기입해주세요.").toString());
			sendMail.setFrom("glc0420@gmail.com", "PreciousFlower");
			sendMail.setTo(memberemail);
			sendMail.send();

			log.info("이메일 : " + memberemail);

		} catch (Exception e) {
			e.printStackTrace();
		}
		return key;
	}

	// 라이더 이메일 인증 End //
	
	// 회원 로그인 프로세스 //
		public String mloginProc(MemberDto member, HttpSession session, RedirectAttributes rttr) {
			String view = null;
			String msg = null;

			String encPwd = mDao.pwdSelect(member.getM_id());

			if(encPwd != null) {
				//존재하는 아이디
				if(pwdEncoder.matches(member.getM_pwd(), encPwd)) {
					//로그인 성공 -> 세션에 로그인 정보를 저장
					//회원 정보(이름, 포인트, 등급이름) : mem 재활용
					member = mDao.hmemberSelect(member.getM_id());
					//세션에 DTO 저장.
					session.setAttribute("mb", member);

					//로그인 성공 후 게시판의 목록 페이지로 이동.
					//*************** 수정 필요 ******************* 리다이렉트 뷰 수정 !
					view = "redirect:/";
				}
				else {
					//로그인 실패(비번 오류)
					view = "redirect:/login";
					msg = "비밀번호가 일치하지 않습니다.";
				}
			}
			else {
				//아이디가 존재하지 않는 경우(회원이 아닌 경우)
				view = "redirect:/login";
				msg = "없는 아이디입니다.";
			}

			rttr.addFlashAttribute("msg", msg);

			return view;
		}
		
		// 회원 로그인 프로세스 end //

		
		
			
		//회원정보 불러오기(마이페이지)
				public ModelAndView mypage(HttpSession session) {
					mv = new ModelAndView();
					
					MemberDto mb = (MemberDto)session.getAttribute("mb");
					String m_id = mb.getM_id();
					
					MemberDto md = mDao.bringMember(m_id);
					
					mv.addObject("md", md);
					
					mv.setViewName("mypage");
					
					return mv;
				}
		
		//회원정보 수정 정보 불러오기 End
		
		
				@Transactional 
				public String memberUpdate(MemberDto member, MultipartHttpServletRequest multi, RedirectAttributes rttr) {
					String view = null;
					String msg = null;

					//getparameter는 name 값을 가져올 수 있음
					member.setM_id(multi.getParameter("m_id"));
					member.setM_pwd(multi.getParameter("m_pwd"));
					member.setM_phone(multi.getParameter("m_phone"));
					member.setM_email(multi.getParameter("m_email"));
					member.setM_addr1(multi.getParameter("m_addr1"));
					member.setM_addr2(multi.getParameter("m_addr2"));
					member.setM_addr3(multi.getParameter("m_addr3"));
					
					String encPwd = mDao.pwdSelect(member.getM_id());
					
					if(pwdEncoder.matches(member.getM_pwd(), encPwd)) {

					try {

						mDao.memberUpdate(member);

						view = "redirect:/mypage";
						msg = "수정 성공";

					} catch (Exception e) {
						e.printStackTrace();

						view = "redirect:/myPage";
						msg = "수정 실패";
					}
					} else {
						view = "redirect:/mypage";
						msg = "비밀번호를 다시 확인해주세요";
					}	
					

					rttr.addFlashAttribute("msg", msg);

					return view;
				}
				
				//회원 탈퇴
				@Transactional
				public String mdelete(MemberDto member, RedirectAttributes rttr, HttpSession session) {
					String view = null;
					String msg = null;
					
					String encPwd = mDao.pwdSelect(member.getM_id());
					
				if(pwdEncoder.matches(member.getM_pwd(), encPwd)) {
					
					try {
						
						session.invalidate();
						mDao.mdelete(member);
						
					    view = "redirect:/"; //최종 수정은 메인 홈페이지 메인으로
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
		

} // class end
