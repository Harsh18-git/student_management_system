<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.AdminBean" %>
<%@ page import="com.sms.model.StudentBean" %>
<%@ page import="java.util.List" %>

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
    <title>Manage Students</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com">
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&display=swap"
          rel="stylesheet">
    <link rel="stylesheet"
          href="<%= request.getContextPath() %>/CSS/manageStudents.css">
</head>

<body>

<div class="header">
    <h1>STUDENT MANAGEMENT SYSTEM</h1>
    <span class="welcome-text">
        Welcome, <%= admin.getUsername().toUpperCase() %> 👋
    </span>
</div>

<div class="wrapper">

    <div class="sidebar">
        <div class="logo">ADMIN PANEL</div>

        <a href="<%= request.getContextPath() %>/AdminServlet?action=showDashboard">🏠 Dashboard</a>
        <a href="<%= request.getContextPath() %>/AdminServlet?action=showAddForm">➕ Add Student</a>
        <a href="<%= request.getContextPath() %>/AdminServlet?action=viewStudents" class="active">👨‍🎓 Manage Students</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-btn">🚪 Logout</a>
    </div>

    <div class="main-content">

        <%-- Message --%>
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

        <%-- Search --%>
        <div class="section-card">
            <div class="section-title">🔍 SEARCH STUDENT</div>

            <form action="<%= request.getContextPath() %>/AdminServlet" method="get" class="search-form">
                <input type="hidden" name="action" value="searchStudent">

                <input type="text" name="keyword" class="search-input"
                       placeholder="Search by Roll Number..."
                       value="<%= request.getAttribute("keyword") != null
                               ? request.getAttribute("keyword") : "" %>">

                <button type="submit" class="btn-search">🔍 Search</button>
                <a href="<%= request.getContextPath() %>/AdminServlet?action=viewStudents" class="btn-reset">✖ Reset</a>
            </form>
        </div>

        <%-- Students Table --%>
        <div class="section-card">
            <div class="section-title">👨‍🎓 ALL STUDENTS</div>

            <%
                List<StudentBean> studentList =
                        (List<StudentBean>) request.getAttribute("studentList");

                if (studentList == null || studentList.isEmpty()) {
            %>
                <div class="no-students">No students found! 🎓</div>
            <%
                } else {
            %>

            <table class="students-table">
                <thead>
                    <tr>
                        <th>ROLL NO</th>
                        <th>NAME</th>
                        <th>COURSE</th>
                        <th>SEMESTER</th>
                        <th>DUES</th>
                        <th>ACTIONS</th>
                    </tr>
                </thead>
                <tbody>
                    <% for (StudentBean s : studentList) { %>
                    <tr>
                        <td><%= s.getRollNumber() %></td>
                        <td><%= s.getName() %></td>
                        <td><%= s.getCourse() %></td>
                        <td><%= s.getSemester() %></td>
                        <td>
                            ₹ <%= s.getDues() %>
                            <% if (s.getDues() > 0) { %>
                                <span class="badge-pending">PENDING</span>
                            <% } else { %>
                                <span class="badge-cleared">CLEARED</span>
                            <% } %>
                        </td>
                        <td>
                            <a href="<%= request.getContextPath() %>/AdminServlet?action=deleteStudent&rollNumber=<%= s.getRollNumber() %>"
                               class="btn-delete"
                               onclick="return confirm('Delete <%= s.getName() %>?')">🗑 Delete</a>

                            <a href="<%= request.getContextPath() %>/AdminServlet?action=showUpdateDues&rollNumber=<%= s.getRollNumber() %>"
                               class="btn-update">💰 Dues</a>

                            <a href="<%= request.getContextPath() %>/AdminServlet?action=showChangePassword&rollNumber=<%= s.getRollNumber() %>"
                               class="btn-password">🔑 Password</a>
                            <a href="<%= request.getContextPath() %>/AdminServlet?action=showUploadMarks&rollNumber=<%= s.getRollNumber() %>"
                                 class="btn-update">📊 Upload Marks</a>
                        </td>
                    </tr>
                    <% } %>
                </tbody>
            </table>

            <%-- 🔥 INLINE UPDATE DUES FORM --%>
            <%
                String updateRoll = (String) request.getAttribute("updateRollNumber");
                if (updateRoll != null) {
            %>
            <div class="update-dues-form">
                <div class="section-title">
                    💰 UPDATE DUES — <%= request.getAttribute("updateStudentName") %> (<%= updateRoll %>)
                </div>

                <form action="<%= request.getContextPath() %>/AdminServlet" method="post">
                    <input type="hidden" name="action" value="updateDues">
                    <input type="hidden" name="rollNumber" value="<%= updateRoll %>">

                    <div class="dues-form-row">
                        <label>Current Dues:</label>
                        <span class="current-dues-value">
                            ₹ <%= request.getAttribute("currentDues") %>
                        </span>
                    </div>

                    <div class="dues-form-row">
                        <label>New Dues Amount (₹):</label>
                        <input type="number"
                               name="newDues"
                               class="dues-input"
                               min="0"
                               step="0.01"
                               value="<%= request.getAttribute("currentDues") %>"
                               required>
                    </div>

                    <div class="dues-form-row">
                        <button type="submit" class="btn-save-dues">💾 Save Dues</button>
                        <a href="<%= request.getContextPath() %>/AdminServlet?action=viewStudents"
                           class="btn-cancel-dues">✖ Cancel</a>
                    </div>
                </form>
            </div>
            <% } %>

            <%-- 🔥 INLINE CHANGE PASSWORD FORM — NEW --%>
            <%
                String changePasswordRoll = (String) request.getAttribute("changePasswordRoll");
                if (changePasswordRoll != null) {
            %>
            <div class="update-dues-form">
                <div class="section-title">
                    🔑 CHANGE PASSWORD — <%= request.getAttribute("changePasswordName") %> (<%= changePasswordRoll %>)
                </div>

                <form action="<%= request.getContextPath() %>/AdminServlet" method="post">
                    <input type="hidden" name="action"     value="changePassword">
                    <input type="hidden" name="rollNumber" value="<%= changePasswordRoll %>">

                    <div class="dues-form-row">
                        <label>New Password:</label>
                        <input type="password"
                               name="newPassword"
                               class="dues-input"
                               placeholder="Enter new password"
                               required>
                    </div>

                    <div class="dues-form-row">
                        <label>Confirm Password:</label>
                        <input type="password"
                               id="confirmPassword"
                               class="dues-input"
                               placeholder="Confirm new password"
                               required>
                    </div>

                    <div class="dues-form-row">
                        <button type="submit"
                                class="btn-save-dues"
                                onclick="return validatePasswords()">🔑 Update Password</button>
                        <a href="<%= request.getContextPath() %>/AdminServlet?action=viewStudents"
                           class="btn-cancel-dues">✖ Cancel</a>
                    </div>
                </form>
            </div>

            <script>
                function validatePasswords() {
                    const newPass     = document.querySelector('input[name="newPassword"]').value;
                    const confirmPass = document.getElementById('confirmPassword').value;
                    if (newPass !== confirmPass) {
                        alert('❌ Passwords do not match! Please try again.');
                        return false;
                    }
                    if (newPass.length < 6) {
                        alert('❌ Password must be at least 6 characters!');
                        return false;
                    }
                    return true;
                }
            </script>

            <% } %>

            <% } %>
        </div>

    </div>
</div>

</body>
</html>