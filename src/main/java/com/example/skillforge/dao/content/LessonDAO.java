package com.example.skillforge.dao.content;

import com.example.skillforge.models.content.LessonModel;
import com.example.skillforge.models.course.ModuleModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Module Lessons
 */
public class LessonDAO {
    private static final Logger LOGGER = Logger.getLogger(LessonDAO.class.getName());
    
    private static final String INSERT_LESSON_SQL = 
            "INSERT INTO Lesson (ModuleID, Title, Content, Duration, ResourceLink) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_LESSONS_BY_MODULE_SQL = 
            "SELECT * FROM Lesson WHERE ModuleID = ? ORDER BY LessonID";
    private static final String SELECT_LESSON_BY_ID_SQL = 
            "SELECT * FROM Lesson WHERE LessonID = ?";
    private static final String UPDATE_LESSON_SQL = 
            "UPDATE Lesson SET Title = ?, Content = ?, Duration = ?, ResourceLink = ? WHERE LessonID = ?";
    private static final String DELETE_LESSON_SQL = 
            "DELETE FROM Lesson WHERE LessonID = ?";
    private static final String COUNT_LESSONS_BY_MODULE_SQL = 
            "SELECT COUNT(*) FROM Lesson WHERE ModuleID = ?";
    private static final String COUNT_LESSONS_BY_COURSE_SQL = 
            "SELECT COUNT(*) FROM Lesson l JOIN Module m ON l.ModuleID = m.ModuleID WHERE m.CourseID = ?";
    
    /**
     * Insert a new lesson
     * @param lesson The lesson to insert
     * @return The ID of the inserted lesson, or 0 if insertion failed
     */
    public static int insertLesson(LessonModel lesson) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_LESSON_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, lesson.getModuleId());
            preparedStatement.setString(2, lesson.getTitle());
            preparedStatement.setString(3, lesson.getContent());
            preparedStatement.setInt(4, lesson.getDuration());
            preparedStatement.setString(5, lesson.getResourceLink());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting lesson", e);
        }
        return 0;
    }
    
    /**
     * Get all lessons for a module
     * @param moduleId The ID of the module
     * @return A list of lessons for the module
     */
    public static List<LessonModel> getLessonsByModule(int moduleId) {
        List<LessonModel> lessons = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_LESSONS_BY_MODULE_SQL)) {
            
            preparedStatement.setInt(1, moduleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                lessons.add(mapResultSetToLessonModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting lessons by module", e);
        }
        return lessons;
    }
    
    /**
     * Get a lesson by ID
     * @param lessonId The ID of the lesson
     * @return The lesson, or null if not found
     */
    public static LessonModel getLessonById(int lessonId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_LESSON_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, lessonId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToLessonModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting lesson by ID", e);
        }
        return null;
    }
    
    /**
     * Update a lesson
     * @param lesson The lesson to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateLesson(LessonModel lesson) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_LESSON_SQL)) {
            
            preparedStatement.setString(1, lesson.getTitle());
            preparedStatement.setString(2, lesson.getContent());
            preparedStatement.setInt(3, lesson.getDuration());
            preparedStatement.setString(4, lesson.getResourceLink());
            preparedStatement.setInt(5, lesson.getLessonId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating lesson", e);
        }
        return false;
    }
    
    /**
     * Delete a lesson
     * @param lessonId The ID of the lesson to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteLesson(int lessonId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_LESSON_SQL)) {
            
            preparedStatement.setInt(1, lessonId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting lesson", e);
        }
        return false;
    }
    
    /**
     * Count the number of lessons in a module
     * @param moduleId The ID of the module
     * @return The number of lessons in the module
     */
    public static int countLessonsByModule(int moduleId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_LESSONS_BY_MODULE_SQL)) {
            
            preparedStatement.setInt(1, moduleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting lessons by module", e);
        }
        return 0;
    }
    
    /**
     * Count the number of lessons in a course
     * @param courseId The ID of the course
     * @return The number of lessons in the course
     */
    public static int countLessonsByCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_LESSONS_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting lessons by course", e);
        }
        return 0;
    }
    
    /**
     * Map a ResultSet to a LessonModel
     * @param resultSet The ResultSet to map
     * @return A LessonModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static LessonModel mapResultSetToLessonModel(ResultSet resultSet) throws SQLException {
        LessonModel lesson = new LessonModel();
        lesson.setLessonId(resultSet.getInt("LessonID"));
        lesson.setModuleId(resultSet.getInt("ModuleID"));
        lesson.setTitle(resultSet.getString("Title"));
        lesson.setContent(resultSet.getString("Content"));
        lesson.setDuration(resultSet.getInt("Duration"));
        lesson.setResourceLink(resultSet.getString("ResourceLink"));
        return lesson;
    }
}
