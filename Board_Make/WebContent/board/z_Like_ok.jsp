<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.sql.*" %>
<%@ page import="com.koreait.db.Dbconn" %>
<%@ include file= "../include/z_sessioncheck.jsp" %>    
<%
	String b_idx = request.getParameter("b_idx");
	String userid = (String)session.getAttribute("userid");
	Connection conn = null;
	PreparedStatement pstmt = null;
	ResultSet rs = null;
	
	try{
		conn = Dbconn.getConnection();
		if(conn != null){
			int b_like = 0;
			
			String sql = "select li_idx from tb_like where li_boardidx=? and li_userid=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			pstmt.setString(2, userid);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				sql = "update tb_board set b_like = b_like - 1 where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.executeUpdate();
				
				sql = "delete from tb_like where li_boardidx=? and li_userid=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.setString(2, userid);
				pstmt.executeUpdate();
			}else{
				sql = "update tb_board set b_like = b_like + 1 where b_idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, b_idx);
				pstmt.executeUpdate();
				
				sql = "insert into tb_like (li_userid, li_boardidx) values (?, ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, b_idx);
				pstmt.executeUpdate();
			}
			
			sql = "select b_like from tb_board where b_idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, b_idx);
			rs = pstmt.executeQuery();
			
			if(rs.next()){
				b_like = rs.getInt("b_like");
				out.print(b_like);
			}
		}
	}catch(Exception e){
		e.printStackTrace();
	}
%>