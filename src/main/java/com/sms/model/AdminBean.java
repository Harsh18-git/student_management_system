package com.sms.model;

public class AdminBean {

    // Admin only needs 3 variables
    private int id;
    private String username;
    private String password;

    // --- id ---
    public int getId() {
        return id;
    }
    public void setId(int id) {
        this.id = id;
    }

    // --- username ---
    public String getUsername() {
        return username;
    }
    public void setUsername(String username) {
        this.username = username;
    }

    // --- password ---
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}