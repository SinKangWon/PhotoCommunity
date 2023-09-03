package kr.ac.kopo.photocommunity.model;

public class Coord {
	public int coordId;
	public String latLngX;
	public String latLngY;
	
	public String getLatLngX() {
		return latLngX;
	}
	public void setLatLngX(String latLngX) {
		this.latLngX = latLngX;
	}
	public String getLatLngY() {
		return latLngY;
	}
	public void setLatLngY(String latLngY) {
		this.latLngY = latLngY;
	}
	public int getCoordId() {
		return coordId;
	}
	public void setCoordId(int coordId) {
		this.coordId = coordId;
	}

	
}