# Global Automotive Sales Analysis (2015-2025): SQL & Synthetic Data Generation

## Overview
This project applies foundational database management and SQL querying skills to analyze global automotive sales trends by engine type: Internal Combustion Engine (ICE), Electric Vehicles (EV), and Hybrid. Instead of relying on a static external dataset, dynamic synthetic data was generated using Python to simulate realistic market shifts between 2015 and 2025 across the top 10 automotive market countries (China, USA, Japan, India, Germany, UK, Brazil, Canada, South Korea, Italy).

## Data Generation Methodology
The dataset is dynamically generated using Python (`sqlite3` and `random` libraries) based on real-world industry baseline parameters:
* **Baseline & Target Metrics:** Uses a 2015 global baseline (ICE: ~97.0%, Hybrid: ~2.4%, EV: ~0.6%) and country-specific target market shares for 2025 (e.g., China EV target: 31%, USA EV target: 10%, Germany EV target: 19%).
* **Linear Interpolation:** Calculates year-specific dynamic engine probabilities for each generated record using a linear progression factor `t = (Selected_Year - 2015) / 10`.
* **Database Setup:** Automatically populates an SQLite database (`car_engine_sales.db`) with simulated transaction records across regions and engine types.

## SQL Analysis & Architecture
The repository features 21 structured SQL queries located in the `queries/` directory, designed to analyze sales volume changes, market shares, and regional adoption rates.

**Key SQL Techniques Utilized:**
* **Aggregations & Grouping:** Extensive use of `SUM()`, `ROUND()`, `GROUP BY`, and `ORDER BY` to aggregate sales volumes by region, year, and powertrain.
* **Common Table Expressions (CTEs):** Implementation of modular `WITH` clauses to build structured multi-step queries for comparative analysis between benchmark years (2015 vs. 2025).
* **Relational Joins:** Usage of `JOIN` and `LEFT JOIN` to combine temporal CTEs for volume delta calculations and percentage growth metrics.
* **Conditional Logic:** Application of `CASE WHEN` statements to gracefully handle edge cases such as division by zero (undefined growth) for early-stage market data.

## Simulated Market Insights
* **Powertrain Transition:** The model successfully reflects the global transition away from traditional ICE vehicles toward EV and Hybrid adoption over the 10-year span.
* **Regional Divergence:** Simulates strong European and Asian EV/Hybrid expansion versus a more gradual shift in the Americas.
* **Data-Driven Strategy:** Demonstrates how SQL queries can extract actionable insights for automotive manufacturers optimizing regional production strategies.

## Repository Structure
* `queries/`: Directory containing 21 numbered `.sql` scripts organized chronologically (2015 baseline, 2025 projections, and comparative trend queries).
* `data_generator.py`: Python script containing the weighted simulation logic and database schema generation.
* `car_engine_sales.db`: Generated SQLite database containing the synthetic 2015-2025 automotive sales dataset.
