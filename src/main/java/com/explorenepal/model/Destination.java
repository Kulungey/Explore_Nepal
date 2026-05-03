package com.explorenepal.model;

/**
 * Model class representing a Travel Destination in the Explore Nepal system.
 * Maps to the 'destinations' table in the database.
 */
public class Destination {

    private int destinationId;
    private String name;
    private String description;
    private String region;       // e.g. Himalayan, Hilly, Terai
    private String category;     // e.g. Trekking, Cultural, Wildlife, Adventure
    private String difficulty;   // Easy, Moderate, Hard
    private int durationDays;
    private double altitude;     // in metres
    private String bestSeason;
    private String imageUrl;
    private int isActive;

    public Destination() {}

    public Destination(String name, String description, String region, String category,
                       String difficulty, int durationDays, double altitude, String bestSeason, String imageUrl) {
        this.name = name;
        this.description = description;
        this.region = region;
        this.category = category;
        this.difficulty = difficulty;
        this.durationDays = durationDays;
        this.altitude = altitude;
        this.bestSeason = bestSeason;
        this.imageUrl = imageUrl;
        this.isActive = 1;
    }

    // Getters and Setters
    public int getDestinationId() { return destinationId; }
    public void setDestinationId(int destinationId) { this.destinationId = destinationId; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public String getRegion() { return region; }
    public void setRegion(String region) { this.region = region; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getDifficulty() { return difficulty; }
    public void setDifficulty(String difficulty) { this.difficulty = difficulty; }

    public int getDurationDays() { return durationDays; }
    public void setDurationDays(int durationDays) { this.durationDays = durationDays; }

    public double getAltitude() { return altitude; }
    public void setAltitude(double altitude) { this.altitude = altitude; }

    public String getBestSeason() { return bestSeason; }
    public void setBestSeason(String bestSeason) { this.bestSeason = bestSeason; }

    public String getImageUrl() { return imageUrl; }
    public void setImageUrl(String imageUrl) { this.imageUrl = imageUrl; }

    public int getIsActive() { return isActive; }
    public void setIsActive(int isActive) { this.isActive = isActive; }
}
