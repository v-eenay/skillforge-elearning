1. your-project/
   │
   ├── pom.xml                     # (If using Maven)
   ├── README.md                   # Optional project description
   │
   └── src/
   └── main/
   ├── java/
   │   └── com/
   │       └── example/
   │           └── skillforge/
   │               ├── controllers/          # Servlets - Handle requests and responses
   │               │   └── CourseController.java
   │               │   └── AuthController.java
   │               │   └── StudentController.java
   │               │
   │               ├── models/               # Data models/entities (POJOs)
   │               │   └── User.java
   │               │   └── Course.java
   │               │   └── Quiz.java
   │               │
   │               ├── services/             # Business logic
   │               │   └── UserService.java
   │               │   └── CourseService.java
   │               │   └── AuthService.java
   │               │
   │               ├── dao/                  # Optional: Data access layer
   │               │   └── UserDAO.java
   │               │   └── CourseDAO.java
   │               │
   │               ├── filters/              # Servlet filters (auth, logging, etc.)
   │               │   └── AuthFilter.java
   │               │   └── LoggingFilter.java
   │               │
   │               └── utils/                # Utility classes
   │                   └── DBConnection.java
   │                   └── HashUtil.java
   │
   ├── resources/                           # config files, SQL, properties
   │   └── application.properties
   │   └── schema.sql
   │
   └── webapp/
   ├── WEB-INF/
   │   ├── web.xml                      # Servlet configuration
   │   └── lib/                         # External JARs (if not using Maven)
   │
   ├── assets/                          # Static files (CSS, JS, images)
   │   ├── css/
   │   ├── js/
   │   └── images/
   │
   ├── views/                           # JSP files (View layer)
   │   ├── index.jsp
   │   ├── login.jsp
   │   ├── dashboard.jsp
   │   └── courses/
   │       ├── list.jsp
   │       ├── details.jsp
   │       └── create.jsp
   │
   └── index.jsp                        # Entry point (optional redirect to login)
