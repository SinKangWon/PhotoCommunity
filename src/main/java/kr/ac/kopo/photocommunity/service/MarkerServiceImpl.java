package kr.ac.kopo.photocommunity.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.ac.kopo.photocommunity.dao.MarkerDao;
import kr.ac.kopo.photocommunity.model.Marker;

@Service
public class MarkerServiceImpl implements MarkerService {
	
	@Autowired
	MarkerDao dao;
	
	
	@Override
	public List<Marker> List() {
		return dao.List();
	}

	@Override
	public Long findMarkerInfo(Marker markerInfo) {
		return dao.findMarkerInfo(markerInfo);
	}



	@Override
	public void add(Marker markerInfo) {
		 dao.add(markerInfo);
		
	}


}
