package com.example.skillforge.models.content;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * Model class for Lesson Content Blocks
 * This represents different types of content within a lesson (text, video, image, etc.)
 */
public class ContentBlockModel implements Serializable {
    public enum BlockType {TEXT, VIDEO, IMAGE, DOCUMENT, CODE, EMBED}
    
    private int contentBlockId;
    private int lessonId;
    private BlockType blockType;
    private String content;        // HTML content for TEXT, URL for VIDEO/IMAGE, code for CODE, embed code for EMBED
    private String title;          // Optional title for the content block
    private String description;    // Optional description
    private int orderIndex;        // Order within the lesson
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    
    // Navigation property
    private LessonModel lesson;

    public ContentBlockModel() {
    }

    public int getContentBlockId() {
        return contentBlockId;
    }

    public void setContentBlockId(int contentBlockId) {
        this.contentBlockId = contentBlockId;
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public BlockType getBlockType() {
        return blockType;
    }

    public void setBlockType(BlockType blockType) {
        this.blockType = blockType;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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

    public int getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(int orderIndex) {
        this.orderIndex = orderIndex;
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

    public LessonModel getLesson() {
        return lesson;
    }

    public void setLesson(LessonModel lesson) {
        this.lesson = lesson;
    }
}
