-- Create Database
CREATE DATABASE IF NOT EXISTS galaxy_entertainment;
USE galaxy_entertainment;

-- Table: ARTISTS
CREATE TABLE ARTISTS (
    artist_id VARCHAR(10) PRIMARY KEY,
    artist_f_name VARCHAR(20) NOT NULL,
    artist_l_name VARCHAR(20) NOT NULL,
    artist_dob DATE,
    artist_nationality VARCHAR(20),
    artist_debut DATE,
    artist_status ENUM('active', 'inactive', 'retired')
);

-- Table: TRAININGS
CREATE TABLE TRAININGS (
    training_id VARCHAR(10) PRIMARY KEY,
    training_name VARCHAR(20) NOT NULL,
    training_professor VARCHAR(20),
    training_duration INT,
    training_area VARCHAR(20),
    training_cost DECIMAL(8,2),
    success_rate DECIMAL(5,2)
);

-- Table: CONTENTS
CREATE TABLE CONTENTS (
    content_id VARCHAR(10) PRIMARY KEY,
    content_title VARCHAR(20) NOT NULL,
    content_type VARCHAR(20),
    content_release DATE,
    production_cost DECIMAL(10,2),
    stream_count INT,
    revenue_generated DECIMAL(12,2),
    artist_id VARCHAR(10),
    FOREIGN KEY (artist_id) REFERENCES ARTISTS(artist_id)
);

-- Table: MARKETS
CREATE TABLE MARKETS (
    market_id VARCHAR(10) PRIMARY KEY,
    market_region VARCHAR(20),
    market_language VARCHAR(20),
    market_population INT,
    market_country VARCHAR(20)
);

-- Table: EVENTS
CREATE TABLE EVENTS (
    event_id VARCHAR(10) PRIMARY KEY,
    event_name VARCHAR(20) NOT NULL,
    event_type VARCHAR(20),
    event_date DATE,
    event_location VARCHAR(50),
    event_status ENUM('scheduled', 'cancelled', 'completed')
);

-- Table: FANS
CREATE TABLE FANS (
    fan_id VARCHAR(10) PRIMARY KEY,
    artist_id VARCHAR(10),
    fan_email VARCHAR(50),
    fan_country VARCHAR(20),
    fan_region VARCHAR(20),
    fan_age INT,
    fan_engagement_score INT,
    fan_join_date DATE,
    FOREIGN KEY (artist_id) REFERENCES ARTISTS(artist_id)
);

-- Table: MERCH
CREATE TABLE MERCH (
    merch_id VARCHAR(10) PRIMARY KEY,
    artist_id VARCHAR(10),
    merch_type VARCHAR(20),
    merch_release DATE,
    merch_status ENUM('available', 'discontinued'),
    merch_available_units INT,
    FOREIGN KEY (artist_id) REFERENCES ARTISTS(artist_id)
);

-- Table: SALES
CREATE TABLE SALES (
    sale_id VARCHAR(10) PRIMARY KEY,
    artist_id VARCHAR(10),
    fan_id VARCHAR(10),
    sale_type VARCHAR(20),
    sale_date DATE,
    sale_quantity INT,
    sale_unit_price DECIMAL(8,2),
    sale_total_amount DECIMAL(10,2),
    sale_status ENUM('pending', 'completed', 'refunded'),
    FOREIGN KEY (artist_id) REFERENCES ARTISTS(artist_id),
    FOREIGN KEY (fan_id) REFERENCES FANS(fan_id)
);

-- Associative Table: ENROLLMENTS
CREATE TABLE ENROLLMENTS (
    enrollment_id VARCHAR(10) PRIMARY KEY,
    artist_id VARCHAR(10),
    training_id VARCHAR(10),
    enrollment_start_date DATE,
    FOREIGN KEY (artist_id) REFERENCES ARTISTS(artist_id),
    FOREIGN KEY (training_id) REFERENCES TRAININGS(training_id)
);

-- Associative Table: PARTICIPATIONS
CREATE TABLE PARTICIPATIONS (
    participation_id VARCHAR(10) PRIMARY KEY,
    artist_id VARCHAR(10),
    event_id VARCHAR(10),
    FOREIGN KEY (artist_id) REFERENCES ARTISTS(artist_id),
    FOREIGN KEY (event_id) REFERENCES EVENTS(event_id)
);

-- Associative Table: MARKET_TARGETED_CONTENTS
CREATE TABLE MARKET_TARGETED_CONTENTS (
    market_id VARCHAR(10),
    content_id VARCHAR(10),
    PRIMARY KEY (market_id, content_id),
    FOREIGN KEY (market_id) REFERENCES MARKETS(market_id),
    FOREIGN KEY (content_id) REFERENCES CONTENTS(content_id)
);

-- Associative Table: MERCH_SALES
CREATE TABLE MERCH_SALES (
    merch_sale_id VARCHAR(10) PRIMARY KEY,
    merch_id VARCHAR(10),
    sale_id VARCHAR(10),
    merch_sale_quantity INT,
    merch_sale_price DECIMAL(12,2),
    FOREIGN KEY (merch_id) REFERENCES MERCH(merch_id),
    FOREIGN KEY (sale_id) REFERENCES SALES(sale_id)
);

-- Associative Table: EVENT_SALES
CREATE TABLE EVENT_SALES (
    event_sale_id VARCHAR(10) PRIMARY KEY,
    event_id VARCHAR(10),
    sale_id VARCHAR(10),
    event_sale_quantity INT,
    event_sale_price DECIMAL(12,2),
    FOREIGN KEY (event_id) REFERENCES EVENTS(event_id),
    FOREIGN KEY (sale_id) REFERENCES SALES(sale_id)
);

-- Associative Table: EVENT_ATTENDANCE
CREATE TABLE EVENT_ATTENDANCE (
    attendance_id VARCHAR(10) PRIMARY KEY,
    fan_id VARCHAR(10),
    event_id VARCHAR(10),
    ticket_type VARCHAR(20),
    attendance_status VARCHAR(20),
    FOREIGN KEY (fan_id) REFERENCES FANS(fan_id),
    FOREIGN KEY (event_id) REFERENCES EVENTS(event_id)
);

-- Associative Table: PROMOTIONAL_EVENT
CREATE TABLE PROMOTIONAL_EVENT (
    promo_event_id VARCHAR(10) PRIMARY KEY,
    event_id VARCHAR(10),
    content_id VARCHAR(10),
    promo_event_type VARCHAR(50),
    FOREIGN KEY (event_id) REFERENCES EVENTS(event_id),
    FOREIGN KEY (content_id) REFERENCES CONTENTS(content_id)
);

-- Create indexes for better performance
CREATE INDEX idx_artists_status ON ARTISTS(artist_status);
CREATE INDEX idx_contents_release ON CONTENTS(content_release);
CREATE INDEX idx_events_date ON EVENTS(event_date);
CREATE INDEX idx_fans_engagement ON FANS(fan_engagement_score);
CREATE INDEX idx_sales_date ON SALES(sale_date);
CREATE INDEX idx_merch_status ON MERCH(merch_status);
CREATE INDEX idx_enrollments_start ON ENROLLMENTS(enrollment_start_date);
