package com.explorenepal.model;

import java.time.LocalDateTime;
import java.util.Locale;

public class User {
    private int id;
    private String fullName;
    private String email;
    private String passwordHash;
    private String phone;
    private int roleId;
    private String roleName;
    private LocalDateTime createdAt;
    private String status;


    public User() {}

    public int getId()                        { return id; }
    public void setId(int id)                 { this.id = id; }

    public String getFullName()               { return fullName; }
    public void setFullName(String v)         { this.fullName = v; }

    public String getEmail()                  { return email; }
    public void setEmail(String v)            { this.email = v; }

    public String getPasswordHash()           { return passwordHash; }
    public void setPasswordHash(String v)     { this.passwordHash = v; }
    public void setPassword(String v)         { this.passwordHash = v; }

    public String getPhone()                  { return phone; }
    public void setPhone(String v)            { this.phone = v; }

    public int getRoleId()                    { return roleId; }
    public void setRoleId(int v)              { this.roleId = v; }
    
    public String getStatus()           { return status; }
    public void setStatus(String v)     { this.status = v; }

    public boolean isPending()          { return "Pending".equalsIgnoreCase(status); }
    public boolean isApproved()         { return "Approved".equalsIgnoreCase(status); }
    public boolean isRejected()         { return "Rejected".equalsIgnoreCase(status); }

    public String getRoleName()               { return roleName; }
    public void setRoleName(String v)         { this.roleName = v; }

    public String getRole()                   { return roleName == null ? null : roleName.toUpperCase(Locale.ROOT); }
    public void setRole(String v)             { this.roleName = v; }

    public LocalDateTime getCreatedAt()       { return createdAt; }
    public void setCreatedAt(LocalDateTime t) { this.createdAt = t; }

    public String getInitial() {
        if (fullName == null || fullName.trim().isEmpty()) return "A";
        return fullName.trim().substring(0, 1).toUpperCase(Locale.ROOT);
    }

    public boolean isAdmin()                  { return roleId == 1 || "ADMIN".equals(getRole()); }
}
