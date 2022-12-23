package com.messi.king.messinews.services;

import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

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

    public static Users findByUsername(String username) {
        final String query = "select * from users where username = :username";
        try (Connection con = DbUtils.getConnection()) {
            Users user = con.createQuery(query)
                    .addParameter("username", username)
                    .executeAndFetchFirst(Users.class);
            return user;
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
}
