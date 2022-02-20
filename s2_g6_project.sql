DROP DATABASE IF EXISTS blx2wj_s2_g6_project;
CREATE DATABASE IF NOT EXISTS blx2wj_s2_g6_project;
USE blx2wj_s2_g6_project;
DROP TABLE IF EXISTS Patient;
DROP TABLE IF EXISTS PreExistingConditions;
DROP TABLE IF EXISTS Possesses;
DROP TABLE IF EXISTS Employee;
DROP TABLE IF EXISTS HealthDistrict;
DROP TABLE IF EXISTS Clinic;
DROP TABLE IF EXISTS Works;
DROP TABLE IF EXISTS Supplier;
DROP TABLE IF EXISTS Distributes;
DROP TABLE IF EXISTS VaccineType;
DROP TABLE IF EXISTS Appointment;


CREATE TABLE Patient (
	patientNo CHAR(2) NOT NULL,
	pFirstName VARCHAR(10),
	pLastName VARCHAR(10),
	pZipCode INT(5),
	pCounty VARCHAR(10),
	pAge INT(3),
	pEthnicity VARCHAR(10),
	pJobType VARCHAR(20),
	CONSTRAINT pk_Patient PRIMARY KEY (patientNo)
  );

INSERT INTO Patient VALUES
(1,'Bill','Smith',22963,'Fluvanna',24,'White','Front-Line'),
(2,'Jane','Johnson',24501,'Lynchburg',38,'Black','Front-Line'),
(3,'Bob','Chen',22963,'Fluvanna',59,'Asian','Agriculture'),
(4,'Mary','Brown',23921,'Buckingham',76,'White','Front-Line'),
(5,'Adam','Jones',22903,'Albermarle',18,'Black','Corporate'),
(6,'Patrick','Miller',24501,'Lynchburg',27,'White','Healthcare'),
(7,'Stephanie','Davis',23921,'Buckingham',33,'White','Corporate'),
(8,'Richard','Curtis',24521,'Amherst',39,'Latino','Agriculture'),
(9,'Steven','Rodriguez',22963,'Fluvanna',42,'Hispanic','Corporate'),
(10,'Carrie','Huang',22625,'Frederick',35,'Asian','Healthcare'),
(11,'Samantha','Martinez',22611,'Clarke',75,'Hispanic',NULL),
(12,'John','Anderson',22903,'Albermarle',53,'White','Education'),
(13,'Taylor','Thomas',24521,'Amherst',42,'White','Education'),
(14,'Casey','Hernandez',24501,'Lynchburg',81,'Hispanic',NULL),
(15,'Charlie','Moore',24522,'Appomattox',30,'Black','Education');

CREATE TABLE PreExistingConditions (
	conditionNo char(2) NOT NULL,
	conditionName VARCHAR(20),
	CONSTRAINT pk_PreExistingConditions PRIMARY KEY (conditionNo)
);

INSERT INTO PreExistingConditions VALUES
(1,'Asthma'),
(2,'Cancer'),
(3,'Obesity'),
(4,'Lung disease'),
(5,'Dementia'),
(6,'Diabetes'),
(7,'Heart condition'),
(8,'Smoker'),
(9,'Liver disease'),
(10,'Other');

CREATE TABLE Possesses (
	patientNo char(2) NOT NULL,
	conditionNo char(2) NOT NULL,
	CONSTRAINT pk_Possesses PRIMARY KEY (patientNo, conditionNo),
	CONSTRAINT fk_Possesses_patientNo FOREIGN KEY (patientNo) REFERENCES Patient(patientNo),
	CONSTRAINT fk_Possesses_conditionNo FOREIGN KEY (conditionNo) REFERENCES PreExistingConditions(conditionNo)
);

INSERT INTO Possesses VALUES
(1,4),
(3,5),
(3,6),
(5,1),
(5,3),
(5,8),
(6,7),
(8,2),
(9,3),
(11,4),
(13,9),
(13,10),
(15,1),
(15,8);

CREATE TABLE Employee (
	eNumber CHAR(2) NOT NULL,
	eName VARCHAR(10),
	CONSTRAINT pk_Employee PRIMARY KEY (eNumber)
  );

INSERT INTO Employee VALUES
(1,'Jordan'),
(2,'Grace'),
(3,'Carter'),
(4,'Tim'),
(5,'Alex'),
(6,'Sean'),
(7,'Janet'),
(8,'Sydney'),
(9,'Andrew'),
(10,'Brett'),
(11,'Daisy'),
(12,'Melanie'),
(13,'Nick'),
(14,'Liz'),
(15,'Craig');


