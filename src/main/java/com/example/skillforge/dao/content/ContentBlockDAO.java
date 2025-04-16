package com.example.skillforge.dao.content;

import com.example.skillforge.models.content.ContentBlockModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Lesson Content Blocks
 */
public class ContentBlockDAO {
    private static final Logger LOGGER = Logger.getLogger(ContentBlockDAO.class.getName());
    
    private static final String INSERT_CONTENT_BLOCK_SQL = 
            "INSERT INTO ContentBlock (LessonID, BlockType, Content, Title, Description, OrderIndex) " +
            "VALUES (?, ?, ?, ?, ?, ?)";
    private static final String SELECT_CONTENT_BLOCKS_BY_LESSON_SQL = 
            "SELECT * FROM ContentBlock WHERE LessonID = ? ORDER BY OrderIndex";
    private static final String SELECT_CONTENT_BLOCK_BY_ID_SQL = 
            "SELECT * FROM ContentBlock WHERE ContentBlockID = ?";
    private static final String UPDATE_CONTENT_BLOCK_SQL = 
            "UPDATE ContentBlock SET BlockType = ?, Content = ?, Title = ?, Description = ?, " +
            "OrderIndex = ? WHERE ContentBlockID = ?";
    private static final String DELETE_CONTENT_BLOCK_SQL = 
            "DELETE FROM ContentBlock WHERE ContentBlockID = ?";
    private static final String REORDER_CONTENT_BLOCKS_SQL = 
            "UPDATE ContentBlock SET OrderIndex = ? WHERE ContentBlockID = ?";
    
    /**
     * Insert a new content block
     * @param contentBlock The content block to insert
     * @return The ID of the inserted content block, or 0 if insertion failed
     */
    public static int insertContentBlock(ContentBlockModel contentBlock) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CONTENT_BLOCK_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, contentBlock.getLessonId());
            preparedStatement.setString(2, contentBlock.getBlockType().toString());
            preparedStatement.setString(3, contentBlock.getContent());
            preparedStatement.setString(4, contentBlock.getTitle());
            preparedStatement.setString(5, contentBlock.getDescription());
            preparedStatement.setInt(6, contentBlock.getOrderIndex());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting content block", e);
        }
        return 0;
    }
    
    /**
     * Get all content blocks for a lesson
     * @param lessonId The ID of the lesson
     * @return A list of content blocks for the lesson
     */
    public static List<ContentBlockModel> getContentBlocksByLesson(int lessonId) {
        List<ContentBlockModel> contentBlocks = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CONTENT_BLOCKS_BY_LESSON_SQL)) {
            
            preparedStatement.setInt(1, lessonId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                contentBlocks.add(mapResultSetToContentBlockModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting content blocks by lesson", e);
        }
        return contentBlocks;
    }
    
    /**
     * Get a content block by ID
     * @param contentBlockId The ID of the content block
     * @return The content block, or null if not found
     */
    public static ContentBlockModel getContentBlockById(int contentBlockId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CONTENT_BLOCK_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, contentBlockId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToContentBlockModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting content block by ID", e);
        }
        return null;
    }
    
    /**
     * Update a content block
     * @param contentBlock The content block to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateContentBlock(ContentBlockModel contentBlock) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CONTENT_BLOCK_SQL)) {
            
            preparedStatement.setString(1, contentBlock.getBlockType().toString());
            preparedStatement.setString(2, contentBlock.getContent());
            preparedStatement.setString(3, contentBlock.getTitle());
            preparedStatement.setString(4, contentBlock.getDescription());
            preparedStatement.setInt(5, contentBlock.getOrderIndex());
            preparedStatement.setInt(6, contentBlock.getContentBlockId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating content block", e);
        }
        return false;
    }
    
    /**
     * Delete a content block
     * @param contentBlockId The ID of the content block to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteContentBlock(int contentBlockId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CONTENT_BLOCK_SQL)) {
            
            preparedStatement.setInt(1, contentBlockId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting content block", e);
        }
        return false;
    }
    
    /**
     * Reorder content blocks
     * @param contentBlockIds A list of content block IDs in the desired order
     * @return true if the reordering was successful, false otherwise
     */
    public static boolean reorderContentBlocks(List<Integer> contentBlockIds) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(REORDER_CONTENT_BLOCKS_SQL)) {
            
            connection.setAutoCommit(false);
            
            for (int i = 0; i < contentBlockIds.size(); i++) {
                preparedStatement.setInt(1, i + 1); // OrderIndex starts at 1
                preparedStatement.setInt(2, contentBlockIds.get(i));
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
            LOGGER.log(Level.SEVERE, "Error reordering content blocks", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to a ContentBlockModel
     * @param resultSet The ResultSet to map
     * @return A ContentBlockModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static ContentBlockModel mapResultSetToContentBlockModel(ResultSet resultSet) throws SQLException {
        ContentBlockModel contentBlock = new ContentBlockModel();
        contentBlock.setContentBlockId(resultSet.getInt("ContentBlockID"));
        contentBlock.setLessonId(resultSet.getInt("LessonID"));
        contentBlock.setBlockType(ContentBlockModel.BlockType.valueOf(resultSet.getString("BlockType")));
        contentBlock.setContent(resultSet.getString("Content"));
        contentBlock.setTitle(resultSet.getString("Title"));
        contentBlock.setDescription(resultSet.getString("Description"));
        contentBlock.setOrderIndex(resultSet.getInt("OrderIndex"));
        
        // Handle timestamps
        Timestamp createdAtTimestamp = resultSet.getTimestamp("CreatedAt");
        if (createdAtTimestamp != null) {
            contentBlock.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        }
        
        Timestamp updatedAtTimestamp = resultSet.getTimestamp("UpdatedAt");
        if (updatedAtTimestamp != null) {
            contentBlock.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        
        return contentBlock;
    }
}
