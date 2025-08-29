## Project Overview
BMW (Bayerische Motoren Werke), also known as Bavarian Motor Works, is a German multinational luxury vehicle and motorcycle manufacturer headquartered in Munich. 
 
The company is well-known for its premium and luxury vehicles, as well as high-performance BMW M and BMW Motorrad motorcycles. 
This project focuses on exploratory data analysis (EDA) and dashboard creation using BMW sales data obtained from Kaggle in order to uncover critical insights that will help BMW improve its sales performance.

Insights and recommendations are provided on the following key areas:

- **Sales & Revenue Trends Over Years**: An analysis of how BMW's total sales/revenue changes over time (year by year), which helps determine overall growth or decline.
- **Model & Fuel type performance**: An evaluation of how various BMW models contribute to total sales and revenue.
- **Regional Performance**: A comparative analysis of BMW's performance in different regions. A review of which models perform best in which regions. These include regional preferences for specific models, as well as strategic product placement opportunities.

Download the interactive Power BI dashboard [here](https://app.powerbi.com/view?r=eyJrIjoiYzU4NmIzNzktYmFiMC00NTQyLWFhNGEtZWI0YjY0MTE4NjBhIiwidCI6IjM1YmEzNjIzLWQzNDgtNDAxMi04OTkwLWMxNWI2YThlNGRkNCJ9).

The SQL queries used for the exploratory data analysis can be found [here]([SQL (BMW) files/01_EDA_queries.sql](https://github.com/Khaythefirst/BMW-Sales-EDA-Dashboard/tree/main/SQL%20(BMW)%20files)).

All SQL queries regarding various business questions are available [here]([SQL (BMW) files/01_EDA_queries.sql](https://github.com/Khaythefirst/BMW-Sales-EDA-Dashboard/tree/main/SQL%20(BMW)%20files)).

## Data Structure
The BMW sales data consists of 11 columns: Model, Year, Region, Color, Fuel_type, Transmission, Engine_size_L, Mileage_KM, Price_USD, Sales_Volume, Sales_Classification with a total row count of 50,000 rows.

Source: [Kaggle](https://www.kaggle.com/datasets/y0ussefkandil/bmw-sales2010-2024)

_**P.S**: Upon cleaning the data, no duplicates were found and no null or blank values. Regardless, I still standardize all data._

## Executive Summary
### Overview of Findings

With a notable peak in 2022, BMW's sales have grown significantly across seven regions between 2010 and 2024. Analysis by model and fuel type reveals that certain models consistently outsell others, with hybrid vehicles dominating most regions and petrol vehicles showing emerging growth trends. Though certain models can be held largely responsible for this increase, the following sections will address additional contributing factors and highlight important areas for improvement.

Below is the overview page from the Power BI dashboard and more examples are included throughout the report. The entire interactive dashboard can be downloaded [here](https://app.powerbi.com/view?r=eyJrIjoiYzU4NmIzNzktYmFiMC00NTQyLWFhNGEtZWI0YjY0MTE4NjBhIiwidCI6IjM1YmEzNjIzLWQzNDgtNDAxMi04OTkwLWMxNWI2YThlNGRkNCJ9).

<img width="1511" height="854" alt="Image" src="https://github.com/user-attachments/assets/4a19cda5-f6e0-4587-8048-c13bef3e1fc1" />


### Sales & Revenue Trends:

- BMW’s performance between 2010 and 2024 shows clear highs and lows. In 2022, the company hit its peak, generating $1.34 trillion in revenue with 17.9 million units sold, marking the strongest year in the period under review.
- However, there were setbacks along the way. Both 2020 and 2023 saw significant drops, with 2023 being the weakest year, recording just $1.22 trillion in revenue and 16.2 million sales.
- Despite these downturns, the brand showed resilience. A slight recovery in 2021 paved the way for a peak 2022, and following a dramatic drop in 2023, sales and revenue rebounded strongly in 2024.
- Overall, the year-over-year trends show a cyclical pattern of decline and recovery, but one that consistently demonstrates BMW's strong market presence and ability to rebound.

### Model & Fuel type performance:

- Across the years and regions, the 7 Series, 3 Series, i8, X1, and 5 Series consistently rank as BMW’s top-selling models.
- With the 7 Series standing out by appearing in the top five for 11 different years. The 7 Series alone contributed an impressive $1.79 trillion in revenue and 23.79 million units sold, making it the brand’s strongest performer.
- Notably, it sold the highest number of hybrid cars, totaling 6.2 million units, alongside 6.1 million diesel, 5.8 million petrol, and 5.7 million electric.
- At the other end of the spectrum, the M3 model ranks as the weakest performer in both sales and revenue.
- When comparing fuel types, hybrid vehicles lead the pack, generating $4.82 trillion in revenue, outperforming petrol, electric, and diesel categories. This reflects a clear consumer preference shift toward hybrid models within BMW’s lineup.

### Regional Performance:

- BMW’s revenue distribution across regions is fairly balanced, though some stand out more than others. Asia leads the pack, contributing 17.1% of total revenue and achieving 42.97 million sales, with the X1 and hybrid models driving its success.
- Europe follows closely with 16.77% of revenue and 42.56 million cars sold, where the i8 and hybrids dominate.
- In North America, revenue share stands at 16.74% with 42.40 million sales, led by the 7 Series and electric vehicles.
- The Middle East comes next at 16.66% of revenue and 42.33 million sales, where the 7 Series and petrol cars perform best.
- South America accounts for 16.38% of revenue with 41.55 million sales, driven by the X6 and diesel models.
- Finally, Africa rounds out the list at 16.35% of revenue and 41.57 million sales, with the 5 Series and petrol vehicles leading the way.
- Overall, the data highlights Asia as the strongest region, while Africa and South America trail slightly behind, though each region shows distinct model and fuel type preferences that shape BMW’s global performance.

### Recommendation:

Based on the uncovered insights, the following recommendations have been provided.

- Regional performance reveals clear differences in customer preferences, which are closely related to each region's economic level.
- Hybrid vehicles are dominant in Asia, Europe, North America, and the Middle East, accounting for a significant portion of revenue and sales, whereas their impact is less pronounced in South America and Africa.
- This suggests that matching vehicle distribution to regional demand is critical to maintaining growth.
- To increase sales, BMW should prioritize marketing more hybrid models to regions where it already leads, while also reinforcing other fuel types where it is dominant.
- The data clearly shows that success is not just about the model, but also about matching the right fuel type to the right region, based on customer preferences and local economic realities.


