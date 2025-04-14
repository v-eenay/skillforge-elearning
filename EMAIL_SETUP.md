# Email Setup Instructions for SkillForge

This document provides detailed instructions for setting up email functionality in the SkillForge application.

## Gmail App Password Setup

The application is now configured to use Gmail as the SMTP server. To make this work, you need to:

1. **Enable 2-Step Verification on your Google account**:
   - Go to your Google Account > Security
   - Enable 2-Step Verification if not already enabled

2. **Generate an App Password**:
   - Go to your Google Account > Security
   - Under "Signing in to Google," select "App passwords" (you'll only see this if 2-Step Verification is enabled)
   - Select "Mail" as the app and "Other (Custom name)" as the device
   - Enter "SkillForge" as the name
   - Click "Generate"
   - Google will display a 16-character app password
   - Copy this password

3. **Update application.properties**:
   - Open `src/main/resources/config/application.properties`
   - Replace `your-app-password` with the 16-character app password you generated
   - Make sure `email.enabled=true`
   - Ensure `email.username` matches your Gmail address

Example configuration:
```properties
# Email configuration
email.enabled=true
email.smtp.host=smtp.gmail.com
email.smtp.port=587
email.username=your.email@gmail.com
email.password=abcd efgh ijkl mnop  # Your 16-character app password (spaces will be ignored)
email.from=your.email@gmail.com
email.admin=koiralavinay@gmail.com
```

## Troubleshooting

If you encounter email sending issues:

1. **Check logs for detailed error messages**
2. **Verify your app password is correct**
3. **Ensure 2-Step Verification is enabled on your Google account**
4. **Check that you're using the correct Gmail address**
5. **Make sure your Google account doesn't have additional security restrictions**

## Alternative Email Providers

If you prefer to use a different email provider:

1. Update the SMTP settings in `application.properties`:
   ```properties
   email.smtp.host=your-smtp-server
   email.smtp.port=your-smtp-port
   email.username=your-email
   email.password=your-password
   ```

2. You may need to adjust the SSL/TLS settings in `EmailUtil.java` depending on your provider's requirements.
