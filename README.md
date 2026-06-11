# 📊 Marketing Analytics Project
### *ShopEasy – Customer Engagement & Conversion Optimization*

> **Author:** Shivam Kumar Mahto  
> **Tool:** Power BI | Python | SQL Server  
> **Database:** `PortfolioProject_MarketingAnalytics`  
> **Data Range:** January 2023 – December 2025

---

## 🧩 Business Problem

**ShopEasy**, an online retail business, is facing reduced customer engagement and conversion rates despite increasing investment in online marketing campaigns.

Key challenges identified:

- **Reduced Customer Engagement** – Declining interactions with site content and marketing materials
- **Decreased Conversion Rates** – Fewer site visitors converting into paying customers
- **Poor Marketing ROI** – Increased marketing spend not translating into proportional revenue
- **Customer Dissatisfaction** – Drop in overall customer feedback scores and satisfaction

---

## 🎯 Project Goals

| Goal | Description |
|---|---|
| 📈 Increase Conversion Rates | Identify funnel drop-off points and optimize the customer journey |
| 💬 Enhance Customer Engagement | Determine which content types drive highest engagement |
| ⭐ Improve Customer Feedback | Analyze reviews to surface actionable sentiment insights |
| 💰 Optimize Marketing Spend | Align budget allocation with highest-performing channels |

**KPIs Tracked:**
- Conversion Rate *(% of visitors who purchase)*
- Customer Engagement Rate *(clicks, likes, views)*
- Average Order Value (AOV)
- Customer Feedback Score *(average review rating)*

---

## 🖼️ Dashboard Preview

> 4 dashboard pages — click to view full-size previews.

### Page 1 – Overview / Executive Summary
![Overview Dashboard](https://github.com/ShivamMahto2105/Marketing-Analytics-Project-/blob/main/Docs/Overview.png)

### Page 2 – Conversion Details
![Conversion Details](https://github.com/ShivamMahto2105/Marketing-Analytics-Project-/blob/main/Docs/Conversion%20Details.png)

### Page 3 – Social Media Details
![Social Media Details](https://github.com/ShivamMahto2105/Marketing-Analytics-Project-/blob/main/Docs/Social%20Media%20Details.png)

### Page 4 – Customer Reviews & Sentiment Analysis
![Customer Review Rating](https://github.com/ShivamMahto2105/Marketing-Analytics-Project-/blob/main/Docs/Customer%20Review%20Details.png)

```

| Table | Type | Key Columns | Description |
|---|---|---|---|
| `fact_customer_journey` | Fact | JourneyID, CustomerID, Action, Date | Tracks site visits → purchases (conversion funnel) |
| `fact_engagement_data` | Fact | CampaignID, Clicks, Likes, Views, Date | Measures content engagement per campaign |
| `fact_customer_reviews` | Fact | ReviewID, CustomerID, Rating, ReviewText | Raw customer feedback (1–5 star ratings) |
| `dim_customers` | Dimension | CustomerID, Name, Region, Segment | Customer profile information |
| `dim_products` | Dimension | ProductID, Name, Category | Product catalog details |
| `dim_date` | Dimension | Date, Month, Quarter, Year | Custom calendar table (see DAX below) |

---

## 🐍 Python – Sentiment Enrichment

The script `Scripts/customer_review_enrichment.py` connects to SQL Server, fetches raw customer reviews, and enriches them with NLP-based sentiment analysis using **VADER (NLTK)**.

### What it does

1. **Fetches** review data from `dbo.customer_reviews` via `pyodbc`
2. **Calculates** a compound sentiment score (`-1.0` to `+1.0`) per review
3. **Categorizes** sentiment combining the score AND star rating:

| Sentiment Score | Rating | → Category |
|---|---|---|
| > 0.05 (Positive) | ≥ 4 | ✅ Positive |
| > 0.05 (Positive) | = 3 | 🔀 Mixed Positive |
| > 0.05 (Positive) | ≤ 2 | 🔀 Mixed Negative |
| < -0.05 (Negative) | ≤ 2 | ❌ Negative |
| < -0.05 (Negative) | = 3 | 🔀 Mixed Negative |
| < -0.05 (Negative) | ≥ 4 | 🔀 Mixed Positive |
| Neutral | ≥ 4 | ✅ Positive |
| Neutral | ≤ 2 | ❌ Negative |
| Neutral | = 3 | ➖ Neutral |

4. **Buckets** scores into ranges:

| Bucket | Meaning |
|---|---|
| `0.5 to 1.0` | Strongly Positive |
| `0.0 to 0.49` | Mildly Positive |
| `-0.49 to 0.0` | Mildly Negative |
| `-1.0 to -0.5` | Strongly Negative |

5. **Exports** enriched data to `fact_customer_reviews_with_sentiment.csv`

### Setup & Run

```bash
# Install dependencies
pip install pandas nltk pyodbc sqlalchemy

# Run the script
python Scripts/customer_review_enrichment.py
```

> ⚙️ Update the connection string in the script with your SQL Server instance name before running.

```python
conn_str = (
    "Driver={SQL Server};"
    "Server=YOUR_SERVER\SQLEXPRESS;"
    "Database=PortfolioProject_MarketingAnalytics;"
    "Trusted_Connection=yes;"
)
```

## 📊 Key Insights from Data

Based on `fact_customer_reviews_with_sentiment.csv` *(1,363 reviews)*:

| Sentiment Category | Count | % |
|---|---|---|
| ✅ Positive | 840 | 61.6% |
| ❌ Negative | 226 | 16.6% |
| 🔀 Mixed Negative | 196 | 14.4% |
| 🔀 Mixed Positive | 86 | 6.3% |
| ➖ Neutral | 15 | 1.1% |

| Score Bucket | Count |
|---|---|
| 0.0 to 0.49 *(mildly positive)* | 564 |
| 0.5 to 1.0 *(strongly positive)* | 464 |
| -0.49 to 0.0 *(mildly negative)* | 317 |
| -1.0 to -0.5 *(strongly negative)* | 18 |

> 📌 **~62% of reviews are positive**, but the ~31% mixed/negative segment is where key improvement opportunities lie for ShopEasy's product and customer experience teams.

---

## 🛠️ Tech Stack

| Layer | Technology |
|---|---|
| 📊 Dashboard & Visualization | Power BI Desktop |
| 🧮 Data Modeling & Measures | DAX (Data Analysis Expressions) |
| 🔄 Data Transformation | Power Query (M Language) |
| 🐍 Sentiment Analysis | Python 3, NLTK (VADER), Pandas |
| 🗄️ Database | Microsoft SQL Server (Express) |
| 🔌 DB Connector | pyodbc, SQLAlchemy |
| 📁 Data Format | CSV, .pbix, .bak |

---
