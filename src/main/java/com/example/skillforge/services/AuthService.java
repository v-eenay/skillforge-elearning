package com.example.skillforge.services;

import com.example.skillforge.dao.UserDAO;
import com.example.skillforge.models.UserModel;

public class AuthService {
    public static int registerUser(String name, String userName, String email, String password, String role, String profileImage, String bio) {
        UserModel user = new UserModel();
        user.setName(name);
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword_hash(password);
        user.setRole(UserModel.Role.valueOf(role));
        user.setProfileImage(profileImage);
        user.setBio(bio);
        return UserDAO.insertUser(user);
    }

    public static UserModel loginUser(String userName, String email, String password) {
        UserModel user = new UserModel();
        user.setUserName(userName);
        user.setEmail(email);
        user.setPassword_hash(password);
        return UserDAO.loginUser(user);
    }
}
