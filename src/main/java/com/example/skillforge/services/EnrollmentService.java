package com.example.skillforge.services;

import com.example.skillforge.dao.enrollment.EnrollmentDAO;
import com.example.skillforge.models.enrollment.EnrollmentModel;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Logger;

/**
 * Service for handling course enrollments
 */
public class EnrollmentService {
    private static final Logger LOGGER = Logger.getLogger(EnrollmentService.class.getName());
    
    /**
     * Enroll a user in a course
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @return The ID of the new enrollment, or 0 if enrollment failed
     */
    public static int enrollUserInCourse(int userId, int courseId) {
        // Check if user is already enrolled
        if (EnrollmentDAO.isUserEnrolled(userId, courseId)) {
            LOGGER.info("User " + userId + " is already enrolled in course " + courseId);
            return 0;
        }
        
        // Create new enrollment
        EnrollmentModel enrollment = new EnrollmentModel();
        enrollment.setUserId(userId);
        enrollment.setCourseId(courseId);
        enrollment.setStatus(EnrollmentModel.Status.ACTIVE);
        enrollment.setEnrolledAt(LocalDateTime.now());
        enrollment.setProgressPercentage(0.0);
        
        // Insert enrollment
        int enrollmentId = EnrollmentDAO.insertEnrollment(enrollment);
        if (enrollmentId > 0) {
            LOGGER.info("User " + userId + " enrolled in course " + courseId + " successfully");
        } else {
            LOGGER.warning("Failed to enroll user " + userId + " in course " + courseId);
        }
        
        return enrollmentId;
    }
    
    /**
     * Get all enrollments for a user
     * @param userId The ID of the user
     * @return A list of enrollments for the user
     */
    public static List<EnrollmentModel> getUserEnrollments(int userId) {
        return EnrollmentDAO.getEnrollmentsByUser(userId);
    }
    
    /**
     * Get all enrollments for a course
     * @param courseId The ID of the course
     * @return A list of enrollments for the course
     */
    public static List<EnrollmentModel> getCourseEnrollments(int courseId) {
        return EnrollmentDAO.getEnrollmentsByCourse(courseId);
    }
    
    /**
     * Update a user's progress in a course
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @param progressPercentage The new progress percentage
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateUserProgress(int userId, int courseId, double progressPercentage) {
        EnrollmentModel enrollment = EnrollmentDAO.getEnrollmentByUserAndCourse(userId, courseId);
        if (enrollment == null) {
            LOGGER.warning("User " + userId + " is not enrolled in course " + courseId);
            return false;
        }
        
        enrollment.setProgressPercentage(progressPercentage);
        enrollment.setLastAccessedAt(LocalDateTime.now());
        
        // If progress is 100%, mark as completed
        if (progressPercentage >= 100.0) {
            enrollment.setStatus(EnrollmentModel.Status.COMPLETED);
            enrollment.setCompletedAt(LocalDateTime.now());
        }
        
        return EnrollmentDAO.updateEnrollment(enrollment);
    }
    
    /**
     * Check if a user is enrolled in a course
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @return true if the user is enrolled in the course, false otherwise
     */
    public static boolean isUserEnrolled(int userId, int courseId) {
        return EnrollmentDAO.isUserEnrolled(userId, courseId);
    }
    
    /**
     * Get the number of students enrolled in a course
     * @param courseId The ID of the course
     * @return The number of enrollments for the course
     */
    public static int getEnrollmentCount(int courseId) {
        return EnrollmentDAO.countEnrollmentsByCourse(courseId);
    }
    
    /**
     * Unenroll a user from a course
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @return true if the unenrollment was successful, false otherwise
     */
    public static boolean unenrollUserFromCourse(int userId, int courseId) {
        EnrollmentModel enrollment = EnrollmentDAO.getEnrollmentByUserAndCourse(userId, courseId);
        if (enrollment == null) {
            LOGGER.warning("User " + userId + " is not enrolled in course " + courseId);
            return false;
        }
        
        return EnrollmentDAO.deleteEnrollment(enrollment.getEnrollmentId());
    }
}
