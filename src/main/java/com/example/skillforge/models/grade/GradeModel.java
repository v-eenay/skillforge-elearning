package com.example.skillforge.models.grade;

import com.example.skillforge.models.assessment.AssessmentModel;
import com.example.skillforge.models.assessment.QuizModel;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.user.UserModel;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Model class for Student Grades
 */
public class GradeModel implements Serializable {
    public enum GradeStatus {PENDING, GRADED, FINALIZED}
    
    private int gradeId;
    private int userId;
    private int courseId;
    private Integer assessmentId;      // Can be null for overall course grade
    private Integer quizId;            // Can be null if not a quiz grade
    private double score;              // Numeric score
    private String letterGrade;        // Optional letter grade (A, B, C, etc.)
    private boolean isPassed;          // Whether the student passed
    private GradeStatus status = GradeStatus.PENDING;
    private String feedback;           // Instructor feedback
    private LocalDateTime gradedAt;
    private LocalDateTime updatedAt;
    
    // Navigation properties
    private UserModel user;
    private CourseModel course;
    private AssessmentModel assessment;
    private QuizModel quiz;

    public GradeModel() {
    }

    public int getGradeId() {
        return gradeId;
    }

    public void setGradeId(int gradeId) {
        this.gradeId = gradeId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public Integer getAssessmentId() {
        return assessmentId;
    }

    public void setAssessmentId(Integer assessmentId) {
        this.assessmentId = assessmentId;
    }

    public Integer getQuizId() {
        return quizId;
    }

    public void setQuizId(Integer quizId) {
        this.quizId = quizId;
    }

    public double getScore() {
        return score;
    }

    public void setScore(double score) {
        this.score = score;
    }

    public String getLetterGrade() {
        return letterGrade;
    }

    public void setLetterGrade(String letterGrade) {
        this.letterGrade = letterGrade;
    }

    public boolean isPassed() {
        return isPassed;
    }

    public void setPassed(boolean passed) {
        isPassed = passed;
    }

    public GradeStatus getStatus() {
        return status;
    }

    public void setStatus(GradeStatus status) {
        this.status = status;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
    }

    public LocalDateTime getGradedAt() {
        return gradedAt;
    }

    public void setGradedAt(LocalDateTime gradedAt) {
        this.gradedAt = gradedAt;
    }

    public LocalDateTime getUpdatedAt() {
        return updatedAt;
    }

    public void setUpdatedAt(LocalDateTime updatedAt) {
        this.updatedAt = updatedAt;
    }

    public UserModel getUser() {
        return user;
    }

    public void setUser(UserModel user) {
        this.user = user;
    }

    public CourseModel getCourse() {
        return course;
    }

    public void setCourse(CourseModel course) {
        this.course = course;
    }

    public AssessmentModel getAssessment() {
        return assessment;
    }

    public void setAssessment(AssessmentModel assessment) {
        this.assessment = assessment;
    }

    public QuizModel getQuiz() {
        return quiz;
    }

    public void setQuiz(QuizModel quiz) {
        this.quiz = quiz;
    }
}
