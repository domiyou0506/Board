package com.koreait.db;

import java.sql.*;
import com.koreait.db.Dbconn;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class z_Login_ok
 */
@WebServlet("/z_Login_ok")
public class z_Login_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public z_Login_ok() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		String userid = request.getParameter("userid");
		String userpw = request.getParameter("userpw");
		
		Connection conn = null;
		PreparedStatement pstmt;
		ResultSet rs = null;
		
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				String sql = "select mem_idx, mem_name from tb_member where mem_userid=? and mem_userpw=sha2(?,256)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, userid);
				pstmt.setString(2, userpw);
				rs = pstmt.executeQuery();
				if(rs.next()){
					session.setAttribute("userid", userid);
					session.setAttribute("idx", rs.getInt("mem_idx"));
					session.setAttribute("name", rs.getString("mem_name"));
					
					writer.println("<script> alert('로그인 되었습니다.');  location.href='z_Login.jsp'; </script>");
				}else{
					writer.println("<script> alert('아이디 또는 비밀번호를 확인하세요'); "
							+ "history.back();"
							+ "</script>");
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}

}
