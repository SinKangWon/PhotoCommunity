package kr.ac.kopo.photocommunity.dao;

import kr.ac.kopo.photocommunity.model.Member;

public interface MemberDao {

	Member login(Member member);

	void signup(Member item);

	int checkId(String id);

    Long findByMemberId(String id);
}
