package kr.ac.kopo.photocommunity.dao;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Coord;

public interface CoordDao {

	List<Coord> List();

	Board checkCoord(Board item);

	void add(Board item);

	

}
