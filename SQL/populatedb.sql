-- Patient Info
INSERT INTO Patient_info VALUES (
    164645466, 
    '123 Sesame Street', 
    'Elmo', 
    'M', 
    'elmo@elmail.com', 
    '6664206969', 
    TO_DATE('2000-01-01', 'YYYYMMDD'), -- constrained checked with '2008-01-01' https://onecompiler.com/postgresql/3xyjc6nst
    NULL,
    NULL
),
(111111111,'529 Random Road','Random McRandom','M','random@gmail.com','1231231234',TO_DATE('2020-01-01','YYYYMMDD'),'Random Insurance Company Inc.',ROW('Random McRandom Sr.','1231231234','randomsenior@gmail.com','Dad')),
(111111112,'529 Random Road','Randomee McRandomee','F','randomee@gmail.com','5551231234',
TO_DATE('2020-01-01','YYYYMMDD'),'Random Insurance Company Inc.',ROW('Random McRandom Sr.','1231231234','randomsenior@gmail.com','Dad')),
--(111111112,'529 Random Road','Random McRandom','F','random@gmail.com','1231231234',
--TO_DATE('2020-01-01','YYYYMMDD'),'Random Insurance Company Inc.',
--NULL), -- this will not work because rep is NULL, yet the age < 15
(515151547, '525 Elgin Street', 'Brooke Lay', 'F', 'brooke@gamil.com','3436589636',TO_DATE('2002-06-08', 'YYYYMMDD'),NULL,NULL),
(388498874, '1225 Imaginary Street, Toronto, ON, Canada', 'John Li', 'F', 'john@gamil.com','3437826548',TO_DATE('2000-09-03', 'YYYYMMDD'),NULL,NULL);

-- Patient
INSERT INTO Patient VALUES 
(1,164645466),
(2,111111111),
(3,111111112),
(4,515151547),
(5,388498874);


-- Patient records
INSERT INTO Patient_records VALUES
(1, 'Patient is going lose their teeth in 2 years if they do not book another appt with us.', 1),
(2,'Random current has healthy teeth. Only requires annual cleaning.', 2),
(3,'Random Sr. needs dentures ASAP. He has no teeth.', 3),
(4,'Brooke needs invisalign because her teeth is crooked.',4),
(5,'John needs extractions on her teeth.',5)
;


