package com.example.skillforge.controllers.instructor;

import com.example.skillforge.dao.content.ContentBlockDAO;
import com.example.skillforge.dao.content.LessonDAO;
import com.example.skillforge.dao.course.CourseDAO;
import com.example.skillforge.dao.course.ModuleDAO;
import com.example.skillforge.models.content.ContentBlockModel;
import com.example.skillforge.models.content.LessonModel;
import com.example.skillforge.models.course.CourseModel;
import com.example.skillforge.models.course.ModuleModel;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.FileUploadUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * Servlet for adding a new content block to a lesson
 */
@WebServlet(name = "AddContentBlockServlet", urlPatterns = {"/instructor/add-content-block"})
@MultipartConfig(fileSizeThreshold = 1024 * 1024, // 1 MB
        maxFileSize = 1024 * 1024 * 50,      // 50 MB
        maxRequestSize = 1024 * 1024 * 100)   // 100 MB
public class AddContentBlockServlet extends HttpServlet {
    private static final Logger LOGGER = Logger.getLogger(AddContentBlockServlet.class.getName());

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Get lesson ID from request parameter
        String lessonIdParam = request.getParameter("lessonId");
        if (lessonIdParam == null || lessonIdParam.isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
            return;
        }

        try {
            int lessonId = Integer.parseInt(lessonIdParam);
            LessonModel lesson = LessonDAO.getLessonById(lessonId);

            if (lesson == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            // Get the module and course to check ownership
            ModuleModel module = ModuleDAO.getModuleById(lesson.getModuleId());
            if (module == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            CourseModel course = CourseDAO.getCourseById(module.getCourseId());

            // Check if course exists and belongs to the current instructor
            if (course == null || course.getCreatedBy() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            // Get existing content blocks for the lesson
            List<ContentBlockModel> contentBlocks = ContentBlockDAO.getContentBlocksByLesson(lessonId);

            // Calculate next order index
            int nextOrderIndex = contentBlocks.size() + 1;

            request.setAttribute("lesson", lesson);
            request.setAttribute("module", module);
            request.setAttribute("course", course);
            request.setAttribute("contentBlocks", contentBlocks);
            request.setAttribute("nextOrderIndex", nextOrderIndex);

            request.getRequestDispatcher("/WEB-INF/views/instructor/add-content-block.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lesson ID: {0}", lessonIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        UserModel user = (UserModel) session.getAttribute("user");

        // Check if user is logged in and is an instructor
        if (user == null || !user.getRole().equals(UserModel.Role.instructor)) {
            response.sendRedirect(request.getContextPath() + "/auth/login");
            return;
        }

        // Get form data
        String lessonIdParam = request.getParameter("lessonId");
        String blockType = request.getParameter("blockType");
        String title = request.getParameter("title");
        String orderIndexParam = request.getParameter("orderIndex");
        String afterAction = request.getParameter("afterAction");

        // Validate required fields
        if (lessonIdParam == null || lessonIdParam.isEmpty() || blockType == null || blockType.isEmpty()) {
            request.setAttribute("error", "Lesson ID and block type are required.");
            doGet(request, response);
            return;
        }

        try {
            int lessonId = Integer.parseInt(lessonIdParam);
            LessonModel lesson = LessonDAO.getLessonById(lessonId);

            if (lesson == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            // Get the module and course to check ownership
            ModuleModel module = ModuleDAO.getModuleById(lesson.getModuleId());
            if (module == null) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            CourseModel course = CourseDAO.getCourseById(module.getCourseId());

            // Check if course exists and belongs to the current instructor
            if (course == null || course.getCreatedBy() != user.getUserId()) {
                response.sendRedirect(request.getContextPath() + "/instructor/courses/");
                return;
            }

            // Create new content block
            ContentBlockModel contentBlock = new ContentBlockModel();
            contentBlock.setLessonId(lessonId);
            contentBlock.setBlockType(ContentBlockModel.BlockType.valueOf(blockType));
            contentBlock.setTitle(title);

            // Set content based on block type
            String content = null;
            String description = null;

            switch (contentBlock.getBlockType()) {
                case TEXT:
                    content = request.getParameter("textContent");
                    if (content == null || content.trim().isEmpty()) {
                        request.setAttribute("error", "Text content is required for TEXT blocks.");
                        doGet(request, response);
                        return;
                    }
                    break;
                case VIDEO:
                    // Check if it's a file upload or URL
                    String videoUrl = request.getParameter("videoUrl");
                    String videoFilePath = FileUploadUtil.uploadContentVideo(request, "videoFile");

                    if (videoFilePath != null && !videoFilePath.isEmpty()) {
                        // File was uploaded
                        content = videoFilePath;
                    } else if (videoUrl != null && !videoUrl.trim().isEmpty()) {
                        // URL was provided
                        content = videoUrl;
                    } else {
                        request.setAttribute("error", "Either a video file or URL is required for VIDEO blocks.");
                        doGet(request, response);
                        return;
                    }

                    description = request.getParameter("videoDescription");
                    break;
                case IMAGE:
                    // Check if it's a file upload or URL
                    String imageUrl = request.getParameter("imageUrl");
                    String imageFilePath = FileUploadUtil.uploadContentImage(request, "imageFile");

                    if (imageFilePath != null && !imageFilePath.isEmpty()) {
                        // File was uploaded
                        content = imageFilePath;
                    } else if (imageUrl != null && !imageUrl.trim().isEmpty()) {
                        // URL was provided
                        content = imageUrl;
                    } else {
                        request.setAttribute("error", "Either an image file or URL is required for IMAGE blocks.");
                        doGet(request, response);
                        return;
                    }

                    description = request.getParameter("imageCaption");
                    break;
                case CODE:
                    content = request.getParameter("codeContent");
                    description = request.getParameter("codeLanguage");
                    if (content == null || content.trim().isEmpty()) {
                        request.setAttribute("error", "Code content is required for CODE blocks.");
                        doGet(request, response);
                        return;
                    }
                    break;
                case DOCUMENT:
                    // Check if it's a file upload or URL
                    String documentUrl = request.getParameter("documentUrl");
                    String documentFilePath = FileUploadUtil.uploadContentDocument(request, "documentFile");

                    if (documentFilePath != null && !documentFilePath.isEmpty()) {
                        // File was uploaded
                        content = documentFilePath;
                    } else if (documentUrl != null && !documentUrl.trim().isEmpty()) {
                        // URL was provided
                        content = documentUrl;
                    } else {
                        request.setAttribute("error", "Either a document file or URL is required for DOCUMENT blocks.");
                        doGet(request, response);
                        return;
                    }

                    description = request.getParameter("documentDescription");
                    break;
                case EMBED:
                    content = request.getParameter("embedCode");
                    if (content == null || content.trim().isEmpty()) {
                        request.setAttribute("error", "Embed code is required for EMBED blocks.");
                        doGet(request, response);
                        return;
                    }
                    break;
            }

            contentBlock.setContent(content);
            contentBlock.setDescription(description);

            // Set order index if provided
            if (orderIndexParam != null && !orderIndexParam.isEmpty()) {
                try {
                    int orderIndex = Integer.parseInt(orderIndexParam);
                    contentBlock.setOrderIndex(orderIndex);
                } catch (NumberFormatException e) {
                    // Use default order index (end of list)
                    List<ContentBlockModel> contentBlocks = ContentBlockDAO.getContentBlocksByLesson(lessonId);
                    contentBlock.setOrderIndex(contentBlocks.size() + 1);
                }
            } else {
                // Use default order index (end of list)
                List<ContentBlockModel> contentBlocks = ContentBlockDAO.getContentBlocksByLesson(lessonId);
                contentBlock.setOrderIndex(contentBlocks.size() + 1);
            }

            try {
                // Insert content block
                LOGGER.info("Inserting content block of type " + contentBlock.getBlockType() + " for lesson ID: " + contentBlock.getLessonId());
                int contentBlockId = ContentBlockDAO.insertContentBlock(contentBlock);

                if (contentBlockId > 0) {
                    // Content block created successfully
                    LOGGER.info("Content block created successfully with ID: " + contentBlockId);
                    contentBlock.setContentBlockId(contentBlockId);
                    session.setAttribute("success", "Content block created successfully!");

                    // Handle after action
                    if ("addAnother".equals(afterAction)) {
                        // Redirect back to add content block page
                        response.sendRedirect(request.getContextPath() + "/instructor/add-content-block?lessonId=" + lessonId);
                        return;
                    } else {
                        // Default: view lesson
                        response.sendRedirect(request.getContextPath() + "/instructor/view-lesson?id=" + lessonId);
                        return;
                    }
                } else {
                    // Content block creation failed
                    LOGGER.warning("Failed to create content block. ContentBlockDAO.insertContentBlock returned 0.");
                    request.setAttribute("error", "Failed to create content block. Please try again.");
                    doGet(request, response);
                }
            } catch (Exception e) {
                // Log the exception
                LOGGER.log(Level.SEVERE, "Exception while creating content block", e);
                request.setAttribute("error", "An error occurred while creating the content block: " + e.getMessage());
                doGet(request, response);
            }
        } catch (NumberFormatException e) {
            LOGGER.log(Level.WARNING, "Invalid lesson ID: {0}", lessonIdParam);
            response.sendRedirect(request.getContextPath() + "/instructor/courses/");
        } catch (IllegalArgumentException e) {
            LOGGER.log(Level.WARNING, "Invalid block type: {0}", blockType);
            request.setAttribute("error", "Invalid block type: " + blockType);
            doGet(request, response);
        }
    }
}
