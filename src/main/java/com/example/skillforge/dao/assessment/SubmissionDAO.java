package com.example.skillforge.dao.assessment;

import com.example.skillforge.models.assessment.SubmissionModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Quiz Submissions
 */
public class SubmissionDAO {
    private static final Logger LOGGER = Logger.getLogger(SubmissionDAO.class.getName());
    
    private static final String INSERT_SUBMISSION_SQL = 
            "INSERT INTO Submission (UserID, QuizID, Status, TotalScore, IsPassed, AttemptNumber, " +
            "StartedAt, SubmittedAt, GradedAt, InstructorFeedback) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_SUBMISSIONS_BY_USER_SQL = 
            "SELECT * FROM Submission WHERE UserID = ? ORDER BY StartedAt DESC";
    private static final String SELECT_SUBMISSIONS_BY_QUIZ_SQL = 
            "SELECT * FROM Submission WHERE QuizID = ? ORDER BY StartedAt DESC";
    private static final String SELECT_SUBMISSION_BY_ID_SQL = 
            "SELECT * FROM Submission WHERE SubmissionID = ?";
    private static final String SELECT_LATEST_SUBMISSION_SQL = 
            "SELECT * FROM Submission WHERE UserID = ? AND QuizID = ? ORDER BY StartedAt DESC LIMIT 1";
    private static final String UPDATE_SUBMISSION_SQL = 
            "UPDATE Submission SET Status = ?, TotalScore = ?, IsPassed = ?, " +
            "SubmittedAt = ?, GradedAt = ?, InstructorFeedback = ? WHERE SubmissionID = ?";
    private static final String DELETE_SUBMISSION_SQL = 
            "DELETE FROM Submission WHERE SubmissionID = ?";
    private static final String COUNT_SUBMISSIONS_BY_QUIZ_SQL = 
            "SELECT COUNT(*) FROM Submission WHERE QuizID = ?";
    private static final String COUNT_ATTEMPTS_BY_USER_QUIZ_SQL = 
            "SELECT COUNT(*) FROM Submission WHERE UserID = ? AND QuizID = ?";
    
