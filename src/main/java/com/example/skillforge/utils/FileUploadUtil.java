package com.example.skillforge.utils;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.Part;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.UUID;

public class FileUploadUtil {

    private static final String UPLOAD_DIRECTORY = "uploads";
    private static final String PROFILE_IMAGES_DIRECTORY = "profile-images";
    private static final String COURSE_THUMBNAILS_DIRECTORY = "course-thumbnails";
    private static final String CONTENT_IMAGES_DIRECTORY = "content-images";
    private static final String CONTENT_VIDEOS_DIRECTORY = "content-videos";
    private static final String CONTENT_DOCUMENTS_DIRECTORY = "content-documents";

    /**
     * Uploads a profile image and returns the path to the uploaded file
     *
     * @param request The HttpServletRequest containing the file
     * @param partName The name of the file part in the request
     * @return The path to the uploaded file, or null if upload failed
     */
    public static String uploadProfileImage(HttpServletRequest request, String partName) {
        try {
            Part filePart = request.getPart(partName);

            // Check if a file was actually uploaded
            if (filePart == null || filePart.getSize() <= 0 || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                return null;
            }

            // Get the file extension
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));

            // Generate a unique file name
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Create the upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY + File.separator + PROFILE_IMAGES_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            // Return the relative path to the file
            return "/" + UPLOAD_DIRECTORY + "/" + PROFILE_IMAGES_DIRECTORY + "/" + uniqueFileName;

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Deletes a profile image
     *
     * @param request The HttpServletRequest
     * @param imagePath The path to the image to delete
     * @return true if the image was deleted, false otherwise
     */
    public static boolean deleteProfileImage(HttpServletRequest request, String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return false;
        }

        try {
            String applicationPath = request.getServletContext().getRealPath("");
            Path path = Paths.get(applicationPath + imagePath);

            return Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Uploads a course thumbnail image and returns the path to the uploaded file
     *
     * @param request The HttpServletRequest containing the file
     * @param partName The name of the file part in the request
     * @return The path to the uploaded file, or null if upload failed
     */
    public static String uploadCourseThumbnail(HttpServletRequest request, String partName) {
        try {
            Part filePart = request.getPart(partName);

            // Check if a file was actually uploaded
            if (filePart == null || filePart.getSize() <= 0 || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                return null;
            }

            // Get the file extension
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));

            // Generate a unique file name
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Create the upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY + File.separator + COURSE_THUMBNAILS_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            // Return the relative path to the file
            return "/" + UPLOAD_DIRECTORY + "/" + COURSE_THUMBNAILS_DIRECTORY + "/" + uniqueFileName;

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Deletes a course thumbnail image
     *
     * @param request The HttpServletRequest
     * @param imagePath The path to the image to delete
     * @return true if the image was deleted, false otherwise
     */
    public static boolean deleteCourseThumbnail(HttpServletRequest request, String imagePath) {
        if (imagePath == null || imagePath.isEmpty()) {
            return false;
        }

        try {
            String applicationPath = request.getServletContext().getRealPath("");
            Path path = Paths.get(applicationPath + imagePath);

            return Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    /**
     * Uploads a content image and returns the path to the uploaded file
     *
     * @param request The HttpServletRequest containing the file
     * @param partName The name of the file part in the request
     * @return The path to the uploaded file, or null if upload failed
     */
    public static String uploadContentImage(HttpServletRequest request, String partName) {
        try {
            Part filePart = request.getPart(partName);

            // Check if a file was actually uploaded
            if (filePart == null || filePart.getSize() <= 0 || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                return null;
            }

            // Get the file extension
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));

            // Generate a unique file name
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Create the upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY + File.separator + CONTENT_IMAGES_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            // Return the relative path to the file
            return "/" + UPLOAD_DIRECTORY + "/" + CONTENT_IMAGES_DIRECTORY + "/" + uniqueFileName;

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Uploads a content video and returns the path to the uploaded file
     *
     * @param request The HttpServletRequest containing the file
     * @param partName The name of the file part in the request
     * @return The path to the uploaded file, or null if upload failed
     */
    public static String uploadContentVideo(HttpServletRequest request, String partName) {
        try {
            Part filePart = request.getPart(partName);

            // Check if a file was actually uploaded
            if (filePart == null || filePart.getSize() <= 0 || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                return null;
            }

            // Get the file extension
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));

            // Generate a unique file name
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Create the upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY + File.separator + CONTENT_VIDEOS_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            // Return the relative path to the file
            return "/" + UPLOAD_DIRECTORY + "/" + CONTENT_VIDEOS_DIRECTORY + "/" + uniqueFileName;

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Uploads a content document and returns the path to the uploaded file
     *
     * @param request The HttpServletRequest containing the file
     * @param partName The name of the file part in the request
     * @return The path to the uploaded file, or null if upload failed
     */
    public static String uploadContentDocument(HttpServletRequest request, String partName) {
        try {
            Part filePart = request.getPart(partName);

            // Check if a file was actually uploaded
            if (filePart == null || filePart.getSize() <= 0 || filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                return null;
            }

            // Get the file extension
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = fileName.substring(fileName.lastIndexOf("."));

            // Generate a unique file name
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;

            // Create the upload directory if it doesn't exist
            String applicationPath = request.getServletContext().getRealPath("");
            String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY + File.separator + CONTENT_DOCUMENTS_DIRECTORY;

            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file
            String filePath = uploadPath + File.separator + uniqueFileName;
            filePart.write(filePath);

            // Return the relative path to the file
            return "/" + UPLOAD_DIRECTORY + "/" + CONTENT_DOCUMENTS_DIRECTORY + "/" + uniqueFileName;

        } catch (IOException | ServletException e) {
            e.printStackTrace();
            return null;
        }
    }

    /**
     * Deletes a content file (image, video, or document)
     *
     * @param request The HttpServletRequest
     * @param filePath The path to the file to delete
     * @return true if the file was deleted, false otherwise
     */
    public static boolean deleteContentFile(HttpServletRequest request, String filePath) {
        if (filePath == null || filePath.isEmpty()) {
            return false;
        }

        try {
            String applicationPath = request.getServletContext().getRealPath("");
            Path path = Paths.get(applicationPath + filePath);

            return Files.deleteIfExists(path);
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }
}
