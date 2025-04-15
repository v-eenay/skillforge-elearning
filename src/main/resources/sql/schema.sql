-- SkillForge Database Schema
-- This file contains all database tables used in the SkillForge application

-- Create and use the database
CREATE DATABASE IF NOT EXISTS skillforge;
USE skillforge;

-- User table - core user entity
CREATE TABLE IF NOT EXISTS User (
    UserID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    UserName VARCHAR(100) NOT NULL UNIQUE,
    Email VARCHAR(100) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Role ENUM('admin', 'instructor', 'student') NOT NULL,
    ProfileImage VARCHAR(255),
    Bio TEXT,
    Status ENUM('active', 'suspended') DEFAULT 'active'
);

-- Add Status field to User table if it doesn't exist
-- This is safe to run even if the column already exists
ALTER TABLE User ADD COLUMN Status ENUM('active', 'suspended') DEFAULT 'active';
-- Contact table - for storing contact form submissions
CREATE TABLE IF NOT EXISTS Contact (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Subject VARCHAR(200),
    Message TEXT NOT NULL,
    UserID INT,
    SubmittedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('new', 'read', 'replied') DEFAULT 'new',
    FOREIGN KEY (UserID) REFERENCES User(UserID)
);

-- Make sure the Contact table exists (in case the above statement fails due to foreign key constraints)
CREATE TABLE IF NOT EXISTS Contact (
    ContactID INT PRIMARY KEY AUTO_INCREMENT,
    Name VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL,
    Subject VARCHAR(200),
    Message TEXT NOT NULL,
    UserID INT,
    SubmittedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('new', 'read', 'replied') DEFAULT 'new'
);

-- Course-Related Entities
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

