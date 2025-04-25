package com.example.skillforge.dao.enrollment;

import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.user.UserDAO;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.enrollment.EnrollmentModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Course Enrollments
 */
public class EnrollmentDAO {
    private static final Logger LOGGER = Logger.getLogger(EnrollmentDAO.class.getName());
    
    private static final String INSERT_ENROLLMENT_SQL = 
            "INSERT INTO Enrollment (UserID, CourseID, Status, EnrolledAt, ProgressPercentage) " +
            "VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ENROLLMENTS_BY_USER_SQL = 
            "SELECT * FROM Enrollment WHERE UserID = ? ORDER BY EnrolledAt DESC";
    private static final String SELECT_ENROLLMENTS_BY_COURSE_SQL = 
            "SELECT * FROM Enrollment WHERE CourseID = ? ORDER BY EnrolledAt DESC";
    private static final String SELECT_ENROLLMENT_BY_ID_SQL = 
            "SELECT * FROM Enrollment WHERE EnrollmentID = ?";
    private static final String SELECT_ENROLLMENT_BY_USER_AND_COURSE_SQL = 
            "SELECT * FROM Enrollment WHERE UserID = ? AND CourseID = ?";
    private static final String UPDATE_ENROLLMENT_SQL = 
            "UPDATE Enrollment SET Status = ?, CompletedAt = ?, LastAccessedAt = ?, " +
            "ProgressPercentage = ? WHERE EnrollmentID = ?";
    private static final String DELETE_ENROLLMENT_SQL = 
            "DELETE FROM Enrollment WHERE EnrollmentID = ?";
    private static final String COUNT_ENROLLMENTS_BY_COURSE_SQL = 
            "SELECT COUNT(*) FROM Enrollment WHERE CourseID = ?";
    private static final String COUNT_ENROLLMENTS_BY_USER_SQL = 
            "SELECT COUNT(*) FROM Enrollment WHERE UserID = ?";
    
