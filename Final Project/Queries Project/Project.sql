USE master
GO;

IF EXISTS (SELECT name FROM sys.databases
		   WHERE name = 'DBI202_SU23_PROJECT_G4')
	DROP DATABASE DBI202_SU23_PROJECT_G4
GO;

CREATE DATABASE DBI202_SU23_PROJECT_G4
GO;

USE DBI202_SU23_PROJECT_G4
GO;


-- CREATE TABLE

-- Create a new table Hotel
CREATE TABLE Hotel (
  hotel_id NVARCHAR(10) NOT NULL,
  hotel_name NVARCHAR(255) NOT NULL,
  [address] NVARCHAR(255) NOT NULL,
  phone DECIMAL(10,0) NULL,
  email NVARCHAR(255) NULL

  CONSTRAINT PK_Hotel PRIMARY KEY CLUSTERED
  (
	hotel_id ASC
  )	
);
GO

-- Create a new table Employee
CREATE TABLE Employee (
  employee_SSN DECIMAL(10,0) NOT NULL,
  employee_name NVARCHAR(255) NOT NULL,
  [role] NVARCHAR(50),
  sex BIT,
  phone DECIMAL(10,0),
  salary DECIMAL(10,0),
  DOB DATE,
  supervisor_SSN DECIMAL(10,0),
  hotel_id NVARCHAR(10)

  CONSTRAINT PK_Employee PRIMARY KEY (employee_SSN),
  CONSTRAINT FK_Employee FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id)
);
GO;

-- Create a new table RoomType
CREATE TABLE RoomType (
  room_type NVARCHAR(20) NOT NULL,
  Descriptions NVARCHAR(255) NULL,
  price DECIMAL(10, 2) NULL

  CONSTRAINT PK_RoomT PRIMARY KEY CLUSTERED 
  (
	room_type ASC
  )
);
Go

-- Create a new table Room
CREATE TABLE Room (
  room_id NVARCHAR(10) NOT NULL,
  hotel_id NVARCHAR(10) NOT NULL,
  room_type NVARCHAR(20) NOT NULL,
  [status] NVARCHAR(20) NULL,
  
  CONSTRAINT PK_Room PRIMARY KEY CLUSTERED
  (
	room_id ASC
  ),
  CONSTRAINT FK_Room FOREIGN KEY (hotel_id) REFERENCES Hotel(hotel_id),
  CONSTRAINT FK_Room_1 FOREIGN KEY (room_type) REFERENCES RoomType(room_type)
);
Go;

-- Create a new table Guest
CREATE TABLE Guest (
  guest_SSN DECIMAL(10,0) NOT NULL,
  guest_name NVARCHAR(255) NOT NULL,
  phone NVARCHAR(20) NULL,
  sex BIT NULL,
  email NVARCHAR(255) NULL,
  country NVARCHAR(255) NULL

  CONSTRAINT PK_Guest PRIMARY KEY (guest_SSN)
);
GO;

-- Create a new table Booking
CREATE TABLE Booking (
  booking_id NVARCHAR(36) NOT NULL,
  guest_SSN DECIMAL(10,0) NOT NULL,
  room_id NVARCHAR(10) NOT NULL,
  check_in_date DATE NULL,
  check_out_date DATE NULL,
  booking_date DATE NULL,

  CONSTRAINT PK_Booking PRIMARY KEY CLUSTERED
  (
	booking_id ASC
  ),
  CONSTRAINT FK_Booking FOREIGN KEY (guest_SSN) REFERENCES Guest(guest_SSN),
  CONSTRAINT FK_Booking_1 FOREIGN KEY (room_id) REFERENCES Room(room_id)
);
GO;

-- Create a new table Bill
CREATE TABLE Bill (
  bill_id NVARCHAR(36) NOT NULL,
  guest_SSN DECIMAL(10,0) NOT NULL,
  total_amount DECIMAL(10, 1) NULL,
  payment_status NVARCHAR(20) NULL,
  payment_date DATE NULL
  
  CONSTRAINT PK_Bill PRIMARY KEY CLUSTERED
  (
	bill_id ASC
  ),
  CONSTRAINT FK_Bill FOREIGN KEY (guest_SSN) REFERENCES Guest(guest_SSN)
);
GO;

-- INSERT DATA INTO THE TABLES

-- Insert data into the Hotel table
INSERT INTO Hotel (hotel_id, hotel_name, [address], phone, email)
VALUES ('H001', 'Hotel ABC', '123 Main Street', 1234567890, 'hotelabc@example.com');
GO;

-- Insert data into the Employee table
INSERT INTO Employee (employee_SSN, employee_name, [role], sex, phone, salary, DOB, supervisor_SSN, hotel_id)
VALUES
(1234567892, 'David Beckham', 'Manager', 1, 9876543210, 5000.00, '1990-05-02', NULL, 'H001'),
(1234567890, 'John Doe', 'Manager', 1, 9876543210, 5000.00, '1990-01-01', NULL, 'H001'),
(2345678901, 'Jane Smith', 'Receptionist', 0, 8765432109, 3000.00, '1995-02-15', 1234567890, 'H001'),
(3456789012, 'David Johnson', 'Housekeeping', 1, 7654321098, 2500.00, '1992-07-10', 1234567890, 'H001'),
(4567890123, 'Emily Wilson', 'Concierge', 0, 6543210987, 3500.00, '1993-09-20', 1234567892, 'H001'),
(5678901234, 'Michael Brown', 'Security', 1, 5432109876, 2800.00, '1988-04-05', 1234567892, 'H001');
GO;

