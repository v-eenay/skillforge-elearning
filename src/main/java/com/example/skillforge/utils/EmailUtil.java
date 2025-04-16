package com.example.skillforge.utils;

import com.example.skillforge.models.user.ContactModel;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeMessage;
import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Utility class for sending emails
 */
public class EmailUtil {
    private static final Logger LOGGER = Logger.getLogger(EmailUtil.class.getName());

    private static String smtpHost;
    private static String smtpPort;
    private static String smtpUsername;
    private static String smtpPassword;
    private static String fromEmail;
    private static String adminEmail;
    private static boolean emailEnabled;

    static {
        try {
            // Try to load properties from different locations
            InputStream in = findPropertiesFile();

            if (in != null) {
                Properties prop = new Properties();
                prop.load(in);
                in.close();

                // Load email configuration
                smtpHost = prop.getProperty("email.smtp.host", "smtp.gmail.com");
                smtpPort = prop.getProperty("email.smtp.port", "587");
                smtpUsername = prop.getProperty("email.username", "");
                smtpPassword = prop.getProperty("email.password", "");
                fromEmail = prop.getProperty("email.from", "noreply@skillforge.com");
                adminEmail = prop.getProperty("email.admin", "koiralavinay@gmail.com");

                // Check if email is enabled
                String enabled = prop.getProperty("email.enabled", "false");
                emailEnabled = enabled != null && enabled.equalsIgnoreCase("true");
            } else {
                // Use default values if properties file not found
                LOGGER.warning("No properties file found. Email functionality will be disabled.");
                smtpHost = "smtp.gmail.com";
                smtpPort = "587";
                smtpUsername = "";
                smtpPassword = "";
                fromEmail = "noreply@skillforge.com";
                adminEmail = "koiralavinay@gmail.com";
                emailEnabled = false;
            }

            if (emailEnabled) {
                LOGGER.info("Email functionality is enabled");
            } else {
                LOGGER.info("Email functionality is disabled");
            }

        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error loading email properties", e);
            emailEnabled = false;
        }
    }

    /**
     * Validate if a string is a valid email address
     * @param email The email address to validate
     * @return true if the email is valid, false otherwise
     */
    private static boolean isValidEmailAddress(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }

        // Basic email validation using regex
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

        if (!email.matches(emailRegex)) {
            LOGGER.warning("Email address does not match valid pattern: " + email);
            return false;
        }

