package com.example.skillforge.dao;

import com.example.skillforge.models.ContactModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Data Access Object for Contact form submissions
 */
public class ContactDAO {
    private static final Logger LOGGER = Logger.getLogger(ContactDAO.class.getName());
    
    private static final String INSERT_CONTACT_SQL = 
            "INSERT INTO Contact (Name, Email, Subject, Message, UserID) VALUES (?, ?, ?, ?, ?)";
    private static final String SELECT_ALL_CONTACTS_SQL = 
            "SELECT * FROM Contact ORDER BY SubmittedAt DESC";
    private static final String SELECT_CONTACT_BY_ID_SQL = 
            "SELECT * FROM Contact WHERE ContactID = ?";
    private static final String UPDATE_CONTACT_STATUS_SQL = 
            "UPDATE Contact SET Status = ? WHERE ContactID = ?";
    private static final String SELECT_CONTACTS_BY_STATUS_SQL = 
            "SELECT * FROM Contact WHERE Status = ? ORDER BY SubmittedAt DESC";
    private static final String SELECT_CONTACTS_BY_USER_SQL = 
            "SELECT * FROM Contact WHERE UserID = ? ORDER BY SubmittedAt DESC";
    
    /**
     * Insert a new contact form submission
     * @param contact The contact form submission to insert
     * @return The ID of the inserted contact, or 0 if insertion failed
     */
    public static int insertContact(ContactModel contact) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_CONTACT_SQL, 
                     PreparedStatement.RETURN_GENERATED_KEYS)) {
            
            preparedStatement.setString(1, contact.getName());
            preparedStatement.setString(2, contact.getEmail());
            preparedStatement.setString(3, contact.getSubject());
            preparedStatement.setString(4, contact.getMessage());
            
            // Handle null userId
            if (contact.getUserId() != null) {
                preparedStatement.setInt(5, contact.getUserId());
            } else {
                preparedStatement.setNull(5, Types.INTEGER);
            }
            
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error inserting contact", e);
        }
        return 0;
    }
    
    /**
     * Get all contact form submissions
     * @return A list of all contact form submissions
     */
    public static List<ContactModel> getAllContacts() {
        List<ContactModel> contacts = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_CONTACTS_SQL)) {
            
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                contacts.add(mapResultSetToContactModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting all contacts", e);
        }
        return contacts;
    }
    
    /**
     * Get a contact form submission by ID
     * @param contactId The ID of the contact form submission
     * @return The contact form submission, or null if not found
     */
    public static ContactModel getContactById(int contactId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CONTACT_BY_ID_SQL)) {
            
            preparedStatement.setInt(1, contactId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToContactModel(resultSet);
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting contact by ID", e);
        }
        return null;
    }
    
    /**
     * Update the status of a contact form submission
     * @param contactId The ID of the contact form submission
     * @param status The new status
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateContactStatus(int contactId, ContactModel.Status status) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_CONTACT_STATUS_SQL)) {
            
            preparedStatement.setString(1, status.toString());
            preparedStatement.setInt(2, contactId);
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error updating contact status", e);
            return false;
        }
    }
    
    /**
     * Get contact form submissions by status
     * @param status The status to filter by
     * @return A list of contact form submissions with the specified status
     */
    public static List<ContactModel> getContactsByStatus(ContactModel.Status status) {
        List<ContactModel> contacts = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CONTACTS_BY_STATUS_SQL)) {
            
            preparedStatement.setString(1, status.toString());
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                contacts.add(mapResultSetToContactModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting contacts by status", e);
        }
        return contacts;
    }
    
    /**
     * Get contact form submissions by user ID
     * @param userId The user ID to filter by
     * @return A list of contact form submissions from the specified user
     */
    public static List<ContactModel> getContactsByUser(int userId) {
        List<ContactModel> contacts = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_CONTACTS_BY_USER_SQL)) {
            
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                contacts.add(mapResultSetToContactModel(resultSet));
            }
        } catch (SQLException e) {
            LOGGER.log(Level.SEVERE, "Error getting contacts by user", e);
        }
        return contacts;
    }
    
    /**
     * Map a ResultSet to a ContactModel
     * @param resultSet The ResultSet to map
     * @return A ContactModel populated with data from the ResultSet
     * @throws SQLException If there is an error accessing the ResultSet
     */
    private static ContactModel mapResultSetToContactModel(ResultSet resultSet) throws SQLException {
        ContactModel contact = new ContactModel();
        contact.setContactId(resultSet.getInt("ContactID"));
        contact.setName(resultSet.getString("Name"));
        contact.setEmail(resultSet.getString("Email"));
        contact.setSubject(resultSet.getString("Subject"));
        contact.setMessage(resultSet.getString("Message"));
        
        // Handle null userId
        int userId = resultSet.getInt("UserID");
        if (!resultSet.wasNull()) {
            contact.setUserId(userId);
        }
        
        // Convert SQL timestamp to LocalDateTime
        Timestamp timestamp = resultSet.getTimestamp("SubmittedAt");
        if (timestamp != null) {
            contact.setSubmittedAt(timestamp.toLocalDateTime());
        }
        
        // Handle status
        String statusStr = resultSet.getString("Status");
        if (statusStr != null && !statusStr.isEmpty()) {
            // Convert database status string to enum
            if (statusStr.equals("new")) {
                contact.setStatus(ContactModel.Status.new_status);
            } else {
                contact.setStatus(ContactModel.Status.valueOf(statusStr));
            }
        }
        
        return contact;
    }
}
