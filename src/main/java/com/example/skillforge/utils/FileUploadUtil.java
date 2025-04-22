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

    // Ensure the upload directories exist
    static {
        try {
            // Create the upload directories if they don't exist
            File uploadDir = new File(System.getProperty("catalina.base") + File.separator + "webapps" + File.separator + UPLOAD_DIRECTORY);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Create subdirectories
            new File(uploadDir, PROFILE_IMAGES_DIRECTORY).mkdirs();
            new File(uploadDir, COURSE_THUMBNAILS_DIRECTORY).mkdirs();
            new File(uploadDir, CONTENT_IMAGES_DIRECTORY).mkdirs();
            new File(uploadDir, CONTENT_VIDEOS_DIRECTORY).mkdirs();
            new File(uploadDir, CONTENT_DOCUMENTS_DIRECTORY).mkdirs();

            System.out.println("Upload directories created successfully");
        } catch (Exception e) {
            System.out.println("Error creating upload directories: " + e.getMessage());
            e.printStackTrace();
        }
    }

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
            System.out.println("Starting thumbnail upload process for part: " + partName);
            Part filePart = request.getPart(partName);
            System.out.println("File part retrieved: " + (filePart != null ? "yes" : "no"));

            // Check if a file was actually uploaded
            if (filePart == null) {
                System.out.println("File part is null");
                return null;
            }

            System.out.println("File size: " + filePart.getSize());
            System.out.println("File name: " + filePart.getSubmittedFileName());

            if (filePart.getSize() <= 0) {
                System.out.println("File size is 0 or negative");
                return null;
            }

            if (filePart.getSubmittedFileName() == null || filePart.getSubmittedFileName().isEmpty()) {
                System.out.println("File name is null or empty");
                return null;
            }

            // Get the file extension
            String fileName = filePart.getSubmittedFileName();
            String fileExtension = "";
            if (fileName.contains(".")) {
                fileExtension = fileName.substring(fileName.lastIndexOf("."));
            } else {
                // Default to .jpg if no extension is found
                fileExtension = ".jpg";
            }
            System.out.println("File extension: " + fileExtension);

            // Generate a unique file name
            String uniqueFileName = UUID.randomUUID().toString() + fileExtension;
            System.out.println("Generated unique filename: " + uniqueFileName);

            // Get the application path
            String applicationPath = request.getServletContext().getRealPath("");
            System.out.println("Application path: " + applicationPath);

            // Try multiple approaches to create the upload directory
            String uploadPath = applicationPath + File.separator + UPLOAD_DIRECTORY + File.separator + COURSE_THUMBNAILS_DIRECTORY;
            System.out.println("Upload path: " + uploadPath);

            // First approach: Use the application path
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                boolean dirCreated = uploadDir.mkdirs();
                System.out.println("Created upload directory (approach 1): " + dirCreated);

                // Second approach: Use catalina.base if first approach fails
                if (!dirCreated) {
                    String catalinaBase = System.getProperty("catalina.base");
                    if (catalinaBase != null) {
                        uploadPath = catalinaBase + File.separator + "webapps" + File.separator +
                                     request.getContextPath().substring(1) + File.separator +
                                     UPLOAD_DIRECTORY + File.separator + COURSE_THUMBNAILS_DIRECTORY;
                        uploadDir = new File(uploadPath);
                        dirCreated = uploadDir.mkdirs();
                        System.out.println("Created upload directory (approach 2): " + dirCreated);
                    }

                    // Third approach: Use java.io.tmpdir if second approach fails
                    if (!dirCreated) {
                        uploadPath = System.getProperty("java.io.tmpdir") + File.separator +
                                     UPLOAD_DIRECTORY + File.separator + COURSE_THUMBNAILS_DIRECTORY;
                        uploadDir = new File(uploadPath);
                        dirCreated = uploadDir.mkdirs();
                        System.out.println("Created upload directory (approach 3): " + dirCreated);

                        if (!dirCreated) {
                            // Last resort: use a fixed path that should be writable
                            uploadPath = "C:" + File.separator + "temp" + File.separator +
                                         UPLOAD_DIRECTORY + File.separator + COURSE_THUMBNAILS_DIRECTORY;
                            uploadDir = new File(uploadPath);
                            dirCreated = uploadDir.mkdirs();
                            System.out.println("Created upload directory (approach 4): " + dirCreated);

                            if (!dirCreated) {
                                throw new IOException("Failed to create upload directory after multiple attempts");
                            }
                        }
                    }
                }
            }

            // Save the file
            String filePath = uploadPath + File.separator + uniqueFileName;
            System.out.println("Saving file to: " + filePath);
            filePart.write(filePath);
            System.out.println("File saved successfully");

            // Verify the file was actually saved
            File savedFile = new File(filePath);
            if (!savedFile.exists() || savedFile.length() == 0) {
                System.out.println("File was not saved properly. Exists: " + savedFile.exists() + ", Size: " + savedFile.length());
                throw new IOException("File was not saved properly");
            }
            System.out.println("File verified: exists and has content");

            // Return the relative path to the file
            String relativePath = "/" + UPLOAD_DIRECTORY + "/" + COURSE_THUMBNAILS_DIRECTORY + "/" + uniqueFileName;
            System.out.println("Returning relative path: " + relativePath);
            return relativePath;

        } catch (Exception e) {
            System.out.println("Exception in uploadCourseThumbnail: " + e.getMessage());
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
