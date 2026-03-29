package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sms.dao.StudentDAO;
import com.sms.model.MarksBean;
import com.sms.model.StudentBean;

@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ════════════════════════════════════
    // doGet — handles navigation
    // ════════════════════════════════════
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        StudentBean student = (session != null)
                ? (StudentBean) session.getAttribute("student") : null;

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (action.equals("showDashboard")) {               // ← NEW
            request.getRequestDispatcher("/WEB-INF/views/studentDashboard.jsp")
                   .forward(request, response);

        } else if (action.equals("viewMarksheet")) {
            StudentDAO dao = new StudentDAO();
            MarksBean marks = dao.getMarksByRollNumber(student.getRollNumber());

            if (marks != null) {
                request.setAttribute("marks", marks);
            } else {
                request.setAttribute("message", "No marksheet found for your roll number.");
            }

            request.getRequestDispatcher("/WEB-INF/views/marksheet.jsp")
                   .forward(request, response);

        } else if (action.equals("viewPayDues")) {
            request.getRequestDispatcher("/WEB-INF/views/payDues.jsp")
                   .forward(request, response);
        }
    }

    // ════════════════════════════════════
    // doPost — handles form submissions
    // ════════════════════════════════════
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        StudentBean student = (session != null)
                ? (StudentBean) session.getAttribute("student") : null;

        if (student == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action.equals("confirmPayment")) {
            StudentDAO dao = new StudentDAO();
            boolean success = dao.clearDues(student.getRollNumber());

            if (success) {
                // Update session so dashboard shows ₹0 immediately
                student.setDues(0);
                session.setAttribute("student", student);
                request.setAttribute("message", "✅ Payment confirmed! Your dues have been cleared.");
            } else {
                request.setAttribute("message", "❌ Something went wrong. Please try again.");
            }

            request.getRequestDispatcher("/WEB-INF/views/payDues.jsp")
                   .forward(request, response);
        }
    }
}