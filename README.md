# Apple Products Pricing Analysis 

**Can a data-driven approach reveal hidden pricing strategies in e-commerce?** This project analyzes 80,000 real pricing records to uncover how Amazon and Flipkart price Apple products differently, whether sale events are genuinely worth waiting for, and whether discount behavior can be predicted — turning raw transactional data into decisions a retail or pricing team could actually act on.

## The Business Question

Retailers and consumers both ask the same thing: *"Am I actually getting the best deal?"* This project answers that with real evidence — not assumptions — using SQL for analysis, Power BI for visualization, and machine learning for prediction.

## Dataset

80,000 daily pricing records for Apple products (iPhone, iPad, Mac, Watch) on Amazon and Flipkart, January 2020 - July 2026, including pricing, discounts, stock status, ratings, and reviews. Sourced from Kaggle.

## Tools Used
`SQL Server` · `Power BI` · `Python (scikit-learn, pandas)`

## Key Findings

**1. There's no single "cheaper" platform — it depends on the product**
Amazon wins on iPad, iPhone, and Watch pricing, but Flipkart is actually cheaper on Mac. A blanket "always buy on X" strategy is wrong.

**2. Regional sale events outperform global ones**
India-specific events — Big Billion Days (37.0% avg discount) and Great Indian Festival (33.4%) — cut deeper than the internationally known Black Friday (31.5%). Local competition drives more aggressive pricing than global campaigns.

**3. India pricing includes a real markup — not just currency conversion**
The data's implied exchange rate runs consistently at ₹95-99/$1, versus the real-world rate of ₹83-87/$1 — pointing to a steady ~15-20% markup across every product line, likely reflecting import duties rather than opportunistic pricing.

**4. Buying Renewed saves ~22-23%, with remarkable consistency**
Across Mac, iPhone, iPad, and Watch, refurbished pricing follows a strikingly uniform discount pattern — suggesting a standardized pricing formula rather than ad hoc markdowns.

**5. Older models get discounted harder than new releases**
MacBook Air M1 discounts noticeably more than the M3 — classic inventory clearance behavior ahead of new launches.

## From Insight to Prediction: Machine Learning

Beyond describing *what happened*, this project builds a Random Forest model to predict discount percentage — testing whether these patterns are strong enough to forecast pricing behavior.

| Metric | Result |
|---|---|
| Mean Absolute Error | 9.96 percentage points |
| R² Score | 0.48 |

**What actually drives discounts?**
1. Condition (Renewed vs. New) — **48%** of predictive power
2. Year — 19%
3. Whether it's a sale day at all — 10%
4. Product Category — 7-8% each
5. Platform — under 1%

**The honest, counterintuitive finding:** platform choice — the thing most price-comparison tools obsess over — barely matters. Product condition and timing drive discounts far more than where you shop.

## Repository Contents
| File | Description |
|---|---|
| `apple_pricing_analysis.sql` | All analytical SQL queries |
| `price_prediction.py` | Data pipeline, feature engineering, model training |
| `apple_pricing_model.pkl` | Saved trained Random Forest model |
| `apple_pricing_visualization.pbix` | Interactive Power BI dashboard |

## Dashboard Preview
<img width="1527" height="850" alt="image" src="https://github.com/user-attachments/assets/0abd86aa-dce3-4da4-b09d-54f65c970c40" />

## Author

**Aastha Pandya** | MIS Graduate (GPA: 3.8) | Data Analyst

GitHub: [github.com/aasthapandyaa](https://github.com/aasthapandyaa)

LinkedIn: [www.linkedin.com/in/aastha-pandya12](https://www.linkedin.com/in/aastha-pandya12)


