package com.mycompany.perfumeshop.utils;

public class ConvertUtils {

	public static Integer convertStringToInt(String number, Integer typeError) {
		try {
			int result = Integer.parseInt(number);
			return result;
		} catch (Exception e) {
			return typeError;
		}
	}
}
