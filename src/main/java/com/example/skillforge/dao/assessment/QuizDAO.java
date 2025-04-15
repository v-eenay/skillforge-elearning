package com.example.skillforge.dao.assessment;

import com.example.skillforge.models.assessment.QuizModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Quizzes
 */
public class QuizDAO {
    private static final Logger LOGGER = Logger.getLogger(QuizDAO.class.getName());
    
    private static final String INSERT_QUIZ_SQL = 
            "INSERT INTO Quiz (CourseID, ModuleID, AssessmentID, Title, Description, TotalMarks, " +
            "PassingMarks, Duration, MaxAttempts, RandomizeQuestions, ShowAnswersAfterSubmission, " +
            "Status, AvailableFrom, AvailableUntil) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_QUIZZES_BY_COURSE_SQL = 
            "SELECT * FROM Quiz WHERE CourseID = ? ORDER BY CreatedAt DESC";
    private static final String SELECT_QUIZZES_BY_MODULE_SQL = 
            "SELECT * FROM Quiz WHERE ModuleID = ? ORDER BY CreatedAt DESC";
    private static final String SELECT_QUIZZES_BY_ASSESSMENT_SQL = 
            "SELECT * FROM Quiz WHERE AssessmentID = ? ORDER BY CreatedAt DESC";
    private static final String SELECT_QUIZ_BY_ID_SQL = 
            "SELECT * FROM Quiz WHERE QuizID = ?";
    private static final String UPDATE_QUIZ_SQL = 
            "UPDATE Quiz SET Title = ?, Description = ?, TotalMarks = ?, PassingMarks = ?, " +
            "Duration = ?, MaxAttempts = ?, RandomizeQuestions = ?, ShowAnswersAfterSubmission = ?, " +
            "Status = ?, AvailableFrom = ?, AvailableUntil = ? WHERE QuizID = ?";
    private static final String DELETE_QUIZ_SQL = 
            "DELETE FROM Quiz WHERE QuizID = ?";
    private static final String COUNT_QUIZZES_BY_COURSE_SQL = 
            "SELECT COUNT(*) FROM Quiz WHERE CourseID = ?";
    private static final String COUNT_QUIZZES_BY_MODULE_SQL = 
            "SELECT COUNT(*) FROM Quiz WHERE ModuleID = ?";
    
    /**
     * Insert a new quiz
     * @param quiz The quiz to insert
     * @return The ID of the inserted quiz, or 0 if insertion failed
     */
    public static int insertQuiz(QuizModel quiz) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUIZ_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            // Handle nullable foreign keys
            if (quiz.getCourseId() != null) {
                preparedStatement.setInt(1, quiz.getCourseId());
            } else {
                preparedStatement.setNull(1, Types.INTEGER);
            }
            
            if (quiz.getModuleId() != null) {
                preparedStatement.setInt(2, quiz.getModuleId());
            } else {
                preparedStatement.setNull(2, Types.INTEGER);
            }
            
            if (quiz.getAssessmentId() != null) {
                preparedStatement.setInt(3, quiz.getAssessmentId());
            } else {
                preparedStatement.setNull(3, Types.INTEGER);
            }
            
            preparedStatement.setString(4, quiz.getTitle());
            preparedStatement.setString(5, quiz.getDescription());
            preparedStatement.setInt(6, quiz.getTotalMarks());
            preparedStatement.setInt(7, quiz.getPassingMarks());
            preparedStatement.setInt(8, quiz.getDuration());
            preparedStatement.setInt(9, quiz.getMaxAttempts());
            preparedStatement.setBoolean(10, quiz.isRandomizeQuestions());
            preparedStatement.setBoolean(11, quiz.isShowAnswersAfterSubmission());
            preparedStatement.setString(12, quiz.getStatus().toString());
            
            // Handle timestamps
            if (quiz.getAvailableFrom() != null) {
                preparedStatement.setTimestamp(13, Timestamp.valueOf(quiz.getAvailableFrom()));
            } else {
                preparedStatement.setNull(13, Types.TIMESTAMP);
            }
            
