-- Airbnb Database Seed Data
-- This script populates the database with realistic sample data
-- Author: ALX Student
-- Date: 2024

USE airbnb_db;

-- Clear existing data (in reverse dependency order)
DELETE FROM Message;
DELETE FROM Review;
DELETE FROM Payment;
DELETE FROM Booking;
DELETE FROM Property;
DELETE FROM User;
DELETE FROM UserRole;
DELETE FROM BookingStatus;
DELETE FROM PaymentMethod;
DELETE FROM Location;

-- Reset auto-increment counters
ALTER TABLE UserRole AUTO_INCREMENT = 1;
ALTER TABLE BookingStatus AUTO_INCREMENT = 1;
ALTER TABLE PaymentMethod AUTO_INCREMENT = 1;
ALTER TABLE Location AUTO_INCREMENT = 1;

-- Insert lookup data

-- UserRole data
INSERT INTO UserRole (role_name, description) VALUES
('guest', 'Regular user who can book properties'),
('host', 'User who can list and manage properties'),
('admin', 'System administrator with full access');

-- BookingStatus data
INSERT INTO BookingStatus (status_name, description) VALUES
('pending', 'Booking request is pending confirmation'),
('confirmed', 'Booking has been confirmed'),
('canceled', 'Booking has been canceled'),
('completed', 'Booking has been completed');

-- PaymentMethod data
INSERT INTO PaymentMethod (method_name, description, is_active) VALUES
('credit_card', 'Credit or debit card payment', TRUE),
('paypal', 'PayPal payment method', TRUE),
('stripe', 'Stripe payment processing', TRUE),
('apple_pay', 'Apple Pay mobile payment', TRUE),
('google_pay', 'Google Pay mobile payment', TRUE);

-- Location data
INSERT INTO Location (city, state, country, postal_code) VALUES
-- United States
('New York', 'NY', 'USA', '10001'),
('Los Angeles', 'CA', 'USA', '90210'),
('Miami Beach', 'FL', 'USA', '33139'),
('San Francisco', 'CA', 'USA', '94102'),
('Chicago', 'IL', 'USA', '60601'),
('Austin', 'TX', 'USA', '73301'),
('Seattle', 'WA', 'USA', '98101'),
('Denver', 'CO', 'USA', '80201'),
('Nashville', 'TN', 'USA', '37201'),
('Portland', 'OR', 'USA', '97201'),
-- International
('London', 'England', 'UK', 'SW1A 1AA'),
('Paris', 'Île-de-France', 'France', '75001'),
('Tokyo', 'Tokyo', 'Japan', '100-0001'),
('Sydney', 'NSW', 'Australia', '2000'),
('Toronto', 'ON', 'Canada', 'M5H 2N2'),
('Amsterdam', 'North Holland', 'Netherlands', '1011'),
('Barcelona', 'Catalonia', 'Spain', '08001'),
('Berlin', 'Berlin', 'Germany', '10115'),
('Rome', 'Lazio', 'Italy', '00100'),
('Dubai', 'Dubai', 'UAE', '00000');

