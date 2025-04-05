package com.example.skillforge.models;

public class Quiz {

    private int id;
    private int courseId;
    private String title;
    private int totalMarks;
    private java.sql.Timestamp createdAt;

    public Quiz() {
    }

    public Quiz(int id, int courseId, String title, int totalMarks, java.sql.Timestamp createdAt) {
        this.id = id;
        this.courseId = courseId;
        this.title = title;
        this.totalMarks = totalMarks;
        this.createdAt = createdAt;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(int totalMarks) {
        this.totalMarks = totalMarks;
    }
    public java.sql.Timestamp getCreatedAt() {
        return createdAt;
    }
    public void setCreatedAt(java.sql.Timestamp createdAt) {
        this.createdAt = createdAt;
    }

}
