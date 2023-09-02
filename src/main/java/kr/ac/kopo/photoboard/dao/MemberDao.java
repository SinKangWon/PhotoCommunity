package kr.ac.kopo.photoboard.dao;

import kr.ac.kopo.photoboard.model.Member;

public interface MemberDao {

	Member login(Member member);

	void signup(Member item);

	int checkId(String id);

}
