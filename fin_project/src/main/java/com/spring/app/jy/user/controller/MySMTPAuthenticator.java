package com.spring.app.jy.user.controller;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class MySMTPAuthenticator extends Authenticator {
	
	@Override
	public PasswordAuthentication getPasswordAuthentication() {

	// Gmail 의 경우 @gmail.com 을 제외한 아이디만 입력한다.
	return new PasswordAuthentication("wldus081317","bcnq sufv oxuh wvgx");
	// "bcnq sufv oxuh wvgx" 은 Google에 로그인 하기위한 앱 비밀번호이다.
	
}
}
