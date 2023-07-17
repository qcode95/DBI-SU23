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

CREATE TABLE HOTEL
(
	HotID NVARCHAR(5) NOT NULL,
	HotName NVARCHAR(20) NOT NULL,
	HotAddr NVARCHAR(50) NOT NULL,
	Details NVARCHAR(100) NULL,
	CONSTRAINT PK_HOTEL PRIMARY KEY CLUSTERED
	(
		HotID ASC  
	) 
)
GO;

CREATE TABLE EMPLOYEE
(
	EmpSSN DECIMAL(18,0) NOT NULL,
	Fisrt_Name NVARCHAR(20) NOT NULL,
	Last_Name NVARCHAR(10) NOT NULL,
	HotID NVARCHAR(5) NOT NULL,
	RoleID NVARCHAR(5) NOT NULL,
	Sex BIT NULL,
	Date_of_Birth DATETIME NULL,
	Contact DECIMAL(10,0) NULL,
	Salary DECIMAL (10,0) NULL,
	CONSTRAINT PK_EMPLOYEE PRIMARY KEY (EmpSSN),

	CONSTRAINT CK_EMPLOYEE CHECK(YEAR(Date_of_Birth) < YEAR(GETDATE() - 18)),
	CONSTRAINT FK_EMPLOYEE FOREIGN KEY (HotID) REFERENCES HOTEL(HotID),
	CONSTRAINT FK_EMPLOYEE_1 FOREIGN KEY (RoleID) REFERENCES [ROLE](RoleID),
)
GO;

CREATE TABLE [ROLE]
(
	RoleID NVARCHAR(5) NOT NULL,
	RoleTitle NVARCHAR(10) NULL,

	CONSTRAINT PK_ROLE PRIMARY KEY CLUSTERED
	(
		RoleID ASC
	)
)
GO;

CREATE TABLE ROOMS
(
	RoomID NVARCHAR(5) NOT NULL,
	RoomType NVARCHAR(10) NOT NULL,
	HotID NVARCHAR(5) NOT NULL,
	Occupancy NVARCHAR(10) NULL,

	CONSTRAINT PK_ROOMS PRIMARY KEY CLUSTERED 
	(
		RoomID ASC
	),
	CONSTRAINT FK_ROOMS FOREIGN KEY (HotID) REFERENCES HOTEL(HotID),
	CONSTRAINT FK_ROOMS_1 FOREIGN KEY (RoomType) REFERENCES ROOMTYPE(RoomType)
)
GO;

CREATE TABLE ROOMTYPE
(
	RoomType NVARCHAR(10) NOT NULL,
	RoomPrice DECIMAL(10,0) NULL,
	Decription NVARCHAR(50) NULL,

	CONSTRAINT PK_ROOMTYPE PRIMARY KEY (RoomType)
)
GO;

CREATE TABLE BOOKING
(	
	BookingID NVARCHAR(5) NOT NULL,
	RoomID NVARCHAR(5) NOT NULL,
	HotID NVARCHAR(5) NOT NULL,
	GuestSSN DECIMAL(18,0) NOT NULL,
	BookingDate DATETIME NULL,
	BookingTime DATE NULL,
	ArrivalDate DATETIME NULL,
	ReturnDate DATETIME NULL,
	Number_of_People INT NULL,
	SpecialReq NVARCHAR(50) NULL,

	CONSTRAINT PK_BOOKING PRIMARY KEY CLUSTERED 
	(
		BookingID ASC
	),
	CONSTRAINT FK_BOOKING FOREIGN KEY (HotID) REFERENCES HOTEL(HotID),
	CONSTRAINT FK_BOOKING_1 FOREIGN KEY (RoomID) REFERENCES ROOMS(RoomID), 
)
GO;

CREATE TABLE GUEST
(
	GuestSSN DECIMAL(18,0) NOT NULL,
	BookingID NVARCHAR(5) NOT NULL,
	Fisrt_Name NVARCHAR(20) NOT NULL,
	Last_Name NVARCHAR(10) NOT NULL,
	Sex BIT NULL,
	Date_of_Birth DATETIME NULL,
	Contact DECIMAL(10,0) NULL,
	Country NVARCHAR(10),

	CONSTRAINT PK_GUEST PRIMARY KEY (GuestSSN),
)
GO;

CREATE TABLE BILL
(
	BillID NVARCHAR(5) NOT NULL,
	GuestSSN DECIMAL(18,0) NOT NULL,
	BookingID NVARCHAR(5) NOT NULL,
	RoomCharges INT NULL,
	[Services] NVARCHAR(50) NULL,
	CreditCard DECIMAL(10,0) NULL,
	PaymentMethod NVARCHAR(10) NULL,
	PaymentDate DATETIME NULL,
	ExpiredDate DATETIME NULL,

	CONSTRAINT PK_BILL PRIMARY KEY CLUSTERED
	(
		BillID ASC
	),
)
GO;

ALTER TABLE BOOKING
ADD CONSTRAINT FK_BOOKING_2 FOREIGN KEY (GuestSSN) REFERENCES GUEST(GuestSSN)
GO;

ALTER TABLE GUEST
ADD CONSTRAINT FK_GUEST FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
GO;

ALTER TABLE BILL
ADD CONSTRAINT FK_BILL FOREIGN KEY (GuestSSN) REFERENCES GUEST(GuestSSN),
    CONSTRAINT FK_BILL_1 FOREIGN KEY (BookingID) REFERENCES BOOKING(BookingID)
GO;