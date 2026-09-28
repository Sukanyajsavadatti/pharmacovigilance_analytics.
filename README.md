# Pharmacovigilance & Adverse Drug Event Analytics

## 📌 Project Overview

This project analyzes adverse drug events using healthcare data to identify patterns in drug safety, event severity, hospitalization, patient demographics, outcomes, and reporting trends.

The project combines **SQL, Python, and Power BI** to demonstrate an end-to-end healthcare data analytics workflow, from data exploration and querying to visualization and business insights.

---

## 🏥 Business Problem

Pharmacovigilance teams need to monitor adverse drug events and identify patterns that may require further investigation.

The objective of this project is to analyze:

* Which drug categories are associated with the highest number of adverse events?
* What is the distribution of adverse events by severity?
* How many reported events are classified as serious?
* Which drug categories have more hospitalized cases?
* What types of adverse events are reported most frequently?
* What are the outcomes of reported adverse events?
* How are adverse events distributed across patient genders?
* How do adverse event reports change over time?

---

## 🎯 Project Objectives

* Analyze adverse drug event patterns using SQL.
* Explore and clean healthcare data using Python.
* Identify frequently reported adverse event types.
* Analyze event severity and serious-event patterns.
* Examine hospitalization associated with adverse events.
* Analyze outcomes of adverse events.
* Understand demographic patterns in reported events.
* Build an interactive Power BI dashboard.
* Generate meaningful healthcare and pharmacovigilance insights.

---

## 🗂️ Dataset

The project contains four related datasets:

### 1. Patients

Contains patient demographic and medical information.

**Key fields:**

* Patient_ID
* Age
* Gender
* Country
* Medical_Condition

### 2. Drugs

Contains information about the drugs involved in reported events.

**Key fields:**

* Drug_ID
* Drug_Name
* Drug_Category
* Manufacturer

### 3. Adverse Events

Contains individual adverse drug event records.

**Key fields:**

* Event_ID
* Patient_ID
* Drug_ID
* Event_Date
* Event_Type
* Severity
* Serious_Event
* Hospitalized
* Outcome

### 4. Event Outcomes

Contains additional information about the resolution and follow-up of adverse events.

**Key fields:**

* Outcome_ID
* Event_ID
* Resolution_Days
* Follow_Up_Required

---

## 🛠️ Tools & Technologies

* **SQL — MySQL**

  * Data querying
  * Aggregation
  * Filtering
  * Grouping
  * Healthcare data analysis

* **Python**

  * Pandas
  * NumPy
  * Data cleaning
  * Exploratory data analysis
  * Data visualization

* **Power BI**

  * Data modeling
  * DAX measures
  * Interactive dashboard
  * KPI analysis
  * Data visualization

* **GitHub**

  * Project documentation
  * Version control
  * Portfolio presentation

---

## 🔍 SQL Analysis

SQL was used to analyze adverse drug event patterns across drugs, patients, severity levels, hospitalization, outcomes, and event types.

The analysis includes:

* Total adverse event analysis
* Adverse events by drug category
* Adverse events by severity
* Serious event analysis
* Hospitalization analysis
* Event type analysis
* Outcome analysis
* Patient demographic analysis
* Event trend analysis

The complete SQL queries are available in:

`SQL/pharmacovigilance_analysis.sql`

---

## 🐍 Python Analysis

Python was used for data exploration and analysis.

The Python workflow includes:

* Loading healthcare datasets
* Checking dataset structure
* Data quality inspection
* Missing-value analysis
* Descriptive statistics
* Exploratory data analysis
* Visualization of important patterns

The analysis is available in:

`Python/`

---

## 📊 Power BI Dashboard

An interactive Power BI dashboard was developed to provide an overview of adverse drug events.

### Key KPIs

* Total Adverse Events
* Serious Events
* Hospitalized Events
* Serious Event Rate
* Average Resolution Days

### Dashboard Visualizations

1. Adverse Events by Drug Category
2. Adverse Events by Severity
3. Serious vs Non-Serious Adverse Events
4. Hospitalized Events by Drug Category
5. Adverse Events by Event Type
6. Adverse Events by Outcome
7. Adverse Events by Gender
8. Adverse Events Trend Over Time

The Power BI dashboard file is available in:

`PowerBI/`

---

## 💡 Key Insights

The dashboard was used to identify patterns in:

* Drug categories associated with reported adverse events
* Distribution of event severity
* Serious versus non-serious events
* Hospitalization patterns
* Frequently reported adverse event types
* Patient outcomes
* Gender distribution
* Changes in adverse event reporting over time



---

## 📈 Conclusion

This project demonstrates an end-to-end healthcare analytics workflow using **SQL, Python, and Power BI**.

By combining structured querying, exploratory analysis, and interactive visualization, the project provides a data-driven view of adverse drug events and their associated characteristics.

The project also demonstrates practical skills in **healthcare data analysis, data modeling, SQL querying, Python-based EDA, DAX, Power BI dashboard development, and analytical storytelling**.

---

## 📁 Project Structure

```text
PROJECT2_pharmacovigilance_analytics/
│
├── data/
│   ├── patients.csv
│   ├── drugs.csv
│   ├── adverse_events.csv
│   └── event_outcomes.csv
│
├── SQL/
│   └── pharmacovigilance_analysis.sql
│
├── Python/
│   └── pharmacovigilance_analysis.ipynb
│
├── PowerBI/
│   └── pharmacovigilance_dashboard.pbix
│
└── README.md
```

---

## 👩‍💻 Skills Demonstrated

**Healthcare Analytics | SQL | MySQL | Python | Pandas | NumPy | Power BI | DAX | Data Cleaning | Exploratory Data Analysis | Data Visualization | Data Modeling | Dashboard Development | Analytical Storytelling**
