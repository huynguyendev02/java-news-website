package com.messi.king.messinews.models;

import java.time.LocalDate;
import java.time.LocalDateTime;

public class Users {
    private int id;
    private String username;
    private String password;
    private String full_name;
    private LocalDateTime issue_at;
    private int expiration;
    private int role;
    private LocalDateTime dob;
    private String email;
    private String otp;
    private LocalDateTime otp_exp;

    public Users(int id, String username, String password, String full_name, LocalDateTime issue_at, int expiration, int role, LocalDateTime dob, String email, String otp, LocalDateTime otp_exp) {
        this.id = id;
        this.username = username;
        this.password = password;
        this.full_name = full_name;
        this.issue_at = issue_at;
        this.expiration = expiration;
        this.role = role;
        this.dob = dob;
        this.email = email;
        this.otp = otp;
        this.otp_exp = otp_exp;
    }

    public Users() {
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getFull_name() {
        return full_name;
    }

    public void setFull_name(String full_name) {
        this.full_name = full_name;
    }



    public LocalDateTime getIssue_at() {
        return issue_at;
    }

    public void setIssue_at(LocalDateTime issue_at) {
        this.issue_at = issue_at;
    }

    public int getExpiration() {
        return expiration;
    }

    public void setExpiration(int expiration) {
        this.expiration = expiration;
    }

    public int getRole() {
        return role;
    }

    public void setRole(int role) {
        this.role = role;
    }

    public LocalDateTime getDob() {
        return dob;
    }

    public void setDob(LocalDateTime dob) {
        this.dob = dob;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getOtp() {
        return otp;
    }

    public void setOtp(String otp) {
        this.otp = otp;
    }

    public LocalDateTime getOtp_exp() {
        return otp_exp;
    }

    public void setOtp_exp(LocalDateTime otp_exp) {
        this.otp_exp = otp_exp;
    }
}
