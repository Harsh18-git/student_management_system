<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.AdminBean, com.sms.model.StudentBean" %>
<%
    AdminBean admin = (AdminBean) session.getAttribute("admin");
    if (admin == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    StudentBean uploadStudent = (StudentBean) request.getAttribute("uploadStudent");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Upload Marks</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/CSS/manageStudents.css">
    <style>
        .upload-container {
            max-width: 600px;
            margin: 40px auto;
        }
        .form-group {
            display: flex;
            align-items: center;
            gap: 1rem;
            margin-bottom: 1.2rem;
        }
        .form-group label {
            min-width: 160px;
            font-weight: 600;
            color: rgb(0, 229, 255);
            font-size: 0.9rem;
            letter-spacing: 1px;
        }
        .form-input {
            flex: 1;
            height: 40px;
            background: rgba(255,255,255,0.05);
            border: 1px solid rgba(0, 229, 255, 0.3);
            border-radius: 8px;
            padding: 0 1rem;
            color: white;
            font-size: 0.9rem;
            font-family: "Exo 2", sans-serif;
            transition: 0.3s;
        }
        .form-input:focus {
            outline: none;
            border-color: rgb(0, 229, 255);
            box-shadow: 0 0 8px rgba(0, 229, 255, 0.2);
        }
        .form-input::placeholder { color: rgba(255,255,255,0.3); }
        .divider {
            border: none;
            border-top: 1px solid rgba(0, 229, 255, 0.15);
            margin: 1.5rem 0;
        }
        .subject-label {
            font-size: 0.85rem;
            font-weight: 700;
            color: rgb(0, 229, 255);
            letter-spacing: 2px;
            margin-bottom: 1rem;
        }
        .btn-submit {
            height: 44px;
            padding: 0 2rem;
            background: rgb(2, 66, 184);
            border: none;
            border-radius: 8px;
            color: white;
            font-size: 0.95rem;
            font-weight: 600;
            letter-spacing: 1px;
            cursor: pointer;
            transition: 0.3s;
        }
        .btn-submit:hover {
            background: rgb(2, 172, 184);
            transform: translateY(-2px);
        }
        .btn-back {
            height: 44px;
            padding: 0 1.5rem;
            background: transparent;
            border: 1px solid rgba(0, 229, 255, 0.3);
            border-radius: 8px;
            color: rgba(255,255,255,0.7);
            font-size: 0.9rem;
            letter-spacing: 1px;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            transition: 0.3s;
            margin-left: 1rem;
        }
        .btn-back:hover {
            border-color: rgb(0, 229, 255);
            color: rgb(0, 229, 255);
        }
        .student-info-box {
            background: rgba(2, 66, 184, 0.15);
            border: 1px solid rgba(0, 229, 255, 0.25);
            border-radius: 10px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            font-size: 0.9rem;
            color: rgba(255,255,255,0.85);
            letter-spacing: 1px;
        }
        .student-info-box span {
            color: rgb(0, 229, 255);
            font-weight: 700;
        }
    </style>
</head>
<body>

<div class="wrapper">
    <!-- Sidebar -->
    <div class="sidebar">
        <div class="logo">SMS ADMIN</div>
        <a href="AdminServlet?action=showDashboard">🏠 Dashboard</a>
        <a href="AdminServlet?action=viewStudents" class="active">👥 Manage Students</a>
        <a href="AdminServlet?action=showAddForm">➕ Add Student</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet" class="logout-btn">🚪 Logout</a>
    </div>

    <!-- Main Content -->
    <div class="main-content">
        <div class="section-card upload-container">
            <div class="section-title">📊 UPLOAD STUDENT MARKS</div>

            <!-- Student Info -->
            <% if (uploadStudent != null) { %>
            <div class="student-info-box">
                Uploading marks for:
                <span><%= uploadStudent.getName() %></span>
                &nbsp;|&nbsp; Roll No: <span><%= uploadStudent.getRollNumber() %></span>
                &nbsp;|&nbsp; Course: <span><%= uploadStudent.getCourse() %></span>
                &nbsp;|&nbsp; Semester: <span><%= uploadStudent.getSemester() %></span>
            </div>

            <form action="AdminServlet" method="post">
                <input type="hidden" name="action" value="uploadMarks" />
                <input type="hidden" name="rollNumber" value="<%= uploadStudent.getRollNumber() %>" />

                <!-- Subject 1 -->
                <p class="subject-label">SUBJECT 1</p>
                <div class="form-group">
                    <label>Subject Name</label>
                    <input type="text" name="sub1Name" class="form-input"
                           placeholder="e.g. Mathematics" required />
                </div>
                <div class="form-group">
                    <label>Marks Obtained</label>
                    <input type="number" name="sub1Marks" class="form-input"
                           placeholder="Out of 100" min="0" max="100" required />
                </div>

                <hr class="divider">

                <!-- Subject 2 -->
                <p class="subject-label">SUBJECT 2</p>
                <div class="form-group">
                    <label>Subject Name</label>
                    <input type="text" name="sub2Name" class="form-input"
                           placeholder="e.g. Database Systems" required />
                </div>
                <div class="form-group">
                    <label>Marks Obtained</label>
                    <input type="number" name="sub2Marks" class="form-input"
                           placeholder="Out of 100" min="0" max="100" required />
                </div>

                <hr class="divider">

                <!-- Subject 3 -->
                <p class="subject-label">SUBJECT 3</p>
                <div class="form-group">
                    <label>Subject Name</label>
                    <input type="text" name="sub3Name" class="form-input"
                           placeholder="e.g. Computer Networks" required />
                </div>
                <div class="form-group">
                    <label>Marks Obtained</label>
                    <input type="number" name="sub3Marks" class="form-input"
                           placeholder="Out of 100" min="0" max="100" required />
                </div>

                <hr class="divider">

                <button type="submit" class="btn-submit">📊 Upload Marks</button>
                <a href="AdminServlet?action=viewStudents" class="btn-back">← Cancel</a>
            </form>

            <% } else { %>
                <p style="color: rgba(255,255,255,0.5);">No student selected.</p>
                <a href="AdminServlet?action=viewStudents" class="btn-back">← Back</a>
            <% } %>
        </div>
    </div>
</div>

</body>
</html>