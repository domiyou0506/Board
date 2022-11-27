<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	if(session.getAttribute("userid") == null){
		response.sendRedirect("/Day4/z_Login.jsp");
		return;
	}
%>