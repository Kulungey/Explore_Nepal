package com.explorenepal.model;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public class Destination {
    private int id;
    private String name;
    private String description;
    private String location;
    private String region;
    private String category;
    private String difficulty;
    private String duration;
    private BigDecimal price;
    private String imageUrl;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;

    public Destination() {}

    public int getId()                           { return id; }
    public void setId(int id)                    { this.id = id; }

    public String getName()                      { return name; }
    public void setName(String v)                { this.name = v; }

    public String getDescription()               { return description; }
    public void setDescription(String v)         { this.description = v; }

    public String getLocation()                  { return location; }
    public void setLocation(String v)            { this.location = v; }

    public String getRegion()                    { return region; }
    public void setRegion(String v)              { this.region = v; }

    public String getCategory()                  { return category; }
    public void setCategory(String v)            { this.category = v; }

    public String getDifficulty()                { return difficulty; }
    public void setDifficulty(String v)          { this.difficulty = v; }

    public String getDuration()                  { return duration; }
    public void setDuration(String v)            { this.duration = v; }

    // called as setDurationDays(int) from DestinationFormServlet
    public void setDurationDays(int days)        { this.duration = days + " days"; }

    public int getDurationDays() {
        if (duration == null || duration.trim().isEmpty()) return 0;
        try {
            return Integer.parseInt(duration.replace(" days", "").replace(" day", "").trim());
        } catch (NumberFormatException e) {
            return 0;
        }
    }

    public BigDecimal getPrice()                 { return price; }
    public void setPrice(BigDecimal v)           { this.price = v; }
    // called as setPrice(double) from DestinationFormServlet
    public void setPrice(double v)               { this.price = BigDecimal.valueOf(v); }

    public String getImageUrl()                  { return imageUrl; }
    public void setImageUrl(String v)            { this.imageUrl = v; }

    public LocalDateTime getCreatedAt()          { return createdAt; }
    public void setCreatedAt(LocalDateTime t)    { this.createdAt = t; }

    public LocalDateTime getUpdatedAt()          { return updatedAt; }
    public void setUpdatedAt(LocalDateTime t)    { this.updatedAt = t; }
}
