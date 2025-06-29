# Database Seed Data - Airbnb Clone

## Overview
This directory contains the seed data scripts for populating the Airbnb clone database with realistic sample data. The data is designed to demonstrate real-world usage scenarios and test all database relationships and constraints.

## Files

### `seed.sql`
The main seed data file containing INSERT statements for all tables with realistic sample data.

## Data Overview

### Sample Data Statistics
- **10 Lookup Records**: User roles, booking statuses, payment methods
- **20 Locations**: Major cities across US and international destinations
- **21 Users**: 8 hosts, 12 guests, 1 admin
- **10 Properties**: Diverse properties across different locations
- **9 Bookings**: Various statuses (confirmed, pending, completed, canceled)
- **8 Payments**: Different payment methods and statuses
- **7 Reviews**: Verified reviews from completed bookings
- **10 Messages**: Communication between users

## Data Structure

### Lookup Tables
1. **UserRole** (3 records)
   - guest, host, admin

2. **BookingStatus** (4 records)
   - pending, confirmed, canceled, completed

3. **PaymentMethod** (5 records)
   - credit_card, paypal, stripe, apple_pay, google_pay

4. **Location** (20 records)
   - 10 US cities + 10 international cities

### Core Data

#### Users (21 records)
- **8 Hosts**: Property owners with diverse listings
- **12 Guests**: Travelers with various booking histories
- **1 Admin**: System administrator

**Sample Hosts:**
- John Smith (2 properties: Downtown Loft, Beachfront Paradise)
- Sarah Johnson (2 properties: Hollywood Hills Villa, Tech District Apartment)
- Michael Brown (1 property: Mountain Retreat Cabin)
- Emily Davis (1 property: Historic Brownstone)
- David Wilson (1 property: Music Row Studio)
- Lisa Anderson (1 property: Portland Eco-Home)
- Robert Taylor (1 property: Seattle Waterfront Condo)
- Jennifer Martinez (1 property: Austin Tech Hub)

#### Properties (10 records)
Diverse property types across different locations:
- **Urban**: Downtown lofts, tech district apartments
- **Luxury**: Hollywood Hills villa, waterfront condos
- **Nature**: Mountain cabins, eco-homes
- **Historic**: Brownstones, music district studios

**Price Range**: $120 - $400 per night
**Capacity**: 2-6 guests
**Locations**: New York, Miami Beach, Los Angeles, San Francisco, Denver, Chicago, Nashville, Portland, Seattle, Austin

#### Bookings (9 records)
Various booking scenarios:
- **Confirmed**: 5 bookings (current and future)
- **Pending**: 2 bookings (awaiting confirmation)
- **Completed**: 2 bookings (past stays)
- **Canceled**: 1 booking

**Date Range**: December 2023 - March 2024
**Total Value**: $8,920 across all bookings

#### Payments (8 records)
Different payment scenarios:
- **Completed**: 6 payments (successful transactions)
- **Pending**: 2 payments (awaiting processing)

**Payment Methods Used:**
- Credit Card: 4 payments
- PayPal: 2 payments
- Stripe: 1 payment
- Apple Pay: 1 payment

#### Reviews (7 records)
Verified reviews from completed bookings:
- **5-Star Reviews**: 4 reviews
- **4-Star Reviews**: 3 reviews
- **All Verified**: True (from actual bookings)

#### Messages (10 records)
Realistic communication scenarios:
- **Guest-Host**: 8 messages (booking inquiries, property questions)
- **Guest-Guest**: 2 messages (recommendations, experiences)

## Data Relationships

### Realistic Scenarios
1. **Multiple Properties per Host**: John Smith and Sarah Johnson each have 2 properties
2. **Booking History**: Various booking statuses show different stages of the booking process
3. **Payment Tracking**: Each booking has corresponding payment records
4. **Review Validation**: All reviews are linked to actual completed bookings
5. **Communication Flow**: Messages between guests and hosts about bookings

### Business Logic Validation
- Reviews only from completed bookings
- Payments linked to valid bookings
- Users have appropriate roles (hosts can list properties, guests can book)
- Location data is consistent and normalized
- Booking dates are logical (end > start)

## Usage

### Prerequisites
- Database schema must be created first (see `database-script-0x01`)
- MySQL/MariaDB connection with write privileges

### Installation
```bash
# Connect to MySQL
mysql -u username -p

# Run the seed script
source database-script-0x02/seed.sql
```

