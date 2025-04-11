package com.example.skillforge.dao;

import com.example.skillforge.models.UserModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private static final String INSERT_USER_SQL = "INSERT INTO user (Name, UserName, Email, PasswordHash, Role, ProfileImage, Bio) VALUES (?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_SQL = "SELECT * FROM user WHERE UserName = ? OR Email = ?";

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
    public static UserModel getUserbyEmail(UserModel user) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_SQL)) {
            preparedStatement.setString(1, user.getUserName());
            preparedStatement.setString(2, user.getEmail());
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                UserModel userModel = new UserModel();
                userModel.setUserId(resultSet.getInt("UserId"));
                userModel.setName(resultSet.getString("Name"));
                userModel.setUserName(resultSet.getString("UserName"));
                userModel.setEmail(resultSet.getString("Email"));
                userModel.setPassword_hash(resultSet.getString("PasswordHash"));
                userModel.setRole(UserModel.Role.valueOf(resultSet.getString("Role")));
                userModel.setProfileImage(resultSet.getString("ProfileImage"));
                userModel.setBio(resultSet.getString("Bio"));
                return userModel;
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null;
    }
}
