USE Healthcare_Analytics;
GO

-- =========================
-- Departments Table
-- =========================
CREATE TABLE Departments (
    Department_ID VARCHAR(10) PRIMARY KEY,
    Department_Name VARCHAR(100) NOT NULL,
    Total_Beds INT,
    ICU_Beds INT
);

-- =========================
-- Doctors Table
-- =========================
CREATE TABLE Doctors (
    Doctor_ID VARCHAR(10) PRIMARY KEY,
    Doctor_Name VARCHAR(100) NOT NULL,
    Gender VARCHAR(10),
    Department_ID VARCHAR(10),
    Department_Name VARCHAR(100),
    Specialization VARCHAR(100),
    Experience_Years INT,
    Qualification VARCHAR(100),
    Consultation_Fee INT,
    Email VARCHAR(100),
    Phone VARCHAR(20),

    CONSTRAINT FK_Doctors_Departments
    FOREIGN KEY (Department_ID)
    REFERENCES Departments(Department_ID)
);

-- =========================
-- Patients Table
-- =========================
CREATE TABLE Patients (
    Patient_ID VARCHAR(10) PRIMARY KEY,
    Patient_Name VARCHAR(100) NOT NULL,
    Age INT,
    Gender VARCHAR(10),
    City VARCHAR(50),
    Admission_Date DATE,
    Discharge_Date DATE,
    Department_ID VARCHAR(10),
    Doctor_ID VARCHAR(10),
    Diagnosis_Code VARCHAR(20),
    Treatment_Cost INT,
    Insurance_Type VARCHAR(50),
    Readmitted VARCHAR(10),

    CONSTRAINT FK_Patients_Departments
    FOREIGN KEY (Department_ID)
    REFERENCES Departments(Department_ID),

    CONSTRAINT FK_Patients_Doctors
    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctors(Doctor_ID)
);

-- =========================
-- Appointments Table
-- =========================
CREATE TABLE Appointments (
    Appointment_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID VARCHAR(10),
    Doctor_ID VARCHAR(10),
    Appointment_Date DATE,
    Waiting_Time_Minutes INT,
    Appointment_Status VARCHAR(50),

    CONSTRAINT FK_Appointments_Patients
    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID),

    CONSTRAINT FK_Appointments_Doctors
    FOREIGN KEY (Doctor_ID)
    REFERENCES Doctors(Doctor_ID)
);

-- =========================
-- Billing Table
-- =========================
CREATE TABLE Billing (
    Bill_ID VARCHAR(10) PRIMARY KEY,
    Patient_ID VARCHAR(10),
    Treatment_Cost INT,
    Medicine_Cost INT,
    Lab_Cost INT,
    Insurance_Coverage INT,
    Net_Bill INT,
    Payment_Method VARCHAR(50),
    Payment_Status VARCHAR(50),

    CONSTRAINT FK_Billing_Patients
    FOREIGN KEY (Patient_ID)
    REFERENCES Patients(Patient_ID)
);

-- =========================
-- Pharmacy Table
-- =========================
CREATE TABLE Pharmacy (
    Medicine_ID VARCHAR(10) PRIMARY KEY,
    Medicine_Name VARCHAR(100),
    Category VARCHAR(50),
    Quantity_Issued INT,
    Unit_Cost INT,
    Supplier VARCHAR(100),
    Stock_Status VARCHAR(50)
);