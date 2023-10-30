package kr.ac.kopo.photocommunity.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Marker;

@Repository
public class MarkerDaoImpl implements MarkerDao {

	@Autowired
	SqlSession sql;

	@Override
	public List<Marker> List(){
		return sql.selectList("marker.List");
	}

	@Override
	public Long findMarkerInfo(Marker markerInfo) {
		return sql.selectOne("marker.markerInfo", markerInfo);
	}

	@Override
	public void add(Marker markerInfo) {
		sql.insert("marker.insert",markerInfo);
		
	}

}
