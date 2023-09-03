package kr.ac.kopo.photocommunity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import kr.ac.kopo.photocommunity.dao.AttachDao;
import kr.ac.kopo.photocommunity.dao.BoardDao;
import kr.ac.kopo.photocommunity.model.Attach;
import kr.ac.kopo.photocommunity.model.Board;
@Service
public class BoardServiceImpl implements BoardService {

	@Autowired
	BoardDao dao;
	
	@Autowired
	AttachDao attachDao;
	
	@Override
	public List<Board> getList(int coordId) {
		
		return dao.getList(coordId);
	}
	
	@Override
	@Transactional
	public void add(Board item) {
		dao.add(item);
		
		if(item.getAttachs() != null) {
			for(Attach attach : item.getAttachs()) {
				attach.setBoardId(item.getId());
				
				attachDao.add(attach);
			}
		}
	}
	
	@Override
	public void delete(int id) {
		dao.delete(id);
	
	}
	@Override
	public Board item(int id) {
		return dao.item(id);
	}
	

	
	
	
}	
	