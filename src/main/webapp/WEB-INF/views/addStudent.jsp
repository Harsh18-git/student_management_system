<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.AdminBean" %>

<%-- Security Check --%>
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
        <title>Add Student</title>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" >
        <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&display=swap"
              rel="stylesheet">
        <link rel="stylesheet"
              href="<%= request.getContextPath() %>/CSS/addStudent.css">
    </head>

    <body>

        <%-- ═══════════ HEADER ═══════════ --%>
        <div class="header">
            <h1>STUDENT MANAGEMENT SYSTEM</h1>
            <span class="welcome-text">
                Welcome, <%= admin.getUsername().toUpperCase() %> 👋
            </span>
        </div>

        <%-- ═══════════ WRAPPER ═══════════ --%>
        <div class="wrapper">

            <%-- ── Sidebar ── --%>
            <div class="sidebar">
                <div class="logo">ADMIN PANEL</div>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=showDashboard">
                    🏠 &nbsp; Dashboard
                </a>
                <a href="#" class="active">➕ &nbsp; Add Student</a>
                
                <a href="<%= request.getContextPath() %>/LogoutServlet"
                   class="logout-btn">🚪 Logout</a>
            </div>

            <%-- ── Main Content ── --%>
            <div class="main-content">

                <%-- Show success or error message if any --%>
                <%
                    String message = (String) request.getAttribute("message");
                    if (message != null) {
                        if (message.contains("successfully")) {
                %>
                            <div class="msg-success">✅ <%= message %></div>
                <%
                        } else {
                %>
                            <div class="msg-error">❌ <%= message %></div>
                <%
                        }
                    }
                %>

                <%-- Add Student Form --%>
                <div class="form-card">

                    <div class="form-title">➕ ADD NEW STUDENT</div>

                    <%-- action hidden field tells AdminServlet what to do --%>
                    <form action="<%= request.getContextPath() %>/AdminServlet"
                          method="post">

                        <%-- Hidden field — tells servlet this is addStudent action --%>
                        <input type="hidden" name="action" value="addStudent">

                        <%-- Row 1: Roll Number + Name --%>
                        <div class="form-row">
                            <div class="form-group">
                                <label>ROLL NUMBER</label>
                                <input type="text"
                                       name="rollNumber"
                                       placeholder="e.g. STU002"
                                       required>
                            </div>
                            <div class="form-group">
                                <label>FULL NAME</label>
                                <input type="text"
                                       name="name"
                                       placeholder="e.g. Rahul Sharma"
                                       required>
                            </div>
                        </div>

                        <%-- Row 2: Email + Course --%>
                        <div class="form-row">
                            <div class="form-group">
                                <label>EMAIL</label>
                                <input type="email"
                                       name="email"
                                       placeholder="e.g. rahul@email.com">
                            </div>
                            <div class="form-group">
                                <label>COURSE</label>
                                <select name="course" required>
                                    <option value="">-- Select Course --</option>
                                    <option value="BCA">BCA</option>
                                    <option value="BCS">BCS</option>
                                    <option value="B.Com">B.Com</option>
                                    <option value="B.Sc">B.Sc</option>
                                    <option value="BBA">BBA</option>
                                </select>
                            </div>
                        </div>

                        <%-- Row 3: Semester + Dues --%>
                        <div class="form-row">
                            <div class="form-group">
                                <label>SEMESTER</label>
                                <select name="semester" required>
                                    <option value="">-- Select Semester --</option>
                                    <option value="1">1st Semester</option>
                                    <option value="2">2nd Semester</option>
                                    <option value="3">3rd Semester</option>
                                    <option value="4">4th Semester</option>
                                    <option value="5">5th Semester</option>
                                    <option value="6">6th Semester</option>
                                </select>
                            </div>
                            <div class="form-group">
                                <label>DUES (₹)</label>
                                <input type="number"
                                       name="dues"
                                       placeholder="e.g. 5000"
                                       value="0"
                                       min="0">
                            </div>
                        </div>

                        <%-- Row 4: Password --%>
                        <div class="form-group">
                            <label>PASSWORD</label>
                            <input type="text"
                                   name="password"
                                   placeholder="Set student login password"
                                   required>
                        </div>

                        <%-- Submit Button --%>
                        <button type="submit" class="btn-submit">
                            ➕ ADD STUDENT
                        </button>

                    </form>

                </div>

            </div>

        </div>

    </body>

</html>