package com.sms.controller;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sms.dao.StudentDAO;
import com.sms.model.AdminBean;
import com.sms.model.StudentBean;
import java.util.List;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    // ════════════════════════════════════
    // doPost — handles form submissions
    // ════════════════════════════════════
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        AdminBean admin = (AdminBean) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if (action.equals("addStudent")) {
            handleAddStudent(request, response);
        } else if (action.equals("updateDues")) {
            handleUpdateDues(request, response);
        } else if (action.equals("changePassword")) {
            handleChangePassword(request, response);
        } else if (action.equals("uploadMarks")) {          // ← NEW
            handleUploadMarks(request, response);
        }
    }

    // ════════════════════════════════════
    // doGet — handles navigation
    // ════════════════════════════════════
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        AdminBean admin = (AdminBean) session.getAttribute("admin");

        if (admin == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");
        if (action == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        if (action.equals("showAddForm")) {
            request.getRequestDispatcher("/WEB-INF/views/addStudent.jsp")
                   .forward(request, response);

        } else if (action.equals("showDashboard")) {
            StudentDAO dao = new StudentDAO();
            int totalStudents = dao.getTotalStudents();
            int pendingDues   = dao.getTotalPendingDues();
            int totalCourses  = dao.getTotalCourses();

            request.setAttribute("totalStudents", totalStudents);
            request.setAttribute("pendingDues",   pendingDues);
            request.setAttribute("totalCourses",  totalCourses);

            request.getRequestDispatcher("/WEB-INF/views/adminDashboard.jsp")
                   .forward(request, response);

        } else if (action.equals("viewStudents")) {
            StudentDAO dao = new StudentDAO();
            List<StudentBean> students = dao.getAllStudents();
            request.setAttribute("studentList", students);

            request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
                   .forward(request, response);

        } else if (action.equals("searchStudent")) {
            String keyword = request.getParameter("keyword");

            StudentDAO dao = new StudentDAO();
            List<StudentBean> students = dao.searchByRollNumber(keyword);

            request.setAttribute("studentList", students);
            request.setAttribute("keyword", keyword);

            request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
                   .forward(request, response);

        } else if (action.equals("deleteStudent")) {
            String rollNumber = request.getParameter("rollNumber");

            StudentDAO dao = new StudentDAO();
            boolean isDeleted = dao.deleteStudent(rollNumber);

            if (isDeleted) {
                request.setAttribute("message", "Student deleted successfully!");
            } else {
                request.setAttribute("message", "Failed to delete student.");
            }

            List<StudentBean> updatedList = new StudentDAO().getAllStudents();
            request.setAttribute("studentList", updatedList);

            request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
                   .forward(request, response);

        } else if (action.equals("showUpdateDues")) {
            String rollNumber = request.getParameter("rollNumber");

            StudentDAO dao = new StudentDAO();
            List<StudentBean> students = dao.getAllStudents();
            request.setAttribute("studentList", students);
            request.setAttribute("updateRollNumber", rollNumber);

            for (StudentBean s : students) {
                if (s.getRollNumber().equals(rollNumber)) {
                    request.setAttribute("currentDues", s.getDues());
                    request.setAttribute("updateStudentName", s.getName());
                    break;
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
                   .forward(request, response);

        } else if (action.equals("showChangePassword")) {
            String rollNumber = request.getParameter("rollNumber");

            StudentDAO dao = new StudentDAO();
            List<StudentBean> students = dao.getAllStudents();
            request.setAttribute("studentList", students);
            request.setAttribute("changePasswordRoll", rollNumber);

            for (StudentBean s : students) {
                if (s.getRollNumber().equals(rollNumber)) {
                    request.setAttribute("changePasswordName", s.getName());
                    break;
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
                   .forward(request, response);

        } else if (action.equals("showUploadMarks")) {      // ← NEW
            String rollNumber = request.getParameter("rollNumber");

            StudentDAO dao = new StudentDAO();
            List<StudentBean> students = dao.getAllStudents();
            for (StudentBean s : students) {
                if (s.getRollNumber().equals(rollNumber)) {
                    request.setAttribute("uploadStudent", s);
                    break;
                }
            }

            request.getRequestDispatcher("/WEB-INF/views/uploadMarks.jsp")
                   .forward(request, response);
        }
    }

    // ════════════════════════════════════
    // handleAddStudent — form submission
    // ════════════════════════════════════
    private void handleAddStudent(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {

        String rollNumber = request.getParameter("rollNumber");
        String name       = request.getParameter("name");
        String email      = request.getParameter("email");
        String course     = request.getParameter("course");
        int semester      = Integer.parseInt(request.getParameter("semester"));
        double dues       = Double.parseDouble(request.getParameter("dues"));
        String password   = request.getParameter("password");

        StudentBean student = new StudentBean();
        student.setRollNumber(rollNumber);
        student.setName(name);
        student.setEmail(email);
        student.setCourse(course);
        student.setSemester(semester);
        student.setDues(dues);
        student.setPassword(password);

        StudentDAO dao = new StudentDAO();
        boolean success = dao.addStudent(student);

        request.setAttribute("totalStudents", dao.getTotalStudents());
        request.setAttribute("pendingDues",   dao.getTotalPendingDues());
        request.setAttribute("totalCourses",  dao.getTotalCourses());

        if (success) {
            request.setAttribute("message", "Student added successfully!");
        } else {
            request.setAttribute("message", "Failed to add student. Try again!");
        }

        request.getRequestDispatcher("/WEB-INF/views/adminDashboard.jsp")
               .forward(request, response);
    }

    // ════════════════════════════════════
    // handleUpdateDues — form submission
    // ════════════════════════════════════
    private void handleUpdateDues(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {

        String rollNumber = request.getParameter("rollNumber");
        double newDues = Double.parseDouble(request.getParameter("newDues"));

        StudentDAO dao = new StudentDAO();
        boolean success = dao.updateDues(rollNumber, newDues);

        if (success) {
            request.setAttribute("message", "Dues updated successfully!");
        } else {
            request.setAttribute("message", "Failed to update dues.");
        }

        List<StudentBean> updatedList = dao.getAllStudents();
        request.setAttribute("studentList", updatedList);

        request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
               .forward(request, response);
    }

    // ════════════════════════════════════
    // handleChangePassword — form submission
    // ════════════════════════════════════
    private void handleChangePassword(HttpServletRequest request,
                                       HttpServletResponse response)
            throws ServletException, IOException {

        String rollNumber  = request.getParameter("rollNumber");
        String newPassword = request.getParameter("newPassword");

        StudentDAO dao = new StudentDAO();
        boolean success = dao.changePassword(rollNumber, newPassword);

        if (success) {
            request.setAttribute("message", "Password changed successfully!");
        } else {
            request.setAttribute("message", "Failed to change password.");
        }

        List<StudentBean> updatedList = dao.getAllStudents();
        request.setAttribute("studentList", updatedList);

        request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
               .forward(request, response);
    }

    // ════════════════════════════════════
    // handleUploadMarks — form submission  ← NEW
    // ════════════════════════════════════
    private void handleUploadMarks(HttpServletRequest request,
                                    HttpServletResponse response)
            throws ServletException, IOException {

        String rollNumber = request.getParameter("rollNumber");
        String sub1Name   = request.getParameter("sub1Name");
        int    sub1Marks  = Integer.parseInt(request.getParameter("sub1Marks"));
        String sub2Name   = request.getParameter("sub2Name");
        int    sub2Marks  = Integer.parseInt(request.getParameter("sub2Marks"));
        String sub3Name   = request.getParameter("sub3Name");
        int    sub3Marks  = Integer.parseInt(request.getParameter("sub3Marks"));

        StudentDAO dao = new StudentDAO();
        boolean success = dao.uploadMarks(rollNumber,
                                           sub1Name, sub1Marks,
                                           sub2Name, sub2Marks,
                                           sub3Name, sub3Marks);

        List<StudentBean> updatedList = dao.getAllStudents();
        request.setAttribute("studentList", updatedList);

        if (success) {
            request.setAttribute("message", "Marks uploaded successfully for " + rollNumber + "!");
        } else {
            request.setAttribute("message", "Failed to upload marks. Student may already have marks.");
        }

        request.getRequestDispatcher("/WEB-INF/views/manageStudents.jsp")
               .forward(request, response);
    }
}