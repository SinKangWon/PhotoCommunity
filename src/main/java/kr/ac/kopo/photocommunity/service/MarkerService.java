package kr.ac.kopo.photocommunity.service;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Marker;

public interface MarkerService {

	List<Marker> List();

	Long findMarkerInfo(Marker markerInfo);

	void add(Marker markerInfo);

}
