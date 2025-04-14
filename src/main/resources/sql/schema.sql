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
ALTER TABLE User ADD COLUMN IF NOT EXISTS Status ENUM('active', 'suspended') DEFAULT 'active';

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

-- The following tables are commented out as they are not currently being used
-- Uncomment and run these statements when needed

/*
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

CREATE TABLE IF NOT EXISTS Report (
    ReportID INT PRIMARY KEY AUTO_INCREMENT,
    ReportedBy INT,
    ReportedEntity VARCHAR(100),
    Reason TEXT,
    Status ENUM('open', 'resolved', 'closed') DEFAULT 'open',
    CreatedAt DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ReportedBy) REFERENCES User(UserID)
);
*/
