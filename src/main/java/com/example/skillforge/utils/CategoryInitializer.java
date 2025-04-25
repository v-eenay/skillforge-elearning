package com.example.skillforge.utils;

import com.example.skillforge.dao.course.CategoryDAO;
import com.example.skillforge.models.course.CategoryModel;

import java.util.ArrayList;
import java.util.List;
import java.util.logging.Logger;

/**
 * Utility class to initialize default categories in the database
 */
public class CategoryInitializer {
    private static final Logger LOGGER = Logger.getLogger(CategoryInitializer.class.getName());

    /**
     * Initialize default categories if they don't exist
     */
    public static void initializeDefaultCategories() {
        LOGGER.info("Initializing default categories...");

        // Define default categories
        List<CategoryModel> defaultCategories = new ArrayList<>();

        defaultCategories.add(createCategory("Web Development",
                "Courses related to web development, including HTML, CSS, JavaScript, and web frameworks"));

        defaultCategories.add(createCategory("Mobile Development",
                "Courses related to mobile app development for iOS, Android, and cross-platform frameworks"));

        defaultCategories.add(createCategory("Data Science",
                "Courses related to data analysis, machine learning, and artificial intelligence"));

        defaultCategories.add(createCategory("Programming Languages",
                "Courses focused on specific programming languages like Java, Python, C++, etc."));

        defaultCategories.add(createCategory("Database Management",
                "Courses related to database design, SQL, NoSQL, and database administration"));

        defaultCategories.add(createCategory("DevOps",
                "Courses related to DevOps practices, tools, and methodologies"));

        defaultCategories.add(createCategory("Cloud Computing",
                "Courses related to cloud platforms like AWS, Azure, Google Cloud, etc."));

        defaultCategories.add(createCategory("Cybersecurity",
                "Courses related to information security, ethical hacking, and security best practices"));

        defaultCategories.add(createCategory("Game Development",
                "Courses related to game design, development, and game engines"));

        defaultCategories.add(createCategory("UI/UX Design",
                "Courses related to user interface and user experience design"));

        // Insert categories if they don't exist
        int insertedCount = 0;
        for (CategoryModel category : defaultCategories) {
            if (!CategoryDAO.categoryExistsByName(category.getName())) {
                int categoryId = CategoryDAO.insertCategory(category);
                if (categoryId > 0) {
                    insertedCount++;
                    LOGGER.info("Inserted category: " + category.getName() + " with ID: " + categoryId);
                } else {
                    LOGGER.warning("Failed to insert category: " + category.getName());
                }
            } else {
                LOGGER.info("Category already exists: " + category.getName());
            }
        }

        LOGGER.info("Category initialization completed. Inserted " + insertedCount + " new categories.");
    }

    /**
     * Create a new CategoryModel
     */
    private static CategoryModel createCategory(String name, String description) {
        CategoryModel category = new CategoryModel();
        category.setName(name);
        category.setDescription(description);
        return category;
    }


}
