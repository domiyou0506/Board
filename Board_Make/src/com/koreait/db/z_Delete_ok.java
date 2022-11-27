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
 * Servlet implementation class z_delete_ok
 */
@WebServlet("/z_Delete_ok")
public class z_Delete_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public z_Delete_ok() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html;charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		PrintWriter writer = response.getWriter();
		HttpSession session = request.getSession();
		
		// http://locationhost:9090/day4/board/delete_ok.jsp?b_idx=1
		String b_idx= request.getParameter("b_idx");
		String userid= (String)session.getAttribute("userid");

		Connection conn =null;
		PreparedStatement pstmt = null;
		
		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				String sql = "delete from tb_board where b_idx=? and b_userid=?";
	 			pstmt = conn.prepareStatement(sql);
	 			pstmt.setString(1, b_idx);
	 			pstmt.setString(2, userid);
	 			
	 			pstmt.executeUpdate();	
	 			
				sql = "delete from tb_b_hit where h_b_idx=?";
	 			pstmt = conn.prepareStatement(sql);
	 			pstmt.setString(1, b_idx);
	 			
	 			pstmt.executeUpdate();	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		writer.println("<script>"
				+ "alert('삭제되었습니다.');"
				+ "location.href='./board/z_List.jsp'"
				+ "</script>");
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
