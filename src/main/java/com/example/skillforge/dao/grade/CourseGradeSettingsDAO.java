package com.example.skillforge.dao.grade;

import com.example.skillforge.models.grade.CourseGradeSettingsModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Course Grade Settings
 */
public class CourseGradeSettingsDAO {
    private static final Logger LOGGER = Logger.getLogger(CourseGradeSettingsDAO.class.getName());
    
    private static final String INSERT_SETTINGS_SQL = 
            "INSERT INTO CourseGradeSettings (CourseID, PassingGrade, UseLetterGrades, " +
            "AutoCalculateFinalGrade, GradeScale, QuizWeightage, AssignmentWeightage, " +
            "ProjectWeightage, MidtermWeightage, FinalExamWeightage, ParticipationWeightage) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_SETTINGS_BY_COURSE_SQL = 
            "SELECT * FROM CourseGradeSettings WHERE CourseID = ?";
    private static final String UPDATE_SETTINGS_SQL = 
            "UPDATE CourseGradeSettings SET PassingGrade = ?, UseLetterGrades = ?, " +
            "AutoCalculateFinalGrade = ?, GradeScale = ?, QuizWeightage = ?, " +
            "AssignmentWeightage = ?, ProjectWeightage = ?, MidtermWeightage = ?, " +
            "FinalExamWeightage = ?, ParticipationWeightage = ? WHERE SettingsID = ?";
    private static final String DELETE_SETTINGS_SQL = 
            "DELETE FROM CourseGradeSettings WHERE SettingsID = ?";
    
