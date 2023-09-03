package kr.ac.kopo.photocommunity.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Coord;

@Repository
public class CoordDaoImpl implements CoordDao {

	@Autowired
	SqlSession sql;

	@Override
	public List<Coord> List(){
		return sql.selectList("coord.List");
	}

	@Override
	public Board checkCoord(Board item) {
		return sql.selectOne("coord.check", item);
	}

	@Override
	public void add(Board item) {
		sql.insert("coord.insert",item);
		
	}
}
