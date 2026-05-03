-- ============================================================
-- Explore Nepal – Database Schema
-- Project: CS5054NI Advanced Programming and Technologies
-- Run this in XAMPP phpMyAdmin or MySQL CLI
-- ============================================================

CREATE DATABASE IF NOT EXISTS explore_nepal
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;

USE explore_nepal;

-- ------------------------------------------------------------
-- TABLE: users
-- Stores all system users (admin + tourists)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    user_id     INT           NOT NULL AUTO_INCREMENT,
    full_name   VARCHAR(100)  NOT NULL,
    email       VARCHAR(100)  NOT NULL UNIQUE,
    password    VARCHAR(255)  NOT NULL,   -- BCrypt hash, always 60 chars
    phone       VARCHAR(15)   NOT NULL,
    role        ENUM('admin','user') NOT NULL DEFAULT 'user',
    is_approved TINYINT(1)    NOT NULL DEFAULT 0,
    created_at  DATETIME      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id)
) ENGINE=InnoDB;

-- Default admin account (password = Admin@123 hashed)
-- You MUST change this password after first login
INSERT INTO users (full_name, email, password, phone, role, is_approved)
VALUES ('Admin', 'admin@explorenepal.com',
        '$2a$12$samplehashchangethisbeforeuse1234567890abcdefghijklm',
        '9800000000', 'admin', 1);

-- ------------------------------------------------------------
-- TABLE: regions
-- Nepal's geographic regions
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS regions (
    region_id   INT          NOT NULL AUTO_INCREMENT,
    region_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT,
    PRIMARY KEY (region_id)
) ENGINE=InnoDB;

INSERT INTO regions (region_name, description) VALUES
('Himalayan',  'High-altitude mountain region including Everest, Annapurna, and Langtang zones.'),
('Hilly',      'Mid-hill region with valleys, cultural cities like Kathmandu and Pokhara.'),
('Terai',      'Lowland plains region with national parks including Chitwan and Bardia.');

-- ------------------------------------------------------------
-- TABLE: destinations
-- Core entity – travel destinations managed by admin
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS destinations (
    destination_id  INT          NOT NULL AUTO_INCREMENT,
    name            VARCHAR(150) NOT NULL,
    description     TEXT,
    region_id       INT          NOT NULL,
    category        ENUM('Trekking','Cultural','Wildlife','Adventure','Religious','Scenic') NOT NULL,
    difficulty      ENUM('Easy','Moderate','Hard','Extreme') NOT NULL DEFAULT 'Moderate',
    duration_days   INT          NOT NULL,
    altitude        DECIMAL(8,2) DEFAULT 0.00,   -- metres above sea level
    best_season     VARCHAR(100),
    image_url       VARCHAR(300),
    is_active       TINYINT(1)   NOT NULL DEFAULT 1,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (destination_id),
    FOREIGN KEY (region_id) REFERENCES regions(region_id) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB;

-- Sample destinations
INSERT INTO destinations (name, description, region_id, category, difficulty, duration_days, altitude, best_season, image_url) VALUES
('Everest Base Camp Trek',
 'Classic trek to the base of the world\'s highest mountain at 5,364m. Passes through Sherpa villages and stunning glaciers.',
 1, 'Trekking', 'Hard', 14, 5364.00, 'March-May, September-November', 'images/ebc.jpg'),

('Annapurna Circuit',
 'World-famous circular trek encircling the Annapurna massif through diverse landscapes and cultures.',
 1, 'Trekking', 'Moderate', 15, 5416.00, 'October-November, March-April', 'images/annapurna.jpg'),

('Kathmandu Durbar Square',
 'UNESCO World Heritage Site – ancient royal palace complex with Newari architecture in the heart of Kathmandu.',
 2, 'Cultural', 'Easy', 1, 1310.00, 'Year-round', 'images/durbar.jpg'),

('Chitwan National Park',
 'Explore the Terai jungle, spot one-horned rhinos, Bengal tigers and crocodiles on jungle safaris.',
 3, 'Wildlife', 'Easy', 3, 200.00, 'October-March', 'images/chitwan.jpg'),

('Pokhara Lakeside',
 'Nepal\'s tourism capital beside Phewa Lake with stunning views of Annapurna range. Adventure hub.',
 2, 'Scenic', 'Easy', 3, 822.00, 'Year-round', 'images/pokhara.jpg');

-- ------------------------------------------------------------
-- TABLE: bookings
-- Tourist trip booking requests (user feature)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS bookings (
    booking_id      INT          NOT NULL AUTO_INCREMENT,
    user_id         INT          NOT NULL,
    destination_id  INT          NOT NULL,
    travel_date     DATE         NOT NULL,
    num_travelers   INT          NOT NULL DEFAULT 1,
    status          ENUM('Pending','Confirmed','Cancelled') NOT NULL DEFAULT 'Pending',
    notes           TEXT,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (booking_id),
    FOREIGN KEY (user_id)         REFERENCES users(user_id)        ON DELETE CASCADE,
    FOREIGN KEY (destination_id)  REFERENCES destinations(destination_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ------------------------------------------------------------
-- TABLE: reviews
-- User reviews for destinations
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS reviews (
    review_id       INT          NOT NULL AUTO_INCREMENT,
    user_id         INT          NOT NULL,
    destination_id  INT          NOT NULL,
    rating          TINYINT      NOT NULL CHECK (rating BETWEEN 1 AND 5),
    comment         TEXT,
    created_at      DATETIME     NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (review_id),
    FOREIGN KEY (user_id)         REFERENCES users(user_id)        ON DELETE CASCADE,
    FOREIGN KEY (destination_id)  REFERENCES destinations(destination_id) ON DELETE CASCADE
) ENGINE=InnoDB;

-- ============================================================
-- END OF SCHEMA
-- ============================================================
