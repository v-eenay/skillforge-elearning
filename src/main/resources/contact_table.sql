-- Create Contact table for storing contact form submissions
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
