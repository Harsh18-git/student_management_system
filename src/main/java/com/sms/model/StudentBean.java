package com.sms.model;

public class StudentBean {

    // These are the variables that hold student data
    // "private" means only this class can access them directly
    // We use getters/setters to access them from outside
    private int id;
    private String rollNumber;
    private String name;
    private String email;
    private String course;
    private int semester;
    private double dues;
    private String password;

   
    public int getId() {
        return id;           // return current value of id
    }
    public void setId(int id) {
        this.id = id;        // "this.id" = class variable, "id" = parameter
    }

    // --- rollNumber ---
    public String getRollNumber() {
        return rollNumber;
    }
    public void setRollNumber(String rollNumber) {
        this.rollNumber = rollNumber;
    }

    // --- name ---
    public String getName() {
        return name;
    }
    public void setName(String name) {
        this.name = name;
    }

    // --- email ---
    public String getEmail() {
        return email;
    }
    public void setEmail(String email) {
        this.email = email;
    }

    // --- course ---
    public String getCourse() {
        return course;
    }
    public void setCourse(String course) {
        this.course = course;
    }

    // --- semester ---
    public int getSemester() {
        return semester;
    }
    public void setSemester(int semester) {
        this.semester = semester;
    }

    // --- dues ---
    public double getDues() {
        return dues;
    }
    public void setDues(double dues) {
        this.dues = dues;
    }

    // --- password ---
    public String getPassword() {
        return password;
    }
    public void setPassword(String password) {
        this.password = password;
    }
}