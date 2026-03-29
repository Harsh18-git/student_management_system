package com.sms.model;

public class MarksBean {
    private String rollNumber;
    private String subject1Name;
    private int    subject1Marks;
    private String subject2Name;
    private int    subject2Marks;
    private String subject3Name;
    private int    subject3Marks;

    public String getRollNumber()          { return rollNumber; }
    public void setRollNumber(String r)    { this.rollNumber = r; }

    public String getSubject1Name()        { return subject1Name; }
    public void setSubject1Name(String s)  { this.subject1Name = s; }

    public int getSubject1Marks()          { return subject1Marks; }
    public void setSubject1Marks(int m)    { this.subject1Marks = m; }

    public String getSubject2Name()        { return subject2Name; }
    public void setSubject2Name(String s)  { this.subject2Name = s; }

    public int getSubject2Marks()          { return subject2Marks; }
    public void setSubject2Marks(int m)    { this.subject2Marks = m; }

    public String getSubject3Name()        { return subject3Name; }
    public void setSubject3Name(String s)  { this.subject3Name = s; }

    public int getSubject3Marks()          { return subject3Marks; }
    public void setSubject3Marks(int m)    { this.subject3Marks = m; }

    public int getTotalMarks() {
        return subject1Marks + subject2Marks + subject3Marks;
    }

    public double getPercentage() {
        return (getTotalMarks() / 300.0) * 100;
    }

    public String getGrade() {
        double pct = getPercentage();
        if (pct >= 90) return "A+";
        else if (pct >= 75) return "A";
        else if (pct >= 60) return "B";
        else if (pct >= 50) return "C";
        else if (pct >= 40) return "D";
        else return "F";
    }
}