### Verification
After running the seed script, verify the data:
```sql
USE airbnb_db;

-- Check record counts
SELECT 'UserRole' as table_name, COUNT(*) as record_count FROM UserRole
UNION ALL
SELECT 'User', COUNT(*) FROM User
UNION ALL
SELECT 'Property', COUNT(*) FROM Property
UNION ALL
SELECT 'Booking', COUNT(*) FROM Booking;

-- Test relationships
SELECT 
    u.first_name, 
    u.last_name, 
    p.name as property_name,
    b.start_date,
    b.end_date
FROM User u
JOIN Property p ON u.user_id = p.host_id
JOIN Booking b ON p.property_id = b.property_id
LIMIT 5;
```

## Sample Queries

### Popular Properties
```sql
SELECT 
    p.name,
    p.pricepernight,
    COUNT(b.booking_id) as total_bookings,
    AVG(r.rating) as avg_rating
FROM Property p
LEFT JOIN Booking b ON p.property_id = b.property_id
LEFT JOIN Review r ON p.property_id = r.property_id
GROUP BY p.property_id
ORDER BY total_bookings DESC;
```

### Host Performance
```sql
SELECT 
    u.first_name,
    u.last_name,
    COUNT(p.property_id) as properties_owned,
    COUNT(b.booking_id) as total_bookings,
    SUM(b.total_price) as total_revenue
FROM User u
JOIN Property p ON u.user_id = p.host_id
LEFT JOIN Booking b ON p.property_id = b.property_id
WHERE u.role_id = (SELECT role_id FROM UserRole WHERE role_name = 'host')
GROUP BY u.user_id;
```

### Payment Analysis
```sql
SELECT 
    pm.method_name,
    COUNT(p.payment_id) as usage_count,
    SUM(p.amount) as total_amount
FROM PaymentMethod pm
LEFT JOIN Payment p ON pm.method_id = p.method_id
GROUP BY pm.method_id
ORDER BY usage_count DESC;
```

## Data Quality Features

### Realistic Content
- **Names**: Common first and last names
- **Emails**: Valid email format with domain
- **Phone Numbers**: US format phone numbers
- **Descriptions**: Detailed, realistic property descriptions
- **Comments**: Authentic-sounding reviews and messages

### Business Logic
- **Pricing**: Realistic nightly rates based on location and property type
- **Dates**: Logical booking dates and durations
- **Ratings**: Realistic 4-5 star ratings with detailed comments
- **Statuses**: Proper workflow progression (pending → confirmed → completed)

### Data Integrity
- **Foreign Keys**: All relationships properly maintained
- **Constraints**: All business rules enforced
- **Uniqueness**: No duplicate records where required
- **Validation**: All check constraints satisfied

## Customization

### Adding More Data
To add additional sample data:
```sql
-- Add more users
INSERT INTO User (first_name, last_name, email, password_hash, phone_number, role_id) VALUES
('New', 'User', 'new.user@email.com', '$2y$10$hashed_password', '+1-555-0301', 
 (SELECT role_id FROM UserRole WHERE role_name = 'guest'));

-- Add more properties
INSERT INTO Property (host_id, name, description, location_id, pricepernight, max_guests, bedrooms, bathrooms) VALUES
((SELECT user_id FROM User WHERE email = 'john.smith@email.com'), 
 'New Property', 'Description here', 
 (SELECT location_id FROM Location WHERE city = 'New York'), 
 200.00, 3, 1, 1);
```

### Modifying Data
To update existing data:
```sql
-- Update property price
UPDATE Property 
SET pricepernight = 175.00 
WHERE name = 'Cozy Downtown Loft';

-- Change booking status
UPDATE Booking 
SET status_id = (SELECT status_id FROM BookingStatus WHERE status_name = 'confirmed')
WHERE start_date = '2024-03-01';
```

## Troubleshooting

### Common Issues
1. **Foreign Key Errors**: Ensure schema is created before seeding
2. **Duplicate Emails**: Check for unique constraint violations
3. **Invalid Dates**: Verify date format and logic
4. **Missing References**: Ensure all lookup data exists

### Data Validation
```sql
-- Check for orphaned records
SELECT COUNT(*) as orphaned_bookings
FROM Booking b
LEFT JOIN Property p ON b.property_id = p.property_id
WHERE p.property_id IS NULL;

-- Verify review integrity
SELECT COUNT(*) as invalid_reviews
FROM Review r
LEFT JOIN Booking b ON r.booking_id = b.booking_id
WHERE b.booking_id IS NULL;
```

## Next Steps

After seeding the database:
1. Test all application features with the sample data
2. Verify query performance with realistic data volumes
3. Test business logic and constraints
4. Create additional test scenarios as needed

## Author
ALX Student - Database Design Project 