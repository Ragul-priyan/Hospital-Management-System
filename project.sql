CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100),
    specialization VARCHAR(100)
);

CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100),
    contact_info VARCHAR(15)
);

CREATE TABLE Rooms (
    room_id INT PRIMARY KEY,
    room_number VARCHAR(10),
    status VARCHAR(20) DEFAULT 'Available' -- 'Available' or 'Occupied'
);

CREATE TABLE Staff (
    staff_id INT PRIMARY KEY,
    name VARCHAR(100),
    role VARCHAR(50), -- e.g., 'Nurse', 'Receptionist', 'Lab Technician'
    contact_info VARCHAR(50)
);

CREATE TABLE Inventory (
    item_id INT PRIMARY KEY,
    item_name VARCHAR(100),
    stock_quantity INT,
    minimum_threshold INT
);

CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY,
    patient_id INT REFERENCES Patients(patient_id),
    doctor_id INT REFERENCES Doctors(doctor_id),
    room_id INT REFERENCES Rooms(room_id),
    admission_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    discharge_date TIMESTAMP,
    status VARCHAR(20) DEFAULT 'Active'
);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_date DATETIME,
    status VARCHAR(20) DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

CREATE TABLE Billing (
    bill_id INT PRIMARY KEY,
    admission_id INT,
    total_amount DECIMAL(10, 2),
    payment_status VARCHAR(20) DEFAULT 'Pending',
    FOREIGN KEY (admission_id) REFERENCES Admissions(admission_id)
);

INSERT INTO Doctors (doctor_id, name, specialization)VALUES 
    (101, 'Dr. Sarah Jenkins', 'Cardiology'),
    (102, 'Dr. Marcus Chen', 'Neurology'),
    (103, 'Dr. Elena Rodriguez', 'Emergency Medicine'),
    (104, 'Dr. James Wilson', 'Pediatrics'),
    (105, 'Dr. Aisha Patel', 'Orthopedics');
    
    INSERT INTO Patients (patient_id, name, contact_info)VALUES
    (201, 'Michael Chang', '555-0192'),
    (202, 'Sarah O''Connor', '555-0183'),
    (203, 'David Thorne', '555-0174'),
    (204, 'Emily Vance', '555-0165');

INSERT INTO Rooms (room_id, room_number, status)VALUES
    (301, '101A', 'Available'),
    (302, '101B', 'Available'),
    (303, '102A', 'Available'),
    (304, 'ICU-1', 'Available'),
    (305, 'ICU-2', 'Available');
    
     INSERT INTO Staff (staff_id, name, role, contact_info) VALUES 
    (601, 'Nurse Mary Joseph', 'Staff Nurse', '555-1122'),
    (602, 'Nurse John Britto', 'ICU Nurse', '555-3344'),
    (603, 'Anitha Suresh', 'Receptionist', '555-5566'),
    (604, 'Ramesh Kumar', 'Lab Technician', '555-7788');
    
    INSERT INTO Inventory (item_id, item_name, category, quantity, unit_price) VALUES 
    (401, 'Paracetamol 500mg', 'Medicine', 500, 2.50),
    (402, 'Amoxicillin 250mg', 'Medicine', 200, 15.00),
    (403, 'Digital Thermometer', 'Equipment', 45, 350.00),
    (404, 'Surgical Gloves (Box)', 'Consumables', 120, 450.00),
    (405, 'Blood Pressure Monitor', 'Equipment', 15, 1800.00),
    (406, 'Cotton Roll 500g', 'Consumables', 80, 120.00),
    (407, 'Saline IV Solution 500ml', 'Medicine', 300, 65.00);
    
    INSERT INTO Admissions (admission_id, patient_id, doctor_id, room_id, admission_date, discharge_date, status) VALUES 
    (1, 201, 101, 301, CURRENT_TIMESTAMP, NULL, 'Active'),
    (2, 202, 103, 304, CURRENT_TIMESTAMP, NULL, 'Active'),
    (3, 203, 102, 302, '2023-10-15 09:00:00', '2023-10-18 11:30:00', 'Discharged');
    
    INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date, status) VALUES 
    (701, 201, 101, '2026-07-28 10:00:00', 'Scheduled'),
    (702, 202, 102, '2026-07-29 11:30:00', 'Scheduled'),
    (703, 203, 104, '2026-07-30 14:00:00', 'Completed');
    
    INSERT INTO Billing (bill_id, admission_id, total_amount, payment_status) VALUES 
    (501, 1, 4500.00, 'Pending'),
    (502, 2, 12500.00, 'Pending'),
    (503, 3, 8200.00, 'Paid');
    
SELECT a.admission_id, 
       p.name AS patient_name, 
       d.name AS doctor_name, 
       d.specialization, 
       r.room_number, 
       b.total_amount,
       b.payment_status,
       a.status AS admission_status,
       a.admission_date 
FROM Admissions a 
JOIN Patients p ON a.patient_id = p.patient_id 
JOIN Doctors d ON a.doctor_id = d.doctor_id 
JOIN Rooms r ON a.room_id = r.room_id
LEFT JOIN Billing b ON a.admission_id = b.admission_id;
    
