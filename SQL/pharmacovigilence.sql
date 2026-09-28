USE pharmacovigilance_analytics;

SELECT COUNT(*) AS patient_count
FROM patients;

SELECT COUNT(*) AS drug_count
FROM drugs;

SELECT COUNT(*) AS event_count
FROM adverse_events;

SET SQL_SAFE_UPDATES = 0;

DELETE FROM adverse_events;

SELECT COUNT(*) AS event_count
FROM adverse_events;

SELECT COUNT(*) AS outcome_count
FROM event_outcomes;

USE pharmacovigilance_analytics;

SELECT COUNT(*) AS total_events
FROM adverse_events;

SELECT COUNT(*) AS events_with_valid_patients
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id;

SELECT COUNT(*) AS events_with_valid_drugs
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id;

SELECT COUNT(*) AS events_with_outcomes
FROM adverse_events ae
JOIN event_outcomes eo
    ON ae.event_id = eo.event_id;
    
/* BUSINESS QUESTIONS- Overall adverse event analysis*/
-- 1.1 Total number of adverse events
SELECT COUNT(*) AS total_adverse_events
FROM adverse_events;


-- 1.2 Number of unique patients reporting adverse events
SELECT COUNT(DISTINCT patient_id) AS unique_patients
FROM adverse_events;


-- 1.3 Number of unique drugs associated with adverse events
SELECT COUNT(DISTINCT drug_id) AS drugs_with_events
FROM adverse_events;


-- 1.4 Distribution of adverse event severity
SELECT
    severity,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY severity
ORDER BY event_count DESC;


-- 1.5 Distribution of adverse event types
SELECT
    event_type,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY event_type
ORDER BY event_count DESC;


-- 1.6 Serious vs non-serious adverse events
SELECT
    serious_event,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY serious_event
ORDER BY event_count DESC;


-- 1.7 Hospitalization status
SELECT
    hospitalized,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY hospitalized
ORDER BY event_count DESC;


-- =========================================================
-- 2. DRUG ANALYSIS
-- =========================================================

-- 2.1 Adverse events by drug
SELECT
    d.drug_name,
    d.drug_category,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
GROUP BY d.drug_id, d.drug_name, d.drug_category
ORDER BY event_count DESC;


-- 2.2 Adverse events by drug category
SELECT
    d.drug_category,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
GROUP BY d.drug_category
ORDER BY event_count DESC;


-- 2.3 Serious events by drug
SELECT
    d.drug_name,
    COUNT(ae.event_id) AS serious_event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
WHERE ae.serious_event = 'Yes'
GROUP BY d.drug_id, d.drug_name
ORDER BY serious_event_count DESC;


-- 2.4 Hospitalizations by drug
SELECT
    d.drug_name,
    COUNT(ae.event_id) AS hospitalization_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
WHERE ae.hospitalized = 'Yes'
GROUP BY d.drug_id, d.drug_name
ORDER BY hospitalization_count DESC;


-- 2.5 Adverse events by manufacturer
SELECT
    d.manufacturer,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
GROUP BY d.manufacturer
ORDER BY event_count DESC;




-- =========================================================
-- 3. PATIENT & DEMOGRAPHIC ANALYSIS
-- =========================================================

-- 3.1 Adverse events by gender
SELECT
    p.gender,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id
GROUP BY p.gender
ORDER BY event_count DESC;


-- 3.2 Adverse events by country
SELECT
    p.country,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id
GROUP BY p.country
ORDER BY event_count DESC;


-- 3.3 Adverse events by medical condition
SELECT
    p.medical_condition,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id
GROUP BY p.medical_condition
ORDER BY event_count DESC;


-- 3.4 Adverse events by age group
SELECT
    CASE
        WHEN p.age < 18 THEN 'Under 18'
        WHEN p.age BETWEEN 18 AND 29 THEN '18-29'
        WHEN p.age BETWEEN 30 AND 44 THEN '30-44'
        WHEN p.age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS age_group,
    COUNT(ae.event_id) AS event_count
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id
GROUP BY age_group
ORDER BY event_count DESC;


-- 3.5 Severe events by age group
SELECT
    CASE
        WHEN p.age < 18 THEN 'Under 18'
        WHEN p.age BETWEEN 18 AND 29 THEN '18-29'
        WHEN p.age BETWEEN 30 AND 44 THEN '30-44'
        WHEN p.age BETWEEN 45 AND 59 THEN '45-59'
        ELSE '60+'
    END AS age_group,
    COUNT(ae.event_id) AS severe_event_count
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id
WHERE ae.severity = 'Severe'
GROUP BY age_group
ORDER BY severe_event_count DESC;


