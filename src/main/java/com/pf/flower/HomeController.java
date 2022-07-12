package com.pf.flower;

import java.util.HashMap;
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
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import com.pf.flower.dao.AdminDao;
import com.pf.flower.dto.AdminDto;
import com.pf.flower.dto.CartDto;
import com.pf.flower.dto.MemberDto;
import com.pf.flower.dto.OrderDto;
import com.pf.flower.dto.ProductDto;
import com.pf.flower.dto.ReviewDto;
import com.pf.flower.dto.VisitDto;
import com.pf.flower.dto.hnListDto;
import com.pf.flower.dto.pListDto;
import com.pf.flower.service.AdminService;
import com.pf.flower.service.MainService;

@Controller
public class HomeController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@Autowired
	private AdminService aServ;
	
	@Autowired
	private MainService mServ;
	
	@Autowired
	private AdminDao aDao;
	
	private ModelAndView mv;
	
	@GetMapping("/")
	public String home(VisitDto visit) {
		logger.info("home()");
		
		aServ.visitCount(visit);
		
		return "home";
	}
	
	@GetMapping("/daycount")
	public String daycount() {
		logger.info("daycount()");
		
		return "daycount";
	}
	
	@PostMapping("/addcart")
	public String addcart(HttpServletRequest request, 
			RedirectAttributes rttr) {
		logger.info("addcart()");

		String view = mServ.addcart(request, rttr);

		return view;
	}
	
	@PostMapping("/quickorder")
	public String quickorder(HttpServletRequest request, 
			RedirectAttributes rttr) {
		logger.info("quickorder()");
		
		String view = mServ.quickorder(request, rttr);
		
		return view;
	}
	
	@GetMapping("/cart")
	public ModelAndView cart(CartDto cart, HttpSession session) {
		logger.info("cart()");
		
		mv = mServ.getCartList(cart, session);
		
		return mv;
	}
	
	@GetMapping("/delCart")
	public String delCart(int c_num, RedirectAttributes rttr) {
		logger.info("delCart() - c_num : " + c_num);
		
		String view = mServ.cartDelete(c_num, rttr);
		
		return view;
	}
	
	@GetMapping("join")
	public String join() {
		logger.info("join()");
		
		return "join"; 
	}
	
	@GetMapping("/login")
	public String login() {
		logger.info("login()"); {
			
			return "login"; 
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		logger.info("logout()");
		
		String view = mServ.logout(session);
		
		return view;
	}
	
	@GetMapping("/f_product")
	public ModelAndView f_product(pListDto plist, HttpSession session) {
		logger.info("f_product()");
		
		mv = mServ.ProductList(plist, session);
		
		return mv;
	}
	
	@GetMapping("/f_contents")
	public ModelAndView f_contents(String p_code) {
		logger.info("f_contents() - p_code : "+p_code);
		
		mv = mServ.fcontents(p_code);
		
		return mv;
	}
	
	@GetMapping("/about")
	public String about() {
		logger.info("about()");
		
		return "about";
	}
	
	@GetMapping("/refund")
	public ModelAndView refund(String od_onum, String od_mid) {
		logger.info("refund()");
		
		mv = mServ.refundcontents(od_onum, od_mid);
		
		return mv;
	}
	
	@GetMapping("/notice")
	public ModelAndView notice(hnListDto hnlist, HttpSession session) {
		logger.info("notice()");
		
		mv = mServ.getHomenList(hnlist, session);
		
		return mv;
	}
	
	@GetMapping("/hnlist")
	public ModelAndView hnlist(hnListDto hnlist, HttpSession session) {
		logger.info("hnlist()");
		
		mv = mServ.getHomenList(hnlist, session);
		
		return mv;
	}
	
	@GetMapping("/n_contents")
	public String n_contents() {
		logger.info("n_contents()");
		
		return "n_contents";
	}
	
	@GetMapping("/hnContents")
	public ModelAndView hnoticeContents(Integer n_num) {
		logger.info("hnoticeContents() - hn_num: " + n_num);
		
		mv = mServ.gethnContents(n_num);
		
		return mv;
	}

	@GetMapping("/Order")
	public ModelAndView selectcorder(HttpSession session) {
		logger.info("selectcorder()");

		mv = mServ.selectCorder(session);

		return mv;
	}
	
	@PostMapping(value = "/forder", produces = "application/json; charset=utf-8")
	@ResponseBody
	public Map<String, String> finalOrder (OrderDto order, String o_mid, 
			HttpServletRequest request, RedirectAttributes rttr) {
		logger.info("finalOrder()");

		String view = mServ.finalOrder(order, o_mid, request, rttr);
		
		Map<String, String> rmap = new HashMap<String, String>();
		rmap.put("res", view);
		
		return rmap;
	}
	
	@GetMapping("/orderList")
	public ModelAndView orderList(OrderDto order, HttpSession session) {
		logger.info("orderList()");
		
		mv = mServ.getMoList(order, session);
		
		return mv;
	}
	
	@GetMapping("/o_contents")
	public ModelAndView o_contents(String od_onum, OrderDto order) {
		logger.info("o_contents()" + od_onum);
		
		mv = mServ.odcontents(od_onum, order);
		
		return mv;
	}
	
	@GetMapping("/ordersuccess")
	public String ordersuccess() {
		logger.info("ordersuccess()");

		return "ordersuccess";
	}

	//리뷰 페이지 불러오기 , 봐서 세션 삭제
	@GetMapping("/review")
	public ModelAndView selectProduct(String p_code, ProductDto product, HttpSession session) {
		logger.info("review()" + p_code);

		mv = mServ.selectProduct(p_code, product, session);

		return mv;
	}


	@PostMapping("/reviewWrite")
	public String boardWrite(ReviewDto review, RedirectAttributes rttr) {
		logger.info("reviewWrite()");

		String view = mServ.reviewWrite(review, rttr);

		return view;
	}
	
	@PostMapping("/refsubmit")
	public String refsubmit(OrderDto order, RedirectAttributes rttr) {
		logger.info("refsubmit()");
		
		String view = mServ.refsubmit(order, rttr);
		
		return view;
	}

}//class end
