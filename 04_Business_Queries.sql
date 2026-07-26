USE Healthcare_Analytics;
GO

------------------------------------------------------------
-- BASIC ANALYSIS
------------------------------------------------------------

-- 1. Total Number of Patients
SELECT COUNT(*) AS Total_Patients
FROM Patients;
GO

-- 2. Total Number of Doctors
SELECT COUNT(*) AS Total_Doctors
FROM Doctors;
GO

-- 3. Total Number of Departments
SELECT COUNT(*) AS Total_Departments
FROM Departments;
GO

-- 4. Total Number of Appointments
SELECT COUNT(*) AS Total_Appointments
FROM Appointments;
GO

-- 5. Total Number of Bills
SELECT COUNT(*) AS Total_Bills
FROM Billing;
GO

------------------------------------------------------------
-- PATIENT ANALYSIS
------------------------------------------------------------

-- 6. Gender-wise Patient Distribution
SELECT Gender,
       COUNT(*) AS Total_Patients
FROM Patients
GROUP BY Gender;
GO

-- 7. Average Patient Age
SELECT AVG(Age) AS Average_Age
FROM Patients;
GO

-- 8. Number of Patients by City
SELECT City,
       COUNT(*) AS Total_Patients
FROM Patients
GROUP BY City
ORDER BY Total_Patients DESC;
GO

-- 9. Readmitted Patients
SELECT Readmitted,
       COUNT(*) AS Patient_Count
FROM Patients
GROUP BY Readmitted;
GO

-- 10. Insurance Type Distribution
SELECT Insurance_Type,
       COUNT(*) AS Total_Patients
FROM Patients
GROUP BY Insurance_Type;
GO

------------------------------------------------------------
-- DOCTOR ANALYSIS
------------------------------------------------------------

-- 11. Doctors in Each Department
SELECT Department_Name,
       COUNT(*) AS Total_Doctors
FROM Doctors
GROUP BY Department_Name
ORDER BY Total_Doctors DESC;
GO

-- 12. Average Consultation Fee
SELECT AVG(Consultation_Fee) AS Average_Fee
FROM Doctors;
GO

-- 13. Top 10 Highest Consultation Fee Doctors
SELECT TOP 10
Doctor_Name,
Department_Name,
Consultation_Fee
FROM Doctors
ORDER BY Consultation_Fee DESC;
GO

-- 14. Average Experience by Department
SELECT Department_Name,
AVG(Experience_Years) AS Avg_Experience
FROM Doctors
GROUP BY Department_Name;
GO

------------------------------------------------------------
-- BILLING ANALYSIS
------------------------------------------------------------

-- 15. Total Revenue Generated
SELECT SUM(Net_Bill) AS Total_Revenue
FROM Billing;
GO

-- 16. Average Net Bill
SELECT AVG(Net_Bill) AS Average_Bill
FROM Billing;
GO

-- 17. Payment Status Summary
SELECT Payment_Status,
COUNT(*) AS Total_Bills
FROM Billing
GROUP BY Payment_Status;
GO

-- 18. Payment Method Distribution
SELECT Payment_Method,
COUNT(*) AS Total_Transactions
FROM Billing
GROUP BY Payment_Method;
GO

-- 19. Top 10 Highest Bills
SELECT TOP 10
Patient_ID,
Net_Bill
FROM Billing
ORDER BY Net_Bill DESC;
GO

------------------------------------------------------------
-- APPOINTMENT ANALYSIS
------------------------------------------------------------

-- 20. Appointment Status Summary
SELECT Appointment_Status,
COUNT(*) AS Total_Appointments
FROM Appointments
GROUP BY Appointment_Status;
GO

-- 21. Average Waiting Time
SELECT AVG(Waiting_Time_Minutes) AS Average_Waiting_Time
FROM Appointments;
GO

------------------------------------------------------------
-- PHARMACY ANALYSIS
------------------------------------------------------------

-- 22. Medicines by Category
SELECT Category,
COUNT(*) AS Total_Medicines
FROM Pharmacy
GROUP BY Category;
GO

-- 23. Stock Status Summary
SELECT Stock_Status,
COUNT(*) AS Total_Items
FROM Pharmacy
GROUP BY Stock_Status;
GO

------------------------------------------------------------
-- JOIN QUERIES
------------------------------------------------------------

-- 24. Patient with Doctor Name
SELECT
P.Patient_Name,
D.Doctor_Name,
D.Department_Name
FROM Patients P
JOIN Doctors D
ON P.Doctor_ID = D.Doctor_ID;
GO

-- 25. Patient Billing Details
SELECT
P.Patient_Name,
B.Net_Bill,
B.Payment_Status
FROM Patients P
JOIN Billing B
ON P.Patient_ID = B.Patient_ID;
GO

-- 26. Appointment Details with Doctor Name
SELECT
A.Appointment_ID,
P.Patient_Name,
D.Doctor_Name,
A.Appointment_Status
FROM Appointments A
JOIN Patients P
ON A.Patient_ID = P.Patient_ID
JOIN Doctors D
ON A.Doctor_ID = D.Doctor_ID;
GO

------------------------------------------------------------
-- ADVANCED QUERIES
------------------------------------------------------------

-- 27. Department-wise Revenue
SELECT
D.Department_Name,
SUM(B.Net_Bill) AS Total_Revenue
FROM Patients P
JOIN Billing B
ON P.Patient_ID = B.Patient_ID
JOIN Doctors D
ON P.Doctor_ID = D.Doctor_ID
GROUP BY D.Department_Name
ORDER BY Total_Revenue DESC;
GO

-- 28. Top 5 Doctors by Number of Patients
SELECT TOP 5
D.Doctor_Name,
COUNT(P.Patient_ID) AS Total_Patients
FROM Doctors D
JOIN Patients P
ON D.Doctor_ID = P.Doctor_ID
GROUP BY D.Doctor_Name
ORDER BY Total_Patients DESC;
GO

-- 29. Rank Doctors by Consultation Fee
SELECT
Doctor_Name,
Consultation_Fee,
RANK() OVER(ORDER BY Consultation_Fee DESC) AS Fee_Rank
FROM Doctors;
GO

-- 30. Patients with Bills Above Average
SELECT
Patient_ID,
Net_Bill
FROM Billing
WHERE Net_Bill >
(
SELECT AVG(Net_Bill)
FROM Billing
);
GO