    /**
     * Insert new course grade settings
     * @param settings The settings to insert
     * @return The ID of the inserted settings, or 0 if insertion failed
     */
    public static int insertSettings(CourseGradeSettingsModel settings) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_SETTINGS_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, settings.getCourseId());
            preparedStatement.setDouble(2, settings.getPassingGrade());
            preparedStatement.setBoolean(3, settings.isUseLetterGrades());
            preparedStatement.setBoolean(4, settings.isAutoCalculateFinalGrade());
            
            // Convert grade scale map to JSON string
            String gradeScaleJson = convertGradeScaleToJson(settings.getGradeScale());
            preparedStatement.setString(5, gradeScaleJson);
            
            preparedStatement.setDouble(6, settings.getQuizWeightage());
            preparedStatement.setDouble(7, settings.getAssignmentWeightage());
            preparedStatement.setDouble(8, settings.getProjectWeightage());
            preparedStatement.setDouble(9, settings.getMidtermWeightage());
            preparedStatement.setDouble(10, settings.getFinalExamWeightage());
            preparedStatement.setDouble(11, settings.getParticipationWeightage());
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting course grade settings", e);
        }
        return 0;
    }
    
    /**
     * Get course grade settings by course ID
     * @param courseId The ID of the course
     * @return The course grade settings, or null if not found
     */
    public static CourseGradeSettingsModel getSettingsByCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_SETTINGS_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToSettingsModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting course grade settings by course", e);
        }
        return null;
    }
    
    /**
     * Update course grade settings
     * @param settings The settings to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateSettings(CourseGradeSettingsModel settings) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_SETTINGS_SQL)) {
            
            preparedStatement.setDouble(1, settings.getPassingGrade());
            preparedStatement.setBoolean(2, settings.isUseLetterGrades());
            preparedStatement.setBoolean(3, settings.isAutoCalculateFinalGrade());
            
            // Convert grade scale map to JSON string
            String gradeScaleJson = convertGradeScaleToJson(settings.getGradeScale());
            preparedStatement.setString(4, gradeScaleJson);
            
            preparedStatement.setDouble(5, settings.getQuizWeightage());
            preparedStatement.setDouble(6, settings.getAssignmentWeightage());
            preparedStatement.setDouble(7, settings.getProjectWeightage());
            preparedStatement.setDouble(8, settings.getMidtermWeightage());
            preparedStatement.setDouble(9, settings.getFinalExamWeightage());
            preparedStatement.setDouble(10, settings.getParticipationWeightage());
            preparedStatement.setInt(11, settings.getSettingsId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating course grade settings", e);
        }
        return false;
    }
    
    /**
     * Delete course grade settings
     * @param settingsId The ID of the settings to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteSettings(int settingsId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_SETTINGS_SQL)) {
            
            preparedStatement.setInt(1, settingsId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting course grade settings", e);
        }
        return false;
    }
    
    /**
     * Map a ResultSet to a CourseGradeSettingsModel
     * @param resultSet The ResultSet to map
     * @return A CourseGradeSettingsModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static CourseGradeSettingsModel mapResultSetToSettingsModel(ResultSet resultSet) throws SQLException {
        CourseGradeSettingsModel settings = new CourseGradeSettingsModel();
        settings.setSettingsId(resultSet.getInt("SettingsID"));
        settings.setCourseId(resultSet.getInt("CourseID"));
        settings.setPassingGrade(resultSet.getDouble("PassingGrade"));
        settings.setUseLetterGrades(resultSet.getBoolean("UseLetterGrades"));
        settings.setAutoCalculateFinalGrade(resultSet.getBoolean("AutoCalculateFinalGrade"));
        
        // Parse grade scale JSON string to map
        String gradeScaleJson = resultSet.getString("GradeScale");
        Map<String, Double> gradeScale = parseGradeScaleJson(gradeScaleJson);
        if (gradeScale != null) {
            settings.setGradeScale(gradeScale);
        }
        
        settings.setQuizWeightage(resultSet.getDouble("QuizWeightage"));
        settings.setAssignmentWeightage(resultSet.getDouble("AssignmentWeightage"));
        settings.setProjectWeightage(resultSet.getDouble("ProjectWeightage"));
        settings.setMidtermWeightage(resultSet.getDouble("MidtermWeightage"));
        settings.setFinalExamWeightage(resultSet.getDouble("FinalExamWeightage"));
        settings.setParticipationWeightage(resultSet.getDouble("ParticipationWeightage"));
        
        return settings;
    }
    
    /**
     * Convert a grade scale map to a JSON string
     * @param gradeScale The grade scale map
     * @return A JSON string representation of the grade scale
     */
    private static String convertGradeScaleToJson(Map<String, Double> gradeScale) {
        StringBuilder json = new StringBuilder("{");
        boolean first = true;
        
        for (Map.Entry<String, Double> entry : gradeScale.entrySet()) {
            if (!first) {
                json.append(",");
            }
            json.append("\"").append(entry.getKey()).append("\":").append(entry.getValue());
            first = false;
        }
        
        json.append("}");
        return json.toString();
    }
    
    /**
     * Parse a JSON string to a grade scale map
     * @param json The JSON string
     * @return A map of letter grades to minimum percentages
     */
    private static Map<String, Double> parseGradeScaleJson(String json) {
        if (json == null || json.isEmpty()) {
            return null;
        }
        
        Map<String, Double> gradeScale = new HashMap<>();
        
        // Simple JSON parsing (for a more robust solution, use a JSON library)
        json = json.trim();
        if (json.startsWith("{") && json.endsWith("}")) {
            json = json.substring(1, json.length() - 1);
            String[] pairs = json.split(",");
            
            for (String pair : pairs) {
                String[] keyValue = pair.split(":");
                if (keyValue.length == 2) {
                    String key = keyValue[0].trim();
                    if (key.startsWith("\"") && key.endsWith("\"")) {
                        key = key.substring(1, key.length() - 1);
                    }
                    
                    try {
                        double value = Double.parseDouble(keyValue[1].trim());
                        gradeScale.put(key, value);
                    } catch (NumberFormatException e) {
                        LOGGER.log(Level.WARNING, "Error parsing grade scale value: " + keyValue[1], e);
                    }
                }
            }
        }
        
        return gradeScale;
    }
}
