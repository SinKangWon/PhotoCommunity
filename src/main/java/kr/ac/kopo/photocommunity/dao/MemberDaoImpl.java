package kr.ac.kopo.photocommunity.dao;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.photocommunity.model.Member;

@Repository
public class MemberDaoImpl implements MemberDao {
	
	@Autowired
	SqlSession sql;

	@Override
	public Member login(Member member) {
		return sql.selectOne("member.login", member);
	}

	@Override
	public void signup(Member item) {
		sql.insert("member.signup", item);		
	}

	@Override
	public int checkId(String id) {
		return sql.selectOne("member.check_id", id);
	}

	@Override
	public Long findByMemberId(String id) {
		return sql.selectOne("member.findByMemberId", id);
	}

}
