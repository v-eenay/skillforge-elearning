package com.example.skillforge.services;

import com.example.skillforge.dao.UserDAO;
import com.example.skillforge.models.User;
import com.example.skillforge.utils.HashPasswordUtil;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {

    public static int registerUser(User user, String password) {
        String hashedPassword = hashPassword(password);
        user.setPasswordHash(hashedPassword);
        return UserDAO.createUser(user);
    }

    public static User loginUser(String email, String password) {
        return UserDAO.validateUser(email, password);
    }

    public static String hashPassword(String password) {
        return BCrypt.hashpw(password, BCrypt.gensalt());
    }

    public static boolean checkPassword(String password, String storedHash) {
        return BCrypt.checkpw(password, storedHash);
    }
}
