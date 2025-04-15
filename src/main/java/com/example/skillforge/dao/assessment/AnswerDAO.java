package com.example.skillforge.dao.assessment;

import com.example.skillforge.models.assessment.AnswerModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Student Answers
 */
public class AnswerDAO {
    private static final Logger LOGGER = Logger.getLogger(AnswerDAO.class.getName());
    
    private static final String INSERT_ANSWER_SQL = 
            "INSERT INTO Answer (SubmissionID, QuestionID, SelectedOption, TextAnswer, IsCorrect, " +
            "ScoreAwarded, InstructorFeedback) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ANSWERS_BY_SUBMISSION_SQL = 
            "SELECT * FROM Answer WHERE SubmissionID = ?";
    private static final String SELECT_ANSWER_BY_ID_SQL = 
            "SELECT * FROM Answer WHERE AnswerID = ?";
    private static final String SELECT_ANSWER_BY_SUBMISSION_QUESTION_SQL = 
            "SELECT * FROM Answer WHERE SubmissionID = ? AND QuestionID = ?";
    private static final String UPDATE_ANSWER_SQL = 
            "UPDATE Answer SET SelectedOption = ?, TextAnswer = ?, IsCorrect = ?, " +
            "ScoreAwarded = ?, InstructorFeedback = ? WHERE AnswerID = ?";
    private static final String DELETE_ANSWER_SQL = 
            "DELETE FROM Answer WHERE AnswerID = ?";
    private static final String DELETE_ANSWERS_BY_SUBMISSION_SQL = 
            "DELETE FROM Answer WHERE SubmissionID = ?";
    
    /**
     * Insert a new answer
     * @param answer The answer to insert
     * @return The ID of the inserted answer, or 0 if insertion failed
     */
    public static int insertAnswer(AnswerModel answer) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ANSWER_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, answer.getSubmissionId());
            preparedStatement.setInt(2, answer.getQuestionId());
            preparedStatement.setString(3, answer.getSelectedOption());
            preparedStatement.setString(4, answer.getTextAnswer());
            preparedStatement.setBoolean(5, answer.isCorrect());
            preparedStatement.setInt(6, answer.getScoreAwarded());
            preparedStatement.setString(7, answer.getInstructorFeedback());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting answer", e);
        }
        return 0;
    }
    
    /**
     * Get all answers for a submission
     * @param submissionId The ID of the submission
     * @return A list of answers for the submission
     */
    public static List<AnswerModel> getAnswersBySubmission(int submissionId) {
        List<AnswerModel> answers = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ANSWERS_BY_SUBMISSION_SQL)) {
            
            preparedStatement.setInt(1, submissionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                answers.add(mapResultSetToAnswerModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting answers by submission", e);
        }
        return answers;
    }
    
    /**
     * Get an answer by ID
     * @param answerId The ID of the answer
     * @return The answer, or null if not found
     */
    public static AnswerModel getAnswerById(int answerId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ANSWER_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, answerId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToAnswerModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting answer by ID", e);
        }
        return null;
    }
    
    /**
     * Get an answer by submission and question
     * @param submissionId The ID of the submission
     * @param questionId The ID of the question
     * @return The answer, or null if not found
     */
    public static AnswerModel getAnswerBySubmissionQuestion(int submissionId, int questionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ANSWER_BY_SUBMISSION_QUESTION_SQL)) {
            
            preparedStatement.setInt(1, submissionId);
            preparedStatement.setInt(2, questionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToAnswerModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting answer by submission and question", e);
        }
        return null;
    }
    
    /**
     * Update an answer
     * @param answer The answer to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateAnswer(AnswerModel answer) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ANSWER_SQL)) {
            
            preparedStatement.setString(1, answer.getSelectedOption());
            preparedStatement.setString(2, answer.getTextAnswer());
            preparedStatement.setBoolean(3, answer.isCorrect());
            preparedStatement.setInt(4, answer.getScoreAwarded());
            preparedStatement.setString(5, answer.getInstructorFeedback());
            preparedStatement.setInt(6, answer.getAnswerId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating answer", e);
        }
        return false;
    }
    
    /**
     * Delete an answer
     * @param answerId The ID of the answer to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteAnswer(int answerId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ANSWER_SQL)) {
            
            preparedStatement.setInt(1, answerId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting answer", e);
        }
        return false;
    }
    
    /**
     * Delete all answers for a submission
     * @param submissionId The ID of the submission
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteAnswersBySubmission(int submissionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ANSWERS_BY_SUBMISSION_SQL)) {
            
            preparedStatement.setInt(1, submissionId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting answers by submission", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to an AnswerModel
     * @param resultSet The ResultSet to map
     * @return An AnswerModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static AnswerModel mapResultSetToAnswerModel(ResultSet resultSet) throws SQLException {
        AnswerModel answer = new AnswerModel();
        answer.setAnswerId(resultSet.getInt("AnswerID"));
        answer.setSubmissionId(resultSet.getInt("SubmissionID"));
        answer.setQuestionId(resultSet.getInt("QuestionID"));
        answer.setSelectedOption(resultSet.getString("SelectedOption"));
        answer.setTextAnswer(resultSet.getString("TextAnswer"));
        answer.setCorrect(resultSet.getBoolean("IsCorrect"));
        answer.setScoreAwarded(resultSet.getInt("ScoreAwarded"));
        answer.setInstructorFeedback(resultSet.getString("InstructorFeedback"));
        return answer;
    }
}
