package kr.ac.kopo.photocommunity.service;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;

public interface BoardService {

	void add(Board item);
	
	void delete(int id);

	List<Board> getList(int coordId);

	Board item(int id);


}
