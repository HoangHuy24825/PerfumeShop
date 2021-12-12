package com.mycompany.perfumeshop.utils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class DateUtils {

	public static SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

	public static Date parseToDate(String str) throws ParseException {
		return sdf.parse(str);
	}
}
