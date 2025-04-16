package com.example.skillforge.models.content;

import com.example.skillforge.models.course.ModuleModel;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Module Lessons
 */
public class LessonModel implements Serializable {
    private int lessonId;
    private int moduleId;
    private String title;
    private String content;
    private int duration; // in minutes
    private String resourceLink;
    
    // Navigation properties
    private ModuleModel module;
    private List<ResourceModel> resources = new ArrayList<>();

    public LessonModel() {
    }

    public int getLessonId() {
        return lessonId;
    }

    public void setLessonId(int lessonId) {
        this.lessonId = lessonId;
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getDuration() {
        return duration;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public String getResourceLink() {
        return resourceLink;
    }

    public void setResourceLink(String resourceLink) {
        this.resourceLink = resourceLink;
    }

    public ModuleModel getModule() {
        return module;
    }

    public void setModule(ModuleModel module) {
        this.module = module;
    }

    public List<ResourceModel> getResources() {
        return resources;
    }

    public void setResources(List<ResourceModel> resources) {
        this.resources = resources;
    }
}
