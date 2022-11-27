<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
		String userid = null;
    	boolean aaa= false;
    	if((session.getAttribute("userid") != null) && (aaa==false)){
    		userid =(String)session.getAttribute("userid");
    	}
    %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인</title>
</head>
<body>
	<h2>로그인</h2>
	<%
		if(userid == null){
	%>
	<form method ="post" action="z_Login_ok">
		<p>아이디: <input type="text" name="userid"></p>
		<p>비밀번호: <input type="password" name="userpw"></p>
		<p><button>로그인</button></p>
	</form>
	<p> 아직 회원이 아니신가요? <a href ="z_Member.jsp">회원가입</a><p>
	<%
		aaa=true;
		}else{
	%>
	<h3><%=userid %>님 환영합니다.!!!!</h3>
	<p><a href ="z_Logout">로그아웃</a> | <a href='z_Info.jsp'>정보수정</a> | <a href="./board/z_List.jsp">게시판</p>
	<%
		}
	%>
</body>
</html>