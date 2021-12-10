package com.mycompany.perfumeshop.valueObjects;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class PageVo<E> {

	private List<E> content;
	private Integer currentPage;
	private Integer totalPage;

}
