-- Airbnb Database Schema (DDL)
-- This script creates the complete database schema for the Airbnb clone project
-- Author: ALX Student
-- Date: 2024

-- Drop database if exists and create new one
DROP DATABASE IF EXISTS airbnb_db;
CREATE DATABASE airbnb_db;
USE airbnb_db;

-- Drop tables if they exist (in reverse dependency order)
DROP TABLE IF EXISTS Message;
DROP TABLE IF EXISTS Review;
DROP TABLE IF EXISTS Payment;
DROP TABLE IF EXISTS Booking;
DROP TABLE IF EXISTS Property;
DROP TABLE IF EXISTS User;
DROP TABLE IF EXISTS UserRole;
DROP TABLE IF EXISTS BookingStatus;
DROP TABLE IF EXISTS PaymentMethod;
DROP TABLE IF EXISTS Location;

-- Create lookup tables for normalization (eliminating ENUMs and potential redundancies)

-- UserRole lookup table (normalizes role enum)
CREATE TABLE UserRole (
    role_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    role_name VARCHAR(20) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- BookingStatus lookup table (normalizes status enum)
CREATE TABLE BookingStatus (
    status_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    status_name VARCHAR(20) UNIQUE NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- PaymentMethod lookup table (normalizes payment_method enum)
CREATE TABLE PaymentMethod (
    method_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    method_name VARCHAR(20) UNIQUE NOT NULL,
    description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Location table (normalizes location data to avoid redundancy)
CREATE TABLE Location (
    location_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(100) NOT NULL,
    state VARCHAR(50) NOT NULL,
    country VARCHAR(50) NOT NULL,
    postal_code VARCHAR(20),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    UNIQUE KEY unique_location (city, state, country, postal_code)
);

-- Create User table (normalized)
CREATE TABLE User (
    user_id UUID PRIMARY KEY DEFAULT (UUID()),
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    phone_number VARCHAR(20) NULL,
    role_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (role_id) REFERENCES UserRole(role_id),
    INDEX idx_email (email),
    INDEX idx_role_id (role_id)
);

-- Create Property table (normalized)
CREATE TABLE Property (
    property_id UUID PRIMARY KEY DEFAULT (UUID()),
    host_id UUID NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    location_id INTEGER NOT NULL,
    pricepernight DECIMAL(10,2) NOT NULL,
    max_guests INTEGER NOT NULL DEFAULT 1,
    bedrooms INTEGER NOT NULL DEFAULT 1,
    bathrooms INTEGER NOT NULL DEFAULT 1,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (host_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (location_id) REFERENCES Location(location_id),
    INDEX idx_property_id (property_id),
    INDEX idx_host_id (host_id),
    INDEX idx_location_id (location_id),
    INDEX idx_is_active (is_active)
);

-- Create Booking table (normalized)
CREATE TABLE Booking (
    booking_id UUID PRIMARY KEY DEFAULT (UUID()),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    total_price DECIMAL(10,2) NOT NULL,
    status_id INTEGER NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (status_id) REFERENCES BookingStatus(status_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_status_id (status_id),
    INDEX idx_dates (start_date, end_date),
    CONSTRAINT chk_dates CHECK (end_date > start_date)
);

-- Create Payment table (normalized)
CREATE TABLE Payment (
    payment_id UUID PRIMARY KEY DEFAULT (UUID()),
    booking_id UUID NOT NULL,
    amount DECIMAL(10,2) NOT NULL,
    payment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    method_id INTEGER NOT NULL,
    transaction_id VARCHAR(100) NULL,
    status ENUM('pending', 'completed', 'failed', 'refunded') DEFAULT 'pending',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    FOREIGN KEY (method_id) REFERENCES PaymentMethod(method_id),
    INDEX idx_payment_id (payment_id),
    INDEX idx_booking_id (booking_id),
    INDEX idx_method_id (method_id),
    INDEX idx_status (status)
);

-- Create Review table (normalized)
CREATE TABLE Review (
    review_id UUID PRIMARY KEY DEFAULT (UUID()),
    property_id UUID NOT NULL,
    user_id UUID NOT NULL,
    booking_id UUID NOT NULL, -- Ensures review is from actual booking
    rating INTEGER NOT NULL,
    comment TEXT NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (property_id) REFERENCES Property(property_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (booking_id) REFERENCES Booking(booking_id) ON DELETE CASCADE,
    INDEX idx_review_id (review_id),
    INDEX idx_property_id (property_id),
    INDEX idx_user_id (user_id),
    INDEX idx_booking_id (booking_id),
    CONSTRAINT chk_rating CHECK (rating >= 1 AND rating <= 5),
    UNIQUE KEY unique_booking_review (booking_id) -- One review per booking
);

-- Create Message table (normalized)
CREATE TABLE Message (
    message_id UUID PRIMARY KEY DEFAULT (UUID()),
    sender_id UUID NOT NULL,
    recipient_id UUID NOT NULL,
    message_body TEXT NOT NULL,
    is_read BOOLEAN DEFAULT FALSE,
    sent_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (sender_id) REFERENCES User(user_id) ON DELETE CASCADE,
    FOREIGN KEY (recipient_id) REFERENCES User(user_id) ON DELETE CASCADE,
    INDEX idx_message_id (message_id),
    INDEX idx_sender_id (sender_id),
    INDEX idx_recipient_id (recipient_id),
    INDEX idx_sent_at (sent_at),
    INDEX idx_is_read (is_read)
);

-- Additional composite indexes for better query performance
CREATE INDEX idx_user_name ON User(first_name, last_name);
CREATE INDEX idx_booking_status_dates ON Booking(status_id, start_date, end_date);
CREATE INDEX idx_payment_method_date ON Payment(method_id, payment_date);
CREATE INDEX idx_review_rating ON Review(rating);
CREATE INDEX idx_message_conversation ON Message(sender_id, recipient_id, sent_at);
CREATE INDEX idx_location_city_state ON Location(city, state);

-- Display table information
SELECT 'Airbnb database schema created successfully!' as status; 