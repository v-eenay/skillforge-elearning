package com.example.skillforge.models;

public class CourseMaterials {
    private Integer id;
    private Integer courseId;
    private String title;
    private String content;
    private String filePath;
    private java.sql.Timestamp uploadedAt;

    public CourseMaterials() {
    }
    public CourseMaterials(Integer id, Integer courseId, String title, String content, String filePath, java.sql.Timestamp uploadedAt) {
        this.id = id;
        this.courseId = courseId;
        this.title = title;
        this.content = content;
        this.filePath = filePath;
        this.uploadedAt = uploadedAt;
    }
    
        public Integer getId() {
            return id;
        }
    
        public void setId(Integer id) {
            this.id = id;
        }
    
        public Integer getCourseId() {
            return courseId;
        }
    
        public void setCourseId(Integer courseId) {
            this.courseId = courseId;
        }
    
        public String getTitle() {
            return title;
        }
    
        public void setTitle(String title) {
            this.title = title;
        }
    
        public String getContent() {
            return content;
        }
    
        public void setContent(String content) {
            this.content = content;
        }
    
        public String getFilePath() {
            return filePath;
        }
    
        public void setFilePath(String filePath) {
            this.filePath = filePath;
        }
    
        public java.sql.Timestamp getUploadedAt() {
            return uploadedAt;
        }
    
        public void setUploadedAt(java.sql.Timestamp uploadedAt) {
            this.uploadedAt = uploadedAt;
        }
    
}
