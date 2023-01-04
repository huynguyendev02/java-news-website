package com.messi.king.messinews.services;

import com.messi.king.messinews.models.EditorManageCategories;
import com.messi.king.messinews.models.Users;
import com.messi.king.messinews.utils.DbUtils;
import org.sql2o.Connection;

import java.math.BigInteger;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class UsersService {
    public static int add(Users user) {
        String insertSql = "INSERT INTO users (username, password, full_name, issue_at, expiration,role, dob, email, otp, otp_exp) VALUES (:username, :password, :full_name, :issue_at, :expiration,:role, :dob, :email, :otp, :otp_exp)";
        try (Connection con = DbUtils.getConnection()) {
            BigInteger id = (BigInteger) con.createQuery(insertSql, true)
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
                    .executeUpdate().getKey();
            return id.intValue();
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
    public static void delete(Users user) {
        final String query = "delete from users where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", user.getId())
                    .executeUpdate();
        }
    }


    public static List<Users> findAll() {
        final String query = "select * from users";
        try (Connection con = DbUtils.getConnection()) {
            return con.createQuery(query)
                    .executeAndFetch(Users.class);
        }
    }
    public static void extendSubscriber(int id, LocalDateTime expireDate) {
        final String query = "update users set expiration= :expiration where id = :id";
        Users user = UsersService.findById(id);
        Duration duration = Duration.between(user.getIssue_at(), expireDate);
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("expiration",duration.toMinutes())
                    .executeUpdate();
        }
    }
    public static void assignCategories(int editor_id, int[] catesId ) {
        List<Integer> newCateId = Arrays.stream(catesId).boxed().toList();
        for (int cateId : catesId) {
            String queryCheck = "Select * from editor_manage_categories where category_id= :cateId and editor_id= :editor_id";
            try (Connection con = DbUtils.getConnection()) {
                boolean check = con.createQuery(queryCheck)
                        .addParameter("editor_id", editor_id)
                        .addParameter("cateId", cateId)
                        .executeAndFetchFirst(EditorManageCategories.class) != null;
                if (check)
                    newCateId.remove(cateId);
            }
        }
        String insertSql = "INSERT INTO editor_manage_categories (editor_id, category_id) VALUES (:editor_id, :category_id)";
        try (Connection con = DbUtils.getConnection()) {
            for (int cateId: newCateId) {
                con.createQuery(insertSql)
                        .addParameter("editor_id", editor_id)
                        .addParameter("category_id", cateId)
                        .executeUpdate();
            }
        }
    }

    public static void updateOTP(int id, String otp) {
        final String query = "update users set otp= :otp, otp_exp= :otp_exp where id = :id";
        try (Connection con = DbUtils.getConnection()) {
            con.createQuery(query)
                    .addParameter("id", id)
                    .addParameter("otp", otp)
                    .addParameter("otp_exp", LocalDateTime.now().plusMinutes(5))
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
