<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "../include/z_sessioncheck.jsp" %>    
<%@page import="com.koreait.db.Dbconn"%>
<%@page import="java.sql.*"%>
<%
	String userid =(String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
		<h2>글쓰기</h2>
		<form method="post" action="../z_Write_ok">
			<p>작성자 : <%=name%>(<%=userid%>)</p>
			<p>제목: <input type="text" name="b_title"></p>
			<p>내용</p>
			<p><textarea style="width: 300px; height: 200px; resize: none; " name="b_content"></textarea></p>
			<p>
			<button>등록</button>
			
			<button type="reset">재작성</button>
			
			<button type="button" onclick="location.href='z_List.jsp'">리스트</button>
			</p>
		</form>
</body>
</html>