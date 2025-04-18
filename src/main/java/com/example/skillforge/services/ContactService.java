package com.example.skillforge.services;

import com.example.skillforge.dao.user.ContactDAO;
import com.example.skillforge.models.user.ContactModel;
import com.example.skillforge.utils.EmailUtil;

import java.util.List;
import java.util.logging.Logger;

/**
 * Service class for handling contact form submissions
 */
public class ContactService {
    private static final Logger LOGGER = Logger.getLogger(ContactService.class.getName());

    /**
     * Submit a contact form
     * @param name The name of the person submitting the form
     * @param email The email of the person submitting the form
     * @param subject The subject of the message
     * @param message The message content
     * @param userId The ID of the logged-in user (can be null for non-logged in users)
     * @return The ID of the inserted contact, or 0 if submission failed
     */
    public static int submitContactForm(String name, String email, String subject, String message, Integer userId) {
        ContactModel contact = new ContactModel();
        contact.setName(name);
        contact.setEmail(email);
        contact.setSubject(subject);
        contact.setMessage(message);
        contact.setUserId(userId);

        // Insert the contact form submission into the database
        int contactId = ContactDAO.insertContact(contact);

        if (contactId > 0) {
            // Set the contact ID
            contact.setContactId(contactId);

            // Send notification email to admin
            try {
                boolean notificationSent = EmailUtil.sendContactNotification(contact);
                if (!notificationSent) {
                    LOGGER.warning("Failed to send notification email to admin, but contact was saved in database.");
                }
            } catch (Exception e) {
                LOGGER.severe("Error sending notification email: " + e.getMessage());
            }

            // Send confirmation email to user
            try {
                boolean confirmationSent = EmailUtil.sendContactConfirmation(contact);
                if (!confirmationSent) {
                    LOGGER.warning("Failed to send confirmation email to user, but contact was saved in database.");
                }
            } catch (Exception e) {
                LOGGER.severe("Error sending confirmation email: " + e.getMessage());
            }

            LOGGER.info("Contact form submitted successfully. ContactID: " + contactId);
        } else {
            LOGGER.warning("Failed to submit contact form");
        }

        return contactId;
    }

    /**
     * Get all contact form submissions
     * @return A list of all contact form submissions
     */
    public static List<ContactModel> getAllContacts() {
        return ContactDAO.getAllContacts();
    }

    /**
     * Get a contact form submission by ID
     * @param contactId The ID of the contact form submission
     * @return The contact form submission, or null if not found
     */
    public static ContactModel getContactById(int contactId) {
        return ContactDAO.getContactById(contactId);
    }

    /**
     * Update the status of a contact form submission
     * @param contactId The ID of the contact form submission
     * @param status The new status
     * @return true if the update was successful, false otherwise
     */
    public static boolean updateContactStatus(int contactId, ContactModel.Status status) {
        return ContactDAO.updateContactStatus(contactId, status);
    }

    /**
     * Get contact form submissions by status
     * @param status The status to filter by
     * @return A list of contact form submissions with the specified status
     */
    public static List<ContactModel> getContactsByStatus(ContactModel.Status status) {
        return ContactDAO.getContactsByStatus(status);
    }

    /**
     * Get contact form submissions by user ID
     * @param userId The user ID to filter by
     * @return A list of contact form submissions from the specified user
     */
    public static List<ContactModel> getContactsByUser(int userId) {
        return ContactDAO.getContactsByUser(userId);
    }
}
