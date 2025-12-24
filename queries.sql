create database Vehicle;

-- create Users Table
create table
  users (
    user_id serial primary key,
    name varchar(50) not null,
    email varchar(100) not null unique,
    phone varchar(20) not null,
    role varchar(20) not null check (role in ('Admin', 'Customer'))
  );

-- Insert sample data into Users Table
insert into users (name, email, phone, role) values
('Alice', 'alice@example.com', '01712345678', 'Customer'),
('Bob', 'bob@example.com', '01823456789', 'Admin'),
('Charlie', 'charlie@example.com', '01934567890', 'Customer');

select * from users;

-- create Vehicles Table
create table
  vehicles (
    vehicle_id serial primary key,
    name varchar(50) not null,
    type varchar(20) check (type in ('car', 'bike', 'truck')) not null,
    model varchar(20),
    registration_number varchar(20) unique not null,
    rental_price int not null check (rental_price >= 0),
    status varchar(30) check (status in ('available', 'rented', 'maintenance')) default 'available'
  );

-- insert sample data into Vehicles Table
insert into vehicles (name, type, model, registration_number, rental_price,status) values
('Toyota Corolla', 'car', '2022', 'ABC123', 50, 'available'),
('Honda Civic', 'car', '2021', 'XYZ789', 60, 'rented'),
('Yamaha R15','bike', '2023', 'GHI-789', 30, 'available'),
('Ford F-150', 'truck', '2020', 'JKL-012', 100, 'maintenance');

select * from vehicles;

-- create Bookings Table
create table
  bookings (
    booking_id serial primary key,
    user_id int references users (user_id) not null,
    vehicle_id int references vehicles (vehicle_id) not null,
    start_date date not null,
    end_date date not null,
    status varchar(20) not null check (
      status in ('pending', 'confirmed', 'completed', 'cancelled')
    ),
    total_cost int not null check (total_cost >= 0)
  );

-- drop table bookings;

-- insert sample data into Bookings Table
insert into bookings (user_id, vehicle_id, start_date, end_date, status, total_cost)
values
(1, 2, '2023-10-01', '2023-10-05', 'completed', 240),
(1, 2, '2023-11-01', '2023-11-03', 'completed', 120),
(3, 2, '2023-12-01', '2023-12-02', 'confirmed', 60),
(1, 1, '2023-12-10', '2023-12-12', 'pending', 100);

select * from bookings;

-- Retrieve booking information along with Customer name and Vehicle name.
select
  b.booking_id,
  u.name as customer_name,
  v.name as vehicle_name,
  b.start_date,
  b.end_date,
  b.status
from
  bookings as b
  join users as u on b.user_id = u.user_id
  join vehicles as v on b.vehicle_id = v.vehicle_id;

-- Retrieve all vehicles that are currently not booked.
  select 
    v.vehicle_id,
    v.name,
    v.type,
    v.model,
    v.registration_number,
    v.rental_price,
    v.status
from vehicles v
where not exists (
    select 1
    from bookings b
    where b.vehicle_id = v.vehicle_id
);