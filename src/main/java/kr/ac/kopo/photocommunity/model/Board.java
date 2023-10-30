package kr.ac.kopo.photocommunity.model;

import java.util.Date;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.web.multipart.MultipartFile;

import com.fasterxml.jackson.annotation.JsonFormat;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor

public class Board {
	private Long boardNum;
	private String title;
	private String contents;
	private String tag;
	@JsonFormat(pattern = "yyyy-MM-dd", timezone = "Asia/Seoul")
	private Date regDate;

	private Long markerNum;
	private Double lat;
	private Double lon;
	private String address;

	private String memberId;
	private String memberName;
	private String memberEmail;

	private List<MultipartFile> attach;
	private List<Attach> attachs;

	private Long cnt;
}
