-- Business Questions
-- 1. Events with average rating.
SELECT Events.EventName, AVG(Feedback.Rating) AS AvgRating
FROM Events JOIN Feedback USING (EventID)
GROUP BY Events.EventID;

-- 2. Total revenue collected per event.
SELECT Events.EventName, SUM(Payments.Amount) AS TotalRevenue
FROM Events JOIN Tickets ON Events.EventID = Tickets.EventID
            JOIN Payments ON Tickets.TicketID = Payments.TicketID
WHERE Payments.Status = 'Paid'
GROUP BY Events.EventID;

-- 3. Feedback comments for a specific event.
SELECT Users.FullName, Feedback.Rating, Feedback.Comment
FROM Feedback JOIN Attendees ON Feedback.AttendeeID = Attendees.AttendeeID
              JOIN Users ON Attendees.UserID = Users.UserID
WHERE Feedback.EventID = 1;

-- 4. Payment status for each attendee.
SELECT Users.FullName, Events.EventName, Payments.Amount, Payments.Status
FROM Payments JOIN Tickets ON Payments.TicketID = Tickets.TicketID
              JOIN Attendees ON Tickets.AttendeeID = Attendees.AttendeeID
              JOIN Users ON Attendees.UserID = Users.UserID
              JOIN Events ON Tickets.EventID = Events.EventID;