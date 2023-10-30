package kr.ac.kopo.photocommunity.service;

import java.io.IOException;
import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;

public interface BoardService {

	void add(Board item);
	
	void delete(Long BoardNum);

	List<Board> getList(Long MarkerNum);

	Board item(Long markerNum);


}
