<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.StudentBean" %>
<%
    StudentBean student = (StudentBean) session.getAttribute("student");
    if(student == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/studentDashboard.css">
</head>
<body>

    <div class="header">
        <h1>Student Dashboard</h1>
        <p>Welcome, <%= student.getName() %> !</p>
    </div>

    <div class="container">
        <div class="sidebar">
            <a href="#" class="active">👤 View Profile</a>
            
            <a href="<%= request.getContextPath() %>/StudentServlet?action=viewMarksheet">📋 View Marksheet</a>
            <a href="<%= request.getContextPath() %>/StudentServlet?action=viewPayDues">💳 Pay Dues</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-btn">🚪 Logout</a>
        </div>

        <div class="content">

            <div class="card">
                <h2>👤 MY PROFILE</h2>
                <table class="profile-table">
                    <tr>
                        <td>Name</td>
                        <td><%= student.getName() %></td>
                    </tr>
                    <tr>
                        <td>Roll Number</td>
                        <td><%= student.getRollNumber() %></td>
                    </tr>
                    <tr>
                        <td>Email</td>
                        <td><%= student.getEmail() %></td>
                    </tr>
                    <tr>
                        <td>Course</td>
                        <td><%= student.getCourse() %></td>
                    </tr>
                    <tr>
                        <td>Semester</td>
                        <td><%= student.getSemester() %></td>
                    </tr>
                </table>
            </div>

            <div class="card">
                <h2>💰 MY DUES</h2>
                <%
                    double dues = student.getDues();
                    if(dues > 0) {
                %>
                    <p style="color:rgba(255,255,255,0.85); font-size:0.95rem; letter-spacing:1px;">
                        Pending Dues: <span class="dues-amount">₹ <%= student.getDues() %></span>
                    </p>
                    <br>
                    <p style="color:rgba(255,255,255,0.85); font-size:0.9rem; letter-spacing:1px;">
                        Status: <span class="badge-pending">PENDING</span>
                    </p>
                    <a href="<%= request.getContextPath() %>/StudentServlet?action=viewPayDues"
                       class="btn-paynow">💳 Pay Now →</a>
                <% } else { %>
                    <p class="dues-cleared">✅ No Pending Dues!</p>
                    <br>
                    <p style="color:rgba(255,255,255,0.85); font-size:0.9rem; letter-spacing:1px;">
                        Status: <span class="badge-cleared">CLEARED</span>
                    </p>
                <% } %>
            </div>

            <div class="card">
                <h2>📋 MY MARKSHEET</h2>
                <p style="color:rgba(255,255,255,0.6); font-size:0.9rem; letter-spacing:1px;">
                    View your subject-wise marks, percentage and overall grade.
                </p>
                <a href="<%= request.getContextPath() %>/StudentServlet?action=viewMarksheet"
                   class="btn-marksheet">📋 View Marksheet →</a>
            </div>

        </div>
    </div>

</body>
</html>