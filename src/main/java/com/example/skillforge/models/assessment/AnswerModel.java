package com.example.skillforge.models.assessment;

import java.io.Serializable;

/**
 * Model class for Student Answers to Quiz Questions
 */
public class AnswerModel implements Serializable {
    private int answerId;
    private int submissionId;
    private int questionId;
    private String selectedOption;     // For MCQ, can be option ID or text
    private String textAnswer;         // For SHORT_ANSWER, ESSAY, FILL_BLANK
    private boolean isCorrect;         // Whether the answer is correct
    private int scoreAwarded;          // Points awarded for this answer
    private String instructorFeedback; // Feedback for this specific answer
    
    // Navigation properties
    private SubmissionModel submission;
    private QuestionModel question;

    public AnswerModel() {
    }

    public int getAnswerId() {
        return answerId;
    }

    public void setAnswerId(int answerId) {
        this.answerId = answerId;
    }

    public int getSubmissionId() {
        return submissionId;
    }

    public void setSubmissionId(int submissionId) {
        this.submissionId = submissionId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getSelectedOption() {
        return selectedOption;
    }

    public void setSelectedOption(String selectedOption) {
        this.selectedOption = selectedOption;
    }

    public String getTextAnswer() {
        return textAnswer;
    }

    public void setTextAnswer(String textAnswer) {
        this.textAnswer = textAnswer;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean correct) {
        isCorrect = correct;
    }

    public int getScoreAwarded() {
        return scoreAwarded;
    }

    public void setScoreAwarded(int scoreAwarded) {
        this.scoreAwarded = scoreAwarded;
    }

    public String getInstructorFeedback() {
        return instructorFeedback;
    }

    public void setInstructorFeedback(String instructorFeedback) {
        this.instructorFeedback = instructorFeedback;
    }

    public SubmissionModel getSubmission() {
        return submission;
    }

    public void setSubmission(SubmissionModel submission) {
        this.submission = submission;
    }

    public QuestionModel getQuestion() {
        return question;
    }

    public void setQuestion(QuestionModel question) {
        this.question = question;
    }
}
