package com.example.skillforge.dao.course;

import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.course.ModuleModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Course Modules
 */
public class ModuleDAO {
    private static final Logger LOGGER = Logger.getLogger(ModuleDAO.class.getName());
    
    private static final String INSERT_MODULE_SQL = 
            "INSERT INTO Module (CourseID, Title, OrderIndex) VALUES (?, ?, ?)";
    private static final String SELECT_MODULES_BY_COURSE_SQL = 
            "SELECT * FROM Module WHERE CourseID = ? ORDER BY OrderIndex";
    private static final String SELECT_MODULE_BY_ID_SQL = 
            "SELECT * FROM Module WHERE ModuleID = ?";
    private static final String UPDATE_MODULE_SQL = 
            "UPDATE Module SET Title = ?, OrderIndex = ? WHERE ModuleID = ?";
    private static final String DELETE_MODULE_SQL = 
            "DELETE FROM Module WHERE ModuleID = ?";
    private static final String COUNT_MODULES_BY_COURSE_SQL = 
            "SELECT COUNT(*) FROM Module WHERE CourseID = ?";
    private static final String REORDER_MODULES_SQL = 
            "UPDATE Module SET OrderIndex = ? WHERE ModuleID = ?";
    
    /**
     * Insert a new module
     * @param module The module to insert
     * @return The ID of the inserted module, or 0 if insertion failed
     */
    public static int insertModule(ModuleModel module) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_MODULE_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, module.getCourseId());
            preparedStatement.setString(2, module.getTitle());
            preparedStatement.setInt(3, module.getOrderIndex());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting module", e);
        }
        return 0;
    }
    
    /**
     * Get all modules for a course
     * @param courseId The ID of the course
     * @return A list of modules for the course
     */
    public static List<ModuleModel> getModulesByCourse(int courseId) {
        List<ModuleModel> modules = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MODULES_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                modules.add(mapResultSetToModuleModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting modules by course", e);
        }
        return modules;
    }
    
    /**
     * Get a module by ID
     * @param moduleId The ID of the module
     * @return The module, or null if not found
     */
    public static ModuleModel getModuleById(int moduleId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_MODULE_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, moduleId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToModuleModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting module by ID", e);
        }
        return null;
    }
    
    /**
     * Update a module
     * @param module The module to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateModule(ModuleModel module) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_MODULE_SQL)) {
            
            preparedStatement.setString(1, module.getTitle());
            preparedStatement.setInt(2, module.getOrderIndex());
            preparedStatement.setInt(3, module.getModuleId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating module", e);
        }
        return false;
    }
    
    /**
     * Delete a module
     * @param moduleId The ID of the module to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteModule(int moduleId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_MODULE_SQL)) {
            
            preparedStatement.setInt(1, moduleId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting module", e);
        }
        return false;
    }
    
    /**
     * Count the number of modules in a course
     * @param courseId The ID of the course
     * @return The number of modules in the course
     */
    public static int countModulesByCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_MODULES_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting modules by course", e);
        }
        return 0;
    }
    
    /**
     * Reorder modules
     * @param moduleIds A list of module IDs in the desired order
     * @return true if the reordering was successful, false otherwise
     */
    public static boolean reorderModules(List<Integer> moduleIds) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(REORDER_MODULES_SQL)) {
            
            connection.setAutoCommit(false);
            
            for (int i = 0; i < moduleIds.size(); i++) {
                preparedStatement.setInt(1, i + 1); // OrderIndex starts at 1
                preparedStatement.setInt(2, moduleIds.get(i));
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
            LOGGER.log(Level.SEVERE, "Error reordering modules", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to a ModuleModel
     * @param resultSet The ResultSet to map
     * @return A ModuleModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static ModuleModel mapResultSetToModuleModel(ResultSet resultSet) throws SQLException {
        ModuleModel module = new ModuleModel();
        module.setModuleId(resultSet.getInt("ModuleID"));
        module.setCourseId(resultSet.getInt("CourseID"));
        module.setTitle(resultSet.getString("Title"));
        module.setOrderIndex(resultSet.getInt("OrderIndex"));
        return module;
    }
}
