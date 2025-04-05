package com.example.skillforge.models;

public class Enrollment {
    private Integer id;
    private Integer courseId;
    private Integer studentId;
    private java.sql.Timestamp enrolledAt;
    private Boolean completed;

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

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public java.sql.Timestamp getEnrolledAt() {
        return enrolledAt;
    }

    public void setEnrolledAt(java.sql.Timestamp enrolledAt) {
        this.enrolledAt = enrolledAt;
    }

    public Boolean getCompleted() {
        return completed;
    }

    public void setCompleted(Boolean completed) {
        this.completed = completed;
    }
}