CREATE TABLE HealthDistrict (
	districtNo CHAR(2) NOT NULL,
	districtName VARCHAR(20),
	dPopulation INT(10),
	phaseNo VARCHAR(10),
	pplVax INT(10),
	CONSTRAINT pk_HealthDistrict PRIMARY KEY (districtNo)
);

INSERT INTO HealthDistrict VALUES
(1,'Blue Ridge',250000,'1c', 71000),
(2,'Piedmont',103000,'1b', 18000),
(3,'Central Virginia',261000,'1c', 112000),
(4,'Lord Fairfax',233000,'2',166000);

CREATE TABLE Clinic (
	clinicNo CHAR(2) NOT NULL,
	cZipCode INT(5),
	cCounty VARCHAR(10),
	districtNo CHAR(2) NOT NULL,
	CONSTRAINT pk_Clinic PRIMARY KEY (clinicNo)
);

INSERT INTO Clinic VALUES
(1,22903,'Albermarle',1),
(2,22963,'County',1),
(3,23921,'Buckingham',2),
(4,24501,'Lynchburg',3),
(5,24521,'Amherst',3),
(6,24522,'Appomattox',3),
(7,22611,'Clarke',4),
(8,22625,'Frederick',4);


CREATE TABLE Works (
	clinicNo CHAR(2),
	eNumber CHAR(2),
	CONSTRAINT pk_Works PRIMARY KEY (clinicNo, eNumber),
	CONSTRAINT fk_Works_clinicNo FOREIGN KEY (clinicNo) REFERENCES Clinic(clinicNo),
	CONSTRAINT fk_Works_eNumber FOREIGN KEY (eNumber) REFERENCES Employee(eNumber)
);

INSERT INTO Works VALUES
(1,1),
(1,2),
(2,3),
(3,4),
(3,5),
(4,4),
(4,5),
(4,6),
(5,7),
(5,14),
(5,15),
(6,7),
(6,10),
(7,11),
(8,12),
(8,13);

CREATE TABLE VaccineType (
	vaccineNo CHAR(2) NOT NULL,
	vaccineName VARCHAR(20),
	CONSTRAINT pk_VaccineType PRIMARY KEY (vaccineNo)
);

INSERT INTO VaccineType VALUES
(1, 'Pfizer'),
(2, 'Moderna'),
(3, 'Johnson & Johnson');

CREATE TABLE Supplier (
	supplierNo CHAR(2) NOT NULL,
	supplierName VARCHAR(20),
	supplierAddress VARCHAR(50),
    vaccineNo CHAR(2) NOT NULL,
	CONSTRAINT pk_Supplier PRIMARY KEY (supplierNo),
    CONSTRAINT fk_Supplier_vaccineNo FOREIGN KEY (vaccineNo) REFERENCES VaccineType(vaccineNo)
);

INSERT INTO Supplier VALUES
(1,'Pfizer 1','366 North Peachtree St. West Warwick, RI 02893','1'),
(2,'Pfizer 2','635 Pacific St. Riverview, FL 33569', '1'),
(3,'Moderna 1','7878 Madison St. Marquette, MI 49855','2'),
(4,'Moderna 2','15 Elm St. Cookeville, TN 38501','2'),
(5,'J&J 1','9975 Bridgeton Street New Britain, CT 06051','3'),
(6,'J&J 2','49 East Rockcrest St. Boca Raton, FL 33428','3');


CREATE TABLE Distributes (
	supplierNo CHAR(2) NOT NULL,
	clinicNo CHAR(2) NOT NULL,
	distDate DATE,
	noDoses INT(10), 
    expDate DATE,
	CONSTRAINT pk_Distributes PRIMARY KEY (supplierNo, clinicNo),
	CONSTRAINT fk_Distributes_supplierNo FOREIGN KEY (supplierNo) REFERENCES Supplier(supplierNo),
	CONSTRAINT fk_Distributes_clinicNo FOREIGN KEY (clinicNo) REFERENCES Clinic(clinicNo)
);