        return true;
    }

    /**
     * Find the properties file in different locations
     * @return InputStream for the properties file, or null if not found
     */
    private static InputStream findPropertiesFile() {
        InputStream in = null;

        // Try config directory first
        in = EmailUtil.class.getClassLoader().getResourceAsStream("config/application.properties");
        if (in != null) {
            LOGGER.info("Using application.properties from config directory for email configuration");
            return in;
        }

        // Try root resources directory
        in = EmailUtil.class.getClassLoader().getResourceAsStream("application.properties");
        if (in != null) {
            LOGGER.info("Using application.properties from root resources directory for email configuration");
            return in;
        }

        // Try template file
        in = EmailUtil.class.getClassLoader().getResourceAsStream("config/application.properties.template");
        if (in != null) {
            LOGGER.info("Using application.properties.template from config directory for email configuration");
            return in;
        }

        LOGGER.warning("Could not find application.properties in any location for email configuration");
        return null;
    }

    /**
     * Send a contact form notification email to the admin
     * @param contact The contact form submission
     * @return true if the email was sent successfully, false otherwise
     */
    public static boolean sendContactNotification(ContactModel contact) {
        if (!emailEnabled) {
            LOGGER.info("Email is disabled. Skipping contact notification email.");
            return false;
        }

        LOGGER.info("Attempting to send contact notification email to " + adminEmail);
        LOGGER.info("Using SMTP settings - Host: " + smtpHost + ", Port: " + smtpPort + ", Username: " + smtpUsername);

        try {
            // Set up mail server properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", smtpHost);
            properties.put("mail.smtp.port", smtpPort);
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
            properties.put("mail.smtp.ssl.trust", "*");
            properties.put("mail.debug", "true"); // Enable debug mode

            // Create a mail session with authentication and debug enabled
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUsername, smtpPassword);
                }
            });
            session.setDebug(true); // Enable session debugging

            // Validate email addresses
            if (!isValidEmailAddress(fromEmail)) {
                LOGGER.severe("Invalid sender email address: " + fromEmail);
                return false;
            }

            if (!isValidEmailAddress(adminEmail)) {
                LOGGER.severe("Invalid admin email address: " + adminEmail);
                return false;
            }

            // Create the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(adminEmail));
            message.setSubject("New Contact Form Submission: " + contact.getSubject());

            // Build the email body
            StringBuilder body = new StringBuilder();
            body.append("A new contact form submission has been received:\n\n");
            body.append("Name: ").append(contact.getName()).append("\n");
            body.append("Email: ").append(contact.getEmail()).append("\n");
            body.append("Subject: ").append(contact.getSubject()).append("\n");
            body.append("Message: ").append(contact.getMessage()).append("\n\n");

            if (contact.getUserId() != null) {
                body.append("This message was submitted by a logged-in user (UserID: ")
                        .append(contact.getUserId()).append(")");
            } else {
                body.append("This message was submitted by a guest user.");
            }

            message.setText(body.toString());

            LOGGER.info("Email message prepared, attempting to send...");
            LOGGER.info("From: " + fromEmail + ", To: " + adminEmail);

            try {
                // Send the message
                Transport.send(message);
                LOGGER.info("Contact notification email sent successfully to " + adminEmail);
                return true;
            } catch (MessagingException e) {
                // Log more details about the error
                LOGGER.severe("Failed to send email: " + e.getMessage());
                if (e instanceof jakarta.mail.SendFailedException) {
                    jakarta.mail.SendFailedException sfe = (jakarta.mail.SendFailedException) e;
                    if (sfe.getInvalidAddresses() != null) {
                        for (jakarta.mail.Address address : sfe.getInvalidAddresses()) {
                            LOGGER.severe("Invalid address: " + address);
                        }
                    }
                }
                throw e; // Re-throw to be caught by the outer catch block
            }

        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending contact notification email: " + e.getMessage(), e);
            if (e.getCause() != null) {
                LOGGER.log(Level.SEVERE, "Cause: " + e.getCause().getMessage());
            }
            return false;
        }
    }

    /**
     * Send a confirmation email to the user who submitted the contact form
     * @param contact The contact form submission
     * @return true if the email was sent successfully, false otherwise
     */
    public static boolean sendContactConfirmation(ContactModel contact) {
        if (!emailEnabled) {
            LOGGER.info("Email is disabled. Skipping contact confirmation email.");
            return false;
        }

        LOGGER.info("Attempting to send contact confirmation email to " + contact.getEmail());

        try {
            // Set up mail server properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", smtpHost);
            properties.put("mail.smtp.port", smtpPort);
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");
            properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
            properties.put("mail.smtp.ssl.trust", "*");
            properties.put("mail.debug", "true"); // Enable debug mode

            // Log SMTP settings for debugging
            LOGGER.info("SMTP Settings - Host: " + smtpHost + ", Port: " + smtpPort + ", Username: " + smtpUsername);

            // Create a mail session with authentication and debug enabled
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUsername, smtpPassword);
                }
            });
            session.setDebug(true); // Enable session debugging

            // Validate email addresses
            if (!isValidEmailAddress(fromEmail)) {
                LOGGER.severe("Invalid sender email address: " + fromEmail);
                return false;
            }

            if (!isValidEmailAddress(contact.getEmail())) {
                LOGGER.severe("Invalid recipient email address: " + contact.getEmail());
                return false;
            }

            // Create the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(contact.getEmail()));
            message.setSubject("Thank you for contacting SkillForge");

            // Build the email body
            StringBuilder body = new StringBuilder();
            body.append("Dear ").append(contact.getName()).append(",\n\n");
            body.append("Thank you for contacting SkillForge. We have received your message and will get back to you as soon as possible.\n\n");
            body.append("Here's a copy of your message:\n\n");
            body.append("Subject: ").append(contact.getSubject()).append("\n");
            body.append("Message: ").append(contact.getMessage()).append("\n\n");
            body.append("Best regards,\n");
            body.append("The SkillForge Team");

            message.setText(body.toString());

            LOGGER.info("Confirmation email message prepared, attempting to send...");
            LOGGER.info("From: " + fromEmail + ", To: " + contact.getEmail());

            try {
                // Send the message
                Transport.send(message);
                LOGGER.info("Contact confirmation email sent successfully to " + contact.getEmail());
                return true;
            } catch (MessagingException e) {
                // Log more details about the error
                LOGGER.severe("Failed to send email: " + e.getMessage());
                if (e instanceof jakarta.mail.SendFailedException) {
                    jakarta.mail.SendFailedException sfe = (jakarta.mail.SendFailedException) e;
                    if (sfe.getInvalidAddresses() != null) {
                        for (jakarta.mail.Address address : sfe.getInvalidAddresses()) {
                            LOGGER.severe("Invalid address: " + address);
                        }
                    }
                }
                throw e; // Re-throw to be caught by the outer catch block
            }

        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending contact confirmation email: " + e.getMessage(), e);
            if (e.getCause() != null) {
                LOGGER.log(Level.SEVERE, "Cause: " + e.getCause().getMessage());
            }
            return false;
        }
    }
}
