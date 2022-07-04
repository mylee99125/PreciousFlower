package com.pf.flower;


import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
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

import com.pf.flower.dto.ListDto;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.NoticeDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.PfileDto;
import com.pf.flower.dto.apListDto;
import com.pf.flower.dto.mListDto;
import com.pf.flower.dto.nListDto;
import com.pf.flower.dto.oListDto;
import com.pf.flower.dto.rmListDto;
import com.pf.flower.service.AdminService;

@Controller
public class AdminController {
	
	private static final Logger logger = LoggerFactory.getLogger(AdminController.class);
	
	@Autowired
	private AdminService aServ;
	
	private ModelAndView mv;
	
	@GetMapping("/aa_plist")
	public ModelAndView aa_plist(apListDto aplist, 
			HttpSession session) {
		logger.info("aa_plist()");
		
		mv = aServ.getProductList(aplist, session);
		
		return mv;
	}
	
	@GetMapping("/aa_olist")
	public ModelAndView aa_olist(oListDto olist,
			HttpSession session) {
		logger.info("aa_olist()");
		
		mv = aServ.getOrderList(olist, session);
		
		return mv;
	}
	
	@GetMapping("/aa_pinsert")
	public String aa_pinsert() {
		logger.info("aa_pinsert()");
		
		return "aa_pinsert";
	}
	
	@GetMapping(value = "/codeCheck",
			produces = "application/text; charset=UTF-8")
	@ResponseBody
	public String codeCheck(String p_code) {
		logger.info("codeCheck() - pcode: " + p_code);
		
		String res = aServ.codeCheck(p_code);
		//DB에 같은 코드가 있는지 여부 확인
		
		return res;
	}
	
	//멀티파트 데이터를 처리할 경우 첫번째 매개변수는 MultipartHttpServletRequest
	@PostMapping("/productInsert")
	public String productInsert(MultipartHttpServletRequest multi,
			HttpSession session, RedirectAttributes rttr) {
		logger.info("productInsert()");
		
		String view = aServ.productInsert(multi, rttr);
		
		return view;
	}
	
	@GetMapping("/aa_pupdate")
	public ModelAndView aa_pupdate(String p_code) {
		logger.info("pupdate():pcode - " + p_code);
		
		mv = aServ.updateFrm(p_code);
		
		return mv;
	}
	
	@PostMapping(value="/delFile",
			produces="application/json; charset=UTF-8")
	@ResponseBody
	public Map<String, List<PfileDto>> delFile(String sysname, String p_code,
			HttpSession session) {
		logger.info("delFile()-sysname : " + sysname);
		
		Map<String, List<PfileDto>> fmap = 
				aServ.fileDelete(sysname, p_code, session);
		
		return fmap; //jackson 라이브러리의 객체가 json object로 변환
	}
	
	@PostMapping("/pupdate")
	public String productUpdate(MultipartHttpServletRequest multi,
			RedirectAttributes rttr) {
		logger.info("productUpdate()");
		
		String view = aServ.productUpdate(multi, rttr);
		
		return view;
	}
	
	@GetMapping("/pdelete")
	public String productDelete(String p_code, RedirectAttributes rttr,
			String sysname, HttpSession session) {
		logger.info("productDelete()-p_code : "+p_code);
		
		String view = aServ.productDelete(p_code, rttr, sysname, session);
		
		return view;
	}
	
	@GetMapping("/aa_ocontents")
	public ModelAndView aa_ocontents(String o_num, OrderDto order) {
		logger.info("aa_ocontents() - o_num : "+o_num);
		
		mv = aServ.orderSelect(o_num, order);
		
		return mv;
	}
	
	@GetMapping("/oupdate")
	public String orderUpdate(OrderDto order, HttpServletRequest request, 
			RedirectAttributes rttr) {
		logger.info("orderUpdate() - o_num : " + order.getO_num());
		
		String view = aServ.orderUpdate(order, request, rttr);
		
		return view;
	}
	
	//Member
	@GetMapping("/aa_mlist")
	public ModelAndView aa_mlist(mListDto mlist, HttpSession session) {
		logger.info("aa_mlist()");
		
		mv = aServ.getMemberList(mlist, session);
		
		return mv;
	}
	
