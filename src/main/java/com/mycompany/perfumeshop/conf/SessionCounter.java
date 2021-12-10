package com.mycompany.perfumeshop.conf;

import java.util.concurrent.atomic.AtomicInteger;

import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class SessionCounter implements HttpSessionListener {

	private final AtomicInteger counter = new AtomicInteger();

	@Override
	public void sessionCreated(HttpSessionEvent se) {

		counter.incrementAndGet(); // incrementing the counter
		updateSessionCounter(se);
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent se) {
		counter.decrementAndGet(); // decrementing counter
		updateSessionCounter(se);
	}

	private void updateSessionCounter(HttpSessionEvent httpSessionEvent) {
		// Let's set in the context
		httpSessionEvent.getSession().getServletContext().setAttribute("activeSession", counter.get());
	}

}
