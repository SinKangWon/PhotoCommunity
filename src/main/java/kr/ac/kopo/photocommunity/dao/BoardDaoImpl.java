package kr.ac.kopo.photocommunity.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.photocommunity.model.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	SqlSession sql;
	
	@Override
	public void add(Board item) {
			sql.insert("board.add", item);
	}
	
	@Override
	public void delete(Long boardNum) {
			sql.delete("board.delete",boardNum);
		
	}

	@Override
	public List<Board> getList(Long boardNum) {
		return sql.selectList("board.getList", boardNum);
	}

	@Override
	public Board item(Long boardNum) {
		return  sql.selectOne("board.item", boardNum);
	}

	

}