            if (quiz.getAvailableUntil() != null) {
                preparedStatement.setTimestamp(14, Timestamp.valueOf(quiz.getAvailableUntil()));
            } else {
                preparedStatement.setNull(14, Types.TIMESTAMP);
            }
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting quiz", e);
        }
        return 0;
    }
    
    /**
     * Get all quizzes for a course
     * @param courseId The ID of the course
     * @return A list of quizzes for the course
     */
    public static List<QuizModel> getQuizzesByCourse(int courseId) {
        List<QuizModel> quizzes = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUIZZES_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                quizzes.add(mapResultSetToQuizModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting quizzes by course", e);
        }
        return quizzes;
    }
    
    /**
     * Get all quizzes for a module
     * @param moduleId The ID of the module
     * @return A list of quizzes for the module
     */
    public static List<QuizModel> getQuizzesByModule(int moduleId) {
        List<QuizModel> quizzes = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUIZZES_BY_MODULE_SQL)) {
            
            preparedStatement.setInt(1, moduleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                quizzes.add(mapResultSetToQuizModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting quizzes by module", e);
        }
        return quizzes;
    }
    
    /**
     * Get all quizzes for an assessment
     * @param assessmentId The ID of the assessment
     * @return A list of quizzes for the assessment
     */
    public static List<QuizModel> getQuizzesByAssessment(int assessmentId) {
        List<QuizModel> quizzes = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUIZZES_BY_ASSESSMENT_SQL)) {
            
            preparedStatement.setInt(1, assessmentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                quizzes.add(mapResultSetToQuizModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting quizzes by assessment", e);
        }
        return quizzes;
    }
    
    /**
     * Get a quiz by ID
     * @param quizId The ID of the quiz
     * @return The quiz, or null if not found
     */
    public static QuizModel getQuizById(int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUIZ_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToQuizModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting quiz by ID", e);
        }
        return null;
    }
    
    /**
     * Update a quiz
     * @param quiz The quiz to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateQuiz(QuizModel quiz) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUIZ_SQL)) {
            
            preparedStatement.setString(1, quiz.getTitle());
            preparedStatement.setString(2, quiz.getDescription());
            preparedStatement.setInt(3, quiz.getTotalMarks());
            preparedStatement.setInt(4, quiz.getPassingMarks());
            preparedStatement.setInt(5, quiz.getDuration());
            preparedStatement.setInt(6, quiz.getMaxAttempts());
            preparedStatement.setBoolean(7, quiz.isRandomizeQuestions());
            preparedStatement.setBoolean(8, quiz.isShowAnswersAfterSubmission());
            preparedStatement.setString(9, quiz.getStatus().toString());
            
            // Handle timestamps
            if (quiz.getAvailableFrom() != null) {
                preparedStatement.setTimestamp(10, Timestamp.valueOf(quiz.getAvailableFrom()));
            } else {
                preparedStatement.setNull(10, Types.TIMESTAMP);
            }
            
            if (quiz.getAvailableUntil() != null) {
                preparedStatement.setTimestamp(11, Timestamp.valueOf(quiz.getAvailableUntil()));
            } else {
                preparedStatement.setNull(11, Types.TIMESTAMP);
            }
            
            preparedStatement.setInt(12, quiz.getQuizId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating quiz", e);
        }
        return false;
    }
    
    /**
     * Delete a quiz
     * @param quizId The ID of the quiz to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteQuiz(int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting quiz", e);
        }
        return false;
    }
    
    /**
     * Count the number of quizzes for a course
     * @param courseId The ID of the course
     * @return The number of quizzes for the course
     */
    public static int countQuizzesByCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_QUIZZES_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting quizzes by course", e);
        }
        return 0;
    }
    
    /**
     * Count the number of quizzes for a module
     * @param moduleId The ID of the module
     * @return The number of quizzes for the module
     */
    public static int countQuizzesByModule(int moduleId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_QUIZZES_BY_MODULE_SQL)) {
            
            preparedStatement.setInt(1, moduleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting quizzes by module", e);
        }
        return 0;
    }
    
    /**
     * Map a ResultSet to a QuizModel
     * @param resultSet The ResultSet to map
     * @return A QuizModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static QuizModel mapResultSetToQuizModel(ResultSet resultSet) throws SQLException {
        QuizModel quiz = new QuizModel();
        quiz.setQuizId(resultSet.getInt("QuizID"));
        
        // Handle nullable foreign keys
        int courseId = resultSet.getInt("CourseID");
        if (!resultSet.wasNull()) {
            quiz.setCourseId(courseId);
        }
        
        int moduleId = resultSet.getInt("ModuleID");
        if (!resultSet.wasNull()) {
            quiz.setModuleId(moduleId);
        }
        
        int assessmentId = resultSet.getInt("AssessmentID");
        if (!resultSet.wasNull()) {
            quiz.setAssessmentId(assessmentId);
        }
        
        quiz.setTitle(resultSet.getString("Title"));
        quiz.setDescription(resultSet.getString("Description"));
        quiz.setTotalMarks(resultSet.getInt("TotalMarks"));
        quiz.setPassingMarks(resultSet.getInt("PassingMarks"));
        quiz.setDuration(resultSet.getInt("Duration"));
        quiz.setMaxAttempts(resultSet.getInt("MaxAttempts"));
        quiz.setRandomizeQuestions(resultSet.getBoolean("RandomizeQuestions"));
        quiz.setShowAnswersAfterSubmission(resultSet.getBoolean("ShowAnswersAfterSubmission"));
        quiz.setStatus(QuizModel.Status.valueOf(resultSet.getString("Status")));
        
        // Handle timestamps
        Timestamp availableFromTimestamp = resultSet.getTimestamp("AvailableFrom");
        if (availableFromTimestamp != null) {
            quiz.setAvailableFrom(availableFromTimestamp.toLocalDateTime());
        }
        
        Timestamp availableUntilTimestamp = resultSet.getTimestamp("AvailableUntil");
        if (availableUntilTimestamp != null) {
            quiz.setAvailableUntil(availableUntilTimestamp.toLocalDateTime());
        }
        
        Timestamp createdAtTimestamp = resultSet.getTimestamp("CreatedAt");
        if (createdAtTimestamp != null) {
            quiz.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        }
        
        Timestamp updatedAtTimestamp = resultSet.getTimestamp("UpdatedAt");
        if (updatedAtTimestamp != null) {
            quiz.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        
        return quiz;
    }
}
