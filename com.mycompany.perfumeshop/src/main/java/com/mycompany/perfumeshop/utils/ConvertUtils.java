package com.mycompany.perfumeshop.utils;

import java.math.BigDecimal;

public class ConvertUtils {

	public static Integer convertStringToInt(String number, Integer typeError) {
		try {
			int result = Integer.parseInt(number);
			return result;
		} catch (Exception e) {
			return typeError;
		}
	}

	public static BigDecimal convertStringToBigDecimal(String number, BigDecimal typeError) {
		try {
			BigDecimal result = new BigDecimal(number);
			return result;
		} catch (Exception e) {
			return typeError;
		}
	}
}
