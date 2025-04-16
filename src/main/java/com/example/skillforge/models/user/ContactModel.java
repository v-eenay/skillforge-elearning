package com.example.skillforge.models.user;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Model class for Contact form submissions
 */
public class ContactModel implements Serializable {
    public enum Status {new_status, read, replied}
    
    private int contactId;
    private String name;
    private String email;
    private String subject;
    private String message;
    private Integer userId; // Can be null for non-logged in users
    private LocalDateTime submittedAt;
    private Status status = Status.new_status;

    public ContactModel() {
    }

    public int getContactId() {
        return contactId;
    }

    public void setContactId(int contactId) {
        this.contactId = contactId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public LocalDateTime getSubmittedAt() {
        return submittedAt;
    }

    public void setSubmittedAt(LocalDateTime submittedAt) {
        this.submittedAt = submittedAt;
    }

    public Status getStatus() {
        return status;
    }

    public void setStatus(Status status) {
        this.status = status;
    }
}
