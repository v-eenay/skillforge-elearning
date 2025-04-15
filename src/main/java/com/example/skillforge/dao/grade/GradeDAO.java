package com.example.skillforge.dao.grade;

import com.example.skillforge.models.grade.GradeModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Student Grades
 */
public class GradeDAO {
    private static final Logger LOGGER = Logger.getLogger(GradeDAO.class.getName());
    
    private static final String INSERT_GRADE_SQL = 
            "INSERT INTO Grade (UserID, CourseID, AssessmentID, QuizID, Score, LetterGrade, " +
            "IsPassed, Status, Feedback, GradedAt) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_GRADES_BY_USER_SQL = 
            "SELECT * FROM Grade WHERE UserID = ? ORDER BY GradedAt DESC";
    private static final String SELECT_GRADES_BY_COURSE_SQL = 
            "SELECT * FROM Grade WHERE CourseID = ? ORDER BY GradedAt DESC";
    private static final String SELECT_GRADES_BY_ASSESSMENT_SQL = 
            "SELECT * FROM Grade WHERE AssessmentID = ? ORDER BY GradedAt DESC";
    private static final String SELECT_GRADES_BY_QUIZ_SQL = 
            "SELECT * FROM Grade WHERE QuizID = ? ORDER BY GradedAt DESC";
    private static final String SELECT_GRADE_BY_ID_SQL = 
            "SELECT * FROM Grade WHERE GradeID = ?";
    private static final String SELECT_COURSE_GRADE_SQL = 
            "SELECT * FROM Grade WHERE UserID = ? AND CourseID = ? AND AssessmentID IS NULL AND QuizID IS NULL";
    private static final String SELECT_ASSESSMENT_GRADE_SQL = 
            "SELECT * FROM Grade WHERE UserID = ? AND AssessmentID = ?";
    private static final String SELECT_QUIZ_GRADE_SQL = 
            "SELECT * FROM Grade WHERE UserID = ? AND QuizID = ?";
    private static final String UPDATE_GRADE_SQL = 
            "UPDATE Grade SET Score = ?, LetterGrade = ?, IsPassed = ?, Status = ?, " +
            "Feedback = ?, GradedAt = ?, UpdatedAt = CURRENT_TIMESTAMP WHERE GradeID = ?";
    private static final String DELETE_GRADE_SQL = 
            "DELETE FROM Grade WHERE GradeID = ?";
    
