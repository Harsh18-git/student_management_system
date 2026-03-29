<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.StudentBean, com.sms.model.MarksBean" %>
<%
    StudentBean student = (StudentBean) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    MarksBean marks = (MarksBean) request.getAttribute("marks");
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Marksheet</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Exo 2", sans-serif; }

        body {
            min-height: 100vh;
            background: #0a1628;
            color: white;
            padding: 2rem;
        }

        .marksheet-container {
            max-width: 780px;
            margin: 0 auto;
        }

        /* ── Header ── */
        .page-header {
            background: linear-gradient(135deg, #0242b8, #436d9a);
            border-radius: 12px;
            padding: 1.5rem 2rem;
            margin-bottom: 1.5rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            box-shadow: 0 4px 15px rgba(0, 229, 255, 0.2);
        }

        .page-header h2 {
            font-size: 1.3rem;
            font-weight: 700;
            letter-spacing: 2px;
        }

        .page-header p {
            font-size: 0.85rem;
            color: rgb(0, 229, 255);
            letter-spacing: 1px;
            margin-top: 4px;
        }

        /* ── Card ── */
        .card {
            background: linear-gradient(135deg, #0d1f3c, #1a3a6b);
            border-radius: 12px;
            padding: 1.5rem 2rem;
            border: 1px solid rgba(0, 229, 255, 0.15);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            margin-bottom: 1.5rem;
        }

        .card-title {
            font-size: 0.9rem;
            font-weight: 700;
            letter-spacing: 2px;
            color: rgb(0, 229, 255);
            margin-bottom: 1.2rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid rgba(0, 229, 255, 0.2);
        }

        /* ── Student Info ── */
        .student-info {
            display: flex;
            flex-wrap: wrap;
            gap: 1.5rem;
            font-size: 0.9rem;
            color: rgba(255,255,255,0.85);
            letter-spacing: 1px;
        }

        .student-info span strong {
            color: rgb(0, 229, 255);
            margin-right: 6px;
        }

        /* ── Marks Table ── */
        .marks-table {
            width: 100%;
            border-collapse: collapse;
        }

        .marks-table thead tr {
            background: rgba(2, 66, 184, 0.4);
            border-bottom: 2px solid rgba(0, 229, 255, 0.3);
        }

        .marks-table th {
            padding: 0.9rem 1rem;
            text-align: left;
            font-size: 0.8rem;
            font-weight: 700;
            letter-spacing: 2px;
            color: rgb(0, 229, 255);
        }

        .marks-table tbody tr {
            border-bottom: 1px solid rgba(0, 229, 255, 0.08);
            transition: 0.2s;
        }

        .marks-table tbody tr:hover {
            background: rgba(0, 229, 255, 0.05);
        }

        .marks-table td {
            padding: 0.85rem 1rem;
            font-size: 0.9rem;
            color: rgba(255,255,255,0.85);
        }

        .pass { color: rgb(0, 220, 120); font-weight: 700; }
        .fail { color: rgb(255, 100, 100); font-weight: 700; }

        /* ── Summary Box ── */
        .summary-box {
            display: flex;
            justify-content: space-around;
            text-align: center;
            gap: 1rem;
        }

        .summary-item label {
            display: block;
            font-size: 0.75rem;
            color: rgba(255,255,255,0.5);
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 8px;
        }

        .summary-item span {
            font-size: 1.6rem;
            font-weight: 700;
            color: rgb(0, 229, 255);
        }

        .grade-badge {
            display: inline-block;
            padding: 4px 20px;
            border-radius: 20px;
            font-size: 1.4rem;
            font-weight: 700;
            background: rgba(0, 220, 120, 0.2);
            border: 1px solid rgba(0, 220, 120, 0.5);
            color: rgb(0, 220, 120);
        }

        .grade-badge.fail-grade {
            background: rgba(255, 80, 80, 0.2);
            border: 1px solid rgba(255, 80, 80, 0.5);
            color: rgb(255, 100, 100);
        }

        /* ── Message ── */
        .message {
            background: rgba(255, 80, 80, 0.15);
            border: 1px solid rgba(255, 80, 80, 0.4);
            color: rgb(255, 100, 100);
            padding: 1rem;
            border-radius: 8px;
            text-align: center;
            letter-spacing: 1px;
        }

        /* ── Back Button ── */
        .back-btn {
            display: inline-block;
            padding: 10px 24px;
            background: rgba(2, 66, 184, 0.3);
            border: 1px solid rgba(0, 229, 255, 0.4);
            border-radius: 8px;
            color: rgb(0, 229, 255);
            text-decoration: none;
            font-size: 0.9rem;
            font-weight: 600;
            letter-spacing: 1px;
            transition: 0.3s;
        }

        .back-btn:hover {
            background: rgba(2, 66, 184, 0.5);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>

<div class="marksheet-container">

    <%-- Page Header --%>
    <div class="page-header">
        <div>
            <h2>📋 STUDENT MARKSHEET</h2>
            <p>Academic Performance Report</p>
        </div>
        <a href="<%= request.getContextPath() %>/StudentServlet?action=showDashboard"
           class="back-btn">← Back to Dashboard</a>
    </div>

    <% if (message != null) { %>
        <div class="card">
            <p class="message"><%= message %></p>
        </div>
    <% } else if (marks != null) { %>

        <%-- Student Info --%>
        <div class="card">
            <div class="card-title">👤 STUDENT INFORMATION</div>
            <div class="student-info">
                <span><strong>Name:</strong> <%= student.getName() %></span>
                <span><strong>Roll No:</strong> <%= student.getRollNumber() %></span>
                <span><strong>Course:</strong> <%= student.getCourse() %></span>
                <span><strong>Semester:</strong> <%= student.getSemester() %></span>
            </div>
        </div>

        <%-- Marks Table --%>
        <div class="card">
            <div class="card-title">📊 SUBJECT-WISE MARKS</div>
            <table class="marks-table">
                <thead>
                    <tr>
                        <th>#</th>
                        <th>SUBJECT</th>
                        <th>MARKS OBTAINED</th>
                        <th>TOTAL MARKS</th>
                        <th>STATUS</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>1</td>
                        <td><%= marks.getSubject1Name() %></td>
                        <td><%= marks.getSubject1Marks() %></td>
                        <td>100</td>
                        <td class="<%= marks.getSubject1Marks() >= 40 ? "pass" : "fail" %>">
                            <%= marks.getSubject1Marks() >= 40 ? "✅ Pass" : "❌ Fail" %>
                        </td>
                    </tr>
                    <tr>
                        <td>2</td>
                        <td><%= marks.getSubject2Name() %></td>
                        <td><%= marks.getSubject2Marks() %></td>
                        <td>100</td>
                        <td class="<%= marks.getSubject2Marks() >= 40 ? "pass" : "fail" %>">
                            <%= marks.getSubject2Marks() >= 40 ? "✅ Pass" : "❌ Fail" %>
                        </td>
                    </tr>
                    <tr>
                        <td>3</td>
                        <td><%= marks.getSubject3Name() %></td>
                        <td><%= marks.getSubject3Marks() %></td>
                        <td>100</td>
                        <td class="<%= marks.getSubject3Marks() >= 40 ? "pass" : "fail" %>">
                            <%= marks.getSubject3Marks() >= 40 ? "✅ Pass" : "❌ Fail" %>
                        </td>
                    </tr>
                </tbody>
            </table>
        </div>

        <%-- Summary --%>
        <div class="card">
            <div class="card-title">🏆 RESULT SUMMARY</div>
            <div class="summary-box">
                <div class="summary-item">
                    <label>Total Marks</label>
                    <span><%= marks.getTotalMarks() %> / 300</span>
                </div>
                <div class="summary-item">
                    <label>Percentage</label>
                    <span><%= String.format("%.2f", marks.getPercentage()) %>%</span>
                </div>
                <div class="summary-item">
                    <label>Overall Grade</label>
                    <span class="grade-badge <%= marks.getGrade().equals("F") ? "fail-grade" : "" %>">
                        <%= marks.getGrade() %>
                    </span>
                </div>
            </div>
        </div>

    <% } %>

    <a href="<%= request.getContextPath() %>/StudentServlet?action=showDashboard"
       class="back-btn">← Back to Dashboard</a>

</div>
</body>
</html>