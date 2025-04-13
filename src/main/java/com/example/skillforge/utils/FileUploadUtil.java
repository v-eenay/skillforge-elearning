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
}
