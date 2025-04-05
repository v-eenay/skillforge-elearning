package com.example.skillforge.dao;

import com.example.skillforge.models.User;
import com.example.skillforge.services.AuthService;
import com.example.skillforge.utils.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class UserDAO {

    public static int createUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password_hash, role, is_active) VALUES (?, ?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getRole().toString());
            ps.setBoolean(5, user.isActive());

            int rowsAffected = ps.executeUpdate();
            if (rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if (rs.next()) {
                    return rs.getInt(1);
                }
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return -1;
    }

    public static User validateUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                if (AuthService.checkPassword(password, rs.getString("password_hash"))) {
                    User user = new User();
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setRole(User.Role.valueOf(rs.getString("role")));
                    user.setActive(rs.getBoolean("is_active"));
                    return user;
                }
            }
        } catch (SQLException e) {
            System.err.println("Error: " + e.getMessage());
        }
        return null;
    }

    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);

        while (true) {
            System.out.println("\n==============================");
            System.out.println("Welcome to SkillForge!");
            System.out.println("==============================");
            System.out.println("Please select an option: ");
            System.out.println("1. Create User");
            System.out.println("2. Validate User");
            System.out.println("3. Exit");

            int choice = scanner.nextInt();
            scanner.nextLine();

            switch (choice) {
                case 1:
                    System.out.print("Enter full name: ");
                    String fullName = scanner.nextLine();
                    System.out.print("Enter email: ");
                    String email = scanner.nextLine();
                    System.out.print("Enter password: ");
                    String password = scanner.nextLine();
                    System.out.println("Select role: ");
                    System.out.println("1. ADMIN");
                    System.out.println("2. INSTRUCTOR");
                    System.out.println("3. STUDENT");

                    int roleChoice = scanner.nextInt();
                    String role = switch (roleChoice) {
                        case 1 -> "ADMIN";
                        case 2 -> "INSTRUCTOR";
                        case 3 -> "STUDENT";
                        default -> {
                            System.out.println("Invalid role choice. Defaulting to STUDENT");
                            yield "STUDENT";
                        }
                    };

                    User newUser = new User();
                    newUser.setFullName(fullName);
                    newUser.setEmail(email);
                    newUser.setRole(User.Role.valueOf(role));
                    newUser.setActive(true);

                    int userId = AuthService.registerUser(newUser, password);
                    if (userId != -1) {
                        System.out.println("User created successfully with ID: " + userId);
                    } else {
                        System.out.println("Failed to create user.");
                    }
                    break;

                case 2:
                    System.out.print("Enter email: ");
                    String loginEmail = scanner.nextLine();
                    System.out.print("Enter password: ");
                    String loginPassword = scanner.nextLine();

                    User validatedUser = AuthService.loginUser(loginEmail, loginPassword);
                    if (validatedUser != null) {
                        System.out.println("User validated successfully!");
                        System.out.println("Welcome " + validatedUser.getFullName());
                    } else {
                        System.out.println("Invalid credentials.");
                    }
                    break;

                case 3:
                    System.out.println("Exiting... Goodbye!");
                    scanner.close();
                    return;

                default:
                    System.out.println("Invalid option. Please try again.");
            }
        }
    }
}
