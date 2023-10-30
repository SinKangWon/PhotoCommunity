package kr.ac.kopo.photocommunity.dao;

import java.util.List;

import kr.ac.kopo.photocommunity.model.Board;
import kr.ac.kopo.photocommunity.model.Marker;

public interface MarkerDao {

	List<Marker> List();

	Long findMarkerInfo(Marker markerInfo);

	void add(Marker markerInfo);

}
