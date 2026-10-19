DROP TABLE IF EXISTS hospital_readmissions;

-- create a table
CREATE TABLE hospital_readmissions (
    age VARCHAR(20),
    time_in_hospital INT,
    n_lab_procedures INT,
    n_procedures INT,
    n_medications INT,
    n_outpatient INT,
    n_inpatient INT,
    n_emergency INT,
    medical_specialty VARCHAR(100),
    diag_1 VARCHAR(50),
    diag_2 VARCHAR(50),
    diag_3 VARCHAR(50),
    glucose_test VARCHAR(20),
    A1Ctest VARCHAR(20),
    change_med VARCHAR(20),
    diabetes_med VARCHAR(20),
    readmitted VARCHAR(10)
);

-- import dataset
COPY hospital_readmissions 
FROM 'G:\kaggle dataset unzip file\hospital_readmissions.csv'
WITH (
	FORMAT csv,
	HEADER TRUE,
	DELIMITER ','
);

-- Step 1: Duplicate Check age, time_in_hospital, and diag_1
SELECT age, time_in_hospital, diag_1, COUNT(*)
FROM hospital_readmissions
GROUP BY age, time_in_hospital, diag_1
HAVING COUNT(*) > 1;

-- Step 2: Text Missing/Null Values Handling 
UPDATE hospital_readmissions
SET medical_specialty = 'Unknown'
WHERE medical_specialty IS NULL OR medical_specialty = '?' OR medical_specialty = '';

UPDATE hospital_readmissions
SET glucose_test = 'None'
WHERE glucose_test IS NULL OR glucose_test = '?' OR glucose_test = '';

UPDATE hospital_readmissions
SET A1Ctest = 'None'
WHERE A1Ctest IS NULL OR A1Ctest = '?' OR A1Ctest = '';

-- Step 3: Critical Missing Data Drop (Updated to use available columns)
DELETE FROM hospital_readmissions
WHERE age IS NULL OR age = '?' OR readmitted IS NULL;


/* Part 2: Business Analytical Queries
Q1. Overall Readmission Rate & Count */

SELECT 
    readmitted,
    COUNT(*) AS total_patients,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) AS percentage
FROM hospital_readmissions
GROUP BY readmitted;


-- Q2. Time in Hospital vs Readmission (Kya lamba stay karne wale patients jaldi readmit hote hain?)
SELECT 
    CASE 
        WHEN time_in_hospital BETWEEN 1 AND 3 THEN 'Short Stay (1-3 days)'
        WHEN time_in_hospital BETWEEN 4 AND 7 THEN 'Medium Stay (4-7 days)'
        ELSE 'Long Stay (>7 days)'
    END AS stay_duration,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_under_30_days,
    ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate_30d
FROM hospital_readmissions
GROUP BY stay_duration
ORDER BY readmission_rate_30d DESC;


-- Q3. Age Group vs Readmission Rate
SELECT 
    age,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_under_30_days,
    ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM hospital_readmissions
GROUP BY age
ORDER BY readmission_rate DESC;


-- Q4. Number of Inpatient Visits vs Readmission (Prior visits ka asar)
SELECT 
    CASE 
        WHEN n_inpatient = 0 THEN 'No Prior Inpatient Visit'
        WHEN n_inpatient BETWEEN 1 AND 3 THEN '1-3 Prior Visits'
        ELSE '4+ Prior Visits'
    END AS prior_visit_category,
    COUNT(*) AS total_patients,
    SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) AS readmitted_under_30_days,
    ROUND(SUM(CASE WHEN readmitted = '<30' THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 2) AS readmission_rate
FROM hospital_readmissions
GROUP BY prior_visit_category
ORDER BY readmission_rate DESC;