-- Employee Info 
INSERT INTO Employee_info VALUES (
  123456789,
  'r', -- constraint checked with 'f' (https://onecompiler.com/postgresql/3xxy77n5g)
  'Bob Marley',
  '123 Postgres Street, Ottawa, ON, Canada',
  60000.25123 -- tested - only shows 60000.25
), -- branch id has 1 receptionist
(141286236,'d','Tisham Islam', '123 Postgres Street, Ottawa, ON, Canada', 75000.50), -- dentist at branch id 1
(158453648,'d','Céline Wan', '123 Postgres Street, Ottawa, ON, Canada', 75000.50), -- dentist at branch id 1
(198523644,'h','Amy Kkiti', '123 Postgres Street, Ottawa, ON, Canada', 65000.50), -- hygenist at branch id 1
(165984846,'b','Bruno Bale', '523 Sesame Street, Ottawa, ON, Canada', 83000.50), -- manager at branch id 1

(388498874,'d','John Li', '1225 Imaginary Street, Toronto, ON, Canada', 70000.50), -- dentist at branch id 2, ALSO A PATIENT
(432364646,'d','Samy Touabi', '5346 Postgres Avenue, Toronto, ON, Canada', 70000.50), -- dentist at branch id 2
(665946369,'r','Oliva Mars', '355 MySQL Road, Toronto, ON, Canada', 55000.50), -- receptionist at branch id 2
(135941655,'r','Christopher Castillo', '885 NoSQL Drive, Toronto, ON, Canada', 55000.50), -- receptionist at branch id 2
(256356565,'h','Nakul Lover', '5243 MariaDB Crossing, Toronto, ON, Canada', 60000.50), -- hygienist at branch id 2
(956233565,'b','Kien Do', '420 Oracle Street, Toronto, ON, Canada', 83000.50); -- manager at branch id 2

-- Branch
INSERT INTO Branch VALUES 
(1,'Ottawa', NULL, NULL, NULL),
(2,'Toronto', NULL, NULL, NULL);

-- Employee
INSERT INTO Employee VALUES 
 -- Employees in branch id 1; 
(1,123456789, 1), -- this is a receptionist at branch 1
(2,141286236, 1),
(3,158453648, 1),
(4,198523644, 1),
(5,165984846, 1), -- this is a manager at branch 1
 -- Employees in branch id 2
(6,388498874, 2),
(7,432364646, 2),
(8,665946369, 2), -- receptionist 1 at branch 2
(9,135941655, 2), -- receptionist 2 at branch 2
(10,256356565, 2),
(11,956233565, 2); -- this is a manager at branch 2
-- don't modify the insertions above to DEFAULT, just make the next insertions DEFAULT

-- Add managers and receptionists to the existing branches
UPDATE Branch
SET manager_id = 5,
receptionist1_id = 1
WHERE (city = 'Ottawa');

UPDATE Branch
SET manager_id = 11,
receptionist1_id = 8,
receptionist2_id = 9
WHERE (city = 'Toronto');

-- Procedure codes
INSERT INTO Procedure_codes VALUES
  (1, 'Teeth Cleanings'),
  (2, 'Teeth Whitening'),
  (3, 'Extractions'),
  (4, 'Veneers'),
  (5, 'Fillings'),
  (6, 'Crowns'),
  (7, 'Root Canal'),
  (8, 'Braces/invisalign'),
  (9, 'Bonding'),
  (10,'Dentures')
;

-- First the patient books an appointment (into a future date)
-- The patient is diagnosed in Treatment
-- Once the Treatment is prescribed, we then create a Appointment_procedure

-- Appointment
-- We could make a list/drop menu of dentists where the person who's doing 
-- the appt booking can choose a dentist
INSERT INTO Appointment VALUES
(1,2,2,TO_DATE('2022-04-05', 'YYYYMMDD'),'10:00:00','11:00:00',3,'Completed',23),
(2,3,3,TO_DATE('2022-04-14', 'YYYYMMDD'),'10:00:00','11:00:00',2,'Booked',5); -- Make sure the 'Extractions' and 'Teeth Cleanings' match up with the procedure code in the Appointment_procedure table

-- Treatment
INSERT INTO Treatment VALUES
(1,'Tooth removal','Midazolam','Tooth ache','Do not eat food 24 hours before the procedure',23,1,1),
(2,'Tooth cleaning','No medications administered','no symptoms','',999,2,2)
;

-- Appointment Procedure
INSERT INTO Appointment_procedure VALUES
(
  1,
  1,
  3,
  TO_DATE('2022-04-05', 'YYYYMMDD'),
  NULL,
  3,
  'We need to remove the bottom left tooth of the patient',
  23, -- this means quadrant 2, tooth #3 https://www.summerleadental.com/all-about-the-tooth-numbers/
  1, -- this means, remove 1 tooth
  NULL,
  NULL,
  500.00,
  NULL
),
(
  2,
  2,
  3,
  TO_DATE('2022-04-14', 'YYYYMMDD'),
  NULL,
  2,
  'Annual patient dental cleaning',
  999, -- code for operation that involves every tooth
  0, -- it's a cleaning, so it's 0
  NULL,
  NULL,
  60.00,
  NULL
);


-- Fee charge
INSERT INTO Fee_charge VALUES
(1, 1, 123,400), -- 123 is a random fee code for extractions
(2, 1, 124,100), -- 124 is a random fee code for medications
(3, 2, 100,60) -- 100 is a random fee code for teeth cleaning
;


-- Invoice (update Appointment_procedure depending on the values of Invoice)
INSERT INTO Invoice VALUES
(
  -- Elmo's invoice
  1,
  TO_DATE('2022-04-05', 'YYYYMMDD'),
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  300,
  200,
  0,
  0,
  1  
),
(
  --Random's invoice
  2,
  TO_DATE('2022-04-14', 'YYYYMMDD'),
  'The Downtown Dental Clinic
  Ottawa ON K1P 6L7
  (613) 234-0792
  ',
  60,
  0,
  0,
  0,
  2
);

-- Insurance_claim
INSERT INTO Insurance_claim VALUES
(1,164645466,'Elmo Inc.','SunLife Insurance','91833',200,1)
;


-- Appointment procedure
UPDATE Appointment_procedure -- Elmo has insurance
SET 
invoice_id = 1,
insurance_charge = 200,
patient_charge = 300,
insurance_claim_id = 1
WHERE (procedure_id = 1);

UPDATE Appointment_procedure -- Random doesn't have insurance
SET 
invoice_id = 2,
patient_charge = 60
WHERE (procedure_id = 2);


-- Patient Billing
INSERT INTO Patient_billing VALUES
(1,1,300,200,500,'Visa'),
(2,2,60,0,60,'Mastercard');


-- User Accounts
INSERT INTO user_account VALUES ('elmurder666', 'ASDFGHJKL:123456', 0, 1, NULL);
INSERT INTO user_account VALUES ('randommd5', 'ASDFGHJKL:123456', 0, 2, NULL);
INSERT INTO user_account VALUES ('randomeemd6', 'ASDFGHJKL:123456', 0, 3, NULL);
INSERT INTO user_account VALUES ('xXx_blayde_xXx', 'ASDFGHJKL:123456', 0, 4, NULL);
INSERT INTO user_account VALUES ('tisla2714', 'ASDFGHJKL:123456', 1, NULL, 2);
INSERT INTO user_account VALUES ('cwmk3565', 'ASDFGHJKL:123456', 1, NULL, 3);
INSERT INTO user_account VALUES ('akiti7935', 'ASDFGHJKL:123456', 1, NULL, 4);
INSERT INTO user_account VALUES ('stoua0809', 'ASDFGHJKL:123456', 1, NULL, 7);
INSERT INTO user_account VALUES ('kdo2342', 'ASDFGHJKL:123456', 1, NULL, 11);
INSERT INTO user_account VALUES ('johnli255', 'ASDFGHJKL:123456', 2, 5, 6);

-- Review
INSERT INTO Review VALUES (
  1,
  'Tisham Islam',
  5, -- constraint is checked with values -1 and 6 (https://onecompiler.com/postgresql/3xxy4xntj)
  2,
  4,
  '2022-04-09',
  1
),
(
  2,
  'Céline Wan',
  1,
  1,
  1,
  '2022-04-10',
  2
);

