package com.koreait.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

//재활용하기 위한 클래스
public class Dbconn {
    //필드 생성
    private static Connection conn;

    public static Connection getConnection() throws SQLException, ClassNotFoundException {      //오류가 발생하므로 오류를 넘겨버림
        String url = "jdbc:mysql://127.0.0.1/aidev?useSSL=false";
        String uid = "root";
        String upw = "1234";

        Class.forName("com.mysql.cj.jdbc.Driver");
        conn = DriverManager.getConnection(url,uid,upw);
        return conn;
    }
}
