package kr.ac.kopo.photocommunity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.photocommunity.dao.CoordDao;
import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Coord;

@Service
public class CoordServiceImpl implements CoordService {
	
	@Autowired
	CoordDao dao;
	
	
	@Override
	public List<Coord> List() {
		return dao.List();
	}


	@Override
	public Board checkCoord(Board item) {
		return dao.checkCoord(item);
	}


	@Override
	public void add(Board item) {
		 dao.add(item);
		
	}

}