-- Insert Users
INSERT INTO User (first_name, last_name, email, password_hash, phone_number, role_id) VALUES
-- Hosts
('John', 'Smith', 'john.smith@email.com', '$2y$10$hashed_password_1', '+1-555-0101', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('Sarah', 'Johnson', 'sarah.johnson@email.com', '$2y$10$hashed_password_2', '+1-555-0102', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('Michael', 'Brown', 'michael.brown@email.com', '$2y$10$hashed_password_3', '+1-555-0103', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('Emily', 'Davis', 'emily.davis@email.com', '$2y$10$hashed_password_4', '+1-555-0104', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('David', 'Wilson', 'david.wilson@email.com', '$2y$10$hashed_password_5', '+1-555-0105', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('Lisa', 'Anderson', 'lisa.anderson@email.com', '$2y$10$hashed_password_6', '+1-555-0106', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('Robert', 'Taylor', 'robert.taylor@email.com', '$2y$10$hashed_password_7', '+1-555-0107', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),
('Jennifer', 'Martinez', 'jennifer.martinez@email.com', '$2y$10$hashed_password_8', '+1-555-0108', 
 (SELECT role_id FROM UserRole WHERE role_name = 'host')),

-- Guests
('Alex', 'Thompson', 'alex.thompson@email.com', '$2y$10$hashed_password_9', '+1-555-0201', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Maria', 'Garcia', 'maria.garcia@email.com', '$2y$10$hashed_password_10', '+1-555-0202', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('James', 'Miller', 'james.miller@email.com', '$2y$10$hashed_password_11', '+1-555-0203', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Sophia', 'Lee', 'sophia.lee@email.com', '$2y$10$hashed_password_12', '+1-555-0204', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Daniel', 'White', 'daniel.white@email.com', '$2y$10$hashed_password_13', '+1-555-0205', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Olivia', 'Clark', 'olivia.clark@email.com', '$2y$10$hashed_password_14', '+1-555-0206', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('William', 'Hall', 'william.hall@email.com', '$2y$10$hashed_password_15', '+1-555-0207', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Emma', 'Young', 'emma.young@email.com', '$2y$10$hashed_password_16', '+1-555-0208', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Christopher', 'King', 'christopher.king@email.com', '$2y$10$hashed_password_17', '+1-555-0209', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),
('Ava', 'Wright', 'ava.wright@email.com', '$2y$10$hashed_password_18', '+1-555-0210', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest')),

-- Admin
('Admin', 'User', 'admin@airbnb.com', '$2y$10$admin_hashed_password', '+1-555-0001', 
 (SELECT role_id FROM UserRole WHERE role_name = 'admin'));

-- Insert Properties
INSERT INTO Property (host_id, name, description, location_id, pricepernight, max_guests, bedrooms, bathrooms) VALUES
-- John's properties
((SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 'Cozy Downtown Loft', 
 'Modern loft in the heart of downtown with city views. Perfect for business travelers or couples seeking a stylish urban retreat.',
 (SELECT location_id FROM Location WHERE city = 'New York' AND state = 'NY'), 
 150.00, 2, 1, 1),

((SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 'Beachfront Paradise', 
 'Stunning beachfront condo with direct ocean access. Private balcony, fully equipped kitchen, and breathtaking sunset views.',
 (SELECT location_id FROM Location WHERE city = 'Miami Beach' AND state = 'FL'), 
 250.00, 4, 2, 2),

-- Sarah's properties
((SELECT user_id FROM User WHERE email = 'sarah.johnson@email.com'), 
 'Hollywood Hills Villa', 
 'Luxurious villa in the Hollywood Hills with panoramic city views, private pool, and celebrity-worthy amenities.',
 (SELECT location_id FROM Location WHERE city = 'Los Angeles' AND state = 'CA'), 
 400.00, 6, 3, 3),

((SELECT user_id FROM User WHERE email = 'sarah.johnson@email.com'), 
 'Tech District Apartment', 
 'Modern apartment in the heart of the tech district. Walking distance to major tech companies and trendy restaurants.',
 (SELECT location_id FROM Location WHERE city = 'San Francisco' AND state = 'CA'), 
 200.00, 3, 1, 1),

-- Michael's properties
((SELECT user_id FROM User WHERE email = 'michael.brown@email.com'), 
 'Mountain Retreat Cabin', 
 'Rustic yet modern cabin in the mountains. Perfect for nature lovers with hiking trails, hot tub, and stunning mountain views.',
 (SELECT location_id FROM Location WHERE city = 'Denver' AND state = 'CO'), 
 180.00, 4, 2, 1),

-- Emily's properties
((SELECT user_id FROM User WHERE email = 'emily.davis@email.com'), 
 'Historic Brownstone', 
 'Beautifully restored historic brownstone with original details, modern amenities, and a private garden.',
 (SELECT location_id FROM Location WHERE city = 'Chicago' AND state = 'IL'), 
 220.00, 5, 2, 2),

-- David's properties
((SELECT user_id FROM User WHERE email = 'david.wilson@email.com'), 
 'Music Row Studio', 
 'Charming studio apartment in the heart of Music Row. Walking distance to live music venues and recording studios.',
 (SELECT location_id FROM Location WHERE city = 'Nashville' AND state = 'TN'), 
 120.00, 2, 1, 1),

-- Lisa's properties
((SELECT user_id FROM User WHERE email = 'lisa.anderson@email.com'), 
 'Portland Eco-Home', 
 'Sustainable eco-friendly home with solar panels, organic garden, and energy-efficient appliances.',
 (SELECT location_id FROM Location WHERE city = 'Portland' AND state = 'OR'), 
 160.00, 4, 2, 2),

-- Robert's properties
((SELECT user_id FROM User WHERE email = 'robert.taylor@email.com'), 
 'Seattle Waterfront Condo', 
 'Luxury waterfront condo with stunning Puget Sound views, private balcony, and access to marina.',
 (SELECT location_id FROM Location WHERE city = 'Seattle' AND state = 'WA'), 
 280.00, 3, 1, 2),

-- Jennifer's properties
((SELECT user_id FROM User WHERE email = 'jennifer.martinez@email.com'), 
 'Austin Tech Hub', 
 'Modern apartment in Austin\'s tech hub. Close to major tech companies, food trucks, and live music venues.',
 (SELECT location_id FROM Location WHERE city = 'Austin' AND state = 'TX'), 
 140.00, 3, 1, 1);

-- Insert Bookings
INSERT INTO Booking (property_id, user_id, start_date, end_date, total_price, status_id) VALUES
-- Confirmed bookings
((SELECT property_id FROM Property WHERE name = 'Cozy Downtown Loft'), 
 (SELECT user_id FROM User WHERE email = 'alex.thompson@email.com'), 
 '2024-01-15', '2024-01-20', 750.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed')),

((SELECT property_id FROM Property WHERE name = 'Beachfront Paradise'), 
 (SELECT user_id FROM User WHERE email = 'maria.garcia@email.com'), 
 '2024-02-01', '2024-02-08', 1750.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed')),

((SELECT property_id FROM Property WHERE name = 'Hollywood Hills Villa'), 
 (SELECT user_id FROM User WHERE email = 'james.miller@email.com'), 
 '2024-01-25', '2024-01-30', 2000.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed')),

((SELECT property_id FROM Property WHERE name = 'Tech District Apartment'), 
 (SELECT user_id FROM User WHERE email = 'sophia.lee@email.com'), 
 '2024-02-10', '2024-02-15', 1000.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed')),

((SELECT property_id FROM Property WHERE name = 'Mountain Retreat Cabin'), 
 (SELECT user_id FROM User WHERE email = 'daniel.white@email.com'), 
 '2024-02-20', '2024-02-25', 900.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed')),

-- Pending bookings
((SELECT property_id FROM Property WHERE name = 'Historic Brownstone'), 
 (SELECT user_id FROM User WHERE email = 'olivia.clark@email.com'), 
 '2024-03-01', '2024-03-05', 880.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'pending')),

((SELECT property_id FROM Property WHERE name = 'Music Row Studio'), 
 (SELECT user_id FROM User WHERE email = 'william.hall@email.com'), 
 '2024-03-10', '2024-03-12', 240.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'pending')),

-- Completed bookings
((SELECT property_id FROM Property WHERE name = 'Portland Eco-Home'), 
 (SELECT user_id FROM User WHERE email = 'emma.young@email.com'), 
 '2023-12-15', '2023-12-20', 800.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'completed')),

((SELECT property_id FROM Property WHERE name = 'Seattle Waterfront Condo'), 
 (SELECT user_id FROM User WHERE email = 'christopher.king@email.com'), 
 '2023-12-01', '2023-12-05', 1120.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'completed')),

-- Canceled bookings
((SELECT property_id FROM Property WHERE name = 'Austin Tech Hub'), 
 (SELECT user_id FROM User WHERE email = 'ava.wright@email.com'), 
 '2024-01-10', '2024-01-15', 700.00, 
 (SELECT status_id FROM BookingStatus WHERE status_name = 'canceled'));

-- Insert Payments
INSERT INTO Payment (booking_id, amount, method_id, transaction_id, status) VALUES
-- Completed payments
((SELECT booking_id FROM Booking WHERE start_date = '2024-01-15'), 750.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'credit_card'), 
 'txn_123456789', 'completed'),

((SELECT booking_id FROM Booking WHERE start_date = '2024-02-01'), 1750.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'paypal'), 
 'txn_987654321', 'completed'),

((SELECT booking_id FROM Booking WHERE start_date = '2024-01-25'), 2000.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'stripe'), 
 'txn_456789123', 'completed'),

((SELECT booking_id FROM Booking WHERE start_date = '2024-02-10'), 1000.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'credit_card'), 
 'txn_789123456', 'completed'),

((SELECT booking_id FROM Booking WHERE start_date = '2024-02-20'), 900.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'apple_pay'), 
 'txn_321654987', 'completed'),

-- Pending payments
((SELECT booking_id FROM Booking WHERE start_date = '2024-03-01'), 880.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'credit_card'), 
 'txn_147258369', 'pending'),

((SELECT booking_id FROM Booking WHERE start_date = '2024-03-10'), 240.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'google_pay'), 
 'txn_963852741', 'pending'),

-- Completed payments for past bookings
((SELECT booking_id FROM Booking WHERE start_date = '2023-12-15'), 800.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'credit_card'), 
 'txn_159357486', 'completed'),

((SELECT booking_id FROM Booking WHERE start_date = '2023-12-01'), 1120.00, 
 (SELECT method_id FROM PaymentMethod WHERE method_name = 'paypal'), 
 'txn_753951852', 'completed');

-- Insert Reviews
INSERT INTO Review (property_id, user_id, booking_id, rating, comment, is_verified) VALUES
-- Reviews for completed bookings
((SELECT property_id FROM Property WHERE name = 'Cozy Downtown Loft'), 
 (SELECT user_id FROM User WHERE email = 'alex.thompson@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2024-01-15'), 
 5, 'Amazing location and the loft was exactly as described. Perfect for our business trip!', TRUE),

((SELECT property_id FROM Property WHERE name = 'Beachfront Paradise'), 
 (SELECT user_id FROM User WHERE email = 'maria.garcia@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2024-02-01'), 
 5, 'Absolutely stunning beachfront property. The views were incredible and the amenities were top-notch.', TRUE),

((SELECT property_id FROM Property WHERE name = 'Hollywood Hills Villa'), 
 (SELECT user_id FROM User WHERE email = 'james.miller@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2024-01-25'), 
 4, 'Beautiful villa with amazing city views. The pool was perfect and the location was great.', TRUE),

((SELECT property_id FROM Property WHERE name = 'Tech District Apartment'), 
 (SELECT user_id FROM User WHERE email = 'sophia.lee@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2024-02-10'), 
 4, 'Great location for tech professionals. Clean, modern apartment with everything we needed.', TRUE),

((SELECT property_id FROM Property WHERE name = 'Mountain Retreat Cabin'), 
 (SELECT user_id FROM User WHERE email = 'daniel.white@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2024-02-20'), 
 5, 'Perfect mountain getaway! The cabin was cozy and the hiking trails were amazing.', TRUE),

-- Reviews for past completed bookings
((SELECT property_id FROM Property WHERE name = 'Portland Eco-Home'), 
 (SELECT user_id FROM User WHERE email = 'emma.young@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2023-12-15'), 
 5, 'Loved the eco-friendly features! The organic garden was beautiful and the home was very comfortable.', TRUE),

((SELECT property_id FROM Property WHERE name = 'Seattle Waterfront Condo'), 
 (SELECT user_id FROM User WHERE email = 'christopher.king@email.com'), 
 (SELECT booking_id FROM Booking WHERE start_date = '2023-12-01'), 
 4, 'Beautiful waterfront location with stunning views. The condo was well-appointed and clean.', TRUE);

-- Insert Messages
INSERT INTO Message (sender_id, recipient_id, message_body, is_read) VALUES
-- Messages between guests and hosts
((SELECT user_id FROM User WHERE email = 'alex.thompson@email.com'), 
 (SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 'Hi! I have a question about check-in time for the downtown loft. Is early check-in available?', FALSE),

((SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 (SELECT user_id FROM User WHERE email = 'alex.thompson@email.com'), 
 'Hi Alex! Yes, early check-in is available from 1 PM. Let me know if you need anything else!', TRUE),

((SELECT user_id FROM User WHERE email = 'maria.garcia@email.com'), 
 (SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 'Hello! Is there parking available at the beachfront property?', FALSE),

((SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 (SELECT user_id FROM User WHERE email = 'maria.garcia@email.com'), 
 'Yes, there\'s a dedicated parking spot included with the rental. You\'ll find it in the garage.', TRUE),

((SELECT user_id FROM User WHERE email = 'james.miller@email.com'), 
 (SELECT user_id FROM User WHERE email = 'sarah.johnson@email.com'), 
 'Hi Sarah! I\'m interested in the Hollywood Hills villa. Are pets allowed?', FALSE),

((SELECT user_id FROM User WHERE email = 'sarah.johnson@email.com'), 
 (SELECT user_id FROM User WHERE email = 'james.miller@email.com'), 
 'Hi James! Unfortunately, pets are not allowed at this property due to HOA restrictions.', TRUE),

((SELECT user_id FROM User WHERE email = 'sophia.lee@email.com'), 
 (SELECT user_id FROM User WHERE email = 'sarah.johnson@email.com'), 
 'Hello! I\'m arriving late at night. What\'s the check-in process for the tech district apartment?', FALSE),

((SELECT user_id FROM User WHERE email = 'sarah.johnson@email.com'), 
 (SELECT user_id FROM User WHERE email = 'sophia.lee@email.com'), 
 'Hi Sophia! We have a keyless entry system. I\'ll send you the access code the day before your arrival.', TRUE),

-- Messages between guests
((SELECT user_id FROM User WHERE email = 'alex.thompson@email.com'), 
 (SELECT user_id FROM User WHERE email = 'maria.garcia@email.com'), 
 'Hey Maria! How was your stay at the beachfront property? I\'m thinking of booking it next month.', FALSE),

((SELECT user_id FROM User WHERE email = 'maria.garcia@email.com'), 
 (SELECT user_id FROM User WHERE email = 'alex.thompson@email.com'), 
 'Hi Alex! It was absolutely amazing! The views are incredible and the property is spotless. Highly recommend!', TRUE);

-- Display summary
SELECT 'Database seeded successfully!' as status;

-- Show data summary
SELECT 
    'UserRole' as table_name, COUNT(*) as record_count FROM UserRole
UNION ALL
SELECT 'BookingStatus', COUNT(*) FROM BookingStatus
UNION ALL
SELECT 'PaymentMethod', COUNT(*) FROM PaymentMethod
UNION ALL
SELECT 'Location', COUNT(*) FROM Location
UNION ALL
SELECT 'User', COUNT(*) FROM User
UNION ALL
SELECT 'Property', COUNT(*) FROM Property
UNION ALL
SELECT 'Booking', COUNT(*) FROM Booking
UNION ALL
SELECT 'Payment', COUNT(*) FROM Payment
UNION ALL
SELECT 'Review', COUNT(*) FROM Review
UNION ALL
SELECT 'Message', COUNT(*) FROM Message; 