package com.example.skillforge.dao.content;

import com.example.skillforge.models.content.ResourceModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Lesson Resources
 */
public class ResourceDAO {
    private static final Logger LOGGER = Logger.getLogger(ResourceDAO.class.getName());
    
    private static final String INSERT_RESOURCE_SQL = 
            "INSERT INTO Resource (LessonID, FileName, FileType, FileURL) VALUES (?, ?, ?, ?)";
    private static final String SELECT_RESOURCES_BY_LESSON_SQL = 
            "SELECT * FROM Resource WHERE LessonID = ? ORDER BY UploadDate DESC";
    private static final String SELECT_RESOURCE_BY_ID_SQL = 
            "SELECT * FROM Resource WHERE ResourceID = ?";
    private static final String UPDATE_RESOURCE_SQL = 
            "UPDATE Resource SET FileName = ?, FileType = ?, FileURL = ? WHERE ResourceID = ?";
    private static final String DELETE_RESOURCE_SQL = 
            "DELETE FROM Resource WHERE ResourceID = ?";
    private static final String COUNT_RESOURCES_BY_LESSON_SQL = 
            "SELECT COUNT(*) FROM Resource WHERE LessonID = ?";
    
    /**
     * Insert a new resource
     * @param resource The resource to insert
     * @return The ID of the inserted resource, or 0 if insertion failed
     */
    public static int insertResource(ResourceModel resource) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_RESOURCE_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, resource.getLessonId());
            preparedStatement.setString(2, resource.getFileName());
            preparedStatement.setString(3, resource.getFileType());
            preparedStatement.setString(4, resource.getFileURL());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting resource", e);
        }
        return 0;
    }
    
    /**
     * Get all resources for a lesson
     * @param lessonId The ID of the lesson
     * @return A list of resources for the lesson
     */
    public static List<ResourceModel> getResourcesByLesson(int lessonId) {
        List<ResourceModel> resources = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESOURCES_BY_LESSON_SQL)) {
            
            preparedStatement.setInt(1, lessonId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                resources.add(mapResultSetToResourceModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting resources by lesson", e);
        }
        return resources;
    }
    
    /**
     * Get a resource by ID
     * @param resourceId The ID of the resource
     * @return The resource, or null if not found
     */
    public static ResourceModel getResourceById(int resourceId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RESOURCE_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, resourceId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToResourceModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting resource by ID", e);
        }
        return null;
    }
    
    /**
     * Update a resource
     * @param resource The resource to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateResource(ResourceModel resource) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_RESOURCE_SQL)) {
            
            preparedStatement.setString(1, resource.getFileName());
            preparedStatement.setString(2, resource.getFileType());
            preparedStatement.setString(3, resource.getFileURL());
            preparedStatement.setInt(4, resource.getResourceId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating resource", e);
        }
        return false;
    }
    
    /**
     * Delete a resource
     * @param resourceId The ID of the resource to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteResource(int resourceId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_RESOURCE_SQL)) {
            
            preparedStatement.setInt(1, resourceId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting resource", e);
        }
        return false;
    }
    
    /**
     * Count the number of resources for a lesson
     * @param lessonId The ID of the lesson
     * @return The number of resources for the lesson
     */
    public static int countResourcesByLesson(int lessonId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_RESOURCES_BY_LESSON_SQL)) {
            
            preparedStatement.setInt(1, lessonId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting resources by lesson", e);
        }
        return 0;
    }
    
    /**
     * Map a ResultSet to a ResourceModel
     * @param resultSet The ResultSet to map
     * @return A ResourceModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static ResourceModel mapResultSetToResourceModel(ResultSet resultSet) throws SQLException {
        ResourceModel resource = new ResourceModel();
        resource.setResourceId(resultSet.getInt("ResourceID"));
        resource.setLessonId(resultSet.getInt("LessonID"));
        resource.setFileName(resultSet.getString("FileName"));
        resource.setFileType(resultSet.getString("FileType"));
        resource.setFileURL(resultSet.getString("FileURL"));
        
        // Handle timestamp
        Timestamp uploadDateTimestamp = resultSet.getTimestamp("UploadDate");
        if (uploadDateTimestamp != null) {
            resource.setUploadDate(uploadDateTimestamp.toLocalDateTime());
        }
        
        return resource;
    }
}
