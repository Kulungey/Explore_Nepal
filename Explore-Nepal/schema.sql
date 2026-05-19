-- ============================================================
-- Explore Nepal — Database Schema
-- Engine: MySQL (XAMPP)
-- Normalised to 3NF | No plain-text passwords stored
-- ============================================================

CREATE DATABASE IF NOT EXISTS explore_nepal
    CHARACTER SET utf8mb4
    COLLATE utf8mb4_unicode_ci;
USE explore_nepal;

-- ------------------------------------------------------------
-- Table 1: roles
-- Lookup table so user.role_id → role.name (3NF: no transitive dependency)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS roles (
    id   TINYINT UNSIGNED NOT NULL AUTO_INCREMENT,
    name VARCHAR(20)      NOT NULL UNIQUE,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

INSERT INTO roles (id, name) VALUES (1, 'ADMIN'), (2, 'USER')
    ON DUPLICATE KEY UPDATE name = VALUES(name);

-- ------------------------------------------------------------
-- Table 2: users
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS users (
    id            INT UNSIGNED     NOT NULL AUTO_INCREMENT,
    full_name     VARCHAR(100)     NOT NULL,
    email         VARCHAR(150)     NOT NULL UNIQUE,
    password_hash VARCHAR(255)     NOT NULL,          -- BCrypt hash
    phone         CHAR(10)         NOT NULL,
    role_id       TINYINT UNSIGNED NOT NULL DEFAULT 2, -- 2 = USER
    created_at    DATETIME         NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (id),
    CONSTRAINT fk_users_role FOREIGN KEY (role_id) REFERENCES roles(id)
        ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB;

-- Default admin account (password: Admin@1234 — change after first login)
-- BCrypt hash of 'Admin@1234'
INSERT INTO users (full_name, email, password_hash, phone, role_id)
VALUES (
    'Site Admin',
    'admin@explorenepal.com',
    '$2a$12$gLIwCeiIODAvvzgJihZ9ROnQX//n.Y.tSfqhBWVJ7j7VBHqz37EjO',
    '9800000000',
    1
) ON DUPLICATE KEY UPDATE
    password_hash = '$2a$12$gLIwCeiIODAvvzgJihZ9ROnQX//n.Y.tSfqhBWVJ7j7VBHqz37EjO',
    role_id = 1;

-- ------------------------------------------------------------
-- Table 3: destinations
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS destinations (
    id           INT UNSIGNED   NOT NULL AUTO_INCREMENT,
    name         VARCHAR(150)   NOT NULL,
    description  TEXT           NOT NULL,
    location     VARCHAR(150)   NOT NULL,
    region       VARCHAR(50)    NOT NULL,             -- Himalayan / Hilly / Terai
    category     VARCHAR(50)    NOT NULL,             -- Trekking / Cultural / Wildlife …
    difficulty   VARCHAR(20)    NOT NULL,             -- Easy / Moderate / Hard
    duration     VARCHAR(50)    NOT NULL,             -- e.g. "14 days"
    price        DECIMAL(10,2)  NOT NULL DEFAULT 0.00,
    image_url    VARCHAR(500)   NULL,
    created_at   DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at   DATETIME       NOT NULL DEFAULT CURRENT_TIMESTAMP
                                ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (id)
) ENGINE=InnoDB;

-- Sample seed data (10 destinations)
INSERT INTO destinations (name, description, location, region, category, difficulty, duration, price, image_url) VALUES
('Everest Base Camp',    'The legendary trek to the foot of the world''s tallest peak. Experience glaciers, Sherpa culture, and breathtaking high-altitude scenery.',                          'Solukhumbu, Koshi',        'Himalayan', 'Trekking',  'Hard',     '14 days', 1299.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuA3SxD3IaIHJMZGhpS_uZXLtdFac3u8PEvZzXMtmF7pe2DQh_wroIydbICXD7-wRbCg5xxf2N625sE2jlU0LfZcSdQHmXQM2-hBxPlA_6W5Uqo7SUNNx2DIHTHxpPRwuKY8ttjWcoYVMC8sq277EfUxzHJVTsHqAlUFA_Fp-swXg5pJG0kF70W6XUkY0zcK6iIDoY-_GtqSaDDvF1MObyK9bvd-3uidragLqlMZk8s0Wvxs6E-iM6FcpeYcIGOZkRNpfF4sw0UvNBU'),
('Annapurna Circuit',    'A classic long-distance trek circling the Annapurna massif, crossing the Thorong La pass at 5416 m.',                                                               'Gandaki Province',         'Himalayan', 'Trekking',  'Moderate', '15 days',  900.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuDEBJGM__3Pg2UtVA1v1bU0FnIqsfcQDgNxLmTXvcJA7qzUiO8YgY3zes2jFI-KEWBO1wBd_vykD2rlT01EMTwrzYgrQqGnip89I_7yCCUiUrUFZKDPsH6nSxOwSQ_SWK7CLdMuwmRULw-KP9CSfMzHpG1Ezh3siLdpZShcbw7L1MVNI6o9ROKgdhGAgLLuPI1W8R-hET2Es4gSFUUWHJLu0HVBMsO7s2bhm7SHx8TrsJDLqUHe6ds1CW30uoJ-Laeh-9AnFRFs97Y'),
('Langtang Valley Trek', 'A beautiful trek through the Langtang National Park, offering close views of glaciers and traditional Tamang villages.',                                            'Rasuwa, Bagmati',          'Himalayan', 'Trekking',  'Moderate', '10 days',  650.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuDUkAO548UNdnGAKkQ8wS0t3xbnTyC7iSKvAvsYWk7jMF0iOaUQ0HmHm6Bc6XuIx0aev3HgRBMTHc2V9KA6iCuNFjtnYaq2z4vUZ-JMcyC_ysKTAtYsJPrEqIHTiR-gZj_6y1281u2n_wBjPBPZe3nlp8d9a9SijrzPuIOsKKQpXIKspCRPwOWFLQhhCCZHu8QTtmAIKadXosNG2ICkmjrtatKK9f6k_UXhuC-A0IbjbF2Wq1a0QzxO6JwAH8Xihiz2cRssxgarIDE'),
('Kathmandu Durbar Square','Explore the ancient royal squares of Kathmandu, filled with intricate Newari architecture, temples, and living heritage.',                                           'Kathmandu, Bagmati',       'Hilly',     'Cultural',  'Easy',     '1 day',     25.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuBPD3UbQCcIbbxoqIUscLZYAm0C6-WRQ2uVc50MIVxKlh5heUrYaZmQT0rss_RNUl5EacQAvguQTHAvg1J9S-vykD2rlT01EMTwrzYgrQqGnip89I_7yCCUiUrUFZKDPsH6nSxOwSQ_SWK7CLdMuwmRULw-KP9CSfMzHpG1Ezh3siLdpZShcbw7L1MVNI6o9ROKgdhGAgLLuPI1W8R-hET2Es4gSFUUWHJLu0HVBMsO7s2bhm7SHx8TrsJDLqUHe6ds1CW30uoJ-Laeh-9AnFRFs97Y'),
('Chitwan Safari',       'Explore Chitwan National Park — home to one-horned rhinos, Bengal tigers, and gharial crocodiles.',                                                               'Chitwan, Bagmati',         'Terai',     'Wildlife',  'Easy',     '3 days',   280.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuD7j1pLj19jwO3iXO3st1hOXgMblzJeaDXvb4mBzyFQ5ddDARJYdg-3-0jBQilTQ9SMmyuKlOlJdOUp_qZd3eZb8ZiQy66FF7cASdfWYWDHetiWEHiyE-R3g75fO7cW6qSet0zm7acDBr35jVwA5BZwNyiPRm61nCU4zz39tnURRvgraCqCnyPrDBJEdrmJgaJYAhb_TM1Z9CzEyG1r2_JqAP2-_BiZPZE4wwqjWVOsf4XOfFk9JZuhjwztqJZZki25Kw1P2x_u694'),
('Pokhara Lakeside',     'Relax by the serene Phewa Lake with stunning reflections of Machhapuchhre peak. Gateway to the Annapurna region.',                                               'Kaski, Gandaki',           'Hilly',     'Scenic',    'Easy',     '3 days',   150.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuCL5Bj0JgZ57U0H_D0gJSnRd9s1oyGiWs9_NojYQcc7lK0lB0MNb_JLvh9NSsCyee3Gbg0iG6_5EdkmZ8iaNN-EI-MbuvXIC92InoJMP0m7cV5j7lUNXqg4nwDp1dC8zro-qhu97EDJyFJSacbtRjxHXNvRu7L-yXOV0AQmtTMWmTp86sR6c_C1fQxmsK5vjS629edGIDm5ywBNBP4jRP0EXhdTAr1lC73x0QedkKNSLxs7vn-Ibozn31povwDmhb2JuElcrcPMENE'),
('Poon Hill Sunrise',    'Trek to the famous viewpoint at 3210 m for one of Nepal''s most iconic Himalayan panoramas at sunrise.',                                                          'Myagdi, Gandaki',          'Hilly',     'Trekking',  'Easy',     '4 days',   320.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuA6HNULcXJXiIjkwCCTZnqH1pAtS6snYTOR9C4-sX0_UODPXv1BaiX7uS87dqgbkLKokCGhBsx8S4_5pmyJAz9c_LLrsz3DfLs39665Hkj2-4S1wWCMSUznm7vUzi9fMSkOvi8IVGBnWMGeBaQ6SNdNre5cdoOTbBR7aQrAwK6buRLBTbJeXVwcwDwaT3iltn3507nroFlXnRxmkeJHtz-t8lPNpUSvwShxmHEJn3U9t5gEkgLi9xdkildOCeOdat-om-cnfsXPlwQ'),
('Lumbini Birthplace',   'Visit the sacred birthplace of Lord Buddha, a UNESCO World Heritage Site with ancient temples and the Ashoka Pillar.',                                            'Rupandehi, Lumbini',       'Terai',     'Religious', 'Easy',     '2 days',   120.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuBltRGQ6VGKWMhomevD5pqr6IqLibTFvkdCksxhi5glQEYXVUXuUHr6quR3V9Y_KJWh96vQyFh06VR2v7GbGyXgeTJ_yFCvO-TuIHFTebgdpFty3MVVtNexBy8oNWjUyPDdOinwtoOFdWwdaNhhxf1WZrQlzVoON2ycT8Vh2rW9B50EtbZUBJWapjzsYyg3MTcnjTLu_c-v_DbLaEI7RQDB4_PsxLsjqjMsH6T_kuo1OBowj1eB4BGQObVQE1yvvZpTAaXx3VvKSUc'),
('Manaslu Circuit',      'One of Nepal''s most remote and spectacular treks, circling the world''s eighth-highest mountain through restricted highland zones.',                             'Gorkha, Gandaki',          'Himalayan', 'Trekking',  'Hard',     '16 days', 1100.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuDywZt9flZcf94aXTTi2AmzM6Yqz3EwzHuj8AR0OTql1Hmj-YFXvm0ETCGkozoTnjSZj95rXVbM7AgEmYsv-vbNGoczEXqw5GNHLX_AsELJkscKYItkpGpwEYo51dT7QWLXCrgrcUNjdmCCG_q3vm4OswhBntJGCPcQFHkX7eBjOTIMlL2ZTfsfWREXZ30Gtvj-9BRkqksj_pCKCwFddTcLEPlNEDOPZgIz8c4EULglJMw4Y5wl9OdgN5YgbpU2t8ymtbh6qaO305g'),
('Upper Mustang',        'Journey into the forbidden kingdom of Mustang — arid canyons, ancient cave monasteries, and Tibetan Buddhist culture beyond the Himalayas.',                     'Mustang, Gandaki',         'Himalayan', 'Adventure', 'Hard',     '14 days', 1800.00, 'https://lh3.googleusercontent.com/aida-public/AB6AXuCu6-OCdp2ogzHRmdXo-1dQ6PYGr02KN6G5mJyDuFxTYHCFTUQzhfQrwSf1Wd7gaHWooz7pbwtWd68_kTFYMiUplAredc8BsE_Xv4Ro-4vczbyk6f-SJokEmHtM_LwOQfhtUEVcagUxDECasRTg1oj41ZgEZb_iH8XLk1Ib56EelnTpqbo28Lvo2Pm2U-CHnMXDqd249b5o5sS1BqtG1CCyFX6tXep0Hmrq0-MRHVsPv2eabqRTL9V0paUpuNT9oGAiB54_U2kM');
