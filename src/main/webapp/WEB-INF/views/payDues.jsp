<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.sms.model.StudentBean" %>
<%
    StudentBean student = (StudentBean) session.getAttribute("student");
    if (student == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    String message = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Pay Dues</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Exo 2", sans-serif; }

        body {
            min-height: 100vh;
            background: #0a1628;
            color: white;
            padding: 2rem;
        }

        .pay-container {
            max-width: 520px;
            margin: 0 auto;
        }

        /* ── Page Header ── */
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
            padding: 2rem;
            border: 1px solid rgba(0, 229, 255, 0.15);
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.3);
            margin-bottom: 1.5rem;
            text-align: center;
        }

        .card-title {
            font-size: 0.9rem;
            font-weight: 700;
            letter-spacing: 2px;
            color: rgb(0, 229, 255);
            margin-bottom: 1.2rem;
            padding-bottom: 0.75rem;
            border-bottom: 1px solid rgba(0, 229, 255, 0.2);
            text-align: left;
        }

        /* ── Dues Highlight ── */
        .dues-highlight {
            font-size: 2rem;
            font-weight: 700;
            color: rgb(255, 130, 80);
            margin-bottom: 1.5rem;
            letter-spacing: 1px;
        }

        /* ── QR Box ── */
        .qr-box {
            background: white;
            border-radius: 12px;
            padding: 16px;
            display: inline-block;
            margin-bottom: 1.5rem;
            box-shadow: 0 0 20px rgba(0, 229, 255, 0.15);
        }

        .qr-box img {
            width: 220px;
            height: 220px;
            object-fit: contain;
            display: block;
        }

        .qr-label {
            font-size: 0.8rem;
            color: #888;
            margin-top: 10px;
            letter-spacing: 1px;
        }

        /* ── Confirm Button ── */
        .confirm-btn {
            width: 100%;
            padding: 14px;
            background: rgba(0, 180, 100, 0.2);
            border: 1px solid rgba(0, 180, 100, 0.5);
            border-radius: 8px;
            color: rgb(0, 220, 120);
            font-size: 1rem;
            font-weight: 700;
            letter-spacing: 1px;
            cursor: pointer;
            transition: 0.3s;
            margin-bottom: 1rem;
            font-family: "Exo 2", sans-serif;
        }

        .confirm-btn:hover {
            background: rgba(0, 180, 100, 0.35);
            transform: translateY(-2px);
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

        /* ── Message Box ── */
        .message-box {
            padding: 14px;
            border-radius: 8px;
            margin-bottom: 1.2rem;
            font-size: 0.95rem;
            letter-spacing: 1px;
            background: rgba(0, 220, 120, 0.15);
            color: rgb(0, 220, 120);
            border: 1px solid rgba(0, 220, 120, 0.4);
        }

        .message-box.error {
            background: rgba(255, 80, 80, 0.15);
            color: rgb(255, 100, 100);
            border-color: rgba(255, 80, 80, 0.4);
        }

        /* ── Cleared Box ── */
        .cleared-box {
            font-size: 1.2rem;
            color: rgb(0, 220, 120);
            font-weight: 700;
            letter-spacing: 1px;
            margin: 1rem 0 1.5rem 0;
        }
    </style>
</head>
<body>

<div class="pay-container">

    <%-- Page Header --%>
    <div class="page-header">
        <div>
            <h2>💰 PAY DUES</h2>
            <p>Scan QR to pay your pending dues</p>
        </div>
        <a href="<%= request.getContextPath() %>/StudentServlet?action=showDashboard"
           class="back-btn">← Dashboard</a>
    </div>

    <%-- Main Card --%>
    <div class="card">
        <div class="card-title">💳 PAYMENT DETAILS</div>

        <%-- Message after payment --%>
        <% if (message != null) { %>
            <div class="message-box <%= message.startsWith("❌") ? "error" : "" %>">
                <%= message %>
            </div>
        <% } %>

        <% if (student.getDues() > 0) { %>

            <div class="dues-highlight">
                Pending: ₹ <%= student.getDues() %>
            </div>

            <div class="qr-box">
                <img src="<%= request.getContextPath() %>/images/upi_qr.png" alt="UPI QR Code" />
                <p class="qr-label">Scan with GPay / PhonePe / Paytm / Any UPI App</p>
            </div>

            <form action="<%= request.getContextPath() %>/StudentServlet" method="post">
                <input type="hidden" name="action" value="confirmPayment" />
                <button type="submit" class="confirm-btn">✅ I Have Paid</button>
            </form>

        <% } else { %>
            <div class="cleared-box">✅ Your dues are already cleared!</div>
        <% } %>

        <a href="<%= request.getContextPath() %>/StudentServlet?action=showDashboard"
           class="back-btn">← Back to Dashboard</a>
    </div>

</div>

</body>
</html>