<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.AdminBean" %>

<%
    AdminBean admin = (AdminBean) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin Dashboard</title>
        <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&display=swap"
              rel="stylesheet">
        <link rel="stylesheet"
              href="<%= request.getContextPath() %>/CSS/adminDashboard.css">
    </head>

    <body>

        <%-- HEADER --%>
        <div class="header">
            <h1>STUDENT MANAGEMENT SYSTEM</h1>
            <p>Welcome, <%= admin.getUsername().toUpperCase() %> 👋</p>
        </div>

        <div class="container">

            <%-- SIDEBAR --%>
            <div class="sidebar">

                <div class="logo">ADMIN PANEL</div>

                <a href="<%= request.getContextPath() %>/AdminServlet?action=showDashboard"
                   class="active">
                    🏠 &nbsp; Dashboard
                </a>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=showAddForm">
                    ➕ &nbsp; Add Student
                </a>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=viewStudents">
                    👨‍🎓 &nbsp; Manage Students
                </a>
               

                <a href="<%= request.getContextPath() %>/LogoutServlet"
                   class="logout-btn">
                    🚪 Logout
                </a>

            </div>

            <%-- MAIN CONTENT --%>
            <div class="content">

                <%-- Show message if any --%>
                <%
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                        if (message.contains("successfully")) {
                %>
                            <div class="msg-success">✅ <%= message %></div>
                <%      } else { %>
                            <div class="msg-error">❌ <%= message %></div>
                <%      }
                    }
                %>

                <%-- Welcome Banner --%>
                <div class="welcome-card">
                    <h2>Welcome Back, <%= admin.getUsername().toUpperCase() %>! 👋</h2>
                    <p>Manage your students, dues and records from here.</p>
                </div>

                <%-- Stats --%>
                <div class="stats">
                    <div class="stat-card">
                        <h3>
                            <%= request.getAttribute("totalStudents") != null
                                ? request.getAttribute("totalStudents") : 0 %>
                        </h3>
                        <p>TOTAL STUDENTS</p>
                    </div>
                    <div class="stat-card">
                        <h3>
                            <%= request.getAttribute("pendingDues") != null
                                ? request.getAttribute("pendingDues") : 0 %>
                        </h3>
                        <p>PENDING DUES</p>
                    </div>
                    <div class="stat-card">
                        <h3>
                            <%= request.getAttribute("totalCourses") != null
                                ? request.getAttribute("totalCourses") : 0 %>
                        </h3>
                        <p>TOTAL COURSES</p>
                    </div>
                </div>

                <%-- Quick Actions --%>
                <div class="actions">
                    <h3>⚡ QUICK ACTIONS</h3>
                    <div class="action-buttons">
                        <a href="<%= request.getContextPath() %>/AdminServlet?action=showAddForm"
                           class="action-btn btn-add">
                            ➕ Add Student
                        </a>
                        <a href="<%= request.getContextPath() %>/AdminServlet?action=viewStudents"
                           class="action-btn btn-view">
                            👁 View Students
                        </a>
                    </div>
                </div>

            </div>
            <%-- end content --%>

        </div>
        <%-- end container --%>

    </body>
</html>