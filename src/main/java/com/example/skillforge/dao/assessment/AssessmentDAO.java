package com.example.skillforge.dao.assessment;

import com.example.skillforge.models.assessment.AssessmentModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Course Assessments
 */
public class AssessmentDAO {
    private static final Logger LOGGER = Logger.getLogger(AssessmentDAO.class.getName());
    
    private static final String INSERT_ASSESSMENT_SQL = 
            "INSERT INTO Assessment (CourseID, Title, Description, AssessmentType, TotalMarks, " +
            "PassingMarks, Duration, IsRequired, Weightage, Status, AvailableFrom, AvailableUntil) " +
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_ASSESSMENTS_BY_COURSE_SQL = 
            "SELECT * FROM Assessment WHERE CourseID = ? ORDER BY AvailableFrom";
    private static final String SELECT_ASSESSMENT_BY_ID_SQL = 
            "SELECT * FROM Assessment WHERE AssessmentID = ?";
    private static final String UPDATE_ASSESSMENT_SQL = 
            "UPDATE Assessment SET Title = ?, Description = ?, AssessmentType = ?, TotalMarks = ?, " +
            "PassingMarks = ?, Duration = ?, IsRequired = ?, Weightage = ?, Status = ?, " +
            "AvailableFrom = ?, AvailableUntil = ? WHERE AssessmentID = ?";
    private static final String DELETE_ASSESSMENT_SQL = 
            "DELETE FROM Assessment WHERE AssessmentID = ?";
    private static final String COUNT_ASSESSMENTS_BY_COURSE_SQL = 
            "SELECT COUNT(*) FROM Assessment WHERE CourseID = ?";
    
    /**
     * Insert a new assessment
     * @param assessment The assessment to insert
     * @return The ID of the inserted assessment, or 0 if insertion failed
     */
    public static int insertAssessment(AssessmentModel assessment) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_ASSESSMENT_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setInt(1, assessment.getCourseId());
            preparedStatement.setString(2, assessment.getTitle());
            preparedStatement.setString(3, assessment.getDescription());
            preparedStatement.setString(4, assessment.getAssessmentType().toString());
            preparedStatement.setInt(5, assessment.getTotalMarks());
            preparedStatement.setInt(6, assessment.getPassingMarks());
            preparedStatement.setInt(7, assessment.getDuration());
            preparedStatement.setBoolean(8, assessment.isRequired());
            preparedStatement.setDouble(9, assessment.getWeightage());
            preparedStatement.setString(10, assessment.getStatus().toString());
            
            // Handle timestamps
            if (assessment.getAvailableFrom() != null) {
                preparedStatement.setTimestamp(11, Timestamp.valueOf(assessment.getAvailableFrom()));
            } else {
                preparedStatement.setNull(11, Types.TIMESTAMP);
            }
            
