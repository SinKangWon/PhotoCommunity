package kr.ac.kopo.photocommunity.dao;

import kr.ac.kopo.photocommunity.model.Attach;

public interface AttachDao {

	void add(Attach attach);

	void deleteByGameId(int gameId);

	boolean delete(int id);

}
