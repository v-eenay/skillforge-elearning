package com.example.skillforge.models.assessment;

import com.example.skillforge.models.user.UserModel;
import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Quiz Submissions
 */
public class SubmissionModel implements Serializable {
    public enum Status {IN_PROGRESS, SUBMITTED, GRADED}
    
    private int submissionId;
    private int userId;
    private int quizId;
    private Status status = Status.IN_PROGRESS;
    private int totalScore;
    private boolean isPassed;
    private int attemptNumber;
    private LocalDateTime startedAt;
    private LocalDateTime submittedAt;
    private LocalDateTime gradedAt;
    private String instructorFeedback;
    
    // Navigation properties
    private UserModel user;
    private QuizModel quiz;
    private List<AnswerModel> answers = new ArrayList<>();

    public SubmissionModel() {
    }

    public int getSubmissionId() {
        return submissionId;
    }

    public void setSubmissionId(int submissionId) {
        this.submissionId = submissionId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }

    public int getTotalScore() {
        return totalScore;
    }

    public void setTotalScore(int totalScore) {
        this.totalScore = totalScore;
    }

    public boolean isPassed() {
        return isPassed;
    }

    public void setPassed(boolean passed) {
        isPassed = passed;
    }

    public int getAttemptNumber() {
        return attemptNumber;
    }

    public void setAttemptNumber(int attemptNumber) {
        this.attemptNumber = attemptNumber;
    }

    public LocalDateTime getStartedAt() {
        return startedAt;
    }

    public void setStartedAt(LocalDateTime startedAt) {
        this.startedAt = startedAt;
    }

    public LocalDateTime getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(LocalDateTime submittedAt) {
        this.submittedAt = submittedAt;
    }

    public LocalDateTime getGradedAt() {
        return gradedAt;
    }

    public void setGradedAt(LocalDateTime gradedAt) {
        this.gradedAt = gradedAt;
    }

    public String getInstructorFeedback() {
        return instructorFeedback;
    }

    public void setInstructorFeedback(String instructorFeedback) {
        this.instructorFeedback = instructorFeedback;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public QuizModel getQuiz() {
        return quiz;
    }

    public void setQuiz(QuizModel quiz) {
        this.quiz = quiz;
    }

    public List<AnswerModel> getAnswers() {
        return answers;
    }

    public void setAnswers(List<AnswerModel> answers) {
        this.answers = answers;
    }
}
