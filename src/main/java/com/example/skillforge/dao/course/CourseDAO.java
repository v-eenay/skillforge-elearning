package com.example.skillforge.dao.course;

import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Courses
 */
public class CourseDAO {
    private static final Logger LOGGER = Logger.getLogger(CourseDAO.class.getName());
    
    private static final String INSERT_COURSE_SQL = 
            "INSERT INTO Course (Title, Description, CategoryID, Level, Thumbnail, Status, CreatedBy) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_COURSES_SQL = 
            "SELECT c.*, cat.Name as CategoryName, cat.Description as CategoryDescription, " +
            "u.Name as CreatorName, u.UserName as CreatorUserName, u.ProfileImage as CreatorProfileImage " +
            "FROM Course c " +
            "JOIN Category cat ON c.CategoryID = cat.CategoryID " +
            "JOIN User u ON c.CreatedBy = u.UserID " +
            "ORDER BY c.CreatedAt DESC";
    private static final String SELECT_COURSE_BY_ID_SQL = 
            "SELECT c.*, cat.Name as CategoryName, cat.Description as CategoryDescription, " +
            "u.Name as CreatorName, u.UserName as CreatorUserName, u.ProfileImage as CreatorProfileImage " +
            "FROM Course c " +
            "JOIN Category cat ON c.CategoryID = cat.CategoryID " +
            "JOIN User u ON c.CreatedBy = u.UserID " +
            "WHERE c.CourseID = ?";
    private static final String SELECT_COURSES_BY_CATEGORY_SQL = 
            "SELECT c.*, cat.Name as CategoryName, cat.Description as CategoryDescription, " +
            "u.Name as CreatorName, u.UserName as CreatorUserName, u.ProfileImage as CreatorProfileImage " +
            "FROM Course c " +
            "JOIN Category cat ON c.CategoryID = cat.CategoryID " +
            "JOIN User u ON c.CreatedBy = u.UserID " +
            "WHERE c.CategoryID = ? " +
            "ORDER BY c.CreatedAt DESC";
    private static final String SELECT_COURSES_BY_INSTRUCTOR_SQL = 
            "SELECT c.*, cat.Name as CategoryName, cat.Description as CategoryDescription, " +
            "u.Name as CreatorName, u.UserName as CreatorUserName, u.ProfileImage as CreatorProfileImage " +
            "FROM Course c " +
            "JOIN Category cat ON c.CategoryID = cat.CategoryID " +
            "JOIN User u ON c.CreatedBy = u.UserID " +
            "WHERE c.CreatedBy = ? " +
            "ORDER BY c.CreatedAt DESC";
    private static final String UPDATE_COURSE_SQL = 
            "UPDATE Course SET Title = ?, Description = ?, CategoryID = ?, Level = ?, " +
            "Thumbnail = ?, Status = ? WHERE CourseID = ?";
    private static final String DELETE_COURSE_SQL = 
            "DELETE FROM Course WHERE CourseID = ?";
    private static final String COUNT_COURSES_SQL = 
            "SELECT COUNT(*) FROM Course";
    private static final String COUNT_ACTIVE_COURSES_SQL = 
            "SELECT COUNT(*) FROM Course WHERE Status = 'active'";
    
