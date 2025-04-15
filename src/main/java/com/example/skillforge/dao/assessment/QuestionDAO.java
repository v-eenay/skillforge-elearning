package com.example.skillforge.dao.assessment;

import com.example.skillforge.models.assessment.QuestionModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Quiz Questions
 */
public class QuestionDAO {
    private static final Logger LOGGER = Logger.getLogger(QuestionDAO.class.getName());
    
    private static final String INSERT_QUESTION_SQL = 
            "INSERT INTO Question (QuizID, QuestionText, QuestionType, CorrectAnswer, Marks, " +
            "Explanation, MediaURL, OrderIndex) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_QUESTIONS_BY_QUIZ_SQL = 
            "SELECT * FROM Question WHERE QuizID = ? ORDER BY OrderIndex";
    private static final String SELECT_QUESTION_BY_ID_SQL = 
            "SELECT * FROM Question WHERE QuestionID = ?";
    private static final String UPDATE_QUESTION_SQL = 
            "UPDATE Question SET QuestionText = ?, QuestionType = ?, CorrectAnswer = ?, " +
            "Marks = ?, Explanation = ?, MediaURL = ?, OrderIndex = ? WHERE QuestionID = ?";
    private static final String DELETE_QUESTION_SQL = 
            "DELETE FROM Question WHERE QuestionID = ?";
    private static final String COUNT_QUESTIONS_BY_QUIZ_SQL = 
            "SELECT COUNT(*) FROM Question WHERE QuizID = ?";
    private static final String REORDER_QUESTIONS_SQL = 
            "UPDATE Question SET OrderIndex = ? WHERE QuestionID = ?";
    
    /**
     * Insert a new question
     * @param question The question to insert
     * @return The ID of the inserted question, or 0 if insertion failed
     */
    public static int insertQuestion(QuestionModel question) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_QUESTION_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, question.getQuizId());
            preparedStatement.setString(2, question.getQuestionText());
            preparedStatement.setString(3, question.getQuestionType().toString());
            preparedStatement.setString(4, question.getCorrectAnswer());
            preparedStatement.setInt(5, question.getMarks());
            preparedStatement.setString(6, question.getExplanation());
            preparedStatement.setString(7, question.getMediaURL());
            preparedStatement.setInt(8, question.getOrderIndex());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting question", e);
        }
        return 0;
    }
    
    /**
     * Get all questions for a quiz
     * @param quizId The ID of the quiz
     * @return A list of questions for the quiz
     */
    public static List<QuestionModel> getQuestionsByQuiz(int quizId) {
        List<QuestionModel> questions = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUESTIONS_BY_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                questions.add(mapResultSetToQuestionModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting questions by quiz", e);
        }
        return questions;
    }
    
    /**
     * Get a question by ID
     * @param questionId The ID of the question
     * @return The question, or null if not found
     */
    public static QuestionModel getQuestionById(int questionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_QUESTION_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, questionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToQuestionModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting question by ID", e);
        }
        return null;
    }
    
    /**
     * Update a question
     * @param question The question to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateQuestion(QuestionModel question) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_QUESTION_SQL)) {
            
            preparedStatement.setString(1, question.getQuestionText());
            preparedStatement.setString(2, question.getQuestionType().toString());
            preparedStatement.setString(3, question.getCorrectAnswer());
            preparedStatement.setInt(4, question.getMarks());
            preparedStatement.setString(5, question.getExplanation());
            preparedStatement.setString(6, question.getMediaURL());
            preparedStatement.setInt(7, question.getOrderIndex());
            preparedStatement.setInt(8, question.getQuestionId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating question", e);
        }
        return false;
    }
    
    /**
     * Delete a question
     * @param questionId The ID of the question to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteQuestion(int questionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_QUESTION_SQL)) {
            
            preparedStatement.setInt(1, questionId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting question", e);
        }
        return false;
    }
    
    /**
     * Count the number of questions for a quiz
     * @param quizId The ID of the quiz
     * @return The number of questions for the quiz
     */
    public static int countQuestionsByQuiz(int quizId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_QUESTIONS_BY_QUIZ_SQL)) {
            
            preparedStatement.setInt(1, quizId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting questions by quiz", e);
        }
        return 0;
    }
    
    /**
     * Reorder questions
     * @param questionIds A list of question IDs in the desired order
     * @return true if the reordering was successful, false otherwise
     */
    public static boolean reorderQuestions(List<Integer> questionIds) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(REORDER_QUESTIONS_SQL)) {
            
            connection.setAutoCommit(false);
            
            for (int i = 0; i < questionIds.size(); i++) {
                preparedStatement.setInt(1, i + 1); // OrderIndex starts at 1
                preparedStatement.setInt(2, questionIds.get(i));
                preparedStatement.addBatch();
            }
            
            int[] affectedRows = preparedStatement.executeBatch();
            connection.commit();
            
            // Check if all updates were successful
            for (int rows : affectedRows) {
                if (rows <= 0) {
                    return false;
                }
            }
            
            return true;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error reordering questions", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to a QuestionModel
     * @param resultSet The ResultSet to map
     * @return A QuestionModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static QuestionModel mapResultSetToQuestionModel(ResultSet resultSet) throws SQLException {
        QuestionModel question = new QuestionModel();
        question.setQuestionId(resultSet.getInt("QuestionID"));
        question.setQuizId(resultSet.getInt("QuizID"));
        question.setQuestionText(resultSet.getString("QuestionText"));
        question.setQuestionType(QuestionModel.QuestionType.valueOf(resultSet.getString("QuestionType")));
        question.setCorrectAnswer(resultSet.getString("CorrectAnswer"));
        question.setMarks(resultSet.getInt("Marks"));
        question.setExplanation(resultSet.getString("Explanation"));
        question.setMediaURL(resultSet.getString("MediaURL"));
        question.setOrderIndex(resultSet.getInt("OrderIndex"));
        return question;
    }
}
