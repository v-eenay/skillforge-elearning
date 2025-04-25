package com.example.skillforge.utils;

import com.example.skillforge.models.user.ContactModel;

import jakarta.mail.*;
import jakarta.mail.internet.InternetAddress;
import jakarta.mail.internet.MimeBodyPart;
import jakarta.mail.internet.MimeMessage;
import jakarta.mail.internet.MimeMultipart;
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.Date;
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
            LOGGER.warning("Email address is null or empty");
            return false;
        }

        // Basic email validation using regex
        String emailRegex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

        if (!email.matches(emailRegex)) {
            LOGGER.warning("Email address does not match valid pattern: " + email);
            return false;
        }

        LOGGER.info("Email address is valid: " + email);
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
     * Read an HTML template from the resources directory
     * @param templatePath The path to the template file
     * @return The template content as a string, or null if the template could not be read
     */
    private static String readHtmlTemplate(String templatePath) {
        try (InputStream inputStream = EmailUtil.class.getClassLoader().getResourceAsStream(templatePath)) {
            if (inputStream == null) {
                LOGGER.severe("Could not find template file: " + templatePath);
                return null;
            }

            StringBuilder content = new StringBuilder();
            try (BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream, StandardCharsets.UTF_8))) {
                String line;
                while ((line = reader.readLine()) != null) {
                    content.append(line).append("\n");
                }
            }
            return content.toString();
        } catch (IOException e) {
            LOGGER.log(Level.SEVERE, "Error reading template file: " + templatePath, e);
            return null;
        }
    }

    /**
     * Replace placeholders in a template with actual values
     * @param template The template string
     * @param placeholders The placeholders to replace (key-value pairs)
     * @return The template with placeholders replaced
     */
    private static String replacePlaceholders(String template, Properties placeholders) {
        if (template == null) {
            return null;
        }

        String result = template;
        for (String key : placeholders.stringPropertyNames()) {
            String placeholder = "{{" + key + "}}";
            String value = placeholders.getProperty(key);
            result = result.replace(placeholder, value);
        }
        return result;
    }

    /**
     * Create a mail session with the configured SMTP settings
     * @return The mail session
     */
    private static Session createMailSession() {
        Properties properties = new Properties();
        properties.put("mail.smtp.host", smtpHost);
        properties.put("mail.smtp.port", smtpPort);
        properties.put("mail.smtp.auth", "true");
        properties.put("mail.smtp.starttls.enable", "true");
        properties.put("mail.smtp.ssl.protocols", "TLSv1.2");
        properties.put("mail.smtp.ssl.trust", "*");
        properties.put("mail.debug", "true"); // Enable debug mode

        Session session = Session.getInstance(properties, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(smtpUsername, smtpPassword);
            }
        });
        session.setDebug(true); // Enable session debugging
        return session;
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
            // Create mail session
            Session session = createMailSession();

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

            // Read the HTML template
            String template = readHtmlTemplate("email-templates/admin-notification.html");
            if (template == null) {
                // Fallback to plain text email if template is not found
                LOGGER.warning("HTML template not found, falling back to plain text email");

                // Build the plain text email body
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
            } else {
                // Replace placeholders in the template
                Properties placeholders = new Properties();
                placeholders.setProperty("name", contact.getName());
                placeholders.setProperty("email", contact.getEmail());
                placeholders.setProperty("subject", contact.getSubject() != null ? contact.getSubject() : "No Subject");
                placeholders.setProperty("message", contact.getMessage());

                // Format the current date
                SimpleDateFormat dateFormat = new SimpleDateFormat("MMMM d, yyyy 'at' h:mm a");
                placeholders.setProperty("date", dateFormat.format(new Date()));

                // Add user badge if the user is logged in
                if (contact.getUserId() != null) {
                    placeholders.setProperty("userBadge", "<span class=\"user-badge\">Registered User</span>");
                } else {
                    placeholders.setProperty("userBadge", "<span class=\"guest-badge\">Guest</span>");
                }

                String htmlContent = replacePlaceholders(template, placeholders);

                // Set the HTML content
                MimeBodyPart htmlPart = new MimeBodyPart();
                htmlPart.setContent(htmlContent, "text/html; charset=utf-8");

                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(htmlPart);

                message.setContent(multipart);
            }

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

        if (!isValidEmailAddress(contact.getEmail())) {
            LOGGER.severe("Invalid recipient email address: " + contact.getEmail());
            return false;
        }

        LOGGER.info("Attempting to send contact confirmation email to " + contact.getEmail());
        LOGGER.info("Using SMTP settings - Host: " + smtpHost + ", Port: " + smtpPort + ", Username: " + smtpUsername);
        LOGGER.info("Email enabled: " + emailEnabled);

        try {
            // Create mail session
            Session session = createMailSession();

            // Create the email message
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(fromEmail));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(contact.getEmail()));
            message.setSubject("Thank you for contacting SkillForge");

            // Read the HTML template
            String template = readHtmlTemplate("email-templates/contact-confirmation.html");
            if (template == null) {
                // Fallback to plain text email if template is not found
                LOGGER.warning("HTML template not found, falling back to plain text email");

                // Build the plain text email body
                StringBuilder body = new StringBuilder();
                body.append("Dear ").append(contact.getName()).append(",\n\n");
                body.append("Thank you for contacting SkillForge. We have received your message and will get back to you as soon as possible.\n\n");
                body.append("Here's a summary of your message:\n\n");
                body.append("Subject: ").append(contact.getSubject()).append("\n");
                body.append("Message: ").append(contact.getMessage()).append("\n\n");
                body.append("Best regards,\n");
                body.append("The SkillForge Team");

                message.setText(body.toString());
            } else {
                // Replace placeholders in the template
                Properties placeholders = new Properties();
                placeholders.setProperty("name", contact.getName());
                placeholders.setProperty("subject", contact.getSubject() != null ? contact.getSubject() : "No Subject");
                placeholders.setProperty("message", contact.getMessage());

                String htmlContent = replacePlaceholders(template, placeholders);

                // Set the HTML content
                MimeBodyPart htmlPart = new MimeBodyPart();
                htmlPart.setContent(htmlContent, "text/html; charset=utf-8");

                Multipart multipart = new MimeMultipart();
                multipart.addBodyPart(htmlPart);

                message.setContent(multipart);
            }

            LOGGER.info("Confirmation email message prepared, attempting to send...");
            LOGGER.info("From: " + fromEmail + ", To: " + contact.getEmail());

            try {
                // Send the message
                Transport.send(message);
                LOGGER.info("Contact confirmation email sent successfully to " + contact.getEmail());
                return true;
            } catch (MessagingException e) {
                // Log more details about the error
                LOGGER.severe("Failed to send confirmation email: " + e.getMessage());
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
