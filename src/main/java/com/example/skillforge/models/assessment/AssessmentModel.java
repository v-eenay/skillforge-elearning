package com.example.skillforge.models.assessment;

import com.example.skillforge.models.course.CourseModel;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Course Assessments
 * This represents a comprehensive assessment for a course
 */
public class AssessmentModel implements Serializable {
    public enum Status {DRAFT, PUBLISHED, ARCHIVED}
    public enum AssessmentType {QUIZ, ASSIGNMENT, PROJECT, FINAL_EXAM, MIDTERM}
    
    private int assessmentId;
    private int courseId;
    private String title;
    private String description;
    private AssessmentType assessmentType;
    private int totalMarks;
    private int passingMarks;      // Minimum marks required to pass
    private int duration;          // Duration in minutes
    private boolean isRequired;    // Whether this assessment is required to complete the course
    private double weightage;      // Percentage contribution to final grade (0-100)
    private Status status = Status.DRAFT;
    private LocalDateTime availableFrom;
    private LocalDateTime availableUntil;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Navigation properties
    private CourseModel course;
    private List<QuizModel> quizzes = new ArrayList<>();

    public AssessmentModel() {
    }

    public int getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(int assessmentId) {
        this.assessmentId = assessmentId;
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

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public AssessmentType getAssessmentType() {
        return assessmentType;
    }

    public void setAssessmentType(AssessmentType assessmentType) {
        this.assessmentType = assessmentType;
    }

    public int getTotalMarks() {
        return totalMarks;
    }

    public void setTotalMarks(int totalMarks) {
        this.totalMarks = totalMarks;
    }

    public int getPassingMarks() {
        return passingMarks;
    }

    public void setPassingMarks(int passingMarks) {
        this.passingMarks = passingMarks;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public boolean isRequired() {
        return isRequired;
    }

    public void setRequired(boolean required) {
        isRequired = required;
    }

    public double getWeightage() {
        return weightage;
    }

    public void setWeightage(double weightage) {
        this.weightage = weightage;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public LocalDateTime getAvailableFrom() {
        return availableFrom;
    }

    public void setAvailableFrom(LocalDateTime availableFrom) {
        this.availableFrom = availableFrom;
    }

    public LocalDateTime getAvailableUntil() {
        return availableUntil;
    }

    public void setAvailableUntil(LocalDateTime availableUntil) {
        this.availableUntil = availableUntil;
    }

    public LocalDateTime getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(LocalDateTime createdAt) {
        this.createdAt = createdAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public CourseModel getCourse() {
        return course;
    }

    public void setCourse(CourseModel course) {
        this.course = course;
    }

    public List<QuizModel> getQuizzes() {
        return quizzes;
    }

    public void setQuizzes(List<QuizModel> quizzes) {
        this.quizzes = quizzes;
    }
}
