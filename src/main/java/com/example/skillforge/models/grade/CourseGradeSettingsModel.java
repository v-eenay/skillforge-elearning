package com.example.skillforge.models.grade;

import com.example.skillforge.models.course.CourseModel;
import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * Model class for Course Grade Settings
 * This allows instructors to configure grading policies for a course
 */
public class CourseGradeSettingsModel implements Serializable {
    private int settingsId;
    private int courseId;
    private double passingGrade;       // Minimum percentage to pass the course (e.g., 70.0)
    private boolean useLetterGrades;   // Whether to use letter grades (A, B, C, etc.)
    private boolean autoCalculateFinalGrade; // Whether to automatically calculate final grade
    
    // Grade scale (percentage ranges for letter grades)
    private Map<String, Double> gradeScale = new HashMap<>(); // e.g., {"A": 90.0, "B": 80.0, ...}
    
    // Weightage for different assessment types (percentages)
    private double quizWeightage;      // Percentage contribution of quizzes to final grade
    private double assignmentWeightage; // Percentage contribution of assignments to final grade
    private double projectWeightage;    // Percentage contribution of projects to final grade
    private double midtermWeightage;    // Percentage contribution of midterm to final grade
    private double finalExamWeightage;  // Percentage contribution of final exam to final grade
    private double participationWeightage; // Percentage contribution of participation to final grade
    
    // Navigation property
    private CourseModel course;

    public CourseGradeSettingsModel() {
        // Initialize default grade scale
        gradeScale.put("A", 90.0);
        gradeScale.put("B", 80.0);
        gradeScale.put("C", 70.0);
        gradeScale.put("D", 60.0);
        gradeScale.put("F", 0.0);
    }

    public int getSettingsId() {
        return settingsId;
    }

    public void setSettingsId(int settingsId) {
        this.settingsId = settingsId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public double getPassingGrade() {
        return passingGrade;
    }

    public void setPassingGrade(double passingGrade) {
        this.passingGrade = passingGrade;
    }

    public boolean isUseLetterGrades() {
        return useLetterGrades;
    }

    public void setUseLetterGrades(boolean useLetterGrades) {
        this.useLetterGrades = useLetterGrades;
    }

    public boolean isAutoCalculateFinalGrade() {
        return autoCalculateFinalGrade;
    }

    public void setAutoCalculateFinalGrade(boolean autoCalculateFinalGrade) {
        this.autoCalculateFinalGrade = autoCalculateFinalGrade;
    }

    public Map<String, Double> getGradeScale() {
        return gradeScale;
    }

    public void setGradeScale(Map<String, Double> gradeScale) {
        this.gradeScale = gradeScale;
    }

    public double getQuizWeightage() {
        return quizWeightage;
    }

    public void setQuizWeightage(double quizWeightage) {
        this.quizWeightage = quizWeightage;
    }

    public double getAssignmentWeightage() {
        return assignmentWeightage;
    }

    public void setAssignmentWeightage(double assignmentWeightage) {
        this.assignmentWeightage = assignmentWeightage;
    }

    public double getProjectWeightage() {
        return projectWeightage;
    }

    public void setProjectWeightage(double projectWeightage) {
        this.projectWeightage = projectWeightage;
    }

    public double getMidtermWeightage() {
        return midtermWeightage;
    }

    public void setMidtermWeightage(double midtermWeightage) {
        this.midtermWeightage = midtermWeightage;
    }

    public double getFinalExamWeightage() {
        return finalExamWeightage;
    }

    public void setFinalExamWeightage(double finalExamWeightage) {
        this.finalExamWeightage = finalExamWeightage;
    }

    public double getParticipationWeightage() {
        return participationWeightage;
    }

    public void setParticipationWeightage(double participationWeightage) {
        this.participationWeightage = participationWeightage;
    }

    public CourseModel getCourse() {
        return course;
    }

    public void setCourse(CourseModel course) {
        this.course = course;
    }
    
    /**
     * Calculate the letter grade for a given percentage score
     * @param percentage The percentage score
     * @return The letter grade
     */
    public String calculateLetterGrade(double percentage) {
        for (Map.Entry<String, Double> entry : gradeScale.entrySet()) {
            if (percentage >= entry.getValue()) {
                return entry.getKey();
            }
        }
        return "F"; // Default to F if no match
    }
    
    /**
     * Check if a given percentage score is a passing grade
     * @param percentage The percentage score
     * @return true if the score is a passing grade, false otherwise
     */
    public boolean isPassingGrade(double percentage) {
        return percentage >= passingGrade;
    }
}
