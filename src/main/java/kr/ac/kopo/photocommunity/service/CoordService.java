package kr.ac.kopo.photocommunity.service;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Coord;

public interface CoordService {

	List<Coord> List();

	Board checkCoord(Board item);

	void add(Board item);


}
