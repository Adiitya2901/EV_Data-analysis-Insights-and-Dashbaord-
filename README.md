#  EV Analytics Project  
*SQL + Power BI dashboard analyzing EV adoption, charging infrastructure, and market trends*

---

##  Introduction  
This is my first end-to-end data analytics project leveraging **SQL Server** and **Power BI** to build interactive dashboards and derive insights from Electric Vehicle datasets.  

The project provides insights into:  
- Charging infrastructure availability  
- EV adoption growth  
- Market-leading models  
- Regional disparities and trends  

The dataset was sourced from **Kaggle** and consists of 4 CSV files:  
- Charging Stations  
- World Summary  
- EV Models  
- Country Summary  


##  Tools & Technologies  
- **SQL Server** – Database setup, data cleaning, and transformations  
- **Visual Studio Code** – Writing & executing SQL queries  
- **Power BI Desktop** – Dashboard creation & visualization  
- **GitHub** – Project documentation & version control  


## Project Workflow  

### 1. Database Setup  
- Created a dedicated database: `EV_Project`
  For that:
      - Open Command Palette → Ctrl + Shift + P
      - Type MS SQL: Connect 
      - Enter connection details (e.g., Server: localhost)
      - Create a new database name = EV_Project 
- Imported all 4 datasets as SQL tables  

 SQL scripts available in this repo:  
- [`Table_Creation.sql`](./Table_Creation.sql)  
- [`Data_Cleaning.sql`](./Data_Cleaning.sql)  

### 2. Data Cleaning & Preparation  
- Removed **duplicates** and **4660 rows with negative/null values** in `power_kw`  
- Standardized country codes (`KR → South Korea`, `UK → United Kingdom`, `SE/CN → Sweden/China`)  
- Created a **Country Dimension table** for consistent relationships  

### 3. Dashboard Development (Power BI)  
- Connected Power BI to SQL database  
- Built relationships across tables in **Model View**  
  ![Model View Overview](image.pdf)  
- Designed interactive visuals 


##  Dashboard Visuals  

### Gauge Charts  
- **Total Charging Stations** → Overall scale of EV infrastructure  
- **Total Countries** → Geographical coverage  
- **Avg. Charging Stations per Country** → Distribution density  

### Table Chart  
- Shows EV Model details: Company, Model, Bodytype, Year, Source Country, Market Regions  
- Helps users explore granular-level EV model data  

### Column Bar Chart  
- **EV Models launched per year** → Highlights growth patterns and trends over time  

### Slicers (Filters)  
- Country, Company, Year  
- Makes dashboard interactive and user-friendly  

### Dashboard File
The complete Power BI dashboard can be found here:  
[EV_Dashboard.pbix](files/EV_Dashboard.pbix)

## Key Insights  
From the dashboard, we can see that the **United States** is leading with more than 82,000 charging stations, followed by the **UK** (26,825) and **Germany** (23,373). On the other hand, **China** and **Japan** have launched a large number of EV models despite having fewer charging stations, which highlights a gap between adoption and infrastructure.

Looking at the year-wise trend, **2021** and **2022** witnessed the highest number of EV model launches, with major contributions from companies like Tesla, Ford, Rivian, BYD, and NIO.

When it comes to body type, **SUVs** and **crossovers** dominate the market, particularly in regions like the **US**, **Sweden**, and **Japan**.

Overall, the insights show how different regions are focusing on different priorities—the **US** is strong in charging station infrastructure, **China** is pushing rapid model launches, while **European** countries such as **Sweden** and **Germany** are balancing both adoption and infrastructure growth.

