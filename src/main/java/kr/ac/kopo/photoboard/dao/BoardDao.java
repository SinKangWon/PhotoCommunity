package kr.ac.kopo.photoboard.dao;

import java.util.List;

import kr.ac.kopo.photoboard.model.Board;

public interface BoardDao {

	void add(Board item);

	List<Board> getList(int coordId);

	void delete(int id);

	Board item(int id);


}
