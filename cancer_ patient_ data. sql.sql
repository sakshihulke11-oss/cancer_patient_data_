CREATE TABLE cancer_patients (
    PatientID VARCHAR(20) PRIMARY KEY,
    Gender VARCHAR(10),
    Age INT,
    Province VARCHAR(50),
    Ethnicity VARCHAR(50),
    TumorType VARCHAR(50),
    CancerStage VARCHAR(10),
    DiagnosisDate DATE,
    TumorSize FLOAT,
    Metastasis VARCHAR(10),
    TreatmentType VARCHAR(50),
    SurgeryDate DATE,
    ChemotherapySessions INT,
    RadiationSessions INT,
    SurvivalStatus VARCHAR(20),
    FollowUpMonths INT,
    SmokingStatus VARCHAR(20),
    AlcoholUse VARCHAR(20),
    GeneticMutation VARCHAR(50),
    Comorbidities VARCHAR(255)
);

select* from cancer_patients;


-- 1. Get all patients above 60 years
SELECT PatientID, Age, Gender, CancerStage 
FROM cancer_patients
WHERE Age > 60;


-- 2. Find patients diagnosed in the last 2 years
SELECT PatientID, DiagnosisDate, TumorType 
FROM cancer_patients
WHERE DiagnosisDate >= DATE_SUB(CURDATE(), INTERVAL 2 YEAR);


-- 3. List patients with metastasis and stage IV cancer
SELECT PatientID, Gender, Age, TumorType 
FROM cancer_patients
WHERE Metastasis = 'Yes' AND CancerStage = 'IV';

-- 4. Count number of patients by cancer stage
SELECT CancerStage, COUNT(*) AS TotalPatients
FROM cancer_patients
GROUP BY CancerStage;

-- 5. Average tumor size by gender
SELECT Gender, AVG(TumorSize) AS AvgTumorSize
FROM cancer_patients
GROUP BY Gender;

-- 6. Count patients by treatment type
SELECT TreatmentType, COUNT(*) AS Total
FROM cancer_patients
GROUP BY TreatmentType;


-- 7. Survival rate by cancer stage
SELECT CancerStage, 
       SUM(CASE WHEN SurvivalStatus = 'Alive' THEN 1 ELSE 0 END) * 100.0 / COUNT(*) AS SurvivalRate
FROM cancer_patients
GROUP BY CancerStage;

-- 8. Patients with longest follow-up
SELECT PatientID, FollowUpMonths, SurvivalStatus
FROM cancer_patients
ORDER BY FollowUpMonths DESC
LIMIT 5;

-- 9. Relation between smoking and cancer stage
SELECT SmokingStatus, CancerStage, COUNT(*) AS Total
FROM cancer_patients
GROUP BY SmokingStatus, CancerStage
ORDER BY SmokingStatus, CancerStage;


-- 10. Patients who had surgery but no chemotherapy
SELECT PatientID, SurgeryDate, ChemotherapySessions
FROM cancer_patients
WHERE SurgeryDate IS NOT NULL AND (ChemotherapySessions IS NULL OR ChemotherapySessions = 0);

-- 11. Patients with genetic mutations and metastasis
SELECT PatientID, GeneticMutation, TumorType, Metastasis
FROM cancer_patients
WHERE GeneticMutation IS NOT NULL AND Metastasis = 'Yes';

-- 12. Correlation between alcohol use and survival status
SELECT AlcoholUse, SurvivalStatus, COUNT(*) AS Total
FROM cancer_patients
GROUP BY AlcoholUse, SurvivalStatus;
