CREATE TABLE Users (
       UserID INT PRIMARY KEY AUTO_INCREMENT,
       FullName VARCHAR(100),
       Email VARCHAR(100) UNIQUE,
       Role ENUM('Admin', 'Organizer', 'Attendee') NOT NULL
);

CREATE TABLE Venues (
       VenueID INT PRIMARY KEY AUTO_INCREMENT,
       VenueName VARCHAR(100),
       Location VARCHAR(100),
       Capacity INT
);

CREATE TABLE Organizers (
       OrganizerID INT PRIMARY KEY AUTO_INCREMENT,
       UserID INT,
       CompanyName VARCHAR(100),
       FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Events (
       EventID INT PRIMARY KEY AUTO_INCREMENT,
       EventName VARCHAR(100),
       EventDate DATE, 
       VenueID INT,
       OrganizerID INT,
       FOREIGN KEY (VenueID) REFERENCES Venues(VenueID),
       FOREIGN KEY (OrganizerID) REFERENCES Organizers(OrganizerID)
);

CREATE TABLE Attendees (
       AttendeeID INT PRIMARY KEY AUTO_INCREMENT,
       UserID INT,
       FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

CREATE TABLE Tickets (
       TicketID INT PRIMARY KEY AUTO_INCREMENT,
       EventID INT,
       AttendeeID INT,
       PurchaseDate DATE,
       FOREIGN KEY (EventID) REFERENCES Events(EventID),
       FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

CREATE TABLE Payments (
       PaymentID INT PRIMARY KEY AUTO_INCREMENT,
       TicketID INT,
       Amount DECIMAL(10,2),
       PaymentDate DATE,
       Status ENUM('Paid', 'Pending', 'Failed') DEFAULT 'Pending',
       FOREIGN KEY (TicketID) REFERENCES Tickets(TicketID)
);

CREATE TABLE Feedback (
       FeedbackID INT PRIMARY KEY AUTO_INCREMENT,
       EventID INT,
       AttendeeID INT,
       Rating INT CHECK (Rating BETWEEN 1 AND 5),
       Comment TEXT,
       SubmittedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
       FOREIGN KEY (EventID) REFERENCES Events(EventID),
       FOREIGN KEY (AttendeeID) REFERENCES Attendees(AttendeeID)
);

-- Users
INSERT INTO Users(FullName, Email, Role)
            VALUES('Alice Johnson', 'alice@example.com', 'Attendee');
INSERT INTO Users(FullName, Email, Role)
            VALUES('Bob Smith', 'bob@example.com', 'Attendee');
INSERT INTO Users(FullName, Email, Role)
            VALUES('Claire Events', 'claire@eventpros.com', 'Organizer');
INSERT INTO Users(FullName, Email, Role)
            VALUES('Admin User', 'admin@ems.com', 'Admin');

-- Organizers
INSERT INTO Organizers(UserID, CompanyName)
            VALUES(3, 'EventPros Inc');

-- Venues
INSERT INTO Venues(VenueName, Location, Capacity)
            VALUES('City Hall', 'Downtown', 300);
INSERT INTO Venues(VenueName, Location, Capacity)
            VALUES('Open Field Arena', 'East Side', 800); 

-- Events
INSERT INTO Events(EventName, EventDate, VenueID, OrganizerID)
            VALUES('Tech Innovators Summit', '2025-09-10', 1, 1);
INSERT INTO Events(EventName, EventDate, VenueID, OrganizerID)
            VALUES('Summer Beats Festival', '2025-08-15', 2, 1);

-- Attendees
INSERT INTO Attendees(UserID)
            VALUES(1);
INSERT INTO Attendees(UserID)
            VALUES(2);

-- Tickets
INSERT INTO Tickets(EventID, AttendeeID, PurchaseDate)
            VALUES(1, 1, '2025-06-01');
INSERT INTO Tickets(EventID, AttendeeID, PurchaseDate)
            VALUES(2, 1, '2025-06-02');
INSERT INTO Tickets(EventID, AttendeeID, PurchaseDate)
            VALUES(2, 2, '2025-06-03');

-- Payments
INSERT INTO Payments(TicketID, Amount, PaymentDate, Status)
            VALUES(1, 50.00, '2025-06-01', 'Paid');
INSERT INTO Payments(TicketID, Amount, PaymentDate, Status)
            VALUES(2, 70.00, '2025-06-02', 'Paid');
INSERT INTO Payments(TicketID, Amount, PaymentDate, Status)
            VALUES(3, 70.00, '2025-06-04', 'Pending');

-- Feedback
INSERT INTO Feedback(EventID, AttendeeID, Rating, Comment)
            VALUES(1, 1, 5, 'Amazing speakers and well organized!');
INSERT INTO Feedback(EventID, AttendeeID, Rating, Comment)
            VALUES(2, 1, 4, 'Loved the music but lines were long.');