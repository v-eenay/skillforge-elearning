package com.example.skillforge.models;

public class Attachment {
    private Integer id;
    private String fileName;
    private String filePath;
    private Integer uploadedBy;
    private java.sql.Timestamp uploadedAt;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }

    public String getFilePath() {
        return filePath;
    }

    public void setFilePath(String filePath) {
        this.filePath = filePath;
    }

    public Integer getUploadedBy() {
        return uploadedBy;
    }

    public void setUploadedBy(Integer uploadedBy) {
        this.uploadedBy = uploadedBy;
    }

    public java.sql.Timestamp getUploadedAt() {
        return uploadedAt;
    }

    public void setUploadedAt(java.sql.Timestamp uploadedAt) {
        this.uploadedAt = uploadedAt;
    }
}