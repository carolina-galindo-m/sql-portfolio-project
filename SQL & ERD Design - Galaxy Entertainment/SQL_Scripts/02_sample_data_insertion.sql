-- Insert sample data into ARTISTS
INSERT INTO ARTISTS (artist_id, artist_f_name, artist_l_name, artist_dob, artist_nationality, artist_debut, artist_status) VALUES
('A001', 'John', 'Doe', '1990-05-15', 'American', '2010-06-01', 'active'),
('A002', 'Jane', 'Smith', '1985-12-23', 'British', '2008-03-15', 'active'),
('A003', 'Carlos', 'Gomez', '1993-07-09', 'Spanish', '2012-09-20', 'active'),
('A004', 'Akira', 'Tanaka', '1992-01-18', 'Japanese', '2011-11-25', 'inactive'),
('A005', 'Lina', 'Khan', '1995-04-28', 'Indian', '2015-08-17', 'active'),
('A006', 'Emily', 'Johnson', '1988-10-10', 'Canadian', '2009-05-12', 'active'),
('A007', 'Marcus', 'Lee', '1991-03-22', 'Australian', '2010-10-30', 'active'),
('A008', 'Sophia', 'Brown', '1994-08-19', 'French', '2013-07-11', 'inactive'),
('A009', 'Noah', 'Miller', '1990-02-25', 'German', '2009-12-05', 'retired'),
('A010', 'Zara', 'Ali', '1996-06-15', 'Pakistani', '2016-04-09', 'active');


-- Insert sample data into TRAININGS
INSERT INTO TRAININGS (training_id, training_name, training_professor, training_duration, training_area, training_cost, success_rate) VALUES
('T001', 'Vocal Training', 'Dr. Hill', 12, 'Music', 5000.00, 85.50),
('T002', 'Stage Presence', 'Prof. Collins', 8, 'Performance', 3500.00, 78.25),
('T003', 'Dance Choreography', 'Ms. Rivera', 16, 'Dance', 7200.00, 92.00),
('T004', 'Media Relations', 'Dr. Nguyen', 6, 'Communication', 2800.00, 65.75),
('T005', 'Song Writing', 'Mr. Davis', 10, 'Music', 4200.00, 88.90),
('T006', 'Acting Workshop', 'Ms. Taylor', 8, 'Acting', 3800.00, 72.40),
('T007', 'Instrument Mastery', 'Dr. Lewis', 20, 'Music', 8500.00, 91.25),
('T008', 'Fitness Training', 'Prof. Kim', 12, 'Health', 4200.00, 68.90),
('T009', 'Social Media', 'Mr. Patel', 6, 'Marketing', 2200.00, 79.60),
('T010', 'Language Course', 'Ms. Clark', 16, 'Language', 5800.00, 84.75);


-- Insert sample data into CONTENTS
INSERT INTO CONTENTS (content_id, content_title, content_type, content_release, production_cost, stream_count, revenue_generated, artist_id) VALUES
('C001', 'Summer Nights', 'Music Video', '2023-06-15', 25000.00, 2500000, 75000.00, 'A001'),
('C002', 'Winter Symphony', 'Album', '2023-11-20', 18000.00, 1800000, 65000.00, 'A002'),
('C003', 'Dance Revolution', 'Single', '2023-08-10', 12000.00, 3200000, 98000.00, 'A003'),
('C004', 'Tokyo Lights', 'EP', '2023-03-05', 15000.00, 1200000, 42000.00, 'A004'),
('C005', 'Bollywood Beat', 'Music Video', '2023-09-12', 28000.00, 4500000, 125000.00, 'A005'),
('C006', 'Urban Legends', 'Album', '2023-04-18', 22000.00, 2800000, 82000.00, 'A006'),
('C007', 'Ocean Waves', 'Single', '2023-07-22', 14000.00, 1900000, 58000.00, 'A007'),
('C008', 'Paris Nights', 'EP', '2023-02-14', 16000.00, 1500000, 48000.00, 'A008'),
('C009', 'Berlin Beats', 'Music Video', '2023-10-05', 32000.00, 3800000, 112000.00, 'A009'),
('C010', 'Desert Rose', 'Single', '2023-12-01', 18000.00, 2600000, 76000.00, 'A010');


