package kr.ac.kopo.photocommunity.dao;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;

public interface BoardDao {

	void add(Board item);

	List<Board> getList(int coordId);

	void delete(int id);

	Board item(int id);


}
