package kr.ac.kopo.photoboard.dao;

import kr.ac.kopo.photoboard.model.Attach;

public interface AttachDao {

	void add(Attach attach);

	void deleteByGameId(int gameId);

	boolean delete(int id);

}