    /**
     * Insert a new enrollment
     * @param enrollment The enrollment to insert
     * @return The ID of the inserted enrollment, or 0 if insertion failed
     */
    public static int insertEnrollment(EnrollmentModel enrollment) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ENROLLMENT_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, enrollment.getUserId());
            preparedStatement.setInt(2, enrollment.getCourseId());
            preparedStatement.setString(3, enrollment.getStatus().toString());
            
            // Set current timestamp for enrollment date
            LocalDateTime now = LocalDateTime.now();
            enrollment.setEnrolledAt(now);
            preparedStatement.setTimestamp(4, Timestamp.valueOf(now));
            
            // Initial progress is 0%
            preparedStatement.setDouble(5, 0.0);
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting enrollment", e);
        }
        return 0;
    }
    
    /**
     * Get all enrollments for a user
     * @param userId The ID of the user
     * @return A list of enrollments for the user
     */
    public static List<EnrollmentModel> getEnrollmentsByUser(int userId) {
        List<EnrollmentModel> enrollments = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ENROLLMENTS_BY_USER_SQL)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                enrollments.add(mapResultSetToEnrollmentModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollments by user", e);
        }
        return enrollments;
    }
    
    /**
     * Get all enrollments for a course
     * @param courseId The ID of the course
     * @return A list of enrollments for the course
     */
    public static List<EnrollmentModel> getEnrollmentsByCourse(int courseId) {
        List<EnrollmentModel> enrollments = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ENROLLMENTS_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                enrollments.add(mapResultSetToEnrollmentModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollments by course", e);
        }
        return enrollments;
    }
    
    /**
     * Get an enrollment by ID
     * @param enrollmentId The ID of the enrollment
     * @return The enrollment, or null if not found
     */
    public static EnrollmentModel getEnrollmentById(int enrollmentId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ENROLLMENT_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, enrollmentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToEnrollmentModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment by ID", e);
        }
        return null;
    }
    
    /**
     * Get an enrollment by user and course
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @return The enrollment, or null if not found
     */
    public static EnrollmentModel getEnrollmentByUserAndCourse(int userId, int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ENROLLMENT_BY_USER_AND_COURSE_SQL)) {
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToEnrollmentModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting enrollment by user and course", e);
        }
        return null;
    }
    
    /**
     * Update an enrollment
     * @param enrollment The enrollment to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateEnrollment(EnrollmentModel enrollment) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ENROLLMENT_SQL)) {
            
            preparedStatement.setString(1, enrollment.getStatus().toString());
            
            // Handle nullable timestamps
            if (enrollment.getCompletedAt() != null) {
                preparedStatement.setTimestamp(2, Timestamp.valueOf(enrollment.getCompletedAt()));
            } else {
                preparedStatement.setNull(2, Types.TIMESTAMP);
            }
            
            // Update last accessed timestamp
            LocalDateTime now = LocalDateTime.now();
            enrollment.setLastAccessedAt(now);
            preparedStatement.setTimestamp(3, Timestamp.valueOf(now));
            
            preparedStatement.setDouble(4, enrollment.getProgressPercentage());
            preparedStatement.setInt(5, enrollment.getEnrollmentId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating enrollment", e);
        }
        return false;
    }
    
    /**
     * Delete an enrollment
     * @param enrollmentId The ID of the enrollment to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteEnrollment(int enrollmentId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ENROLLMENT_SQL)) {
            
            preparedStatement.setInt(1, enrollmentId);
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting enrollment", e);
        }
        return false;
    }
    
    /**
     * Count enrollments for a course
     * @param courseId The ID of the course
     * @return The number of enrollments for the course
     */
    public static int countEnrollmentsByCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ENROLLMENTS_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting enrollments by course", e);
        }
        return 0;
    }
    
    /**
     * Count enrollments for a user
     * @param userId The ID of the user
     * @return The number of enrollments for the user
     */
    public static int countEnrollmentsByUser(int userId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ENROLLMENTS_BY_USER_SQL)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting enrollments by user", e);
        }
        return 0;
    }
    
    /**
     * Check if a user is enrolled in a course
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @return true if the user is enrolled in the course, false otherwise
     */
    public static boolean isUserEnrolled(int userId, int courseId) {
        return getEnrollmentByUserAndCourse(userId, courseId) != null;
    }
    
    /**
     * Map a ResultSet to an EnrollmentModel
     * @param resultSet The ResultSet to map
     * @return An EnrollmentModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static EnrollmentModel mapResultSetToEnrollmentModel(ResultSet resultSet) throws SQLException {
        EnrollmentModel enrollment = new EnrollmentModel();
        enrollment.setEnrollmentId(resultSet.getInt("EnrollmentID"));
        enrollment.setUserId(resultSet.getInt("UserID"));
        enrollment.setCourseId(resultSet.getInt("CourseID"));
        enrollment.setStatus(EnrollmentModel.Status.valueOf(resultSet.getString("Status")));
        
        // Handle timestamps
        Timestamp enrolledAt = resultSet.getTimestamp("EnrolledAt");
        if (enrolledAt != null) {
            enrollment.setEnrolledAt(enrolledAt.toLocalDateTime());
        }
        
        Timestamp completedAt = resultSet.getTimestamp("CompletedAt");
        if (completedAt != null) {
            enrollment.setCompletedAt(completedAt.toLocalDateTime());
        }
        
        Timestamp lastAccessedAt = resultSet.getTimestamp("LastAccessedAt");
        if (lastAccessedAt != null) {
            enrollment.setLastAccessedAt(lastAccessedAt.toLocalDateTime());
        }
        
        enrollment.setProgressPercentage(resultSet.getDouble("ProgressPercentage"));
        
        // Load related entities
        UserModel student = UserDAO.getUserById(enrollment.getUserId());
        enrollment.setStudent(student);
        
        CourseModel course = CourseDAO.getCourseById(enrollment.getCourseId());
        enrollment.setCourse(course);
        
        return enrollment;
    }
}
