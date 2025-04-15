package com.example.skillforge.dao.assessment;

import com.example.skillforge.models.assessment.OptionModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Question Options
 */
public class OptionDAO {
    private static final Logger LOGGER = Logger.getLogger(OptionDAO.class.getName());
    
    private static final String INSERT_OPTION_SQL = 
            "INSERT INTO QuestionOption (QuestionID, OptionText, IsCorrect, Feedback, MediaURL, OrderIndex) " +
            "VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_OPTIONS_BY_QUESTION_SQL = 
            "SELECT * FROM QuestionOption WHERE QuestionID = ? ORDER BY OrderIndex";
    private static final String SELECT_OPTION_BY_ID_SQL = 
            "SELECT * FROM QuestionOption WHERE OptionID = ?";
    private static final String UPDATE_OPTION_SQL = 
            "UPDATE QuestionOption SET OptionText = ?, IsCorrect = ?, Feedback = ?, " +
            "MediaURL = ?, OrderIndex = ? WHERE OptionID = ?";
    private static final String DELETE_OPTION_SQL = 
            "DELETE FROM QuestionOption WHERE OptionID = ?";
    private static final String COUNT_OPTIONS_BY_QUESTION_SQL = 
            "SELECT COUNT(*) FROM QuestionOption WHERE QuestionID = ?";
    private static final String REORDER_OPTIONS_SQL = 
            "UPDATE QuestionOption SET OrderIndex = ? WHERE OptionID = ?";
    
    /**
     * Insert a new option
     * @param option The option to insert
     * @return The ID of the inserted option, or 0 if insertion failed
     */
    public static int insertOption(OptionModel option) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_OPTION_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, option.getQuestionId());
            preparedStatement.setString(2, option.getOptionText());
            preparedStatement.setBoolean(3, option.isCorrect());
            preparedStatement.setString(4, option.getFeedback());
            preparedStatement.setString(5, option.getMediaURL());
            preparedStatement.setInt(6, option.getOrderIndex());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting option", e);
        }
        return 0;
    }
    
    /**
     * Get all options for a question
     * @param questionId The ID of the question
     * @return A list of options for the question
     */
    public static List<OptionModel> getOptionsByQuestion(int questionId) {
        List<OptionModel> options = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_OPTIONS_BY_QUESTION_SQL)) {
            
            preparedStatement.setInt(1, questionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                options.add(mapResultSetToOptionModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting options by question", e);
        }
        return options;
    }
    
    /**
     * Get an option by ID
     * @param optionId The ID of the option
     * @return The option, or null if not found
     */
    public static OptionModel getOptionById(int optionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_OPTION_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, optionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToOptionModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting option by ID", e);
        }
        return null;
    }
    
    /**
     * Update an option
     * @param option The option to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateOption(OptionModel option) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_OPTION_SQL)) {
            
            preparedStatement.setString(1, option.getOptionText());
            preparedStatement.setBoolean(2, option.isCorrect());
            preparedStatement.setString(3, option.getFeedback());
            preparedStatement.setString(4, option.getMediaURL());
            preparedStatement.setInt(5, option.getOrderIndex());
            preparedStatement.setInt(6, option.getOptionId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating option", e);
        }
        return false;
    }
    
    /**
     * Delete an option
     * @param optionId The ID of the option to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteOption(int optionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_OPTION_SQL)) {
            
            preparedStatement.setInt(1, optionId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting option", e);
        }
        return false;
    }
    
    /**
     * Count the number of options for a question
     * @param questionId The ID of the question
     * @return The number of options for the question
     */
    public static int countOptionsByQuestion(int questionId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_OPTIONS_BY_QUESTION_SQL)) {
            
            preparedStatement.setInt(1, questionId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting options by question", e);
        }
        return 0;
    }
    
    /**
     * Reorder options
     * @param optionIds A list of option IDs in the desired order
     * @return true if the reordering was successful, false otherwise
     */
    public static boolean reorderOptions(List<Integer> optionIds) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(REORDER_OPTIONS_SQL)) {
            
            connection.setAutoCommit(false);
            
            for (int i = 0; i < optionIds.size(); i++) {
                preparedStatement.setInt(1, i + 1); // OrderIndex starts at 1
                preparedStatement.setInt(2, optionIds.get(i));
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
            LOGGER.log(Level.SEVERE, "Error reordering options", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to an OptionModel
     * @param resultSet The ResultSet to map
     * @return An OptionModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static OptionModel mapResultSetToOptionModel(ResultSet resultSet) throws SQLException {
        OptionModel option = new OptionModel();
        option.setOptionId(resultSet.getInt("OptionID"));
        option.setQuestionId(resultSet.getInt("QuestionID"));
        option.setOptionText(resultSet.getString("OptionText"));
        option.setCorrect(resultSet.getBoolean("IsCorrect"));
        option.setFeedback(resultSet.getString("Feedback"));
        option.setMediaURL(resultSet.getString("MediaURL"));
        option.setOrderIndex(resultSet.getInt("OrderIndex"));
        return option;
    }
}
