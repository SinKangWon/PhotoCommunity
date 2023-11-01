package kr.ac.kopo.photocommunity.service;

import java.io.IOException;
import java.util.List;

import kr.ac.kopo.photocommunity.global.FileUpload;
import kr.ac.kopo.photocommunity.model.Marker;
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
	MarkerService markerService;

	@Autowired
	BoardDao dao;
	
	@Autowired
	AttachDao attachDao;
	
	@Override
	public List<Board> getList(Long boardNum) {
		
		return dao.getList(boardNum);
	}
	
	@Override
	@Transactional
	public void add(Board item) {
		Marker markerInfo = new Marker();
		markerInfo.setLat(item.getLat());
		markerInfo.setLon(item.getLon());
		markerInfo.setAddress(item.getAddress());

		markerInfo.setMarkerNum(markerService.findMarkerInfo(markerInfo));
		if (markerInfo.getMarkerNum() == null) {
			markerService.add(markerInfo);
			markerInfo.setMarkerNum(markerService.findMarkerInfo(markerInfo));
		}

		item.setMarkerNum(markerInfo.markerNum);
		item.setLat(markerInfo.lat);
		item.setLon(markerInfo.lon);

		item.setAttachs(FileUpload.filesUpload(item.getAttach()));

		item.setBoardNum(dao.add(item));
		if(item.getAttachs() != null) {
			for(Attach attach : item.getAttachs()) {
				attach.setBoardNum(item.getBoardNum());

				attachDao.add(attach);
			}
		}


	}
	
	@Override
	public void delete(Long boardNum) {
		dao.delete(boardNum);
	
	}
	@Override
	public Board item(Long boardNum) {
		return dao.item(boardNum);
	}
	

	
	
	
}	
	