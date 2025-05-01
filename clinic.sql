-- create tables for a clinic management system
-- This SQL script creates tables for a clinic management system.

-- Create table: Specialties
CREATE TABLE Specialties (
    specialty_id INT AUTO_INCREMENT PRIMARY KEY,
    specialty_name VARCHAR(100) NOT NULL UNIQUE
);
-- Create table: Doctors
CREATE TABLE Doctors (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    specialty_id INT,
    FOREIGN KEY (specialty_id)
        REFERENCES Specialties (specialty_id)
);
-- Create table: Patients
CREATE TABLE Patients (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    firstName VARCHAR(100) NOT NULL,
    lastName VARCHAR(100) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20)
);
-- Create table: Appointments
CREATE TABLE Appointments (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    doctor_id INT NOT NULL,
    patient_id INT NOT NULL,
    appointment_datetime DATETIME NOT NULL,
    reason VARCHAR(255),
    FOREIGN KEY (doctor_id)
        REFERENCES Doctors (doctor_id),
    FOREIGN KEY (patient_id)
        REFERENCES Patients (patient_id),
    UNIQUE (doctor_id , appointment_datetime)
);
-- Create table: Payments
CREATE TABLE Payments (
    payment_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT UNIQUE NOT NULL,
    amount DECIMAL(10 , 2 ) NOT NULL,
    payment_date DATE NOT NULL,
    payment_method ENUM('Cash', 'Card', 'Online') NOT NULL,
    FOREIGN KEY (appointment_id)
        REFERENCES Appointments (appointment_id)
);
-- Create table Medications
CREATE TABLE Medications (
    medication_id INT AUTO_INCREMENT PRIMARY KEY,
    medication_name VARCHAR(100) NOT NULL UNIQUE,
    description TEXT
);
-- Create table Prescriptions
CREATE TABLE Prescriptions (
    prescription_id INT AUTO_INCREMENT PRIMARY KEY,
    appointment_id INT NOT NULL,
    medication_id INT NOT NULL,
    dosage VARCHAR(50) NOT NULL,
    duration_days INT NOT NULL,
    FOREIGN KEY (appointment_id)
        REFERENCES Appointments (appointment_id),
    FOREIGN KEY (medication_id)
        REFERENCES Medications (medication_id),
    UNIQUE (appointment_id , medication_id)
);

-- Sample Data Insertion

-- Specialties
INSERT INTO Specialties (specialty_name) VALUES
('Cardiology'), ('Dermatology'), ('General Practice'), ('Pediatrics');

-- Doctors
INSERT INTO Doctors (doctor_name, email, phone, specialty_id) VALUES
('Dr. Alice Smith', 'alice@clinic.com', '123-456-7890', 1),
('Dr. Bob Lee', 'bob@clinic.com', '234-567-8901', 2),
('Dr. Clara Zhou', 'clara@clinic.com', '345-678-9012', 3);

-- Patients
INSERT INTO Patients (firstName,lastName, date_of_birth, email, phone) VALUES
('John', 'Doe', '1990-05-15', 'john@example.com', '555-123-4567'),
('Mary', 'Jane', '1985-09-30', 'mary@example.com', '555-987-6543');

-- Appointments
INSERT INTO Appointments (doctor_id, patient_id, appointment_datetime, reason) VALUES
(1, 1, '2025-05-05 10:00:00', 'Heart check-up'),
(2, 2, '2025-05-06 11:30:00', 'Skin rash treatment');

-- Payments
INSERT INTO Payments (appointment_id, amount, payment_date, payment_method) VALUES
(1, 150.00, '2025-05-05', 'Card'),
(2, 100.00, '2025-05-06', 'Cash');

 -- Medications
INSERT INTO Medications (medication_name, description) VALUES
('Atorvastatin', 'Used to lower cholesterol'),
('Ibuprofen', 'Pain reliever and anti-inflammatory'),
('Cetirizine', 'Allergy medication');

 -- Prescriptions
INSERT INTO Prescriptions (appointment_id, medication_id, dosage, duration_days) VALUES
(1, 1, '10mg once daily', 30),
(2, 2, '200mg twice daily', 5),
(2, 3, '10mg once daily', 7);