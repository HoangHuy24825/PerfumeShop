package com.mycompany.perfumeshop.utils;

import org.springframework.web.multipart.MultipartFile;

public class Validate {

	public static boolean isNumber(String number) {
		return number.matches(Constants.REGEX_NUM);
	}

	public static boolean isEmptyUploadFile(MultipartFile image) {
		return image == null || image.getOriginalFilename().isEmpty();
	}

	public static boolean isEmptyUploadFile(MultipartFile[] images) {
		if (images == null || images.length <= 0 || (images.length > 0 && images[0].getOriginalFilename().isEmpty())) {
			return true;
		}
		return false;
	}

}