-- Insert sample data into MARKETS
INSERT INTO MARKETS (market_id, market_region, market_language, market_population, market_country) VALUES
('M001', 'North America', 'English', 350000000, 'USA'),
('M002', 'Europe', 'English', 67000000, 'UK'),
('M003', 'Asia', 'Hindi', 1380000000, 'India'),
('M004', 'East Asia', 'Japanese', 125000000, 'Japan'),
('M005', 'Europe', 'Spanish', 47000000, 'Spain'),
('C006', 'Urban Legends', 'Album', '2023-04-18', 22000.00, 2800000, 82000.00, 'A006'),
('C007', 'Ocean Waves', 'Single', '2023-07-22', 14000.00, 1900000, 58000.00, 'A007'),
('C008', 'Paris Nights', 'EP', '2023-02-14', 16000.00, 1500000, 48000.00, 'A008'),
('C009', 'Berlin Beats', 'Music Video', '2023-10-05', 32000.00, 3800000, 112000.00, 'A009'),
('C010', 'Desert Rose', 'Single', '2023-12-01', 18000.00, 2600000, 76000.00, 'A010');


-- Insert sample data into EVENTS
INSERT INTO EVENTS (event_id, event_name, event_type, event_date, event_location, event_status) VALUES
('EV001', 'Summer Fest 2023', 'Concert', '2023-07-15', 'Los Angeles', 'completed'),
('EV002', 'Music Awards', 'Award Show', '2023-09-20', 'London', 'completed'),
('EV003', 'Asian Tour', 'Concert', '2023-11-05', 'Tokyo', 'scheduled'),
('EV004', 'Fan Meeting', 'Meet & Greet', '2023-12-10', 'Mumbai', 'scheduled'),
('EV005', 'Charity Gala', 'Fundraiser', '2023-10-15', 'Madrid', 'completed'),
('EV006', 'Winter Concert', 'Concert', '2023-12-20', 'Toronto', 'scheduled'),
('EV007', 'Fan Appreciation', 'Meet & Greet', '2023-11-30', 'Sydney', 'scheduled'),
('EV008', 'Music Festival', 'Festival', '2023-08-25', 'Rio de Janeiro', 'completed'),
('EV009', 'Album Launch', 'Launch Event', '2023-10-08', 'Seoul', 'completed'),
('EV010', 'Charity Concert', 'Fundraiser', '2023-09-18', 'Dubai', 'completed');


-- Insert sample data into FANS
INSERT INTO FANS (fan_id, artist_id, fan_email, fan_country, fan_region, fan_age, fan_engagement_score, fan_join_date) VALUES
('F001', 'A001', 'fan1@email.com', 'USA', 'North America', 25, 85, '2022-01-15'),
('F002', 'A002', 'fan2@email.com', 'UK', 'Europe', 30, 92, '2021-03-20'),
('F003', 'A003', 'fan3@email.com', 'Spain', 'Europe', 22, 78, '2022-08-10'),
('F004', 'A004', 'fan4@email.com', 'Japan', 'Asia', 28, 65, '2021-11-05'),
('F005', 'A005', 'fan5@email.com', 'India', 'Asia', 24, 88, '2022-05-30'),
('F006', 'A006', 'fan6@email.com', 'Canada', 'North America', 27, 81, '2021-07-12'),
('F007', 'A007', 'fan7@email.com', 'Australia', 'Oceania', 31, 76, '2022-03-25'),
('F008', 'A008', 'fan8@email.com', 'France', 'Europe', 23, 69, '2023-01-08'),
('F009', 'A009', 'fan9@email.com', 'Germany', 'Europe', 29, 94, '2020-11-15'),
('F010', 'A010', 'fan10@email.com', 'Pakistan', 'Asia', 26, 87, '2022-09-20');


