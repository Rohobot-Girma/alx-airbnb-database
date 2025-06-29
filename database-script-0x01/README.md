# Database Schema (DDL) - Airbnb Clone

## Overview
This directory contains the Database Definition Language (DDL) scripts for the Airbnb clone project. The schema is designed following normalization principles to achieve Third Normal Form (3NF).

## Files

### `schema.sql`
The main database schema file containing all CREATE TABLE statements, constraints, and indexes.

## Database Structure

### Core Tables (6)
1. **User** - User accounts and profiles
2. **Property** - Rental properties listed by hosts
3. **Booking** - Property reservations made by guests
4. **Payment** - Payment transactions for bookings
5. **Review** - Guest reviews for properties
6. **Message** - Communication between users

### Lookup Tables (4)
1. **UserRole** - User roles (guest, host, admin)
2. **BookingStatus** - Booking statuses (pending, confirmed, canceled)
3. **PaymentMethod** - Payment methods (credit_card, paypal, stripe)
4. **Location** - Property locations (city, state, country)

## Schema Features

### Data Types
- **UUID** for primary keys (globally unique identifiers)
- **VARCHAR** for variable-length strings
- **TEXT** for long text content
- **DECIMAL** for monetary values
- **DATE/TIMESTAMP** for temporal data
- **BOOLEAN** for true/false values
- **INTEGER** for numeric IDs and counts

### Constraints
- **Primary Keys**: UUID with auto-generation
- **Foreign Keys**: Referential integrity with CASCADE deletes
- **Unique Constraints**: Email uniqueness, location uniqueness
- **Check Constraints**: Rating validation (1-5), date validation
- **NOT NULL**: Required fields enforcement

### Indexes
- **Primary Key Indexes**: Automatic on all primary keys
- **Foreign Key Indexes**: For join performance
- **Unique Indexes**: Email, location combinations
- **Composite Indexes**: For common query patterns
- **Single Column Indexes**: For frequently searched fields

## Normalization

The schema follows Third Normal Form (3NF) principles:

### 1NF Compliance
- All attributes contain atomic values
- No repeating groups or arrays
- Primary keys properly defined

### 2NF Compliance
- All tables have single-column primary keys
- No partial dependencies on composite keys
- All non-key attributes fully dependent on primary keys

### 3NF Compliance
- No transitive dependencies
- ENUM types replaced with lookup tables
- Location data normalized to eliminate redundancy
- Review validation enhanced with booking references

## Usage

### Prerequisites
- MySQL 8.0+ or MariaDB 10.5+
- Database user with CREATE privileges

### Installation
```bash
# Connect to MySQL
mysql -u username -p

# Run the schema script
source database-script-0x01/schema.sql
```

### Verification
After running the schema, verify the tables were created:
```sql
USE airbnb_db;
SHOW TABLES;
DESCRIBE User;
DESCRIBE Property;
-- etc.
```

## Table Relationships

### Entity Relationship Diagram
```
User (1) ←→ (N) Property
User (1) ←→ (N) Booking
User (1) ←→ (N) Review
User (1) ←→ (N) Message
Property (1) ←→ (N) Booking
Property (1) ←→ (N) Review
Booking (1) ←→ (N) Payment
Booking (1) ←→ (1) Review
```

### Key Relationships
- **User → Property**: One user can host many properties
- **Property → Booking**: One property can have many bookings
- **Booking → Payment**: One booking can have multiple payments
- **User → Review**: One user can write many reviews
- **User ↔ User**: Users can send/receive messages

## Performance Considerations

### Indexing Strategy
- Primary keys automatically indexed
- Foreign keys indexed for join performance
- Composite indexes for common query patterns
- Unique indexes for data integrity

### Query Optimization
The schema includes indexes optimized for:
- User authentication (email)
- Property searches (location, active status)
- Booking queries (dates, status)
- Payment tracking (method, date)
- Review analysis (rating, property)

## Security Features

### Data Protection
- Password hashing support
- UUID primary keys (non-sequential)
- Input validation constraints
- Referential integrity enforcement

### Access Control
- Role-based user system
- Soft delete capabilities
- Audit trail timestamps
- Transaction tracking

## Maintenance

### Backup
```bash
mysqldump -u username -p airbnb_db > backup.sql
```

### Schema Updates
For schema modifications, create migration scripts:
```sql
-- Example migration
ALTER TABLE User ADD COLUMN profile_picture VARCHAR(255);
```

## Troubleshooting

### Common Issues
1. **UUID Function**: Ensure MySQL version supports UUID() function
2. **Foreign Key Errors**: Check that referenced tables exist
3. **Index Creation**: Verify sufficient disk space for indexes
4. **Character Set**: Ensure UTF-8 character set for international support

### Error Resolution
```sql
-- Check table status
SHOW TABLE STATUS;

-- Verify foreign keys
SELECT * FROM information_schema.KEY_COLUMN_USAGE 
WHERE TABLE_SCHEMA = 'airbnb_db';

-- Check indexes
SHOW INDEX FROM User;
```

## Next Steps

After creating the schema:
1. Populate with sample data (see `database-script-0x02`)
2. Test all relationships and constraints
3. Verify query performance
4. Implement application layer integration

## Author
ALX Student - Database Design Project 