INSERT INTO Distributes VALUES
(1,1,'2021-04-19',4,'2021-04-20'),
(2,2,'2021-04-20',3,'2021-04-21'),
(1,3,'2021-04-21',2,'2021-04-22'),
(3,3,'2021-04-22',2,'2021-04-23'),
(1,4,'2021-04-23',6,'2021-04-24'),
(2,5,'2021-04-24',3,'2021-04-25'),
(4,5,'2021-04-25',7,'2021-04-26'),
(2,6,'2021-04-23',5,'2021-04-24'),
(4,6,'2021-04-22',5,'2021-04-23'),
(6,6,'2021-04-19',2,'2021-04-20'),
(3,7,'2021-04-20',7,'2021-04-21'),
(6,8,'2021-04-21',4,'2021-04-22');



CREATE TABLE Appointment (
	aptId CHAR(2) NOT NULL,
	aptDate DATE,
	aotTime TIME,
	doseNo INT(2),
	vaccineNo CHAR(2) NOT NULL,
	patientNo CHAR(2) NOT NULL,
	clinicNo CHAR(2) NOT NULL,
	CONSTRAINT pk_Appointment PRIMARY KEY (aptId),
	CONSTRAINT fk_Appointment_vaccineNo FOREIGN KEY (vaccineNo) REFERENCES VaccineType(vaccineNo),
	CONSTRAINT fk_Appointment_patientNo FOREIGN KEY (patientNo) REFERENCES Patient(patientNo),
	CONSTRAINT fk_Appointment_clinicNo FOREIGN KEY (clinicNo) REFERENCES Clinic(clinicNo)
);

INSERT INTO Appointment VALUES
(1,'2021-04-20','09:00:00',1,1,1,2),
(2,'2021-04-20','09:30:00',1,2,2,4),
(3,'2021-03-27','10:00:00',1,2,3,2),
(4,'2021-04-20','10:30:00',1,3,4,3),
(5,'2021-03-27','11:00:00',1,1,5,1),
(6,'2021-04-20','11:30:00',1,1,6,4),
(7,'2021-04-20','12:00:00',1,2,7,3),
(8,'2021-03-27','12:30:00',1,1,8,5),
(9,'2021-04-20','13:00:00',1,3,9,2),
(10,'2021-04-20','13:30:00',1,1,10,8),
(11,'2021-03-27','14:00:00',1,2,11,7),
(12,'2021-04-20','14:30:00',1,1,12,1),
(13,'2021-03-27','15:00:00',1,2,13,1),
(14,'2021-04-20','13:00:00',1,2,14,4),
(15,'2021-04-20','14:00:00',1,3,15,6),
(16,'2021-04-20','10:00:00',2,1,3,2),
(17,'2021-04-20','11:00:00',2,2,5,1),
(18,'2021-04-20','12:00:00',2,1,8,5),
(19,'2021-04-21','11:30:00',2,2,11,7),
(20,'2021-04-21','15:00:00',2,1,13,1);


SELECT * FROM Patient;
SELECT * FROM PreExistingConditions;
SELECT * FROM Possesses;
SELECT * FROM Employee;
SELECT * FROM HealthDistrict;
SELECT * FROM Clinic;
SELECT * FROM Works;
SELECT * FROM Supplier;
SELECT * FROM Distributes;
SELECT * FROM VaccineType;
SELECT * FROM Appointment;

-- Q1: How many days will it take to vaccinate the entire health district?
SELECT h.districtName, (count(distinct(a.patientNo))/count(distinct(a.aptDate ))) AS dailyAverage, 
	   h.dPopulation AS Population,(h.dPopulation-(count(distinct(a.patientNo)))) AS notVaxed, 
	   (h.dPopulation-(count(distinct(a.patientNo)))) DIV (count(distinct(a.patientNo))/count(distinct(a.aptDate ))) AS daysTilFullVax
FROM Appointment a,Patient p, HealthDistrict h, Clinic c
WHERE p.patientNo=a.patientNo AND a.clinicNo=c.clinicNo AND c.districtNo=h.districtNo
GROUP BY h.districtName, h.dPopulation;


-- Q2: How can we mitigate the risk of expired vaccines?
SELECT a.aptDate, d.expDate, c.clinicNo, COUNT(a.aptID) AS administeredDoses, d.noDoses AS totalDoses, d.noDoses - COUNT(a.aptID) as expiredDoses
FROM Distributes d, Appointment a, Clinic c
WHERE a.clinicNo=c.clinicNo AND c.clinicNo=d.clinicNo AND a.clinicNo=d.clinicNo AND d.expDate=a.aptDate 
GROUP BY a.aptDate, d.expDate, c.clinicNo, d.noDoses
HAVING COUNT(a.aptId) < d.noDoses
ORDER BY c.clinicNo;


