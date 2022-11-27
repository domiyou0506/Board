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
 * Servlet implementation class z_Edit_ok
 */
@WebServlet("/z_Edit_ok")
public class z_Edit_ok extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public z_Edit_ok() {
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
		String b_idx= request.getParameter("b_idx");
		String b_title= request.getParameter("b_title");
		String b_content= request.getParameter("b_content");
		
		Connection conn =null;
		PreparedStatement pstmt = null;

		try{
			conn = Dbconn.getConnection();
			if(conn != null){
				String sql = "update tb_board set b_title=?, b_content=? where b_idx =?";
	 			pstmt = conn.prepareStatement(sql);
	 			pstmt.setString(1, b_title);
				pstmt.setString(2, b_content);
	 			pstmt.setString(3, b_idx);
	 			pstmt.executeUpdate();	
			}
		}catch(Exception e){
			e.printStackTrace();
		}
		
		writer.println("<script>"
				+ "alert('변경되었습니다!');"
				+ "location.href='./board/z_View.jsp?b_idx="+b_idx+"'"
				+ "</script>");
	}
}
