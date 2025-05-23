package com.example.skillforge.services;

import com.example.skillforge.dao.user.UserDAO;
import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.PasswordHashUtil;

import java.util.List;

public class AuthService {
    public static int registerUser(String name, String userName, String email, String password, String role, String profileImage, String bio) {
        String hashedPassword = PasswordHashUtil.hashPassword(password);
        UserModel user = new UserModel();
        user.setName(name);
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword_hash(hashedPassword);
        user.setRole(UserModel.Role.valueOf(role));
        user.setProfileImage(profileImage);
        user.setBio(bio);
        return UserDAO.insertUser(user);
    }

    public static UserModel loginUser(String userName, String email, String password) {
        UserModel user = new UserModel();
        user.setUserName(userName);
        user.setEmail(email);
        UserModel existingUser = UserDAO.getUserbyEmail(user);

        // Check if user exists and password is correct
        if (existingUser != null && PasswordHashUtil.checkPassword(password, existingUser.getPassword_hash())) {
            // Check if user is not suspended
            if (existingUser.getStatus() != UserModel.Status.suspended) {
                return existingUser;
            }
        }
        return null;
    }

    public static boolean updateUserStatus(int userId, UserModel.Status status) {
        return UserDAO.updateUserStatus(userId, status);
    }

    public static boolean deleteUser(int userId) {
        return UserDAO.deleteUser(userId);
    }

    public static List<UserModel> getAllUsers() {
        return UserDAO.getAllUsers();
    }

    public static UserModel getUserById(int userId) {
        return UserDAO.getUserById(userId);
    }

    public static boolean updateUserProfile(UserModel user) {
        return UserDAO.updateUserProfile(user);
    }

    /**
     * Get a list of the most recently registered users
     * @param limit The maximum number of users to return
     * @return A list of the most recent users
     */
    public static List<UserModel> getRecentUsers(int limit) {
        return UserDAO.getRecentUsers(limit);
    }
}
