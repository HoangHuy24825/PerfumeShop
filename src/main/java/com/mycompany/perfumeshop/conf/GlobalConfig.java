package com.mycompany.perfumeshop.conf;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.PropertySource;
import org.springframework.stereotype.Component;

import lombok.Getter;

@Component
@PropertySource("classpath:page.properties")
@PropertySource("classpath:mail.properties")
@Getter
public class GlobalConfig {

	@Value("${init.page}")
	private int initPage;

	@Value("${size.client.page}")
	private int sizeClientPage;

	@Value("${size.manage.page}")
	private int sizeManagePage;

	@Value("${upload.root.path}")
	private String uploadRootPath;

	@Value("${email}")
	private String email;

	@Value("${password}")
	private String password;

	@Value("${size.client.blog.page}")
	private int sizeClientBlog;

	@Value("${title.page}")
	private String titleWebsite;

	@Value("${success.status.order}")
	private Integer orderSuccessStatus;

	@Value("${cancel.status.order}")
	private Integer orderCancelStatus;

	@Value("${not.approve.status.order}")
	private Integer orderNotProveStatus;

}
