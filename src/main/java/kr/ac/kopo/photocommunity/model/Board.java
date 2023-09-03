package kr.ac.kopo.photocommunity.model;

import java.util.Date;
import java.util.List;

import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;



public class Board {
	private int id;
	private String title;
	private String contents;
	private String tag;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date regDate;
	private int coordId;
	private double latLngX;
	private double latLngY;
	private String latLngName;
	private String memberId;
	private String memberName;
	private String memberEmail;
	private List<MultipartFile> attach;
	private List<Attach> attachs;
	private int cnt;
	
	public List<Attach> getAttachs() {
		return attachs;
	}

	public void setAttachs(List<Attach> attachs) {
		this.attachs = attachs;
	}

	public List<MultipartFile> getAttach() {
		return attach;
	}

	public void setAttach(List<MultipartFile> attach) {
		this.attach = attach;
	}


	public String getContents() {
		return contents;
	}

	public void setContents(String contents) {
		this.contents = contents;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getRegDate() {
		return regDate;
	}

	public void setRegDate(Date regDate) {
		this.regDate = regDate;
	}

	public String getTag() {
		return tag;
	}

	public void setTag(String tag) {
		this.tag = tag;
	}

	public double getLatLngX() {
		return latLngX;
	}

	public void setLatLngX(double latLngX) {
		this.latLngX = latLngX;
	}

	public double getLatLngY() {
		return latLngY;
	}

	public void setLatLngY(double latLngY) {
		this.latLngY = latLngY;
	}

	public int getCoordId() {
		return coordId;
	}

	public void setCoordId(int coordId) {
		this.coordId = coordId;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMemberName() {
		return memberName;
	}

	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}

	public String getMemberEmail() {
		return memberEmail;
	}

	public void setMemberEmail(String memberEmail) {
		this.memberEmail = memberEmail;
	}

	public int getCnt() {
		return cnt;
	}

	public void setCnt(int cnt) {
		this.cnt = cnt;
	}

	public String getLatLngName() {
		return latLngName;
	}

	public void setLatLngName(String latLngName) {
		this.latLngName = latLngName;
	}

}