    /**
     * Insert a new grade
     * @param grade The grade to insert
     * @return The ID of the inserted grade, or 0 if insertion failed
     */
    public static int insertGrade(GradeModel grade) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_GRADE_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, grade.getUserId());
            preparedStatement.setInt(2, grade.getCourseId());
            
            // Handle nullable foreign keys
            if (grade.getAssessmentId() != null) {
                preparedStatement.setInt(3, grade.getAssessmentId());
            } else {
                preparedStatement.setNull(3, Types.INTEGER);
            }
            
            if (grade.getQuizId() != null) {
                preparedStatement.setInt(4, grade.getQuizId());
            } else {
                preparedStatement.setNull(4, Types.INTEGER);
            }
            
            preparedStatement.setDouble(5, grade.getScore());
            preparedStatement.setString(6, grade.getLetterGrade());
            preparedStatement.setBoolean(7, grade.isPassed());
            preparedStatement.setString(8, grade.getStatus().toString());
            preparedStatement.setString(9, grade.getFeedback());
            
            // Handle timestamp
            if (grade.getGradedAt() != null) {
                preparedStatement.setTimestamp(10, Timestamp.valueOf(grade.getGradedAt()));
            } else {
                preparedStatement.setNull(10, Types.TIMESTAMP);
            }
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting grade", e);
        }
        return 0;
    }
    
    /**
     * Get all grades for a user
     * @param userId The ID of the user
     * @return A list of grades for the user
     */
    public static List<GradeModel> getGradesByUser(int userId) {
        List<GradeModel> grades = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GRADES_BY_USER_SQL)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                grades.add(mapResultSetToGradeModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting grades by user", e);
        }
        return grades;
    }
    
    /**
     * Get all grades for a course
     * @param courseId The ID of the course
     * @return A list of grades for the course
     */
    public static List<GradeModel> getGradesByCourse(int courseId) {
        List<GradeModel> grades = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GRADES_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                grades.add(mapResultSetToGradeModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting grades by course", e);
        }
        return grades;
    }
    
    /**
     * Get all grades for an assessment
     * @param assessmentId The ID of the assessment
     * @return A list of grades for the assessment
     */
    public static List<GradeModel> getGradesByAssessment(int assessmentId) {
        List<GradeModel> grades = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GRADES_BY_ASSESSMENT_SQL)) {
            
            preparedStatement.setInt(1, assessmentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                grades.add(mapResultSetToGradeModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting grades by assessment", e);
        }
        return grades;
    }
    
    /**
     * Get all grades for a quiz
     * @param quizId The ID of the quiz
     * @return A list of grades for the quiz
     */
    public static List<GradeModel> getGradesByQuiz(int quizId) {
        List<GradeModel> grades = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GRADES_BY_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                grades.add(mapResultSetToGradeModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting grades by quiz", e);
        }
        return grades;
    }
    
    /**
     * Get a grade by ID
     * @param gradeId The ID of the grade
     * @return The grade, or null if not found
     */
    public static GradeModel getGradeById(int gradeId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_GRADE_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, gradeId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToGradeModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting grade by ID", e);
        }
        return null;
    }
    
    /**
     * Get the course grade for a user
     * @param userId The ID of the user
     * @param courseId The ID of the course
     * @return The course grade, or null if not found
     */
    public static GradeModel getCourseGrade(int userId, int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_COURSE_GRADE_SQL)) {
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToGradeModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting course grade", e);
        }
        return null;
    }
    
    /**
     * Get the assessment grade for a user
     * @param userId The ID of the user
     * @param assessmentId The ID of the assessment
     * @return The assessment grade, or null if not found
     */
    public static GradeModel getAssessmentGrade(int userId, int assessmentId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ASSESSMENT_GRADE_SQL)) {
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, assessmentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToGradeModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting assessment grade", e);
        }
        return null;
    }
    
    /**
     * Get the quiz grade for a user
     * @param userId The ID of the user
     * @param quizId The ID of the quiz
     * @return The quiz grade, or null if not found
     */
    public static GradeModel getQuizGrade(int userId, int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUIZ_GRADE_SQL)) {
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToGradeModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting quiz grade", e);
        }
        return null;
    }
    
    /**
     * Update a grade
     * @param grade The grade to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateGrade(GradeModel grade) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_GRADE_SQL)) {
            
            preparedStatement.setDouble(1, grade.getScore());
            preparedStatement.setString(2, grade.getLetterGrade());
            preparedStatement.setBoolean(3, grade.isPassed());
            preparedStatement.setString(4, grade.getStatus().toString());
            preparedStatement.setString(5, grade.getFeedback());
            
            // Handle timestamp
            if (grade.getGradedAt() != null) {
                preparedStatement.setTimestamp(6, Timestamp.valueOf(grade.getGradedAt()));
            } else {
                preparedStatement.setNull(6, Types.TIMESTAMP);
            }
            
            preparedStatement.setInt(7, grade.getGradeId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating grade", e);
        }
        return false;
    }
    
    /**
     * Delete a grade
     * @param gradeId The ID of the grade to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteGrade(int gradeId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_GRADE_SQL)) {
            
            preparedStatement.setInt(1, gradeId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting grade", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to a GradeModel
     * @param resultSet The ResultSet to map
     * @return A GradeModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static GradeModel mapResultSetToGradeModel(ResultSet resultSet) throws SQLException {
        GradeModel grade = new GradeModel();
        grade.setGradeId(resultSet.getInt("GradeID"));
        grade.setUserId(resultSet.getInt("UserID"));
        grade.setCourseId(resultSet.getInt("CourseID"));
        
        // Handle nullable foreign keys
        int assessmentId = resultSet.getInt("AssessmentID");
        if (!resultSet.wasNull()) {
            grade.setAssessmentId(assessmentId);
        }
        
        int quizId = resultSet.getInt("QuizID");
        if (!resultSet.wasNull()) {
            grade.setQuizId(quizId);
        }
        
        grade.setScore(resultSet.getDouble("Score"));
        grade.setLetterGrade(resultSet.getString("LetterGrade"));
        grade.setPassed(resultSet.getBoolean("IsPassed"));
        grade.setStatus(GradeModel.GradeStatus.valueOf(resultSet.getString("Status")));
        grade.setFeedback(resultSet.getString("Feedback"));
        
        // Handle timestamps
        Timestamp gradedAtTimestamp = resultSet.getTimestamp("GradedAt");
        if (gradedAtTimestamp != null) {
            grade.setGradedAt(gradedAtTimestamp.toLocalDateTime());
        }
        
        Timestamp updatedAtTimestamp = resultSet.getTimestamp("UpdatedAt");
        if (updatedAtTimestamp != null) {
            grade.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        
        return grade;
    }
}
