# 🏥 Hospital Readmissions & Healthcare Analytics Dashboard

This project analyzes the Hospital Readmissions dataset (130-US hospitals) using **PostgreSQL**, **Python (Pandas)**, and **Power BI** to identify key risk factors contributing to patient readmissions within 30 days and optimize clinical workflows.

---

## 📊 Dashboard Preview
 ![HOSPITAL Preview](Hospital Analysis DashBoard.png)

---

## 🛠️ Tech Stack & Tools Used
* **Database & Querying:** PostgreSQL, pgAdmin 4 (Data schema setup, hygiene scripts, and analytical aggregations)
* **Data Processing:** Python (Pandas, NumPy for missing value handling, `pd.cut`, and custom categorization)
* **Visualization:** Power BI Desktop (Dark slate & neon teal/purple theme, KPI cards, interactive slicers)
* **Version Control:** Git & GitHub

---

## 🔍 Key Business & Clinical Questions Addressed
1. **Overall Readmission Rate:** What percentage of patients are readmitted within 30 days versus after 30 days or not at all?
2. **Stay Duration Impact:** Does a longer length of stay in the hospital increase the likelihood of early readmission?
3. **Age-Wise Risk Analysis:** Which age brackets experience the highest rates of patient readmission?
4. **Prior Inpatient History:** How heavily do prior hospital visits influence future readmission patterns?

---

## 📂 Repository Structure
* `hospital_readmissions_cleaned.csv` -> Processed and cleaned dataset ready for Power BI import
* `hospital_cleaning.py` -> Python script for handling missing values (`?`, `NaN`), dropping invalid records, and cleaning columns
* `hospital_queries.sql` -> SQL scripts for data cleaning, integrity checks, and clinical metric queries
* `Hospital_Readmissions_Dashboard.pbix` -> Power BI Interactive Dashboard File

---

## 🚀 Key Insights & Findings
* **Inpatient History Correlation:** Patients with 4 or more prior inpatient visits show a drastically higher 30-day readmission risk, signaling a need for chronic care management.
* **Length of Stay:** Extended stays correlate with complex medical histories, highlighting the importance of post-discharge follow-up care.
* **Age Factor:** Older demographics account for a large portion of early readmissions, requiring targeted geriatric care planning.

---

## 👨‍💻 Author
**Yogesh Kumar**
* BCA Student | Aspiring Data Analyst