-- Insert data into the RoomType table
INSERT INTO RoomType (room_type, Descriptions, price)
VALUES
('Standard', 'Standard room with basic amenities', 100.00),
('Deluxe', 'Spacious room with additional amenities', 150.00),
('Suite', 'Luxurious suite with separate living area', 200.00);
GO;

-- Insert data into the Room table
INSERT INTO Room (room_id, hotel_id, room_type, [status])
VALUES
('R001', 'H001', 'Standard', 'Available'),
('R002', 'H001', 'Standard', 'Occupied'),
('R003', 'H001', 'Deluxe', 'Available'),
('R004', 'H001', 'Deluxe', 'Available'),
('R005', 'H001', 'Suite', 'Reserved');
GO;

-- Insert data into the Guest table
INSERT INTO Guest (guest_SSN, guest_name, phone, sex, email, country)
VALUES
(1234567890, 'John Doe', '123-456-7890', 1, 'john.doe@example.com', 'USA'),
(9876543210, 'Jane Smith', '987-654-3210', 0, 'jane.smith@example.com', 'UK'),
(5555555555, 'Alice Johnson', NULL, 0, 'alice.johnson@example.com', 'Canada'),
(1111111111, 'Bob Anderson', '111-111-1111', 1, NULL, 'Australia'),
(9999999999, 'Eve Davis', NULL, 0, NULL, 'Germany');
GO;

-- Insert data into the Booking table
INSERT INTO Booking (booking_id, guest_SSN, room_id, check_in_date, check_out_date, booking_date)
VALUES
('B001', 1234567890, 'R001', '2023-07-19', '2023-07-22', '2023-07-18'),
('B002', 9876543210, 'R002', '2023-07-20', '2023-07-25', '2023-07-18'),
('B003', 5555555555, 'R003', '2023-07-21', '2023-07-24', '2023-07-19'),
('B004', 1111111111, 'R004', '2023-07-23', '2023-07-25', '2023-07-20'),
('B005', 9999999999, 'R005', '2023-07-25', '2023-07-28', '2023-07-21');
GO;

-- Insert data into the Bill table
INSERT INTO Bill (bill_id, guest_SSN, total_amount, payment_status, payment_date)
VALUES
('BL001', 1234567890, 300.0, 'Paid', '2023-07-18'),
('BL002', 9876543210, 500.0, 'Pending', NULL),
('BL003', 5555555555, 400.0, 'Paid', '2023-07-19'),
('BL004', 1111111111, 200.0, 'Paid', '2023-07-20'),
('BL005', 9999999999, 350.0, 'Pending', NULL);
GO;

-- Check data of the tables
SELECT * FROM Bill
SELECT * FROM Booking
SELECT * FROM Employee
SELECT * FROM Guest
SELECT * FROM Hotel
SELECT * FROM Room
SELECT * FROM RoomType
GO;


-- QUERIES

-- 1. Display supervisor of Employee whose name "David Johnson".
SELECT * 
FROM Employee e
WHERE e.employee_SSN = (SELECT supervisor_SSN 
					    FROM Employee
						WHERE employee_name = 'David Johnson')
GO;

-- 2. Display all room are available.
SELECT * 
FROM Room r
WHERE r.status = 'Available'
GO;

-- 3. Display all guest who have paid the bill.
SELECT g.guest_SSN [Guest SSN], g.guest_name [Name], g.phone [Phone Number], g.country [Country]
FROM Guest g
JOIN Booking b ON g.guest_SSN = b.guest_SSN
JOIN Bill bl ON b.booking_id = bl.booking_id
WHERE bl.payment_status = 'Paid'
GO;

-- 4. Write a procedure that add a new employee into Employee table.
CREATE PROCEDURE addEmp
(
@SSN DECIMAL(10,0),
@name NVARCHAR(255),
@role NVARCHAR(50),
@sex BIT,
@phone DECIMAL(10,0),
@salary DECIMAL(10,0),
@DOB DATE,
@supervisor_SSN DECIMAL(10,0),
@hotel_id NVARCHAR(10)
)
AS
BEGIN 
	IF EXISTS (SELECT 1 
			   FROM Employee e
			   WHERE e.employee_SSN = @SSN)
		BEGIN 
			PRINT 'Employee already exist.'
		END
	ELSE 
		BEGIN 
			INSERT INTO Employee VALUES(@SSN, @name, @role, @sex, @phone, @salary, @DOB, @supervisor_SSN, @hotel_id)
			PRINT 'Add succesfully.'
		END
END
GO;

EXEC addEmp 1234567897, 'David Beckhum', 'Security', 1, 9876543219, 3000.00, '1990-09-02', 1234567890, 'H001'
GO;

-- 5. Write a function that display a bill of a guest by name.
CREATE FUNCTION DisBill
(
@name NVARCHAR(255)
)
RETURNS TABLE
AS
RETURN 
	(SELECT bl.bill_id [Bill ID], bl.total_amount [Price], bl.payment_status [Status], bl.payment_date [Payment Date]
	 FROM Bill bl
	 JOIN Booking b ON bl.booking_id = b.booking_id
	 JOIN Guest g ON b.guest_SSN = g.guest_SSN
	 WHERE g.guest_name = @name)
GO;

SELECT [Bill ID], [Price], [Status], [Payment Date]
FROM DisBill('Jane Doe')
GO;





