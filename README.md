# ⚽ Sports Performance & Injury Risk Analytics

### 🎯 Objective
A full-scale analytics project combining **player performance**, **injury risk modeling**, and **training load optimization** to improve sports science decision-making.  
The solution applies **machine learning** and **linear programming** to identify high-risk players and generate optimized weekly training loads.

---

## 📊 Project Overview

| Phase | Description |
|-------|--------------|
| **1️⃣ EDA & Data Modeling** | Analyze player metrics, wellness, and workload data. |
| **2️⃣ Predictive Analytics** | Build injury risk model (Logistic Regression + Random Forest + XGBoost). |
| **3️⃣ Optimization Modeling** | Optimize training loads using Linear Programming (PuLP). |
| **4️⃣ Visualization** | Power BI dashboards for team and player insights. |

---

## 🗂 Power BI Dashboard

### 1. Player Risk & Performance Overview

- Risk Distribution  
- Average Predicted Risk  
- Team Comparison  
- Player Details (sortable, filterable)

![Player Risk & Performance Overview](./Power%20BI%20Dashboard/Player%20Risk%20&%20Performance%20Overview.jpeg)

### 2. Training Optimization Scenarios

- Scenario Comparison: Balanced vs Recovery vs HighPerformance  
- Risk vs Load Scatter  
- Recommended Scenario Card  
- Player-level load plan

![Training Optimization Scenarios](./Power%20BI%20Dashboard/Training%20Optimization%20Scenarios.jpeg)

### 3. Team Insights & Risk Hotspots

- Team KPIs: Avg Risk, Avg Load, Expected Risk  
- Trend Charts  
- Summary Text from optimization_summary.md

![Team Insights & Risk Hotspots](./Power%20BI%20Dashboard/Team%20Insights%20&%20Risk%20Hotspots.jpeg)

---

## ⚙️ Tech Stack
- **Language:** Python 3.12  
- **Libraries:** pandas, numpy, scikit-learn, matplotlib, pulp, joblib  
- **Database:** Microsoft SQL Server  
- **Visualization:** Power BI Desktop  
- **Optimization:** Linear Programming (PuLP)

---

## 🧠 Methodology

1. **Data Preparation:**  
   - Player-level workload & injury data cleaned and standardized  
   - Derived metrics: *Acute:Chronic Workload Ratio (ACWR)*, *Fatigue Index*, etc.

2. **Modeling:**  
   - Injury risk prediction via Random Forest + XGBoost  
   - Risk probability exported (`InjuryRiskScores.csv`)

3. **Optimization:**  
   - LP model minimizes expected injury risk under workload & fatigue constraints  
   - Three Scenarios: Balanced, Recovery, HighPerformance  
   - Outputs: `optimized_training_plan.csv`, `optimization_kpis.csv`

4. **Visualization:**  
   - Power BI dashboards integrate risk, workload, and scenario KPIs  
   - Scenario slicer enables management decision simulation

---

## 📈 Outputs
| File | Description |
|------|--------------|
| `InjuryRiskScores.csv` | Player-level risk predictions |
| `optimized_training_plan.csv` | Training load recommendations |
| `optimization_kpis.csv` | Team KPIs per scenario |
| `optimization_summary.md` | Narrative summary of results |

---

## 📚 Documentation
See the `/docs/` folder for:
- `insights_summary.md` — business insights  
- `methodology.md` — technical methodology  
- `scenario_analysis.md` — optimization stress tests  

---

## 📌 Author
👤 **Aman Kumar Singh**  
📧 amankrsingh1831@gmail.com  
🔗 www.linkedin.com/in/aman-kumar-singh-3a3305387  

---

## 📄 License
MIT License  
Feel free to fork and adapt for educational or professional use.