-- =========================================================
-- 4. OUTCOME & RESOLUTION ANALYSIS
-- =========================================================

-- 4.1 Distribution of event outcomes
SELECT
    outcome,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY outcome
ORDER BY event_count DESC;


-- 4.2 Average resolution time by severity
SELECT
    ae.severity,
    ROUND(AVG(eo.resolution_days), 2) AS avg_resolution_days
FROM adverse_events ae
JOIN event_outcomes eo
    ON ae.event_id = eo.event_id
GROUP BY ae.severity
ORDER BY avg_resolution_days DESC;


-- 4.3 Average resolution time by event type
SELECT
    ae.event_type,
    COUNT(*) AS event_count,
    ROUND(AVG(eo.resolution_days), 2) AS avg_resolution_days
FROM adverse_events ae
JOIN event_outcomes eo
    ON ae.event_id = eo.event_id
GROUP BY ae.event_type
ORDER BY avg_resolution_days DESC;


-- 4.4 Follow-up requirement
SELECT
    eo.follow_up_required,
    COUNT(*) AS event_count
FROM event_outcomes eo
GROUP BY eo.follow_up_required
ORDER BY event_count DESC;


-- 4.5 Outcome by severity
SELECT
    ae.severity,
    ae.outcome,
    COUNT(*) AS event_count
FROM adverse_events ae
GROUP BY ae.severity, ae.outcome
ORDER BY ae.severity, event_count DESC;



-- =========================================================
-- 5. TIME TREND ANALYSIS
-- =========================================================

-- 5.1 Adverse events by year
SELECT
    YEAR(event_date) AS event_year,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY YEAR(event_date)
ORDER BY event_year;


-- 5.2 Adverse events by month
SELECT
    MONTH(event_date) AS event_month,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY MONTH(event_date)
ORDER BY event_month;


-- 5.3 Adverse events by year and severity
SELECT
    YEAR(event_date) AS event_year,
    severity,
    COUNT(*) AS event_count
FROM adverse_events
GROUP BY YEAR(event_date), severity
ORDER BY event_year, event_count DESC;


-- 5.4 Serious events by year
SELECT
    YEAR(event_date) AS event_year,
    COUNT(*) AS serious_event_count
FROM adverse_events
WHERE serious_event = 'Yes'
GROUP BY YEAR(event_date)
ORDER BY event_year;


-- 5.5 Hospitalized events by year
SELECT
    YEAR(event_date) AS event_year,
    COUNT(*) AS hospitalized_event_count
FROM adverse_events
WHERE hospitalized = 'Yes'
GROUP BY YEAR(event_date)
ORDER BY event_year;




-- =========================================================
-- 6. CROSS-TABLE ANALYSIS
-- =========================================================

-- 6.1 Adverse events by drug and severity
SELECT
    d.drug_name,
    ae.severity,
    COUNT(*) AS event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
GROUP BY d.drug_id, d.drug_name, ae.severity
ORDER BY d.drug_name, event_count DESC;


-- 6.2 Adverse events by drug and outcome
SELECT
    d.drug_name,
    ae.outcome,
    COUNT(*) AS event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
GROUP BY d.drug_id, d.drug_name, ae.outcome
ORDER BY d.drug_name, event_count DESC;


-- 6.3 Adverse events by medical condition and severity
SELECT
    p.medical_condition,
    ae.severity,
    COUNT(*) AS event_count
FROM adverse_events ae
JOIN patients p
    ON ae.patient_id = p.patient_id
GROUP BY p.medical_condition, ae.severity
ORDER BY p.medical_condition, event_count DESC;


-- 6.4 Drug category and serious events
SELECT
    d.drug_category,
    COUNT(*) AS serious_event_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
WHERE ae.serious_event = 'Yes'
GROUP BY d.drug_category
ORDER BY serious_event_count DESC;


-- 6.5 Drug category and hospitalization
SELECT
    d.drug_category,
    COUNT(*) AS hospitalization_count
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
WHERE ae.hospitalized = 'Yes'
GROUP BY d.drug_category
ORDER BY hospitalization_count DESC;


-- 6.6 Average resolution time by drug category
SELECT
    d.drug_category,
    COUNT(eo.event_id) AS event_count,
    ROUND(AVG(eo.resolution_days), 2) AS avg_resolution_days
FROM adverse_events ae
JOIN drugs d
    ON ae.drug_id = d.drug_id
JOIN event_outcomes eo
    ON ae.event_id = eo.event_id
GROUP BY d.drug_category
ORDER BY avg_resolution_days DESC;
