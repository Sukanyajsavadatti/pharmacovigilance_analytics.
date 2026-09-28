import pandas as pd

# Load datasets
patients = pd.read_csv("data/patients.csv")
drugs = pd.read_csv("data/drugs.csv")
adverse_events = pd.read_csv("data/adverse_events.csv")
event_outcomes = pd.read_csv("data/event_outcomes.csv")

# Convert date column
adverse_events["event_date"] = pd.to_datetime(adverse_events["event_date"])

# Display dataset sizes
print("Patients:", patients.shape)
print("Drugs:", drugs.shape)
print("Adverse Events:", adverse_events.shape)
print("Event Outcomes:", event_outcomes.shape)

# Check missing values
print("\nMissing Values:")
print(patients.isnull().sum())
print(drugs.isnull().sum())
print(adverse_events.isnull().sum())
print(event_outcomes.isnull().sum())

# Basic statistical summary
print("\nPatient Age Statistics:")
print(patients["age"].describe())


# =========================================================
# PYTHON ANALYSIS
# =========================================================

import matplotlib.pyplot as plt


# 1. Overall event severity distribution
severity_counts = adverse_events["severity"].value_counts()

print("\nSeverity Distribution:")
print(severity_counts)


# 2. Serious event and hospitalization rates
total_events = len(adverse_events)

serious_events = (adverse_events["serious_event"] == "Yes").sum()
hospitalized_events = (adverse_events["hospitalized"] == "Yes").sum()

serious_rate = (serious_events / total_events) * 100
hospitalization_rate = (hospitalized_events / total_events) * 100

print("\nKey Safety Metrics:")
print(f"Total adverse events: {total_events}")
print(f"Serious events: {serious_events}")
print(f"Serious event rate: {serious_rate:.2f}%")
print(f"Hospitalized events: {hospitalized_events}")
print(f"Hospitalization rate: {hospitalization_rate:.2f}%")


# 3. Average resolution time
avg_resolution = event_outcomes["resolution_days"].mean()

print(f"Average resolution time: {avg_resolution:.2f} days")


# =========================================================
# VISUALIZATIONS
# =========================================================

# 4. Severity distribution
plt.figure(figsize=(8, 5))
severity_counts.plot(kind="bar")

plt.title("Adverse Events by Severity")
plt.xlabel("Severity")
plt.ylabel("Number of Events")
plt.xticks(rotation=0)

plt.tight_layout()
plt.show()


# 5. Adverse events by year
yearly_events = (
    adverse_events
    .groupby(adverse_events["event_date"].dt.year)
    .size()
)

print("\nAdverse Events by Year:")
print(yearly_events)

plt.figure(figsize=(8, 5))
yearly_events.plot(kind="line", marker="o")

plt.title("Adverse Events by Year")
plt.xlabel("Year")
plt.ylabel("Number of Events")

plt.tight_layout()
plt.show()


# 6. Top 10 drugs by adverse-event reports
top_drugs = (
    adverse_events
    .merge(drugs[["drug_id", "drug_name"]], on="drug_id")
    ["drug_name"]
    .value_counts()
    .head(10)
)

print("\nTop 10 Drugs by Adverse Event Reports:")
print(top_drugs)

plt.figure(figsize=(9, 5))
top_drugs.sort_values().plot(kind="barh")

plt.title("Top 10 Drugs by Adverse Event Reports")
plt.xlabel("Number of Events")
plt.ylabel("Drug")

plt.tight_layout()
plt.show()