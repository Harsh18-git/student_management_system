package com.sms.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import com.sms.model.StudentBean;
import java.util.List;
import java.util.ArrayList;
import java.sql.SQLException;
import com.sms.model.MarksBean;

public class StudentDAO {

	public boolean addStudent(StudentBean student) {

	    Connection con = DBConnection.getConnection();

	    try {
	        String sql = "INSERT INTO students " +
	                     "(roll_number, name, email, course, semester, dues, password) " +
	                     "VALUES (?, ?, ?, ?, ?, ?, ?)";

	        PreparedStatement ps = con.prepareStatement(sql);

	        ps.setString(1, student.getRollNumber());
	        ps.setString(2, student.getName());
	        ps.setString(3, student.getEmail());
	        ps.setString(4, student.getCourse());
	        ps.setInt(5, student.getSemester());
	        ps.setDouble(6, student.getDues());
	        ps.setString(7, student.getPassword());

	        int rows = ps.executeUpdate();

	        // Close resources
	        ps.close();
	        con.close();

	        // If rows > 0 → insert was successful
	        return rows > 0;

	    } catch (Exception e) {
	        System.out.println("❌ Add Student Error: " + e.getMessage());
	        return false;
	    }
	}
    public StudentBean login(String rollNumber, String password) {

    	StudentBean student = null;

        Connection con = DBConnection.getConnection();

        try {
           
            String sql = "SELECT * FROM students WHERE roll_number=? AND password=?";

            PreparedStatement ps = con.prepareStatement(sql);

            
            ps.setString(1, rollNumber);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                student = new StudentBean();
                student.setId(rs.getInt("id"));
                student.setRollNumber(rs.getString("roll_number"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getInt("semester"));
                student.setDues(rs.getDouble("dues"));
                student.setPassword(rs.getString("password"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("❌ Student Login Error: " + e.getMessage());
        }

        return student;
    }
    /*
     * Returns total number of students in database
     */
    public int getTotalStudents() {
        Connection con = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM students";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("❌ Count Error: " + e.getMessage());
        }
        return count;
    }

    /*
     * Returns total number of students with pending dues
     */
    public int getTotalPendingDues() {
        Connection con = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "SELECT COUNT(*) FROM students WHERE dues > 0";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("❌ Dues Count Error: " + e.getMessage());
        }
        return count;
    }

    /*
     * Returns total number of distinct courses
     */
    public int getTotalCourses() {
        Connection con = DBConnection.getConnection();
        int count = 0;
        try {
            String sql = "SELECT COUNT(DISTINCT course) FROM students";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                count = rs.getInt(1);
            }
            rs.close();
            ps.close();
            con.close();
        } catch (Exception e) {
            System.out.println("❌ Course Count Error: " + e.getMessage());
        }
        return count;
    }
    
