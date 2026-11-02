import sqlite3
import random 

countries_dict = {
    "China": {"region": "Asia", "market_share": 29.9, "engine_type_2025": [31, 20, 49]}, # EV, Hybrid, ICE respectively
    "USA": {"region": "Americas", "market_share": 18.5, "engine_type_2025": [10, 14, 76]},
    "Japan": {"region": "Asia", "market_share": 5.1, "engine_type_2025": [2, 55, 43]},
    "India": {"region": "Asia", "market_share": 5.1, "engine_type_2025": [3, 2, 95]},
    "Germany": {"region": "Europe", "market_share": 3.2, "engine_type_2025": [19, 30, 51]},
    "United Kingdom": {"region": "Europe", "market_share": 2.75, "engine_type_2025": [23, 25, 52]},
    "Brazil": {"region": "Americas", "market_share": 2.5, "engine_type_2025": [3, 5, 92]},
    "Canada": {"region": "Americas", "market_share": 2.4, "engine_type_2025": [6, 20, 74]},
    "South Korea": {"region": "Asia", "market_share": 2.1, "engine_type_2025": [12, 28, 60]},
    "Italy": {"region": "Europe", "market_share": 2.0, "engine_type_2025": [6, 44, 50]}
}

country_list = list(countries_dict.keys())
weight_list = [countries_dict[country]["market_share"] for country in country_list]

print("Countries: ", country_list)
print("Weights: ", weight_list)

conn = sqlite3.connect("car_engine_sales.db")
cursor = conn.cursor()

cursor.execute("DROP TABLE IF EXISTS car_engine_sales")

cursor.execute("""
    CREATE TABLE car_engine_sales (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        year INTEGER,
        region TEXT,
        country TEXT,
        engine_type TEXT,
        sales_volume INTEGER
    )
""")

print("Reset existing table if any, created new table with specified name. Proceeding with data generation...")

for i in range(3000):
    # Random year selection
    selected_year = random.randint(2015, 2025)

    # Country selection based on market share weight
    selected_country = random.choices(country_list, weights=weight_list, k=1)[0]

    # Region of the selected country
    selected_region = countries_dict[selected_country]["region"]

    # 2015 Fixed Engine Type Usage Percentages
    values_2015 = [0.6, 2.4, 97.0] #--> EV, Hybrid, and ICE percentages
    
    # Creation of yearly ratio multiplier
    t = (selected_year - 2015) / 10.0
    
    # 2015 Engine Type Usage Global Averages
    ev_2015, hybrid_2015, ice_2015 = values_2015

    # 2025 Country Engine Type Usage Percentages (Country Specific)
    ev_2025, hybrid_2025, ice_2025 = countries_dict[selected_country]["engine_type_2025"]

    # Calculation of dynamic engine type percentages by year
    ev_current = ev_2015 + (ev_2025 - ev_2015) * t
    hybrid_current = hybrid_2015 + (hybrid_2025 - hybrid_2015) * t
    ice_current = ice_2015 + (ice_2025 - ice_2015) * t

    # Yearly Engine Type Usage Percentages List
    current_weights = [ev_current, hybrid_current, ice_current]

    selected_engine = random.choices(["EV", "Hybrid", "ICE"], weights=current_weights, k=1)[0]

    # Random Sales Determination (Values in thousands scale --> 10=10000 or 100=100000)
    # Number ranges are set to roughly balance total annual sales in 2015 and 2025.
    # This increases the realism of the model.

    min_range_2015, max_range_2015 = (150, 300)
    min_range_2025, max_range_2025 = (200, 500)

    # Annual growth calculated linearly
    yearly_min = min_range_2015 + ((min_range_2025 - min_range_2015) * t)
    yearly_max = max_range_2015 + ((max_range_2025 - max_range_2015) * t)
    sales_volume = random.randint(int(yearly_min), int(yearly_max))

    cursor.execute("INSERT INTO car_engine_sales(year, region, country, engine_type, sales_volume) VALUES (?, ?, ?, ?, ?)", 
                   (selected_year, selected_region, selected_country, selected_engine, sales_volume))

conn.commit()
conn.close()

print("Research simulation database 'car_engine_sales.db' created successfully.")