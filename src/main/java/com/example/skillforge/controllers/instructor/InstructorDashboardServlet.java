package com.example.skillforge.controllers.instructor;

import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.user.UserModel;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;

import java.io.IOException;
import java.util.List;

@WebServlet(name = "InstructorDashboardServlet", value = "/instructor/dashboard")
public class InstructorDashboardServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Get the logged-in user
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Get instructor's courses
        List<CourseModel> courses = CourseDAO.getCoursesByInstructor(user.getUserId());
        request.setAttribute("courses", courses);

        // Get statistics
        int totalCourses = courses.size();
        int activeCourses = 0;

        for (CourseModel course : courses) {
            if (course.getStatus() == CourseModel.Status.active) {
                activeCourses++;
            }
        }

        request.setAttribute("totalCourses", totalCourses);
        request.setAttribute("activeCourses", activeCourses);
        request.setAttribute("draftCourses", totalCourses - activeCourses);

        request.getRequestDispatcher("/WEB-INF/views/instructor/instructor-dashboard.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

    }
}