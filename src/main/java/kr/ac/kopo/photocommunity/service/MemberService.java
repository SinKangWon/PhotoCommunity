package kr.ac.kopo.photocommunity.service;

import kr.ac.kopo.photocommunity.model.Member;

public interface MemberService {

	boolean login(Member member);

	void signup(Member item);

	boolean checkId(String id);

}
