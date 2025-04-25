package com.example.skillforge.dao.course;

import com.example.skillforge.models.course.CategoryModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Course Categories
 */
public class CategoryDAO {
    private static final Logger LOGGER = Logger.getLogger(CategoryDAO.class.getName());

    private static final String INSERT_CATEGORY_SQL =
            "INSERT INTO Category (Name, Description) VALUES (?, ?)";
    private static final String SELECT_ALL_CATEGORIES_SQL =
            "SELECT * FROM Category ORDER BY Name";
    private static final String SELECT_CATEGORY_BY_ID_SQL =
            "SELECT * FROM Category WHERE CategoryID = ?";
    private static final String UPDATE_CATEGORY_SQL =
            "UPDATE Category SET Name = ?, Description = ? WHERE CategoryID = ?";
    private static final String DELETE_CATEGORY_SQL =
            "DELETE FROM Category WHERE CategoryID = ?";
    private static final String COUNT_COURSES_BY_CATEGORY_SQL =
            "SELECT COUNT(*) FROM Course WHERE CategoryID = ?";

    /**
     * Insert a new category
     * @param category The category to insert
     * @return The ID of the inserted category, or 0 if insertion failed
     */
    public static int insertCategory(CategoryModel category) {
        LOGGER.info("Inserting category: " + category.getName());
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CATEGORY_SQL,
                     PreparedStatement.RETURN_GENERATED_KEYS)) {

            preparedStatement.setString(1, category.getName());
            preparedStatement.setString(2, category.getDescription());

            LOGGER.info("Executing SQL: " + INSERT_CATEGORY_SQL + " with params: [" + category.getName() + ", " + category.getDescription() + "]");
            int affectedRows = preparedStatement.executeUpdate();
            LOGGER.info("Affected rows: " + affectedRows);

            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    int categoryId = generatedKeys.getInt(1);
                    LOGGER.info("Category inserted successfully with ID: " + categoryId);
                    return categoryId;
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting category: " + e.getMessage(), e);
        }
        LOGGER.warning("Failed to insert category: " + category.getName());
        return 0;
    }

    /**
     * Get all categories
     * @return A list of all categories
     */
    public static List<CategoryModel> getAllCategories() {
        List<CategoryModel> categories = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CATEGORIES_SQL)) {

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                categories.add(mapResultSetToCategoryModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all categories", e);
        }
        return categories;
    }

    /**
     * Get a category by ID
     * @param categoryId The ID of the category
     * @return The category, or null if not found
     */
    public static CategoryModel getCategoryById(int categoryId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CATEGORY_BY_ID_SQL)) {

            preparedStatement.setInt(1, categoryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToCategoryModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting category by ID", e);
        }
        return null;
    }

    /**
     * Update a category
     * @param category The category to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateCategory(CategoryModel category) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CATEGORY_SQL)) {

            preparedStatement.setString(1, category.getName());
            preparedStatement.setString(2, category.getDescription());
            preparedStatement.setInt(3, category.getCategoryId());

            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating category", e);
        }
        return false;
    }

    /**
     * Delete a category
     * @param categoryId The ID of the category to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteCategory(int categoryId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_CATEGORY_SQL)) {

            preparedStatement.setInt(1, categoryId);

            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting category", e);
        }
        return false;
    }

    /**
     * Count the number of courses in a category
     * @param categoryId The ID of the category
     * @return The number of courses in the category
     */
    public static int countCoursesByCategory(int categoryId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_COURSES_BY_CATEGORY_SQL)) {

            preparedStatement.setInt(1, categoryId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting courses by category", e);
        }
        return 0;
    }

    /**
     * Check if a category with the given name already exists
     * @param name The name to check
     * @return true if a category with the given name exists, false otherwise
     */
    public static boolean categoryExistsByName(String name) {
        String sql = "SELECT COUNT(*) FROM Category WHERE Name = ?";

        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            preparedStatement.setString(1, name);
            ResultSet resultSet = preparedStatement.executeQuery();

            if (resultSet.next()) {
                return resultSet.getInt(1) > 0;
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error checking if category exists by name: " + name, e);
        }

        return false;
    }

    /**
     * Map a ResultSet to a CategoryModel
     * @param resultSet The ResultSet to map
     * @return A CategoryModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static CategoryModel mapResultSetToCategoryModel(ResultSet resultSet) throws SQLException {
        CategoryModel category = new CategoryModel();
        category.setCategoryId(resultSet.getInt("CategoryID"));
        category.setName(resultSet.getString("Name"));
        category.setDescription(resultSet.getString("Description"));
        return category;
    }
}
