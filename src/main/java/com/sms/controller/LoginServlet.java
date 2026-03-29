package com.sms.controller;
import com.sms.dao.StudentDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import com.sms.dao.AdminDAO;
import com.sms.model.AdminBean;
import com.sms.model.StudentBean;


@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        AdminDAO adminDAO = new AdminDAO();
        StudentDAO studentDAO = new StudentDAO();

        
        AdminBean admin = adminDAO.login(username, password);

        if (admin != null) {
            
            HttpSession session = request.getSession();

            
            session.setAttribute("admin", admin);
            StudentDAO dao = new StudentDAO();
            request.setAttribute("totalStudents", dao.getTotalStudents());
            request.setAttribute("pendingDues",   dao.getTotalPendingDues());
            request.setAttribute("totalCourses",  dao.getTotalCourses());
            
            request.getRequestDispatcher("/WEB-INF/views/adminDashboard.jsp")
            .forward(request, response);
            return; 
        }

       
        StudentBean student = studentDAO.login(username, password);

        if (student != null) {

            HttpSession session = request.getSession();

            session.setAttribute("student", student);

            request.getRequestDispatcher("/WEB-INF/views/studentDashboard.jsp")
            .forward(request, response);
            return; 
        }

        
        request.setAttribute("error", "Invalid username or password!");

        request.getRequestDispatcher("/login.jsp")
               .forward(request, response);
    }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        // Just show the login page
        request.getRequestDispatcher("/login.jsp")
               .forward(request, response);
    }
}