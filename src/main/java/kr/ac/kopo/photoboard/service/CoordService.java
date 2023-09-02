package kr.ac.kopo.photoboard.service;

import java.util.List;

import kr.ac.kopo.photoboard.model.Board;
import kr.ac.kopo.photoboard.model.Coord;

public interface CoordService {

	List<Coord> List();

	Board checkCoord(Board item);

	void add(Board item);


}