    /**
     * Insert a new course
     * @param course The course to insert
     * @return The ID of the inserted course, or 0 if insertion failed
     */
    public static int insertCourse(CourseModel course) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_COURSE_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setString(1, course.getTitle());
            preparedStatement.setString(2, course.getDescription());
            preparedStatement.setInt(3, course.getCategoryId());
            preparedStatement.setString(4, course.getLevel());
            preparedStatement.setString(5, course.getThumbnail());
            preparedStatement.setString(6, course.getStatus().toString());
            preparedStatement.setInt(7, course.getCreatedBy());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting course", e);
        }
        return 0;
    }
    
    /**
     * Get all courses with category and creator information
     * @return A list of all courses
     */
    public static List<CourseModel> getAllCourses() {
        List<CourseModel> courses = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_COURSES_SQL)) {
            
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                courses.add(mapResultSetToCourseModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all courses", e);
        }
        return courses;
    }
    
    /**
     * Get a course by ID with category and creator information
     * @param courseId The ID of the course
     * @return The course, or null if not found
     */
    public static CourseModel getCourseById(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSE_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToCourseModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting course by ID", e);
        }
        return null;
    }
    
    /**
     * Get courses by category
     * @param categoryId The ID of the category
     * @return A list of courses in the category
     */
    public static List<CourseModel> getCoursesByCategory(int categoryId) {
        List<CourseModel> courses = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSES_BY_CATEGORY_SQL)) {
            
            preparedStatement.setInt(1, categoryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                courses.add(mapResultSetToCourseModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting courses by category", e);
        }
        return courses;
    }
    
    /**
     * Get courses by instructor
     * @param instructorId The ID of the instructor
     * @return A list of courses created by the instructor
     */
    public static List<CourseModel> getCoursesByInstructor(int instructorId) {
        List<CourseModel> courses = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSES_BY_INSTRUCTOR_SQL)) {
            
            preparedStatement.setInt(1, instructorId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                courses.add(mapResultSetToCourseModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting courses by instructor", e);
        }
        return courses;
    }
    
    /**
     * Update a course
     * @param course The course to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateCourse(CourseModel course) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_COURSE_SQL)) {
            
            preparedStatement.setString(1, course.getTitle());
            preparedStatement.setString(2, course.getDescription());
            preparedStatement.setInt(3, course.getCategoryId());
            preparedStatement.setString(4, course.getLevel());
            preparedStatement.setString(5, course.getThumbnail());
            preparedStatement.setString(6, course.getStatus().toString());
            preparedStatement.setInt(7, course.getCourseId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating course", e);
        }
        return false;
    }
    
    /**
     * Delete a course
     * @param courseId The ID of the course to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting course", e);
        }
        return false;
    }
    
    /**
     * Count the total number of courses
     * @return The total number of courses
     */
    public static int countCourses() {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_COURSES_SQL)) {
            
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting courses", e);
        }
        return 0;
    }
    
    /**
     * Count the number of active courses
     * @return The number of active courses
     */
    public static int countActiveCourses() {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ACTIVE_COURSES_SQL)) {
            
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting active courses", e);
        }
        return 0;
    }
    
    /**
     * Map a ResultSet to a CourseModel with category and creator information
     * @param resultSet The ResultSet to map
     * @return A CourseModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static CourseModel mapResultSetToCourseModel(ResultSet resultSet) throws SQLException {
        CourseModel course = new CourseModel();
        course.setCourseId(resultSet.getInt("CourseID"));
        course.setTitle(resultSet.getString("Title"));
        course.setDescription(resultSet.getString("Description"));
        course.setCategoryId(resultSet.getInt("CategoryID"));
        course.setLevel(resultSet.getString("Level"));
        course.setThumbnail(resultSet.getString("Thumbnail"));
        course.setStatus(CourseModel.Status.valueOf(resultSet.getString("Status")));
        course.setCreatedBy(resultSet.getInt("CreatedBy"));
        
        // Handle timestamps
        Timestamp createdAtTimestamp = resultSet.getTimestamp("CreatedAt");
        if (createdAtTimestamp != null) {
            course.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        }
        
        Timestamp updatedAtTimestamp = resultSet.getTimestamp("UpdatedAt");
        if (updatedAtTimestamp != null) {
            course.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        
        // Set category information
        CategoryModel category = new CategoryModel();
        category.setCategoryId(resultSet.getInt("CategoryID"));
        category.setName(resultSet.getString("CategoryName"));
        category.setDescription(resultSet.getString("CategoryDescription"));
        course.setCategory(category);
        
        // Set creator information
        UserModel creator = new UserModel();
        creator.setUserId(resultSet.getInt("CreatedBy"));
        creator.setName(resultSet.getString("CreatorName"));
        creator.setUserName(resultSet.getString("CreatorUserName"));
        creator.setProfileImage(resultSet.getString("CreatorProfileImage"));
        course.setCreator(creator);
        
        return course;
    }
}