-- Insert sample data into MERCH
INSERT INTO MERCH (merch_id, artist_id, merch_type, merch_release, merch_status, merch_available_units) VALUES
('ME001', 'A001', 'T-Shirt', '2023-06-01', 'available', 500),
('ME002', 'A002', 'Poster', '2023-07-15', 'available', 1000),
('ME003', 'A003', 'Album', '2023-08-20', 'available', 800),
('ME004', 'A004', 'Photobook', '2023-05-10', 'discontinued', 0),
('ME005', 'A005', 'Hoodie', '2023-09-05', 'available', 300),
('ME006', 'A006', 'Cap', '2023-07-08', 'available', 400),
('ME007', 'A007', 'Vinyl', '2023-08-25', 'available', 250),
('ME008', 'A008', 'Keychain', '2023-04-12', 'discontinued', 0),
('ME009', 'A009', 'Limited Edition', '2023-11-30', 'available', 150),
('ME010', 'A010', 'Tote Bag', '2023-09-18', 'available', 600);


-- Insert sample data into ENROLLMENTS
INSERT INTO ENROLLMENTS (enrollment_id, artist_id, training_id, enrollment_start_date) VALUES
('E001', 'A001', 'T001', '2023-01-10'),
('E002', 'A002', 'T002', '2023-02-15'),
('E003', 'A003', 'T003', '2023-01-25'),
('E004', 'A004', 'T004', '2023-03-05'),
('E005', 'A005', 'T005', '2023-02-20'),
('E006', 'A006', 'T006', '2023-03-12'),
('E007', 'A007', 'T007', '2023-01-18'),
('E008', 'A008', 'T008', '2023-04-02'),
('E009', 'A009', 'T009', '2023-02-28'),
('E010', 'A010', 'T010', '2023-03-22');


-- Insert sample data into MARKET_TARGETED_CONTENTS
INSERT INTO MARKET_TARGETED_CONTENTS (market_id, content_id) VALUES
('M001', 'C001'),
('M002', 'C002'),
('M003', 'C005'),
('M004', 'C004'),
('M005', 'C003'),
('M006', 'C008'),
('M007', 'C006'),
('M008', 'C007'),
('M009', 'C009'),
('M010', 'C010');


-- Insert sample data into SALES (10 rows)
INSERT INTO SALES (sale_id, artist_id, fan_id, sale_type, sale_date, sale_quantity, sale_unit_price, sale_total_amount, sale_status) VALUES
('S001', 'A001', 'F001', 'merch', '2023-07-20', 2, 25.00, 50.00, 'completed'),
('S002', 'A002', 'F002', 'ticket', '2023-09-25', 1, 75.00, 75.00, 'completed'),
('S003', 'A003', 'F003', 'merch', '2023-08-15', 3, 30.00, 90.00, 'completed'),
('S004', 'A004', 'F004', 'album', '2023-06-10', 1, 15.00, 15.00, 'completed'),
('S005', 'A005', 'F005', 'merch', '2023-10-05', 2, 40.00, 80.00, 'completed'),
('S006', 'A006', 'F006', 'ticket', '2023-11-28', 2, 60.00, 120.00, 'pending'),
('S007', 'A007', 'F007', 'merch', '2023-09-12', 1, 35.00, 35.00, 'completed'),
('S008', 'A008', 'F008', 'album', '2023-05-22', 1, 12.00, 12.00, 'refunded'),
('S009', 'A009', 'F009', 'merch', '2023-12-01', 1, 50.00, 50.00, 'completed'),
('S010', 'A010', 'F010', 'ticket', '2023-10-30', 1, 45.00, 45.00, 'completed');


