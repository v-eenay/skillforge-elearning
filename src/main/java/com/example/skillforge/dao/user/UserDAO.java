package com.example.skillforge.dao.user;

import com.example.skillforge.models.user.UserModel;
import com.example.skillforge.utils.DBConnectionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private static final String INSERT_USER_SQL = "INSERT INTO user (Name, UserName, Email, PasswordHash, Role, ProfileImage, Bio, Status) VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
    private static final String SELECT_USER_SQL = "SELECT * FROM user WHERE UserName = ? OR Email = ?";
    private static final String SELECT_ALL_USERS_SQL = "SELECT * FROM user";
    private static final String SELECT_RECENT_USERS_SQL = "SELECT * FROM user ORDER BY UserID DESC LIMIT ?";
    private static final String SELECT_USER_BY_ID_SQL = "SELECT * FROM user WHERE UserID = ?";
    private static final String UPDATE_USER_STATUS_SQL = "UPDATE user SET Status = ? WHERE UserID = ?";
    private static final String DELETE_USER_SQL = "DELETE FROM user WHERE UserID = ?";
    private static final String UPDATE_USER_PROFILE_SQL = "UPDATE user SET Name = ?, UserName = ?, Email = ?, ProfileImage = ?, Bio = ? WHERE UserID = ?";

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
            preparedStatement.setString(8, user.getStatus().toString());
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

                // Handle status field - default to active if not present in database
                String statusStr = resultSet.getString("Status");
                if (statusStr != null && !statusStr.isEmpty()) {
                    userModel.setStatus(UserModel.Status.valueOf(statusStr));
                } else {
                    userModel.setStatus(UserModel.Status.active);
                }

                return userModel;
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    private static UserModel mapResultSetToUserModel(ResultSet resultSet) throws SQLException {
        UserModel userModel = new UserModel();
        userModel.setUserId(resultSet.getInt("UserId"));
        userModel.setName(resultSet.getString("Name"));
        userModel.setUserName(resultSet.getString("UserName"));
        userModel.setEmail(resultSet.getString("Email"));
        userModel.setPassword_hash(resultSet.getString("PasswordHash"));
        userModel.setRole(UserModel.Role.valueOf(resultSet.getString("Role")));
        userModel.setProfileImage(resultSet.getString("ProfileImage"));
        userModel.setBio(resultSet.getString("Bio"));

        // Handle status field - default to active if not present in database
        String statusStr = resultSet.getString("Status");
        if (statusStr != null && !statusStr.isEmpty()) {
            userModel.setStatus(UserModel.Status.valueOf(statusStr));
        } else {
            userModel.setStatus(UserModel.Status.active);
        }

        return userModel;
    }

    public static List<UserModel> getAllUsers() {
        List<UserModel> users = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_USERS_SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                users.add(mapResultSetToUserModel(resultSet));
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return users;
    }

    public static UserModel getUserById(int userId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_USER_BY_ID_SQL)) {
            preparedStatement.setInt(1, userId);
            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                return mapResultSetToUserModel(resultSet);
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return null;
    }

    public static boolean updateUserStatus(int userId, UserModel.Status status) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_STATUS_SQL)) {
            preparedStatement.setString(1, status.toString());
            preparedStatement.setInt(2, userId);
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    public static boolean deleteUser(int userId) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_USER_SQL)) {
            preparedStatement.setInt(1, userId);
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    public static boolean updateUserProfile(UserModel user) {
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_USER_PROFILE_SQL)) {
            preparedStatement.setString(1, user.getName());
            preparedStatement.setString(2, user.getUserName());
            preparedStatement.setString(3, user.getEmail());
            preparedStatement.setString(4, user.getProfileImage());
            preparedStatement.setString(5, user.getBio());
            preparedStatement.setInt(6, user.getUserId());
            int affectedRows = preparedStatement.executeUpdate();
            return affectedRows > 0;
        } catch (SQLException e) {
            System.err.println(e.getMessage());
            return false;
        }
    }

    /**
     * Get a list of the most recently registered users
     * @param limit The maximum number of users to return
     * @return A list of the most recent users
     */
    public static List<UserModel> getRecentUsers(int limit) {
        List<UserModel> users = new ArrayList<>();
        try (Connection connection = DBConnectionUtil.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_RECENT_USERS_SQL)) {
            preparedStatement.setInt(1, limit);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                users.add(mapResultSetToUserModel(resultSet));
            }
        } catch (SQLException e) {
            System.err.println(e.getMessage());
        }
        return users;
    }
}