-- Q3: How should the vaccine doses be distributed across the health districts in an equitable manner?
# Determine the number of people left to vaccinate in each health district.
SELECT districtNo, dPopulation - pplVax AS LeftToVax
FROM HealthDistrict;


# Determine which patients have preexisting conditions and the health district they belong to.
SELECT p.patientNo AS PatientsWConditions, h.districtNo
FROM Patient p, Possesses o, PreExistingConditions e, Appointment a, Clinic c, HealthDistrict h
WHERE p.patientNo = o.patientNo AND o.conditionNo = e.conditionNo AND p.patientNo = a.patientNo AND a.clinicNo = c.clinicNo AND c.districtNo = h.districtNo
GROUP BY p.patientNo, h.districtNo
ORDER BY length(p.patientNo), p.patientNo;

# Determine which patients are over the age of 55 and the health district they belong to.
SELECT p.patientNo AS PatientsOver55, h.districtNo, p.pAge
FROM Patient p, Appointment a, Clinic c, HealthDistrict h
WHERE p.pAge > 55 AND p.patientNo = a.patientNo AND a.clinicNo = c.clinicNo AND c.districtNo = h.districtNo
GROUP BY p.patientNo, h.districtNo
ORDER BY length(p.patientNo), p.patientNo;


-- Q4. How does each health district perform compared to the state average in terms of vaccination rate?
# Under or over average - VA is vaccinating 80,000 daily out of 8.7 million ~ 1% -> 7% per week
SELECT h.districtName, h.pplVax/h.dpopulation AS currPropVax, h.dpopulation - h.pplVax AS needVax, count(aptID)*2500 AS schedVax,
		(count(aptID)*2500)/(h.dpopulation - h.pplVax) as vaxRate
FROM  HealthDistrict h, Clinic c, Appointment a, Patient p
WHERE h.districtNo = c.districtNo and c.clinicNo=a.clinicNo and a.patientNo = p.patientNo
GROUP BY h.districtNo;
# HAVING schedVax / needVax < 0.07;


-- Q5: On a given day, which clinics are expected to have unused vaccines and how many? 
-- Additionally, are there certain clinics that are more likely to have a particular type of vaccine than others?
SELECT d.distDate, c.clinicNo, sum(noDoses), aptMade, sum(noDoses) - aptMade as aptAvail
FROM clinic c
LEFT JOIN distributes d ON c.clinicNo = d.clinicNo 
LEFT JOIN (
	SELECT c.clinicNo, a.aptDate, count(distinct a.aptId) aptMade
	FROM appointment a, clinic c
	WHERE a.clinicNo = c.clinicNo
	GROUP BY c.clinicNo, a.aptDate
) a ON a.clinicNo = c.clinicNo AND a.aptDate = d.distDate 
GROUP BY c.clinicNo, d.distDate
HAVING sum(noDoses) - aptMade > 0
ORDER BY distDate;

# Does health district impact type of vaccine distributed?
SELECT h.districtName, v.vaccineName, SUM(noDoses) / districtDoses doseProp
FROM healthdistrict h
LEFT JOIN  (
	SELECT h.districtNo, SUM(noDoses) districtDoses
	FROM healthdistrict h, distributes d, clinic c
	WHERE h.districtNo = c.districtNo AND c.clinicNo = d.clinicNo 
	GROUP BY h.districtNo
) t ON t.districtNo = h.districtNo
LEFT JOIN clinic c ON h.districtNo = c.districtNo
LEFT JOIN distributes d ON c.clinicNo = d.clinicNo 
LEFT JOIN supplier s ON s.supplierNo = d.supplierNo
LEFT JOIN vaccinetype v ON v.vaccineNo = s.vaccineNo
GROUP BY v.vaccineNo, h.districtNo;


-- Q6: Is the lack of vaccines or lack of employees at clinics the reason why people are not being vaccinated?
# Determining how many doses, employees, and appointments each clinic has on a given day.
SELECT d.clinicNo, d.distDate, d.noDoses, COUNT(DISTINCT a.patientNo) AS noAppointments, COUNT(DISTINCT eNumber) AS NoEmployees
FROM Distributes d, Appointment a, Works w
WHERE d.clinicNo = a.clinicNo AND d.clinicNo = w.clinicNo
GROUP BY d.clinicNo, d.distDate, d.noDoses
ORDER BY d.clinicNo;
