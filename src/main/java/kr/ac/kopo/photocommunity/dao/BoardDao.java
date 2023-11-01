package kr.ac.kopo.photocommunity.dao;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;

public interface BoardDao {

	void add(Board item);

	List<Board> getList(Long markerNum);

	void delete(Long boardNum);

	Board item(Long boardNum);


}
