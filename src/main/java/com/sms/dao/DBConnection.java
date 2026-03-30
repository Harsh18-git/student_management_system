package com.sms.dao;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
	private static final String URL = "jdbc:mysql://bmmunptwx8wqg5bgwjuf-mysql.services.clever-cloud.com:3306/bmmunptwx8wqg5bgwjuf";
	private static final String USER = "uxdfdjh6m57prmys";
	private static final String PASSWORD = "Mc92Ka0O9S3nKv3RbEvt";
    
    public static Connection getConnection() {
    	Connection con = null;

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            con = DriverManager.getConnection(URL, USER, PASSWORD);

            System.out.println("✅ Database Connected Successfully!");

        } catch (ClassNotFoundException e) {
            System.out.println("❌ MySQL Driver Not Found! " + e.getMessage());

        } catch (SQLException e) {
            System.out.println("❌ Connection Failed! " + e.getMessage());
        }

        return con;
    	
    	
    }

}