-- Insert sample data into PARTICIPATIONS (10 rows)
INSERT INTO PARTICIPATIONS (participation_id, artist_id, event_id) VALUES
('P001', 'A001', 'EV001'),
('P002', 'A002', 'EV002'),
('P003', 'A003', 'EV003'),
('P004', 'A004', 'EV004'),
('P005', 'A005', 'EV005'),
('P006', 'A006', 'EV006'),
('P007', 'A007', 'EV007'),
('P008', 'A008', 'EV008'),
('P009', 'A009', 'EV009'),
('P010', 'A010', 'EV010');


-- Insert sample data into MERCH_SALES (10 rows)
INSERT INTO MERCH_SALES (merch_sale_id, merch_id, sale_id, merch_sale_quantity, merch_sale_price) VALUES
('MS001', 'ME001', 'S001', 2, 50.00),
('MS002', 'ME002', 'S003', 3, 90.00),
('MS003', 'ME003', 'S004', 1, 15.00),
('MS004', 'ME005', 'S005', 2, 80.00),
('MS005', 'ME006', 'S007', 1, 35.00),
('MS006', 'ME007', 'S008', 1, 12.00),
('MS007', 'ME009', 'S009', 1, 50.00),
('MS008', 'ME010', 'S003', 1, 30.00),
('MS009', 'ME001', 'S007', 1, 25.00),
('MS010', 'ME005', 'S001', 1, 40.00);


-- Insert sample data into EVENT_SALES (10 rows)
INSERT INTO EVENT_SALES (event_sale_id, event_id, sale_id, event_sale_quantity, event_sale_price) VALUES
('ES001', 'EV001', 'S002', 1, 75.00),
('ES002', 'EV002', 'S006', 2, 120.00),
('ES003', 'EV003', 'S010', 1, 45.00),
('ES004', 'EV004', 'S002', 1, 75.00),
('ES005', 'EV005', 'S006', 1, 60.00),
('ES006', 'EV006', 'S010', 1, 45.00),
('ES007', 'EV007', 'S002', 1, 75.00),
('ES008', 'EV008', 'S006', 2, 120.00),
('ES009', 'EV009', 'S010', 1, 45.00),
('ES010', 'EV010', 'S002', 1, 75.00);


-- Insert sample data into EVENT_ATTENDANCE (10 rows)
INSERT INTO EVENT_ATTENDANCE (attendance_id, fan_id, event_id, ticket_type, attendance_status) VALUES
('AT001', 'F001', 'EV001', 'VIP', 'confirmed'),
('AT002', 'F002', 'EV002', 'Standard', 'confirmed'),
('AT003', 'F003', 'EV003', 'Premium', 'pending'),
('AT004', 'F004', 'EV004', 'Standard', 'confirmed'),
('AT005', 'F005', 'EV005', 'VIP', 'confirmed'),
('AT006', 'F006', 'EV006', 'Standard', 'pending'),
('AT007', 'F007', 'EV007', 'Premium', 'confirmed'),
('AT008', 'F008', 'EV008', 'Standard', 'cancelled'),
('AT009', 'F009', 'EV009', 'VIP', 'confirmed'),
('AT010', 'F010', 'EV010', 'Standard', 'confirmed');


-- Insert sample data into PROMOTIONAL_EVENT (10 rows)
INSERT INTO PROMOTIONAL_EVENT (promo_event_id, event_id, content_id, promo_event_type) VALUES
('PE001', 'EV001', 'C001', 'Album Launch Promotion'),
('PE002', 'EV002', 'C002', 'Award Show Performance'),
('PE003', 'EV003', 'C003', 'Tour Promotion'),
('PE004', 'EV004', 'C004', 'Fan Meeting Content'),
('PE005', 'EV005', 'C005', 'Charity Event Feature'),
('PE006', 'EV006', 'C006', 'Winter Concert Promotion'),
('PE007', 'EV007', 'C007', 'Fan Appreciation Content'),
('PE008', 'EV008', 'C008', 'Festival Performance'),
('PE009', 'EV009', 'C009', 'Album Launch Event'),
('PE010', 'EV010', 'C010', 'Charity Concert Feature');
