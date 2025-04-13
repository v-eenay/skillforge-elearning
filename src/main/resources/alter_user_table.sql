-- Add Status field to User table
ALTER TABLE User ADD COLUMN Status ENUM('active', 'suspended') DEFAULT 'active';
