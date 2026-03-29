package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.sms.model.AdminBean;

/*
 * AdminDAO handles ONE job:
 * Check if admin username and password exist in database
 * If yes → return AdminBean object with admin data
 * If no  → return null
 */
public class AdminDAO {

    /*
     * This method checks admin login
     * Parameters:
     *   username → what admin typed in username field
     *   password → what admin typed in password field
     * Returns:
     *   AdminBean → if login is correct
     *   null      → if login is wrong
     */
    public AdminBean login(String username, String password) {

        // We will return this — null means login failed
        AdminBean admin = null;

        // Step 1: Get connection to database
        // DBConnection.getConnection() is our class we already made
        Connection con = DBConnection.getConnection();

        try {
            // Step 2: Write the SQL query
            // "?" are placeholders — we fill them below
            // This is called PreparedStatement
            // It is SAFER than normal Statement
            // It prevents SQL Injection attacks
            String sql = "SELECT * FROM admin WHERE username=? AND password=?";

            // Step 3: Prepare the statement with our SQL
            PreparedStatement ps = con.prepareStatement(sql);

            // Step 4: Fill in the "?" placeholders
            // First "?"  → position 1 → username
            // Second "?" → position 2 → password
            ps.setString(1, username);
            ps.setString(2, password);

            // Step 5: Execute the query
            // ResultSet holds the rows returned by the query
            ResultSet rs = ps.executeQuery();

            // Step 6: Check if any row was returned
            // rs.next() moves to next row — returns true if row exists
            if (rs.next()) {
                // Login is correct! Row found in database
                // Create AdminBean and fill it with data from database
                admin = new AdminBean();

                // rs.getInt("id") → gets "id" column value from result
                admin.setId(rs.getInt("id"));
                admin.setUsername(rs.getString("username"));
                admin.setPassword(rs.getString("password"));
            }

            // Step 7: Close resources to free memory
            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("❌ Admin Login Error: " + e.getMessage());
        }

        // Return admin object (or null if login failed)
        return admin;
    }
}