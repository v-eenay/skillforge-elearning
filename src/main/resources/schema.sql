-- Create and use the database
CREATE DATABASE IF NOT EXISTS skillforge;
USE skillforge;

-- 🔑 Core User Entities
CREATE TABLE IF NOT EXISTS Role (
                                    RoleID INT PRIMARY KEY AUTO_INCREMENT,
                                    RoleName VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE IF NOT EXISTS User (
                                    UserID INT PRIMARY KEY AUTO_INCREMENT,
                                    Name VARCHAR(100) NOT NULL,
                                    Email VARCHAR(100) NOT NULL UNIQUE,
                                    PasswordHash VARCHAR(255) NOT NULL,
                                    RoleID INT,
                                    ProfileImage VARCHAR(255),
                                    Bio TEXT,
                                    FOREIGN KEY (RoleID) REFERENCES Role(RoleID)
);

-- 📚 Course-Related Entities
CREATE TABLE IF NOT EXISTS Category (
                                        CategoryID INT PRIMARY KEY AUTO_INCREMENT,
                                        Name VARCHAR(100) NOT NULL,
                                        Description TEXT
);

CREATE TABLE IF NOT EXISTS Course (
                                      CourseID INT PRIMARY KEY AUTO_INCREMENT,
                                      Title VARCHAR(200) NOT NULL,
                                      Description TEXT,
                                      CategoryID INT,
                                      Level VARCHAR(50),
                                      Thumbnail VARCHAR(255),
                                      Status ENUM('active', 'inactive') DEFAULT 'active',
                                      CreatedBy INT,
                                      CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                                      FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID),
                                      FOREIGN KEY (CreatedBy) REFERENCES User(UserID)
);

CREATE TABLE IF NOT EXISTS Module (
                                      ModuleID INT PRIMARY KEY AUTO_INCREMENT,
                                      CourseID INT,
                                      Title VARCHAR(200) NOT NULL,
                                      OrderIndex INT,
                                      FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE IF NOT EXISTS Lesson (
                                      LessonID INT PRIMARY KEY AUTO_INCREMENT,
                                      ModuleID INT,
                                      Title VARCHAR(200) NOT NULL,
                                      Content TEXT,
                                      Duration INT,
                                      ResourceLink VARCHAR(255),
                                      FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID)
);

CREATE TABLE IF NOT EXISTS Resource (
                                        ResourceID INT PRIMARY KEY AUTO_INCREMENT,
                                        LessonID INT,
                                        FileName VARCHAR(255),
                                        FileType VARCHAR(50),
                                        FileURL VARCHAR(255),
                                        UploadDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                                        FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
);

-- 🎓 Enrollment and Progress Tracking
CREATE TABLE IF NOT EXISTS Enrollment (
                                          EnrollmentID INT PRIMARY KEY AUTO_INCREMENT,
                                          UserID INT,
                                          CourseID INT,
                                          EnrollmentDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                                          Status ENUM('active', 'completed') DEFAULT 'active',
                                          FOREIGN KEY (UserID) REFERENCES User(UserID),
                                          FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE IF NOT EXISTS Progress (
                                        ProgressID INT PRIMARY KEY AUTO_INCREMENT,
                                        EnrollmentID INT,
                                        LessonID INT,
                                        Status ENUM('completed', 'not completed') DEFAULT 'not completed',
                                        CompletedAt DATETIME,
                                        FOREIGN KEY (EnrollmentID) REFERENCES Enrollment(EnrollmentID),
                                        FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
);

-- 📝 Assessment & Feedback
CREATE TABLE IF NOT EXISTS Quiz (
                                    QuizID INT PRIMARY KEY AUTO_INCREMENT,
                                    CourseID INT,
                                    ModuleID INT,
                                    Title VARCHAR(200),
                                    TotalMarks INT,
                                    Duration INT,
                                    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
                                    FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID)
);

CREATE TABLE IF NOT EXISTS Question (
                                        QuestionID INT PRIMARY KEY AUTO_INCREMENT,
                                        QuizID INT,
                                        QuestionText TEXT,
                                        QuestionType ENUM('MCQ', 'TrueFalse'),
                                        CorrectAnswer VARCHAR(255),
                                        FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
);

-- Renamed to avoid MySQL keyword conflict
CREATE TABLE IF NOT EXISTS QuestionOption (
                                              OptionID INT PRIMARY KEY AUTO_INCREMENT,
                                              QuestionID INT,
                                              OptionText VARCHAR(255),
                                              IsCorrect BOOLEAN,
                                              FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

CREATE TABLE IF NOT EXISTS Submission (
                                          SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
                                          UserID INT,
                                          QuizID INT,
                                          SubmittedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
                                          TotalScore INT,
                                          FOREIGN KEY (UserID) REFERENCES User(UserID),
                                          FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
);

CREATE TABLE IF NOT EXISTS Answer (
                                      AnswerID INT PRIMARY KEY AUTO_INCREMENT,
                                      SubmissionID INT,
                                      QuestionID INT,
                                      SelectedOption VARCHAR(255),
                                      FOREIGN KEY (SubmissionID) REFERENCES Submission(SubmissionID),
                                      FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

CREATE TABLE IF NOT EXISTS Review (
                                      ReviewID INT PRIMARY KEY AUTO_INCREMENT,
                                      UserID INT,
                                      CourseID INT,
                                      Rating INT CHECK (Rating BETWEEN 1 AND 5),
                                      Comment TEXT,
                                      ReviewDate DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      FOREIGN KEY (UserID) REFERENCES User(UserID),
                                      FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

-- 🧑‍🏫 Instructor-Specific
CREATE TABLE IF NOT EXISTS InstructorProfile (
                                                 InstructorID INT PRIMARY KEY,
                                                 Bio TEXT,
                                                 Qualifications TEXT,
                                                 LinkedIn VARCHAR(255),
                                                 Website VARCHAR(255),
                                                 Rating DECIMAL(3,2),
                                                 TotalStudents INT,
                                                 FOREIGN KEY (InstructorID) REFERENCES User(UserID)
);

-- 🛠️ Admin-Specific
CREATE TABLE IF NOT EXISTS AdminActivityLog (
                                                LogID INT PRIMARY KEY AUTO_INCREMENT,
                                                AdminID INT,
                                                ActionType VARCHAR(100),
                                                Description TEXT,
                                                Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
                                                FOREIGN KEY (AdminID) REFERENCES User(UserID)
);

CREATE TABLE IF NOT EXISTS Report (
                                      ReportID INT PRIMARY KEY AUTO_INCREMENT,
                                      ReportedBy INT,
                                      ReportedEntity VARCHAR(100),
                                      Reason TEXT,
                                      Status ENUM('open', 'resolved', 'closed') DEFAULT 'open',
                                      CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
                                      FOREIGN KEY (ReportedBy) REFERENCES User(UserID)
);
