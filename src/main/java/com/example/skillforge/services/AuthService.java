package com.example.skillforge.services;

import com.example.skillforge.dao.UserDAO;
import com.example.skillforge.models.UserModel;
import com.example.skillforge.utils.PasswordHashUtil;

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
        if (existingUser != null && PasswordHashUtil.checkPassword(password, existingUser.getPassword_hash())) {
            return existingUser;
        }
        return null;
    }
}
