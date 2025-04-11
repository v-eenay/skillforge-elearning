package com.example.skillforge.dao;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private static final String INSERT_USER_SQL = "INSERT INTO user (Name, UserName, Email, PasswordHash, Role, ProfileImage, Bio) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_SQL = "SELECT * FROM user WHERE UserName = ? OR Email = ? AND PasswordHash = ?";

    public static int insertUser(UserModel user) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_USER_SQL, PreparedStatement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getUserName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getPassword_hash());
            preparedStatement.setString(5, user.getRole().toString());
            preparedStatement.setString(6, user.getProfileImage());
            preparedStatement.setString(7, user.getBio());
            int affectedRows = preparedStatement.executeUpdate();
            if (affectedRows > 0) {
                ResultSet generatedKeys = preparedStatement.getGeneratedKeys();
                if (generatedKeys.next()) {
                    return generatedKeys.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return 0;
    }
}
