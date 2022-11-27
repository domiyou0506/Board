<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file= "../include/z_sessioncheck.jsp" %>    
<%@page import="com.koreait.db.Dbconn"%>
<%@page import="java.sql.*"%>

<%
	request.setCharacterEncoding("UTF-8");

	String userid =(String)session.getAttribute("userid");
	String name = (String)session.getAttribute("name");
	String b_idx= request.getParameter("b_idx");

	Connection conn =null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	String b_title = "";
	String b_content = "";

	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			String sql = "select b_title, b_content from tb_board where b_idx =?";
 			pstmt = conn.prepareStatement(sql);
 			pstmt.setString(1, b_idx);
			rs=pstmt.executeQuery();

			
			while(rs.next()){
				b_title = rs.getString("b_title");
				b_content = rs.getString("b_content");
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
 %>    


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>글쓰기</title>
</head>
<body>
		<h2>글쓰기</h2>
		<form method="post" action="../z_Edit_ok">
			<input type="hidden" name="b_idx"  value="<%=b_idx%>">
			<p>작성자 : <%=name%>(<%=userid%>)</p>
			<p>제목: <input type="text" name="b_title" value="<%=b_title%>"></p>
			<p>내용</p>
			<p><textarea style="width: 300px; height: 200px; resize: none; " name="b_content"><%=b_content%></textarea></p>
			<p>
			
			<button>등록</button>
			<button type="reset">재작성</button>
			<button type="button" onclick="location.href='history.back()'">돌아가기</button>
			</p>
		</form>
</body>
</html>