package kr.co.sun.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpSession;

import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import kr.co.sun.domain.httpConnection;
import lombok.extern.log4j.Log4j;

@Log4j
@Controller
public class CommonController {

	@GetMapping("/accessError")
	public void accessDenied(Authentication auth, Model model) {
		
		log.info("access Denied : " + auth);
		
		model.addAttribute("msg", "Access Denied");	
	}
	
	@GetMapping("/customLogin")
	public void loginInupt(String error, String logout, Model model, HttpSession session) {
		//String access_token = (String)session.getAttribute("access_token");
		//System.out.println("kakaoToken :: " + access_token); // 카카오 토큰 콘솔에 출력
		
		log.info("error: " + error);
		log.info("logout: " +logout);
		
		if (error != null) {
			model.addAttribute("error", "Login Error Check Your Account");
		}
		
		if (logout != null) {
			model.addAttribute("logout", "Logout!!");
		}
		
	}
	
	@RequestMapping("/customLogout")
    public void access(HttpSession session) throws IOException {
        
        String kakaoToken = (String)session.getAttribute("kakaoToken");
        System.out.println("kakaoToken :: " + kakaoToken); // 카카오 토큰 콘솔에 출력
        
        Map<String, String> map = new HashMap<String, String>();
        map.put("Authorization", "Bearer " + kakaoToken);
        
        httpConnection conn = httpConnection.getInstance();
        
        String result = conn.HttpPostConnection("https://kapi.kakao.com/v1/user/logout", map).toString();
        System.out.println(result); 
        
    }
	

	
}










