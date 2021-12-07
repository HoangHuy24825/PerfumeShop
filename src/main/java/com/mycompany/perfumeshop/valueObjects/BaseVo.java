package com.mycompany.perfumeshop.valueObjects;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

@AllArgsConstructor
@NoArgsConstructor
@Getter
@Setter
public class BaseVo<E> {

	private List<E> listEntity;

	private int currentPage;

	private int totalPage;
}
