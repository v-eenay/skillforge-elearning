# SkillForge E-Learning Platform

<div align="center">
  <img src="src/main/webapp/assets/images/logo.png" alt="SkillForge Logo" width="200">
  <p><em>Learn from Industry Experts</em></p>

  [![Java](https://img.shields.io/badge/Java-EE-red.svg)](https://www.oracle.com/java/technologies/java-ee-glance.html)
  [![Bootstrap](https://img.shields.io/badge/Bootstrap-5-purple.svg)](https://getbootstrap.com/)
  [![MySQL](https://img.shields.io/badge/MySQL-8-blue.svg)](https://www.mysql.com/)
</div>

## 📋 Overview

SkillForge is a modern e-learning platform designed to provide high-quality educational content from industry experts. The platform offers an intuitive interface for both learners and instructors, making knowledge sharing and skill acquisition more accessible.

## ✨ Features

- 🧭 User-friendly course navigation
- 📱 Responsive design for all devices
- 🔒 Secure authentication system
- 🖥️ Interactive learning interface
- 👨‍🏫 Expert-led course content
- 📊 Progress tracking
- 📧 Contact form with email notifications
- 👤 User profile management
- 🎓 Course enrollment and management
- 🔍 Course search and filtering

## 🛠️ Technology Stack

- **Backend**: Java EE (Servlets, JSP)
- **Frontend**: HTML5, CSS3, JavaScript, Bootstrap 5
- **Database**: MySQL
- **Build Tool**: Maven
- **Server**: Apache Tomcat
- **Authentication**: Custom JWT implementation
- **Email**: Jakarta Mail API

## 🚀 Getting Started

### Prerequisites

- JDK 11 or higher
- Apache Maven 3.6+
- MySQL 8.0+
- Apache Tomcat 9+

### Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/v-eenay/skillforge-elearning.git
   cd skillforge-elearning
   ```

2. **Configure the application**:
   ```bash
   cp src/main/resources/config/application.properties.template src/main/resources/config/application.properties
   ```
   Edit the `application.properties` file with your database and email settings.

3. **Build the project**:
   ```bash
   mvn clean package
   ```

4. **Deploy to Tomcat**:
   - Copy the generated WAR file from the `target` directory to Tomcat's `webapps` directory
   - Or use Maven's Tomcat plugin: `mvn tomcat7:deploy`

5. **Access the application**:
   Open your browser and navigate to `http://localhost:8080/skillforge`

## ⚙️ Configuration

### Database Setup

The application will automatically create the database and tables if they don't exist. Configure your database connection in `application.properties`:

```properties
# Database connection properties
db.driver=com.mysql.cj.jdbc.Driver
db.url=jdbc:mysql://localhost:3306/skillforge
db.username=your_db_username
db.password=your_db_password
```

### Email Configuration

To enable email functionality for contact forms and notifications:

1. Configure the SMTP settings in `application.properties`:
   ```properties
   # Email configuration
   email.enabled=true
   email.smtp.host=smtp.gmail.com
   email.smtp.port=587
   email.username=your.email@gmail.com
   email.password=your-app-password
   email.from=your.email@gmail.com
   email.admin=admin.email@gmail.com
   ```

2. **For Gmail users**:
   - Enable 2-Step Verification on your Google account
   - Generate an App Password:
     - Go to your Google Account > Security
     - Under "Signing in to Google," select "App passwords"
     - Select "Mail" as the app and "Other (Custom name)" as the device
     - Enter "SkillForge" as the name
     - Use the generated 16-character password in your configuration

### Security Note

⚠️ **IMPORTANT**: Never commit the `application.properties` file to version control as it contains sensitive information. The file is already added to `.gitignore`.

## 🔍 Troubleshooting

### Email Issues

If you encounter problems with email functionality:

1. Check application logs for detailed error messages
2. Verify your SMTP credentials are correct
3. For Gmail: ensure 2-Step Verification is enabled and you're using an App Password
4. Test your SMTP settings with a mail client
5. Check firewall settings if running in a corporate environment

### Database Connection Issues

1. Verify MySQL is running and accessible
2. Check database credentials in `application.properties`
3. Ensure the database user has sufficient privileges
4. Try connecting to the database using a MySQL client

## 🧰 Testing

Run the automated tests with:

```bash
mvn test
```

## 👨‍💻 Author

**Vinay Koirala**
Lecturer, Itahari International College

### Contact

- Email: koiralavinay@gmail.com
- Academic Email: Binaya.koirala@iic.edu.np
- GitHub: [v-eenay/skillforge-elearning](https://github.com/v-eenay/skillforge-elearning.git)
