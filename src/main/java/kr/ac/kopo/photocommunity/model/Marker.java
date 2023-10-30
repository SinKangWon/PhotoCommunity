package kr.ac.kopo.photocommunity.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class Marker {
	public Long markerNum;
	//위도
	public Double lat;
	//경도
	public Double lon;
	public String address;
	
}