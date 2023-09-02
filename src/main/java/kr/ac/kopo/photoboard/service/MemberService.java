package kr.ac.kopo.photoboard.service;

import kr.ac.kopo.photoboard.model.Member;

public interface MemberService {

	boolean login(Member member);

	void signup(Member item);

	boolean checkId(String id);

}