    /**
     * Insert a new submission
     * @param submission The submission to insert
     * @return The ID of the inserted submission, or 0 if insertion failed
     */
    public static int insertSubmission(SubmissionModel submission) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SUBMISSION_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, submission.getUserId());
            preparedStatement.setInt(2, submission.getQuizId());
            preparedStatement.setString(3, submission.getStatus().toString());
            preparedStatement.setInt(4, submission.getTotalScore());
            preparedStatement.setBoolean(5, submission.isPassed());
            preparedStatement.setInt(6, submission.getAttemptNumber());
            
            // Handle timestamps
            if (submission.getStartedAt() != null) {
                preparedStatement.setTimestamp(7, Timestamp.valueOf(submission.getStartedAt()));
            } else {
                preparedStatement.setNull(7, Types.TIMESTAMP);
            }
            
            if (submission.getSubmittedAt() != null) {
                preparedStatement.setTimestamp(8, Timestamp.valueOf(submission.getSubmittedAt()));
            } else {
                preparedStatement.setNull(8, Types.TIMESTAMP);
            }
            
            if (submission.getGradedAt() != null) {
                preparedStatement.setTimestamp(9, Timestamp.valueOf(submission.getGradedAt()));
            } else {
                preparedStatement.setNull(9, Types.TIMESTAMP);
            }
            
            preparedStatement.setString(10, submission.getInstructorFeedback());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting submission", e);
        }
        return 0;
    }
    
    /**
     * Get all submissions for a user
     * @param userId The ID of the user
     * @return A list of submissions for the user
     */
    public static List<SubmissionModel> getSubmissionsByUser(int userId) {
        List<SubmissionModel> submissions = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SUBMISSIONS_BY_USER_SQL)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                submissions.add(mapResultSetToSubmissionModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting submissions by user", e);
        }
        return submissions;
    }
    
    /**
     * Get all submissions for a quiz
     * @param quizId The ID of the quiz
     * @return A list of submissions for the quiz
     */
    public static List<SubmissionModel> getSubmissionsByQuiz(int quizId) {
        List<SubmissionModel> submissions = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SUBMISSIONS_BY_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                submissions.add(mapResultSetToSubmissionModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting submissions by quiz", e);
        }
        return submissions;
    }
    
    /**
     * Get a submission by ID
     * @param submissionId The ID of the submission
     * @return The submission, or null if not found
     */
    public static SubmissionModel getSubmissionById(int submissionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SUBMISSION_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, submissionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToSubmissionModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting submission by ID", e);
        }
        return null;
    }
    
    /**
     * Get the latest submission for a user and quiz
     * @param userId The ID of the user
     * @param quizId The ID of the quiz
     * @return The latest submission, or null if not found
     */
    public static SubmissionModel getLatestSubmission(int userId, int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_LATEST_SUBMISSION_SQL)) {
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToSubmissionModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting latest submission", e);
        }
        return null;
    }
    
    /**
     * Update a submission
     * @param submission The submission to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateSubmission(SubmissionModel submission) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SUBMISSION_SQL)) {
            
            preparedStatement.setString(1, submission.getStatus().toString());
            preparedStatement.setInt(2, submission.getTotalScore());
            preparedStatement.setBoolean(3, submission.isPassed());
            
            // Handle timestamps
            if (submission.getSubmittedAt() != null) {
                preparedStatement.setTimestamp(4, Timestamp.valueOf(submission.getSubmittedAt()));
            } else {
                preparedStatement.setNull(4, Types.TIMESTAMP);
            }
            
            if (submission.getGradedAt() != null) {
                preparedStatement.setTimestamp(5, Timestamp.valueOf(submission.getGradedAt()));
            } else {
                preparedStatement.setNull(5, Types.TIMESTAMP);
            }
            
            preparedStatement.setString(6, submission.getInstructorFeedback());
            preparedStatement.setInt(7, submission.getSubmissionId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating submission", e);
        }
        return false;
    }
    
    /**
     * Delete a submission
     * @param submissionId The ID of the submission to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteSubmission(int submissionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SUBMISSION_SQL)) {
            
            preparedStatement.setInt(1, submissionId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting submission", e);
        }
        return false;
    }
    
    /**
     * Count the number of submissions for a quiz
     * @param quizId The ID of the quiz
     * @return The number of submissions for the quiz
     */
    public static int countSubmissionsByQuiz(int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_SUBMISSIONS_BY_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting submissions by quiz", e);
        }
        return 0;
    }
    
    /**
     * Count the number of attempts for a user and quiz
     * @param userId The ID of the user
     * @param quizId The ID of the quiz
     * @return The number of attempts for the user and quiz
     */
    public static int countAttemptsByUserQuiz(int userId, int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ATTEMPTS_BY_USER_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, userId);
            preparedStatement.setInt(2, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting attempts by user and quiz", e);
        }
        return 0;
    }
    
    /**
     * Map a ResultSet to a SubmissionModel
     * @param resultSet The ResultSet to map
     * @return A SubmissionModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static SubmissionModel mapResultSetToSubmissionModel(ResultSet resultSet) throws SQLException {
        SubmissionModel submission = new SubmissionModel();
        submission.setSubmissionId(resultSet.getInt("SubmissionID"));
        submission.setUserId(resultSet.getInt("UserID"));
        submission.setQuizId(resultSet.getInt("QuizID"));
        submission.setStatus(SubmissionModel.Status.valueOf(resultSet.getString("Status")));
        submission.setTotalScore(resultSet.getInt("TotalScore"));
        submission.setPassed(resultSet.getBoolean("IsPassed"));
        submission.setAttemptNumber(resultSet.getInt("AttemptNumber"));
        submission.setInstructorFeedback(resultSet.getString("InstructorFeedback"));
        
        // Handle timestamps
        Timestamp startedAtTimestamp = resultSet.getTimestamp("StartedAt");
        if (startedAtTimestamp != null) {
            submission.setStartedAt(startedAtTimestamp.toLocalDateTime());
        }
        
        Timestamp submittedAtTimestamp = resultSet.getTimestamp("SubmittedAt");
        if (submittedAtTimestamp != null) {
            submission.setSubmittedAt(submittedAtTimestamp.toLocalDateTime());
        }
        
        Timestamp gradedAtTimestamp = resultSet.getTimestamp("GradedAt");
        if (gradedAtTimestamp != null) {
            submission.setGradedAt(gradedAtTimestamp.toLocalDateTime());
        }
        
        return submission;
    }
}
