# Global Automotive Sales Analysis (2015-2025): SQL & Synthetic Data Generation

## Overview
This project applies foundational database management and SQL querying skills to analyze global automotive sales trends by engine type: Internal Combustion Engine (ICE), Electric Vehicles (EV), and Hybrid. Instead of using a static dataset, realistic synthetic data was generated using Python to simulate linear market shifts between 2015 and 2025 across the top 10 vehicle market countries (China, USA, Japan, India, Germany, UK, Brazil, Canada, South Korea, Italy).

## Data Generation Methodology
The dataset was engineered using Python (`sqlite3` and `random` libraries) to reflect actual industry transformations.
* **Baseline & Target Metrics:** The simulation uses a 2015 global baseline (ICE: 97.0%, Hybrid: 2.4%, EV: 0.6%) and country-specific target metrics for 2025 (e.g., China EV: 31%, USA EV: 10%, Germany EV: 19%).
* **Linear Transformation:** A progression multiplier `t = (Selected_Year - 2015) / 10` was applied to calculate dynamic probabilities for each year during data generation.
* **Database Setup:** Generated records were inserted into an SQLite database (`car_engine_sales.db`), containing 3,000 yearly regional sales data points.

## SQL Analysis & Architecture
The repository includes 21 distinct SQL query files located in the `queries/` directory, executed using SQLite to analyze market share, growth rates, and regional shifts.

**Key SQL Techniques Utilized:**
* **Aggregations & Grouping:** Extensive use of `SUM()`, `ROUND()`, `GROUP BY`, and `ORDER BY` to calculate total vehicle sales by region and engine type.
* **Common Table Expressions (CTEs):** Used `WITH` clauses to build modular temporary result sets for complex comparative calculations between 2015 and 2025.
* **Table Joins:** Utilized `JOIN` and `LEFT JOIN` to merge CTEs and calculate volume differences and percentage growths across years.
* **Conditional Logic:** Implemented `CASE WHEN` statements to handle undefined percentage growths (e.g., division by zero for regions with 0 EV sales in 2015).

## Key Business Findings
1. **Decline of Traditional ICE:** Between 2015 and 2025, traditional ICE vehicles experienced a significant market share decline globally, dropping to ~55.5% of total sales by 2025.
2. **Regional Variations:** Europe and Asia demonstrated rapid adoption of EV and Hybrid technologies, while the American market showed a more conservative transition with ICE vehicles maintaining a higher share.
3. **Strategic Insight:** Automotive manufacturers must prioritize EV and Hybrid production for Asian and European markets while balancing ICE and alternative powertrains in the Americas.

## Repository Structure
* `queries/`: Directory containing 21 numbered `.sql` query files organized chronologically (2015 analysis, 2025 analysis, and comparative trend analysis).
* `data_generator.py`: Python script containing the market share logic and SQLite database generation script.
* `car_engine_sales.db`: Generated SQLite database file containing the synthetic 2015-2025 automotive sales dataset.
