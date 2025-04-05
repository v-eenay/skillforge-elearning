package com.example.skillforge.dao;

import com.example.skillforge.models.User;
import com.example.skillforge.utils.DBConnection;
import com.example.skillforge.utils.HashPasswordUtil;
import org.mindrot.jbcrypt.BCrypt;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Scanner;

public class UserDAO {
    public static int createUser(User user) {
        String sql = "INSERT INTO users (full_name, email, password_hash, role, is_active) VALUES (?, ?, ?, ?,?)";
        try(Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, user.getFullName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPasswordHash());
            ps.setString(4, user.getRole().toString());
            ps.setBoolean(5, user.isActive());

            int rowsAffected = ps.executeUpdate();
            if(rowsAffected > 0) {
                ResultSet rs = ps.getGeneratedKeys();
                if(rs.next()) {
                    return rs.getInt(1);
                }
            }
        }
        catch (SQLException e){
            System.err.println("Error: "+e.getMessage());
        }
    return -1;
    }

    public static User validateUser(String email, String password) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try(Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();
            while(rs.next()) {
                if(HashPasswordUtil.checkPassword(password, rs.getString("password_hash"))) {
                    User user = new User();
                    user.setFullName(rs.getString("full_name"));
                    user.setEmail(rs.getString("email"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setRole(User.Role.valueOf(rs.getString("role")));
                    user.setActive(rs.getBoolean("is_active"));
                    return user;
                }
            }
        }
        catch (SQLException e){
            System.err.println("Error: "+e.getMessage());
        }
        return null;
    }
    //Checking the functions
    public static void main(String[] args) {
        Scanner scanner = new Scanner(System.in);
        System.out.println("Please select the option: ");
        System.out.println("1. Create User");
        System.out.println("2. Validate User");
        
        int choice = scanner.nextInt();
        scanner.nextLine(); // consume newline
        
        switch(choice) {
            case 1:
                System.out.println("Enter full name: ");
                String fullName = scanner.nextLine();
                System.out.println("Enter email: ");
                String email = scanner.nextLine();
                System.out.println("Enter password: ");
                String password = scanner.nextLine();
                System.out.println("Select role: ");
                System.out.println("1. ADMIN");
                System.out.println("2. INSTRUCTOR");
                System.out.println("3. STUDENT");
                
                int roleChoice = scanner.nextInt();
                String role = switch (roleChoice) {
                    case 1 -> "admin";
                    case 2 -> "instructor";
                    case 3 -> "student";
                    default -> {
                        System.out.println("Invalid role choice. Defaulting to STUDENT");
                        yield "STUDENT";
                    }
                };
                password = BCrypt.hashpw(password, BCrypt.gensalt());
                User newUser = new User();
                newUser.setFullName(fullName);
                newUser.setEmail(email);
                newUser.setPasswordHash(password);
                newUser.setRole(User.Role.valueOf(role));
                newUser.setActive(true);
                
                int userId = createUser(newUser);
                if(userId != -1) {
                    System.out.println("User created successfully with ID: " + userId);
                } else {
                    System.out.println("Failed to create user");
                }
                break;
                
            case 2:
                System.out.println("Enter email: ");
                String loginEmail = scanner.nextLine();
                System.out.println("Enter password: ");
                String loginPassword = scanner.nextLine();
                User validatedUser = validateUser(loginEmail, loginPassword);
                if(validatedUser != null) {
                    System.out.println("User validated successfully!");
                    System.out.println("Welcome " + validatedUser.getFullName());
                } else {
                    System.out.println("Invalid credentials");
                }
                break;
                
            default:
                System.out.println("Invalid option");
        }
        
        scanner.close();
    }}