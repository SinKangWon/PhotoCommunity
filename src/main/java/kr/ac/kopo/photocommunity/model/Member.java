package kr.ac.kopo.photocommunity.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Member {
	private Long memberNum;
	private String id;
	private String passwd;
	private String name;
	private String email;

}
