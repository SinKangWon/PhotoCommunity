package kr.ac.kopo.photoboard.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpSession;

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

import kr.ac.kopo.photoboard.model.Attach;
import kr.ac.kopo.photoboard.model.Board;
import kr.ac.kopo.photoboard.model.Coord;
import kr.ac.kopo.photoboard.model.Member;
import kr.ac.kopo.photoboard.service.BoardService;
import kr.ac.kopo.photoboard.service.CoordService;
import kr.ac.kopo.photoboard.service.MemberService;

@Controller
public class RootController {
	final String uploadPath = "c://Users/ekdrm/PCupload/";
	@RequestMapping("/")
	public String index(Model model) {
		
		List<Coord> coordlist = coordService.List(); // list 라는 이림의 배열을 선언한 후 그 요소는 list 메소드를 service요청하여 지정한다
		
		model.addAttribute("listB", coordlist); //boardlist 변수를 "list"라는 속성으로 Attribute에 add(추가)한다.
		
		return "index";
	
	}

	@Autowired
	BoardService boardService;

	@Autowired
	MemberService memberService;

	@Autowired
	CoordService coordService;

	/*
	 * @RequestMapping("/list") //클라이언트가 "요청(Request)"한 url을 분석하여 /list로 접속하였을 경우 아래
	 * 메소드 실행 public String list(Model model) { // list문자값을 반환하는 list 메소드 이며,
	 * model객체를 가지고 있다 List<Board> list = boardService.getList(); //list 라는 이림의 배열을
	 * 선언한 후 그 요소는 list 메소드를 service요청하여 지정한다 
	 * for(Board target : list) {
	 * System.out.println(target.getId()); 
	 * System.out.println(target.getTag());
	 * System.out.println(target.getTitle());
	 * System.out.println(target.getXcoord());
	 * System.out.println(target.getYcoord());
	 * System.out.println(target.getRegDate()); } 
	 * model.addAttribute("list", list);
	 * //list 변수를 list라는 이름의 Attribute에 저장한다.
	 * 
	 * return "list"; }
	 */
	@ResponseBody
	@GetMapping("/markerDetail/{coordId}")
	public List<Board> markerDetail(@PathVariable int coordId) {
		
		return boardService.getList(coordId);
	}
	
	@RequestMapping("/detail/{id}")
	public String detail(@PathVariable int id, Model model) {
		
		Board item = boardService.item(id);
		
		model.addAttribute("item", item);
		
		List<Attach> attachs = item.getAttachs();
		
		for (Attach attach : attachs) {
			String filename = attach.getFilename();
			System.out.println(filename);
			System.out.println(model);
		}
		
		
		return "detail";
	}
	
	@GetMapping("/add") // 클라이언트가 get방식으로 요청하였을 때 아래 매소드 실행
	public String add(Model model) {// add 문자값을 반환해주는 add메소드
		
		return "add";

	}
	@PostMapping("/add")
	public String add(Board item, @SessionAttribute Member member) {
		item.setMemberId(member.getId() );
		Board fakeBoard = coordService.checkCoord(item);
		
		item.setCoordId(fakeBoard.getCoordId());
		item.setCnt(fakeBoard.getCnt());
		
		if(item.getCnt()==0) {
			coordService.add(item);
		}
		
		
		
		try {
			List<Attach> list = new ArrayList<Attach>();
			
			for(MultipartFile attach : item.getAttach()) {
				if(attach != null && !attach.isEmpty()) {
					String filename = attach.getOriginalFilename();
					
					attach.transferTo(new File(uploadPath + filename));					
						
					Attach attachItem = new Attach();
					attachItem.setFilename(filename);
	
					list.add(attachItem);
				}					
			}
				
			item.setAttachs(list);
			
			boardService.add(item);
		} catch (Exception e) {
			e.printStackTrace(); //예외가 생긴곳과 메세지를 알려주는 역할
		}
		
		return "redirect:.";
	}

	@RequestMapping("/delete")
	public String delete(int id) {
		boardService.delete(id); // boardservice에 boardnum delete요청

		return "index"; // list로 돌어와
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

	@ResponseBody // ? 왜 여기서 responsebody를 썼지?
	@GetMapping("/checkId/{id}")
	public String checkId(@PathVariable String id) {
		if (memberService.checkId(id))
			return "OK";
		else
			return "FAIL";
	}
	
	
}
