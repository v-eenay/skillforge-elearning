# SkillForge E-Learning Platform

SkillForge is a modern e-learning platform designed to provide high-quality educational content from industry experts. The platform offers an intuitive interface for both learners and instructors, making knowledge sharing and skill acquisition more accessible.

## Features

- User-friendly course navigation
- Responsive design for all devices
- Secure authentication system
- Interactive learning interface
- Expert-led course content
- Progress tracking

## Technology Stack

- Java EE
- JSP/Servlet
- Bootstrap 5
- MySQL

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/v-eenay/skillforge-elearning.git
   ```
2. Create your configuration file:
   ```bash
   cd skillforge-elearning
   cp src/main/resources/config/application.properties.template src/main/resources/config/application.properties
   ```
3. Configure your database and email settings in the newly created `application.properties` file
4. Build and deploy using Maven

## Configuration

The application uses a properties file for configuration. For security reasons, this file is not included in version control.

### Setting Up Configuration

1. Copy the template file:
   ```bash
   cp src/main/resources/config/application.properties.template src/main/resources/config/application.properties
   ```
2. Edit the `application.properties` file with your actual credentials
3. **IMPORTANT**: Never commit the `application.properties` file to version control

## Email Configuration

To enable email functionality for contact form submissions, follow these steps:

1. Open the `src/main/resources/config/application.properties` file
2. Set `email.enabled=true`
3. Configure the SMTP settings:
   - `email.smtp.host`: Your SMTP server (e.g., smtp.gmail.com)
   - `email.smtp.port`: SMTP port (usually 587 for TLS)
   - `email.username`: Your email address
   - `email.password`: Your email password or app password
   - `email.from`: The "From" email address
   - `email.admin`: The admin email address to receive notifications

### Using Gmail

If you're using Gmail, you'll need to:

1. Enable 2-Step Verification on your Google account
2. Generate an App Password:
   - Go to your Google Account > Security
   - Under "Signing in to Google," select "App passwords"
   - Generate a new app password for "Mail" and "Other (Custom name)"
   - Use this app password in the `email.password` field

Example configuration:
```properties
# Email configuration
email.enabled=true
email.smtp.host=smtp.gmail.com
email.smtp.port=587
email.username=your.email@gmail.com
email.password=your-app-password
email.from=your.email@gmail.com
email.admin=koiralavinay@gmail.com
```

## Database Configuration

The application will automatically create the database and tables if they don't exist. The default database configuration is:

```properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/skillforge
db.username=root
db.password=
```

Update these values in `src/main/resources/config/application.properties` if needed.

## Author

**Vinay Koirala**
Lecturer, Itahari International College

### Contact

- Email: koiralavinay@gmail.com
- Academic Email: Binaya.koirala@iic.edu.np
- GitHub: [v-eenay/skillforge-elearning](https://github.com/v-eenay/skillforge-elearning.git)
