package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.time.LocalDateTime;
import java.util.List;

public class UsersService {
    public static void add(Users user) {
        String insertSql = "INSERT INTO users (username, password, full_name, issue_at, expiration,role, dob, email, otp, otp_exp) VALUES (:username, :password, :full_name, :issue_at, :expiration,:role, :dob, :email, :otp, :otp_exp)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(insertSql)
                    .addParameter("username", user.getUsername())
                    .addParameter("password", user.getPassword())
                    .addParameter("full_name", user.getFull_name())
                    .addParameter("issue_at", user.getIssue_at())
                    .addParameter("expiration", user.getExpiration())
                    .addParameter("role", user.getRole())
                    .addParameter("dob",user.getDob())
                    .addParameter("email", user.getEmail())
                    .addParameter("otp",user.getOtp())
                    .addParameter("otp_exp",user.getOtp_exp())
                    .executeUpdate();
        }
    }

    public static Users findById(int id) {
        final String query = "select * from users where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            Users user = con.createQuery(query)
                    .addParameter("id", id)
                    .executeAndFetchFirst(Users.class);
            return user;
        }
    }

    public static List<Users> findAll() {
        final String query = "select * from users";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Users.class);
        }
    }
    public static void extendSubscriber(int id) {
        final String query = "update users set issue_at = :issue_at, expiration= :expiration where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("issue_at", LocalDateTime.now())
                    .addParameter("expiration",7*24*60 )
                    .executeUpdate();
        }
    }
    public static void assignCategories(int editor_id, List<Integer> catesId ) {
        final String deleteSql = "delete from editor_manage_categories where editor_id = :editor_id";
        String insertSql = "INSERT INTO editor_manage_categories (editor_id, category_id) VALUES (:editor_id, :category_id)";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(deleteSql)
                    .addParameter("editor_id",editor_id)
                    .executeUpdate();
            for (int cateId: catesId) {
                con.createQuery(insertSql)
                        .addParameter("editor_id", editor_id)
                        .addParameter("category_id", cateId)
                        .executeUpdate();
            }
        }
    }


    public static Users findByUsername(String username) {
        final String query = "select * from users where username = :username";
        try (Connection con = DbUtils.getConnection()) {
            Users user = con.createQuery(query)
                    .addParameter("username", username)
                    .executeAndFetchFirst(Users.class);
            return user;
        }
    }
    public static List<Users> findAllByRole(int role) {
        final String query = "select * from users where role = :role";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .addParameter("role", role)
                    .executeAndFetch(Users.class);
        }
    }



    public static Users findByEmail(String email) {
        final String query = "select * from users where email = :email";
        try (Connection con = DbUtils.getConnection()) {
            Users user = con.createQuery(query)
                    .addParameter("email", email)
                    .executeAndFetchFirst(Users.class);
            return user;
        }
    }

    public static void updateProfile(int id, String fullName, int role, String email, LocalDateTime dob) {
        final String query = "update users set full_name = :fullName, role= :role, email= :email, dob= :dob where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("fullName",fullName)
                    .addParameter("role",role)
                    .addParameter("email",email)
                    .addParameter("dob",dob)
                    .executeUpdate();
        }
    }

    public static void changePassword(int id, String password) {
        final String query = "update users set password= :password where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("password",password)
                    .executeUpdate();
        }
    }
}