-- Content Blocks for Lessons
CREATE TABLE IF NOT EXISTS ContentBlock (
    ContentBlockID INT PRIMARY KEY AUTO_INCREMENT,
    LessonID INT,
    BlockType ENUM('TEXT', 'VIDEO', 'IMAGE', 'DOCUMENT', 'CODE', 'EMBED') NOT NULL,
    Content TEXT,
    Title VARCHAR(200),
    Description TEXT,
    OrderIndex INT,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (LessonID) REFERENCES Lesson(LessonID)
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

-- Enrollment and Progress Tracking
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

-- Assessment & Feedback
CREATE TABLE IF NOT EXISTS Assessment (
    AssessmentID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    Title VARCHAR(200) NOT NULL,
    Description TEXT,
    AssessmentType ENUM('QUIZ', 'ASSIGNMENT', 'PROJECT', 'FINAL_EXAM', 'MIDTERM') NOT NULL,
    TotalMarks INT NOT NULL,
    PassingMarks INT NOT NULL,
    Duration INT,
    IsRequired BOOLEAN DEFAULT TRUE,
    Weightage DOUBLE DEFAULT 0,
    Status ENUM('DRAFT', 'PUBLISHED', 'ARCHIVED') DEFAULT 'DRAFT',
    AvailableFrom DATETIME,
    AvailableUntil DATETIME,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE IF NOT EXISTS Quiz (
    QuizID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    ModuleID INT,
    AssessmentID INT,
    Title VARCHAR(200) NOT NULL,
    Description TEXT,
    TotalMarks INT NOT NULL,
    PassingMarks INT NOT NULL,
    Duration INT,
    MaxAttempts INT DEFAULT 1,
    RandomizeQuestions BOOLEAN DEFAULT FALSE,
    ShowAnswersAfterSubmission BOOLEAN DEFAULT FALSE,
    Status ENUM('DRAFT', 'PUBLISHED', 'ARCHIVED') DEFAULT 'DRAFT',
    AvailableFrom DATETIME,
    AvailableUntil DATETIME,
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (ModuleID) REFERENCES Module(ModuleID),
    FOREIGN KEY (AssessmentID) REFERENCES Assessment(AssessmentID)
);

CREATE TABLE IF NOT EXISTS Question (
    QuestionID INT PRIMARY KEY AUTO_INCREMENT,
    QuizID INT,
    QuestionText TEXT NOT NULL,
    QuestionType ENUM('MCQ', 'TRUE_FALSE', 'SHORT_ANSWER', 'ESSAY', 'MATCHING', 'FILL_BLANK') NOT NULL,
    CorrectAnswer VARCHAR(255),
    Marks INT DEFAULT 1,
    Explanation TEXT,
    MediaURL VARCHAR(255),
    OrderIndex INT,
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
);

-- Renamed to avoid MySQL keyword conflict
CREATE TABLE IF NOT EXISTS QuestionOption (
    OptionID INT PRIMARY KEY AUTO_INCREMENT,
    QuestionID INT,
    OptionText VARCHAR(255) NOT NULL,
    IsCorrect BOOLEAN DEFAULT FALSE,
    Feedback TEXT,
    MediaURL VARCHAR(255),
    OrderIndex INT,
    FOREIGN KEY (QuestionID) REFERENCES Question(QuestionID)
);

CREATE TABLE IF NOT EXISTS Submission (
    SubmissionID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    QuizID INT,
    Status ENUM('IN_PROGRESS', 'SUBMITTED', 'GRADED') DEFAULT 'IN_PROGRESS',
    TotalScore INT DEFAULT 0,
    IsPassed BOOLEAN DEFAULT FALSE,
    AttemptNumber INT DEFAULT 1,
    StartedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    SubmittedAt DATETIME,
    GradedAt DATETIME,
    InstructorFeedback TEXT,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
);

CREATE TABLE IF NOT EXISTS Answer (
    AnswerID INT PRIMARY KEY AUTO_INCREMENT,
    SubmissionID INT,
    QuestionID INT,
    SelectedOption VARCHAR(255),
    TextAnswer TEXT,
    IsCorrect BOOLEAN DEFAULT FALSE,
    ScoreAwarded INT DEFAULT 0,
    InstructorFeedback TEXT,
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

-- Instructor-Specific
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

-- Admin-Specific
CREATE TABLE IF NOT EXISTS AdminActivityLog (
    LogID INT PRIMARY KEY AUTO_INCREMENT,
    AdminID INT,
    ActionType VARCHAR(100),
    Description TEXT,
    Timestamp DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AdminID) REFERENCES User(UserID)
);

-- Grade-Related Entities
CREATE TABLE IF NOT EXISTS Grade (
    GradeID INT PRIMARY KEY AUTO_INCREMENT,
    UserID INT,
    CourseID INT,
    AssessmentID INT,
    QuizID INT,
    Score DOUBLE NOT NULL,
    LetterGrade VARCHAR(5),
    IsPassed BOOLEAN DEFAULT FALSE,
    Status ENUM('PENDING', 'GRADED', 'FINALIZED') DEFAULT 'PENDING',
    Feedback TEXT,
    GradedAt DATETIME,
    UpdatedAt DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES User(UserID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (AssessmentID) REFERENCES Assessment(AssessmentID),
    FOREIGN KEY (QuizID) REFERENCES Quiz(QuizID)
);

CREATE TABLE IF NOT EXISTS CourseGradeSettings (
    SettingsID INT PRIMARY KEY AUTO_INCREMENT,
    CourseID INT,
    PassingGrade DOUBLE DEFAULT 70.0,
    UseLetterGrades BOOLEAN DEFAULT TRUE,
    AutoCalculateFinalGrade BOOLEAN DEFAULT TRUE,
    GradeScale TEXT,
    QuizWeightage DOUBLE DEFAULT 20.0,
    AssignmentWeightage DOUBLE DEFAULT 20.0,
    ProjectWeightage DOUBLE DEFAULT 20.0,
    MidtermWeightage DOUBLE DEFAULT 15.0,
    FinalExamWeightage DOUBLE DEFAULT 20.0,
    ParticipationWeightage DOUBLE DEFAULT 5.0,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
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

