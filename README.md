📦 SkillForge Project Structure
==========================

   📂 your-project/<br>
   ├── 📄 pom.xml                          # Maven project configuration<br>
   ├── 📄 README.md                        # Project documentation<br>
   ├── 📄 .gitignore                       # Git ignore configuration<br>
   ├── 📄 LICENSE                          # Project license<br>
   │<br>
   └── 📂 src/<br>
      ├── 📂 main/<br>
      │   ├── 📂 java/<br>
      │   │   └── 📂 com/<br>
      │   │       └── 📂 example/<br>
      │   │           └── 📂 skillforge/<br>
      │   │               ├── 📂 config/                    # Configuration classes<br>
      │   │               │   ├── 📄 AppConfig.java<br>
      │   │               │   └── 📄 SecurityConfig.java<br>
      │   │               │<br>
      │   │               ├── 📂 controllers/               # Request handlers<br>
      │   │               │   ├── 📄 AuthController.java<br>
      │   │               │   ├── 📄 CourseController.java<br>
      │   │               │   ├── 📄 StudentController.java<br>
      │   │               │   └── 📄 AdminController.java<br>
      │   │               │<br>
      │   │               ├── 📂 models/                    # Domain models<br>
      │   │               │   ├── 📂 dto/                   # Data Transfer Objects<br>
      │   │               │   │   ├── 📄 CourseDTO.java<br>
      │   │               │   │   └── 📄 UserDTO.java<br>
      │   │               │   │<br>
      │   │               │   ├── 📄 User.java<br>
      │   │               │   ├── 📄 Course.java<br>
      │   │               │   ├── 📄 Quiz.java<br>
      │   │               │   └── 📄 Lesson.java<br>
      │   │               │<br>
      │   │               ├── 📂 services/                  # Business logic layer<br>
      │   │               │   ├── 📂 impl/                  # Service implementations<br>
      │   │               │   │   ├── 📄 UserServiceImpl.java<br>
      │   │               │   │   └── 📄 CourseServiceImpl.java<br>
      │   │               │   │<br>
      │   │               │   ├── 📄 UserService.java<br>
      │   │               │   ├── 📄 CourseService.java<br>
      │   │               │   └── 📄 AuthService.java<br>
      │   │               │<br>
      │   │               ├── 📂 repositories/              # Data access layer<br>
      │   │               │   ├── 📄 UserRepository.java<br>
      │   │               │   └── 📄 CourseRepository.java<br>
      │   │               │<br>
      │   │               ├── 📂 security/                  # Security components<br>
      │   │               │   ├── 📂 filters/<br>
      │   │               │   │   ├── 📄 AuthFilter.java<br>
      │   │               │   │   └── 📄 LoggingFilter.java<br>
      │   │               │   │<br>
      │   │               │   └── 📄 SecurityUtils.java<br>
      │   │               │<br>
      │   │               └── 📂 utils/                     # Utility classes<br>
      │   │                   ├── 📄 DBConnection.java<br>
      │   │                   ├── 📄 HashUtil.java<br>
      │   │                   └── 📄 ValidationUtil.java<br>
      │   │<br>
      │   ├── 📂 resources/<br>
      │   │   ├── 📂 db/                                   # Database scripts<br>
      │   │   │   ├── 📄 schema.sql<br>
      │   │   │   └── 📄 data.sql<br>
      │   │   │<br>
      │   │   ├── 📂 config/                               # Configuration files<br>
      │   │   │   ├── 📄 application.properties<br>
      │   │   │   └── 📄 log4j2.xml<br>
      │   │   │<br>
      │   │   └── 📂 templates/                            # Email templates<br>
      │   │       └── 📄 email-templates.html<br>
      │   │<br>
      │   └── 📂 webapp/<br>
      │       ├── 📂 WEB-INF/<br>
      │       │   ├── 📄 web.xml                           # Servlet configuration<br>
      │       │   └── 📂 lib/                              # External libraries<br>
      │       │<br>
      │       ├── 📂 assets/                               # Static resources<br>
      │       │   ├── 📂 css/<br>
      │       │   │   ├── 📄 main.css<br>
      │       │   │   └── 📄 responsive.css<br>
      │       │   │<br>
      │       │   ├── 📂 js/<br>
      │       │   │   ├── 📄 app.js<br>
      │       │   │   └── 📄 utils.js<br>
      │       │   │<br>
      │       │   ├── 📂 images/<br>
      │       │   │   ├── 📂 icons/<br>
      │       │   │   └── 📂 backgrounds/<br>
      │       │   │<br>
      │       │   └── 📂 fonts/<br>
      │       │<br>
      │       ├── 📂 views/                                # JSP views<br>
      │       │   ├── 📂 auth/<br>
      │       │   │   ├── 📄 login.jsp<br>
      │       │   │   └── 📄 register.jsp<br>
      │       │   │<br>
      │       │   ├── 📂 courses/<br>
      │       │   │   ├── 📄 list.jsp<br>
      │       │   │   ├── 📄 details.jsp<br>
      │       │   │   └── 📄 create.jsp<br>
      │       │   │<br>
      │       │   ├── 📂 admin/<br>
      │       │   │   ├── 📄 dashboard.jsp<br>
      │       │   │   └── 📄 users.jsp<br>
      │       │   │<br>
      │       │   ├── 📂 common/                           # Shared components<br>
      │       │   │   ├── 📄 header.jsp<br>
      │       │   │   ├── 📄 footer.jsp<br>
      │       │   │   └── 📄 navigation.jsp<br>
      │       │   │<br>
      │       │   ├── 📄 index.jsp<br>
      │       │   └── 📄 dashboard.jsp<br>
      │       │<br>
      │       └── 📄 index.jsp                             # Entry point<br>
      │<br>
      └── 📂 test/                                         # Test directory<br>
          ├── 📂 java/                                     # Unit tests<br>
          │   └── 📂 com/<br>
          │       └── 📂 example/<br>
          │           └── 📂 skillforge/<br>
          │               ├── 📂 controllers/<br>
          │               ├── 📂 services/<br>
          │               └── 📂 repositories/<br>
          │<br>
          └── 📂 resources/                                # Test resources<br>
              └── 📄 test.properties<br>