    /*
     * This method returns ALL students from database
     * Returns a List of StudentBean objects
     * Each StudentBean = one row from students table
     */
    public List<StudentBean> getAllStudents() {

        // List to store all students
        List<StudentBean> students = new ArrayList<>();

        Connection con = DBConnection.getConnection();

        try {
            // Get all students ordered by name
            String sql = "SELECT * FROM students ORDER BY name";
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();

            // Loop through each row
            while (rs.next()) {
                // Create new bean for each row
                StudentBean student = new StudentBean();
                student.setId(rs.getInt("id"));
                student.setRollNumber(rs.getString("roll_number"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getInt("semester"));
                student.setDues(rs.getDouble("dues"));
                student.setPassword(rs.getString("password"));

                // Add to list
                students.add(student);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("❌ Get All Students Error: " + e.getMessage());
        }

        return students;
    }

    /*
     * Search student by roll number
     * Returns matching students list
     */
    public List<StudentBean> searchByRollNumber(String rollNumber) {

        List<StudentBean> students = new ArrayList<>();
        Connection con = DBConnection.getConnection();

        try {
            // LIKE query — finds partial matches too
            // e.g. searching "STU" finds STU001, STU002 etc
            String sql = "SELECT * FROM students WHERE roll_number LIKE ?";
            PreparedStatement ps = con.prepareStatement(sql);

            // % means "anything before or after"
            ps.setString(1, "%" + rollNumber + "%");

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                StudentBean student = new StudentBean();
                student.setId(rs.getInt("id"));
                student.setRollNumber(rs.getString("roll_number"));
                student.setName(rs.getString("name"));
                student.setEmail(rs.getString("email"));
                student.setCourse(rs.getString("course"));
                student.setSemester(rs.getInt("semester"));
                student.setDues(rs.getDouble("dues"));
                student.setPassword(rs.getString("password"));
                students.add(student);
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("❌ Search Error: " + e.getMessage());
        }

        return students;
    }
 // Add inside StudentDAO class
    public boolean deleteStudent(String rollNumber) {
        boolean deleted = false;
        Connection con = DBConnection.getConnection();
        try {
            // Delete from marks first (foreign key constraint)
            String deleteMarks = "DELETE FROM marks WHERE roll_number = ?";
            PreparedStatement ps1 = con.prepareStatement(deleteMarks);
            ps1.setString(1, rollNumber);
            ps1.executeUpdate();

            // Then delete from students
            String deleteStudent = "DELETE FROM students WHERE roll_number = ?";
            PreparedStatement ps2 = con.prepareStatement(deleteStudent);
            ps2.setString(1, rollNumber);
            int rows = ps2.executeUpdate();

            if (rows > 0) deleted = true;

        } catch (Exception e) {
            System.out.println("Delete Error: " + e.getMessage());
        } finally {
            try { if (con != null) con.close(); } catch (Exception e) {}
        }
        return deleted;
    }
    public boolean updateDues(String rollNumber, double newDues) {
        Connection con = DBConnection.getConnection();
        try {
            String sql = "UPDATE students SET dues = ? WHERE roll_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setDouble(1, newDues);
            ps.setString(2, rollNumber);
            int rows = ps.executeUpdate();
            ps.close();
            con.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("❌ Update Dues Error: " + e.getMessage());
            return false;
        }
    }
    public boolean changePassword(String rollNumber, String newPassword) {
        String sql = "UPDATE students SET password = ? WHERE roll_number = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, newPassword);
            ps.setString(2, rollNumber);
            return ps.executeUpdate() > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }
    public MarksBean getMarksByRollNumber(String rollNumber) {
        MarksBean marks = null;
        Connection con = DBConnection.getConnection();
        try {
            String sql = "SELECT * FROM marks WHERE roll_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, rollNumber);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                marks = new MarksBean();
                marks.setRollNumber(rs.getString("roll_number"));
                marks.setSubject1Name(rs.getString("subject1_name"));
                marks.setSubject1Marks(rs.getInt("subject1_marks"));
                marks.setSubject2Name(rs.getString("subject2_name"));
                marks.setSubject2Marks(rs.getInt("subject2_marks"));
                marks.setSubject3Name(rs.getString("subject3_name"));
                marks.setSubject3Marks(rs.getInt("subject3_marks"));
            }

            rs.close();
            ps.close();
            con.close();

        } catch (Exception e) {
            System.out.println("❌ Get Marks Error: " + e.getMessage());
        }
        return marks;
    }
    
    public boolean clearDues(String rollNumber) {
        Connection con = DBConnection.getConnection();
        try {
            String sql = "UPDATE students SET dues = 0 WHERE roll_number = ?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, rollNumber);
            int rows = ps.executeUpdate();
            ps.close();
            con.close();
            return rows > 0;
        } catch (Exception e) {
            System.out.println("❌ Clear Dues Error: " + e.getMessage());
            return false;
        }
    }
    
    public boolean uploadMarks(String rollNumber,
            String sub1Name, int sub1Marks,
            String sub2Name, int sub2Marks,
            String sub3Name, int sub3Marks) {
            Connection con = DBConnection.getConnection();
      try {
           String sql = "INSERT INTO marks (roll_number, subject1_name, subject1_marks, " +
           "subject2_name, subject2_marks, subject3_name, subject3_marks) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";
           PreparedStatement ps = con.prepareStatement(sql);
           ps.setString(1, rollNumber);
           ps.setString(2, sub1Name);
           ps.setInt(3, sub1Marks);
           ps.setString(4, sub2Name);
           ps.setInt(5, sub2Marks);
           ps.setString(6, sub3Name);
           ps.setInt(7, sub3Marks);
           int rows = ps.executeUpdate();
           ps.close();
           con.close();
           return rows > 0;
         } catch (Exception e) {
             System.out.println("❌ Upload Marks Error: " + e.getMessage());
                return false;
           }
     }
}