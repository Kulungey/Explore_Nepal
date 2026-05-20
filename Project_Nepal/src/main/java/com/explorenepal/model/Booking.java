package com.explorenepal.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Booking {
    private int id;
    private int userId;
    private int destinationId;
    private String bookingRef;
    private BigDecimal amount;
    private String status;
    private LocalDateTime createdAt;
    private String userFullName;
    private String userEmail;
    private String destinationName;

    public int getId()                          { return id; }
    public void setId(int id)                   { this.id = id; }
    public int getUserId()                      { return userId; }
    public void setUserId(int v)                { this.userId = v; }
    public int getDestinationId()               { return destinationId; }
    public void setDestinationId(int v)         { this.destinationId = v; }
    public String getBookingRef()               { return bookingRef; }
    public void setBookingRef(String v)         { this.bookingRef = v; }
    public BigDecimal getAmount()               { return amount; }
    public void setAmount(BigDecimal v)         { this.amount = v; }
    public String getStatus()                   { return status; }
    public void setStatus(String v)             { this.status = v; }
    public LocalDateTime getCreatedAt()         { return createdAt; }
    public void setCreatedAt(LocalDateTime v)   { this.createdAt = v; }
    public String getUserFullName()             { return userFullName; }
    public void setUserFullName(String v)       { this.userFullName = v; }
    public String getUserEmail()                { return userEmail; }
    public void setUserEmail(String v)          { this.userEmail = v; }
    public String getDestinationName()          { return destinationName; }
    public void setDestinationName(String v)    { this.destinationName = v; }
}