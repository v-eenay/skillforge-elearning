package com.example.skillforge.models.assessment;

import java.io.Serializable;

/**
 * Model class for Question Options (for multiple-choice questions)
 */
public class OptionModel implements Serializable {
    private int optionId;
    private int questionId;
    private String optionText;
    private boolean isCorrect;
    private String feedback;       // Optional feedback for this option
    private String mediaURL;       // Optional image URL
    private int orderIndex;        // Order within the question
    
    // Navigation property
    private QuestionModel question;

    public OptionModel() {
    }

    public int getOptionId() {
        return optionId;
    }

    public void setOptionId(int optionId) {
        this.optionId = optionId;
    }

    public int getQuestionId() {
        return questionId;
    }

    public void setQuestionId(int questionId) {
        this.questionId = questionId;
    }

    public String getOptionText() {
        return optionText;
    }

    public void setOptionText(String optionText) {
        this.optionText = optionText;
    }

    public boolean isCorrect() {
        return isCorrect;
    }

    public void setCorrect(boolean correct) {
        isCorrect = correct;
    }

    public String getFeedback() {
        return feedback;
    }

    public void setFeedback(String feedback) {
        this.feedback = feedback;
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

    public QuestionModel getQuestion() {
        return question;
    }

    public void setQuestion(QuestionModel question) {
        this.question = question;
    }
}
