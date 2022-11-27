package com.koreait.db;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.*;
import com.koreait.db.Dbconn;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class z_re_write_ok
 */
@WebServlet("/z_Re_write_ok")
public class z_Re_write_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public z_Re_write_ok() {
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
		
		String userid =(String)session.getAttribute("userid");
		String name = (String)session.getAttribute("name");
		String re_content= request.getParameter("re_content");
		String b_idx= request.getParameter("b_idx");
		
		Connection conn =null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;

		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				String sql = "insert into tb_reply (re_userid, re_name, re_content, re_boardidx) values(?, ?, ?, ?);";
			 			pstmt = conn.prepareStatement(sql);
			 			pstmt.setString(1, userid);
						pstmt.setString(2, name);
			 			pstmt.setString(3, re_content);
			 			pstmt.setString(4, b_idx);
			 			pstmt.executeUpdate();	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		writer.println("<script>"
				+ "alert('등록되었습니다.');"
				+ "location.href='./board/z_View.jsp?b_idx="+b_idx+"'"
				+ "</script>");	
		
	}

}
