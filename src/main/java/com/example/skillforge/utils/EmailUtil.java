package com.example.skillforge.utils;

import com.example.skillforge.models.ContactModel;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
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
            InputStream in = EmailUtil.class.getClassLoader().getResourceAsStream("config/application.properties");

            // If application.properties is not found in config directory, try the root resources directory
            if (in == null) {
                in = EmailUtil.class.getClassLoader().getResourceAsStream("application.properties");
                if (in == null) {
                    LOGGER.warning("Could not find application.properties in either config/ or root resources directory");
                    emailEnabled = false;
                    return;
                } else {
                    LOGGER.info("Using application.properties from root resources directory for email configuration");
                }
            } else {
                LOGGER.info("Using application.properties from config directory for email configuration");
            }

            Properties prop = new Properties();
            prop.load(in);
            in.close();

            // Load email configuration
            smtpHost = prop.getProperty("email.smtp.host");
            smtpPort = prop.getProperty("email.smtp.port");
            smtpUsername = prop.getProperty("email.username");
            smtpPassword = prop.getProperty("email.password");
            fromEmail = prop.getProperty("email.from");
            adminEmail = prop.getProperty("email.admin");

            // Check if email is enabled
            String enabled = prop.getProperty("email.enabled");
            emailEnabled = enabled != null && enabled.equalsIgnoreCase("true");

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
     * Send a contact form notification email to the admin
     * @param contact The contact form submission
     * @return true if the email was sent successfully, false otherwise
     */
    public static boolean sendContactNotification(ContactModel contact) {
        if (!emailEnabled) {
            LOGGER.info("Email is disabled. Skipping contact notification email.");
            return false;
        }

        try {
            // Set up mail server properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", smtpHost);
            properties.put("mail.smtp.port", smtpPort);
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");

            // Create a mail session with authentication
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUsername, smtpPassword);
                }
            });

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

            // Send the message
            Transport.send(message);
            LOGGER.info("Contact notification email sent successfully to " + adminEmail);
            return true;

        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending contact notification email", e);
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

        try {
            // Set up mail server properties
            Properties properties = new Properties();
            properties.put("mail.smtp.host", smtpHost);
            properties.put("mail.smtp.port", smtpPort);
            properties.put("mail.smtp.auth", "true");
            properties.put("mail.smtp.starttls.enable", "true");

            // Create a mail session with authentication
            Session session = Session.getInstance(properties, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(smtpUsername, smtpPassword);
                }
            });

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

            // Send the message
            Transport.send(message);
            LOGGER.info("Contact confirmation email sent successfully to " + contact.getEmail());
            return true;

        } catch (MessagingException e) {
            LOGGER.log(Level.SEVERE, "Error sending contact confirmation email", e);
            return false;
        }
    }
}
