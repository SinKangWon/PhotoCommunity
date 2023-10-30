package kr.ac.kopo.photocommunity.model;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
public class Attach {
	private Long attachNum;
	private Long boardNum;
	private String filename;
}
