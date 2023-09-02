package kr.ac.kopo.photoboard.dao;

import java.util.List;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.photoboard.model.Board;

@Repository
public class BoardDaoImpl implements BoardDao {

	@Autowired
	SqlSession sql;
	
	@Override
	public void add(Board item) {
			sql.insert("board.add", item);
		
	}
	
	@Override
	public void delete(int id) {
			sql.delete("board.delete",id);
		
	}

	@Override
	public List<Board> getList(int coordId) {
		return sql.selectList("board.getList", coordId);
	}

	@Override
	public Board item(int id) {
		return  sql.selectOne("board.item", id);
	}

	

}
