package com.example.skillforge.models;

public class QuizAttempt {
    private Integer id;
    private Integer quizId;
    private Integer studentId;
    private Integer score;
    private java.sql.Timestamp attemptedAt;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getQuizId() {
        return quizId;
    }

    public void setQuizId(Integer quizId) {
        this.quizId = quizId;
    }

    public Integer getStudentId() {
        return studentId;
    }

    public void setStudentId(Integer studentId) {
        this.studentId = studentId;
    }

    public Integer getScore() {
        return score;
    }

    public void setScore(Integer score) {
        this.score = score;
    }

    public java.sql.Timestamp getAttemptedAt() {
        return attemptedAt;
    }

    public void setAttemptedAt(java.sql.Timestamp attemptedAt) {
        this.attemptedAt = attemptedAt;
    }
}