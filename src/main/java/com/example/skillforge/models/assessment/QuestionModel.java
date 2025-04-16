package com.example.skillforge.models.assessment;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Quiz Questions
 */
public class QuestionModel implements Serializable {
    public enum QuestionType {MCQ, TRUE_FALSE, SHORT_ANSWER, ESSAY, MATCHING, FILL_BLANK}
    
    private int questionId;
    private int quizId;
    private String questionText;
    private QuestionType questionType;
    private String correctAnswer;  // For TRUE_FALSE, SHORT_ANSWER, FILL_BLANK
    private int marks;             // Points for this question
    private String explanation;    // Explanation of the correct answer
    private String mediaURL;       // Optional image or video URL
    private int orderIndex;        // Order within the quiz
    
    // Navigation properties
    private QuizModel quiz;
    private List<OptionModel> options = new ArrayList<>();

    public QuestionModel() {
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public int getQuizId() {
        return quizId;
    }

    public void setQuizId(int quizId) {
        this.quizId = quizId;
    }

    public String getQuestionText() {
        return questionText;
    }

    public void setQuestionText(String questionText) {
        this.questionText = questionText;
    }

    public QuestionType getQuestionType() {
        return questionType;
    }

    public void setQuestionType(QuestionType questionType) {
        this.questionType = questionType;
    }

    public String getCorrectAnswer() {
        return correctAnswer;
    }

    public void setCorrectAnswer(String correctAnswer) {
        this.correctAnswer = correctAnswer;
    }

    public int getMarks() {
        return marks;
    }

    public void setMarks(int marks) {
        this.marks = marks;
    }

    public String getExplanation() {
        return explanation;
    }

    public void setExplanation(String explanation) {
        this.explanation = explanation;
    }

    public String getMediaURL() {
        return mediaURL;
    }

    public void setMediaURL(String mediaURL) {
        this.mediaURL = mediaURL;
    }

    public int getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(int orderIndex) {
        this.orderIndex = orderIndex;
    }

    public QuizModel getQuiz() {
        return quiz;
    }

    public void setQuiz(QuizModel quiz) {
        this.quiz = quiz;
    }

    public List<OptionModel> getOptions() {
        return options;
    }

    public void setOptions(List<OptionModel> options) {
        this.options = options;
    }
}
