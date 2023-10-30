package kr.ac.kopo.photocommunity.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

import kr.ac.kopo.photocommunity.service.MarkerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.SessionAttribute;
import org.springframework.web.multipart.MultipartFile;

import kr.ac.kopo.photocommunity.model.Attach;
import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Marker;
import kr.ac.kopo.photocommunity.model.Member;
import kr.ac.kopo.photocommunity.service.BoardService;
import kr.ac.kopo.photocommunity.service.MemberService;

@Controller
public class RootController {
	@RequestMapping("/")
	public String index(Model model) {
		List<Marker> markerList = markerService.List();
		model.addAttribute("listB", markerList);
		return "index";
	
	}

	@Autowired
	BoardService boardService;

	@Autowired
	MemberService memberService;

	@Autowired
	MarkerService markerService;


	@ResponseBody
	@GetMapping("/markerDetail/{markerNum}")
	public List<Board> markerDetail(@PathVariable Long markerNum) {
		
		return boardService.getList(markerNum);
	}
	
	@RequestMapping("/detail/{boardNum}")
	public String detail(@PathVariable Long boardNum, Model model) {
		
		Board item = boardService.item(boardNum);
		
		model.addAttribute("item", item);
		
		return "detail";
	}
	
	@GetMapping("/add")
	public String add() {
		return "add";
	}

	@PostMapping("/add")
	public String add(Board item, @SessionAttribute Member member) {
		item.setMemberName(member.getName());

		boardService.add(item);

		return "redirect:.";
	}

	@RequestMapping("/delete")
	public String delete(Long boardNum) {
		boardService.delete(boardNum);
		
		return "index";
	}

	@GetMapping("/login")
	public String login() {
		return "login";
	}

	@PostMapping("/login")
	public String login(Member member, HttpSession session) {
		if (memberService.login(member)) {
			session.setAttribute("member", member);

			String targetUrl = (String) session.getAttribute("target_url");
			System.out.println("RootController: " + targetUrl);
			session.removeAttribute("target_url");

			if (targetUrl == null)
				return "redirect:.";
			else
				return "redirect:" + targetUrl;
		} 	else
			return "redirect:.";
	}

	@RequestMapping("/logout")
	public String logout(HttpSession session) {
		session.invalidate();

		return "redirect:.";
	}

	@GetMapping("/signup")
	public String signup() {
		return "index";
	}

	@PostMapping("/signup")
	public String signup(Member item) {

		memberService.signup(item);

		return "redirect:.";
	}

	@ResponseBody
	@GetMapping("/checkId/{id}")
	public String checkId(@PathVariable String id) {
		if (memberService.checkId(id))
			return "OK";
		else
			return "FAIL";
	}
	
	
}