            if (assessment.getAvailableUntil() != null) {
                preparedStatement.setTimestamp(12, Timestamp.valueOf(assessment.getAvailableUntil()));
            } else {
                preparedStatement.setNull(12, Types.TIMESTAMP);
            }
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting assessment", e);
        }
        return 0;
    }
    
    /**
     * Get all assessments for a course
     * @param courseId The ID of the course
     * @return A list of assessments for the course
     */
    public static List<AssessmentModel> getAssessmentsByCourse(int courseId) {
        List<AssessmentModel> assessments = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ASSESSMENTS_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                assessments.add(mapResultSetToAssessmentModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting assessments by course", e);
        }
        return assessments;
    }
    
    /**
     * Get an assessment by ID
     * @param assessmentId The ID of the assessment
     * @return The assessment, or null if not found
     */
    public static AssessmentModel getAssessmentById(int assessmentId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ASSESSMENT_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, assessmentId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToAssessmentModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting assessment by ID", e);
        }
        return null;
    }
    
    /**
     * Update an assessment
     * @param assessment The assessment to update
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateAssessment(AssessmentModel assessment) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_ASSESSMENT_SQL)) {
            
            preparedStatement.setString(1, assessment.getTitle());
            preparedStatement.setString(2, assessment.getDescription());
            preparedStatement.setString(3, assessment.getAssessmentType().toString());
            preparedStatement.setInt(4, assessment.getTotalMarks());
            preparedStatement.setInt(5, assessment.getPassingMarks());
            preparedStatement.setInt(6, assessment.getDuration());
            preparedStatement.setBoolean(7, assessment.isRequired());
            preparedStatement.setDouble(8, assessment.getWeightage());
            preparedStatement.setString(9, assessment.getStatus().toString());
            
            // Handle timestamps
            if (assessment.getAvailableFrom() != null) {
                preparedStatement.setTimestamp(10, Timestamp.valueOf(assessment.getAvailableFrom()));
            } else {
                preparedStatement.setNull(10, Types.TIMESTAMP);
            }
            
            if (assessment.getAvailableUntil() != null) {
                preparedStatement.setTimestamp(11, Timestamp.valueOf(assessment.getAvailableUntil()));
            } else {
                preparedStatement.setNull(11, Types.TIMESTAMP);
            }
            
            preparedStatement.setInt(12, assessment.getAssessmentId());
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating assessment", e);
        }
        return false;
    }
    
    /**
     * Delete an assessment
     * @param assessmentId The ID of the assessment to delete
     * @return true if the deletion was successful, false otherwise
     */
    public static boolean deleteAssessment(int assessmentId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_ASSESSMENT_SQL)) {
            
            preparedStatement.setInt(1, assessmentId);
            
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error deleting assessment", e);
        }
        return false;
    }
    
    /**
     * Count the number of assessments for a course
     * @param courseId The ID of the course
     * @return The number of assessments for the course
     */
    public static int countAssessmentsByCourse(int courseId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(COUNT_ASSESSMENTS_BY_COURSE_SQL)) {
            
            preparedStatement.setInt(1, courseId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error counting assessments by course", e);
        }
        return 0;
    }
    
    /**
     * Map a ResultSet to an AssessmentModel
     * @param resultSet The ResultSet to map
     * @return An AssessmentModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static AssessmentModel mapResultSetToAssessmentModel(ResultSet resultSet) throws SQLException {
        AssessmentModel assessment = new AssessmentModel();
        assessment.setAssessmentId(resultSet.getInt("AssessmentID"));
        assessment.setCourseId(resultSet.getInt("CourseID"));
        assessment.setTitle(resultSet.getString("Title"));
        assessment.setDescription(resultSet.getString("Description"));
        assessment.setAssessmentType(AssessmentModel.AssessmentType.valueOf(resultSet.getString("AssessmentType")));
        assessment.setTotalMarks(resultSet.getInt("TotalMarks"));
        assessment.setPassingMarks(resultSet.getInt("PassingMarks"));
        assessment.setDuration(resultSet.getInt("Duration"));
        assessment.setRequired(resultSet.getBoolean("IsRequired"));
        assessment.setWeightage(resultSet.getDouble("Weightage"));
        assessment.setStatus(AssessmentModel.Status.valueOf(resultSet.getString("Status")));
        
        // Handle timestamps
        Timestamp availableFromTimestamp = resultSet.getTimestamp("AvailableFrom");
        if (availableFromTimestamp != null) {
            assessment.setAvailableFrom(availableFromTimestamp.toLocalDateTime());
        }
        
        Timestamp availableUntilTimestamp = resultSet.getTimestamp("AvailableUntil");
        if (availableUntilTimestamp != null) {
            assessment.setAvailableUntil(availableUntilTimestamp.toLocalDateTime());
        }
        
        Timestamp createdAtTimestamp = resultSet.getTimestamp("CreatedAt");
        if (createdAtTimestamp != null) {
            assessment.setCreatedAt(createdAtTimestamp.toLocalDateTime());
        }
        
        Timestamp updatedAtTimestamp = resultSet.getTimestamp("UpdatedAt");
        if (updatedAtTimestamp != null) {
            assessment.setUpdatedAt(updatedAtTimestamp.toLocalDateTime());
        }
        
        return assessment;
    }
}