	@GetMapping("/mlist")
	public ModelAndView memberList(mListDto mlist, HttpSession session) {
		logger.info("mlist()");
		
		mv = aServ.getMemberList(mlist, session);
		
		return mv;
	}
	
	@GetMapping("/aa_mcontents")
	public ModelAndView aa_mcontents(String m_id, OrderDto order) {
		logger.info("aa_mcontents() - m_id: " + m_id);

		mv = aServ.getmContents(m_id, order);
		
		return mv;
	}
	
	@GetMapping("/memberUpdate")
	public String memberUpdate(MemberDto member, String m_id, RedirectAttributes rttr) {
		logger.info("memberUpdate() - m_id: " + m_id);
		
		String view = aServ.memberUpdate(member, m_id, rttr);
		
		return view;
	}
	
	@GetMapping("/memberDelete")
	public String memberDelete(String m_id, RedirectAttributes rttr) {
		logger.info("memberDelete() - m_id: " + m_id);
		
		String view = aServ.memberDelete(m_id, rttr);
		
		return view;
	}
	
	@GetMapping("aa_rmlist")
	public ModelAndView aa_rmlist(rmListDto rmlist, HttpSession session) {
		logger.info("aa_rmlist()");
		
		mv = aServ.getRmemberList(rmlist, session);
		
		return mv;
	}
	
	@GetMapping("/rmlist")
	public ModelAndView rmemberList(rmListDto rmlist, HttpSession session) {
		logger.info("rmlist()");
		
		mv = aServ.getRmemberList(rmlist, session);
		
		return mv;
	}
	
	@GetMapping("aa_rmcontents")
	public ModelAndView aa_rmcontents(String r_id, OrderDto order) {
		logger.info("aa_rmcontents() - r_id " + r_id);
		
		mv = aServ.getrmContents(r_id, order);
		
		return mv;
	}
	
	@GetMapping("/rmemberDelete")
	public String rmemberDelete(String r_id, RedirectAttributes rttr) {
		logger.info("memberDelete() - r_id: " + r_id);
		
		String view = aServ.rmemberDelete(r_id, rttr);
		
		return view;
	}
	
	@GetMapping("/aa_notice")
	public ModelAndView aa_notice(nListDto nlist, HttpSession session) {
		logger.info("aa_notice()");
		
		mv = aServ.getNoticeList(nlist, session);
		
		return mv;
	}
	
	@GetMapping("/nlist")
	public ModelAndView nlist(nListDto nlist, HttpSession session) {
		logger.info("nlist()");
		
		mv = aServ.getNoticeList(nlist, session);
		
		return mv;
	}
	
	@GetMapping("/aa_ninsert")
	public String aa_ninsert() {
		logger.info("aa_ninsert()");
		
		return "aa_ninsert";
	}
	
	@PostMapping("/noticeInsert")
	public String noticeInsert(NoticeDto notice, RedirectAttributes rttr) {
		logger.info("noticeInsert()");
		
		String view = aServ.noticeInsert(notice, rttr);
		
		return view;
	}
	
	@GetMapping("/aa_ncontents")
	public String aa_ncontents() {
		logger.info("aa_ncontents()");
		return "aa_ncontents";
	}
	
	@GetMapping("/noticeContents")
	public ModelAndView noticeContents(Integer n_num) {
		logger.info("noticeContents() - n_num: " + n_num);
		
		mv = aServ.getnContents(n_num);
		
		return mv;
	}
	
	@GetMapping("/aa_nupdate")
	public ModelAndView aa_nupdate(int n_num) {
		logger.info("aa_nupdate() - n_num: " + n_num);
		
		mv = aServ.aa_nupdate(n_num);
		
		return mv;
	}
	
	@PostMapping("/noticeUpdate")
	public String noticeUpdate(NoticeDto notice, int n_num, RedirectAttributes rttr) {
		logger.info("noticeUpdate()");
		
		String view = aServ.noticeUpdate(notice, n_num, rttr);
		
		return view;
	}

	@GetMapping("/nDelete")
	public String noticeDelete(int n_num, RedirectAttributes rttr) {
		logger.info("noticeDelete() - n_num: " + n_num);
		
		String view = aServ.noticeDelete(n_num, rttr);
		
		return view;
	}
	
}//class end






