create database Vehicle;

-- create Users Table
CREATE TABLE users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL,
  email VARCHAR(100) NOT NULL UNIQUE,
  phone VARCHAR(20) NOT NULL,
  role VARCHAR(20) NOT NULL
    CHECK (role IN ('Admin', 'Customer'))
);

-- Insert sample data into Users Table
INSERT INTO users (name, email, phone, role) VALUES
('Alice', 'alice@example.com', '01712345678', 'Customer'),
('Bob', 'bob@example.com', '01823456789', 'Admin'),
('Charlie', 'charlie@example.com', '01934567890', 'Customer');

select * from users;

-- create Vehicles Table
CREATE TABLE vehicles (
    vehicle_id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    type VARCHAR(20) check(type in ('car', 'bike', 'truck')) NOT NULL,
    model VARCHAR(20),
    registration_number VARCHAR(20) UNIQUE NOT NULL,
    rental_price INT NOT NULL CHECK (rental_price >= 0),
    status VARCHAR(30) CHECK(status IN ('available', 'rented', 'maintenance')) DEFAULT 'available'
);

-- insert sample data into Vehicles Table
INSERT INTO vehicles (name, type, model, registration_number, rental_price,status) VALUES
('Toyota Corolla', 'car', '2022', 'ABC123', 50, 'available'),
('Honda Civic', 'car', '2021', 'XYZ789', 60, 'rented'),
('Yamaha R15','bike', '2023', 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

select * from vehicles;

-- create Bookings Table
CREATE TABLE bookings (
    booking_id SERIAL PRIMARY KEY,
    user_id INT REFERENCES users (user_id) NOT NULL,
    vehicle_id INT REFERENCES vehicles (vehicle_id) NOT NULL,
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    status VARCHAR(20) NOT NULL CHECK (
        status IN ('pending', 'confirmed', 'completed', 'cancelled')),
    total_cost INT NOT NULL CHECK (total_cost >= 0)
);

drop table bookings;

-- insert sample data into Bookings Table
INSERT INTO bookings (user_id, vehicle_id, start_date, end_date, status, total_cost)
VALUES
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

select * from bookings;







