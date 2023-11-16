package com.javarush.quest.lazarev.controller;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.annotation.WebInitParam;

import java.io.IOException;

@WebFilter(urlPatterns = "/*", initParams = {
        @WebInitParam(name = "paramName", value = "paramValue")
})
public class SoulsFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {
        Integer souls = (Integer) ((HttpServletRequest) request).getSession().getAttribute("souls");
        request.setAttribute("souls", souls);
        chain.doFilter(request, response);
    }

    @Override
    public void init(FilterConfig filterConfig) {

    }

    @Override
    public void destroy() {

    }
}