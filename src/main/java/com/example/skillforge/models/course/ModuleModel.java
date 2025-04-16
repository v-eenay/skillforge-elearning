package com.example.skillforge.models.course;

import com.example.skillforge.models.content.LessonModel;
import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * Model class for Course Modules
 */
public class ModuleModel implements Serializable {
    private int moduleId;
    private int courseId;
    private String title;
    private int orderIndex;
    
    // Navigation properties
    private CourseModel course;
    private List<LessonModel> lessons = new ArrayList<>();

    public ModuleModel() {
    }

    public int getModuleId() {
        return moduleId;
    }

    public void setModuleId(int moduleId) {
        this.moduleId = moduleId;
    }

    public int getCourseId() {
        return courseId;
    }

    public void setCourseId(int courseId) {
        this.courseId = courseId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public int getOrderIndex() {
        return orderIndex;
    }

    public void setOrderIndex(int orderIndex) {
        this.orderIndex = orderIndex;
    }

    public CourseModel getCourse() {
        return course;
    }

    public void setCourse(CourseModel course) {
        this.course = course;
    }

    public List<LessonModel> getLessons() {
        return lessons;
    }

    public void setLessons(List<LessonModel> lessons) {
        this.lessons = lessons;
    }
}
