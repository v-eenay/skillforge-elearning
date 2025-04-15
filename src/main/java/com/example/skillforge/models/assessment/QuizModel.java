package com.example.skillforge.models.assessment;

import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.course.ModuleModel;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Quizzes
 */
public class QuizModel implements Serializable {
    public enum Status {DRAFT, PUBLISHED, ARCHIVED}
    
    private int quizId;
    private Integer courseId;      // Can be null if quiz is part of an assessment
    private Integer moduleId;      // Can be null if quiz is part of an assessment
    private Integer assessmentId;  // Can be null if quiz is standalone
    private String title;
    private String description;
    private int totalMarks;
    private int passingMarks;      // Minimum marks required to pass
    private int duration;          // Duration in minutes
    private int maxAttempts;       // Maximum number of attempts allowed
    private boolean randomizeQuestions;
    private boolean showAnswersAfterSubmission;
    private Status status = Status.DRAFT;
    private LocalDateTime availableFrom;
    private LocalDateTime availableUntil;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Navigation properties
    private CourseModel course;
    private ModuleModel module;
    private AssessmentModel assessment;
    private List<QuestionModel> questions = new ArrayList<>();
    private List<SubmissionModel> submissions = new ArrayList<>();

    public QuizModel() {
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public Integer getCourseId() {
        return courseId;
    }

    public void setCourseId(Integer courseId) {
        this.courseId = courseId;
    }

    public Integer getModuleId() {
        return moduleId;
    }

    public void setModuleId(Integer moduleId) {
        this.moduleId = moduleId;
    }

    public Integer getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(Integer assessmentId) {
        this.assessmentId = assessmentId;
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

    public int getMaxAttempts() {
        return maxAttempts;
    }

    public void setMaxAttempts(int maxAttempts) {
        this.maxAttempts = maxAttempts;
    }

    public boolean isRandomizeQuestions() {
        return randomizeQuestions;
    }

    public void setRandomizeQuestions(boolean randomizeQuestions) {
        this.randomizeQuestions = randomizeQuestions;
    }

    public boolean isShowAnswersAfterSubmission() {
        return showAnswersAfterSubmission;
    }

    public void setShowAnswersAfterSubmission(boolean showAnswersAfterSubmission) {
        this.showAnswersAfterSubmission = showAnswersAfterSubmission;
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

    public ModuleModel getModule() {
        return module;
    }

    public void setModule(ModuleModel module) {
        this.module = module;
    }

    public AssessmentModel getAssessment() {
        return assessment;
    }

    public void setAssessment(AssessmentModel assessment) {
        this.assessment = assessment;
    }

    public List<QuestionModel> getQuestions() {
        return questions;
    }

    public void setQuestions(List<QuestionModel> questions) {
        this.questions = questions;
    }

    public List<SubmissionModel> getSubmissions() {
        return submissions;
    }

    public void setSubmissions(List<SubmissionModel> submissions) {
        this.submissions = submissions;
    }
}
