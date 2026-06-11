## 🧮 DAX Measures

All measures are defined in the `Marketing Analytics` Power BI model.

### ➤ Basic Aggregations

```dax
-- Total Clicks
Clicks = SUM(fact_engagement_data[Clicks])

-- Total Likes
Likes = SUM(fact_engagement_data[Likes])

-- Total Views
Views = SUM(fact_engagement_data[Views])

-- Average Customer Rating
Rating (Average) = AVERAGE(fact_customer_review[Rating])
```

### ➤ Count Measures

```dax
-- Distinct campaigns tracked
Number of Campaigns = DISTINCTCOUNT(fact_engagement_data[CampaignID])

-- Distinct customer journey entries
Number of Customer Journeys = DISTINCTCOUNT(fact_customer_journey[JourneyID])

-- Distinct customer reviews
Number of Customer Reviews = DISTINCTCOUNT(fact_customer_review[ReviewID])
```

### ➤ Conversion Rate

```dax
Conversion Rate =
VAR TotalVisitors =
    CALCULATE(
        COUNT(fact_customer_journey[JourneyID]),
        fact_customer_journey[Action] = "View"
    )
VAR TotalPurchases =
    CALCULATE(
        COUNT(fact_customer_journey[JourneyID]),
        fact_customer_journey[Action] = "Purchase"
    )
RETURN
    IF(
        TotalVisitors = 0,
        0,
        DIVIDE(TotalPurchases, TotalVisitors)
    )
```

> 💡 Uses `DIVIDE()` to safely handle zero-division, and `VAR` for readable, optimized logic.

---

## 📅 Calendar Table DAX

A fully computed date dimension covering **Jan 2023 – Dec 2025**:

```dax
Calendar =
ADDCOLUMNS(
    CALENDAR(DATE(2023, 1, 1), DATE(2025, 12, 31)),
    "DateAsInteger",   FORMAT([Date], "YYYYMMDD"),
    "Year",            YEAR([Date]),
    "Monthnumber",     FORMAT([Date], "MM"),
    "YearMonthnumber", FORMAT([Date], "YYYY/MM"),
    "YearMonthShort",  FORMAT([Date], "YYYY/mmm"),
    "MonthNameShort",  FORMAT([Date], "mmm"),
    "MonthNameLong",   FORMAT([Date], "mmmm"),
    "DayOfWeekNumber", WEEKDAY([Date]),
    "DayOfWeek",       FORMAT([Date], "dddd"),
    "DayOfWeekShort",  FORMAT([Date], "ddd"),
    "Quarter",         "Q" & FORMAT([Date], "Q"),
    "YearQuarter",     FORMAT([Date], "YYYY") & "/Q" & FORMAT([Date], "Q")
)
```

**Generated Columns:**

| Column | Example | Use |
|---|---|---|
| `DateAsInteger` | `20240315` | Fast integer joins |
| `Year` | `2024` | Year slicer |
| `Monthnumber` | `03` | Sort months correctly |
| `YearMonthnumber` | `2024/03` | Timeline axis |
| `YearMonthShort` | `2024/Mar` | Compact labels |
| `MonthNameShort` | `Mar` | Chart axis |
| `MonthNameLong` | `March` | Tooltips / cards |
| `DayOfWeekNumber` | `3` | Weekday sorting |
| `DayOfWeek` | `Wednesday` | Day-level analysis |
| `DayOfWeekShort` | `Wed` | Compact axis |
| `Quarter` | `Q1` | Quarterly slicer |
| `YearQuarter` | `2024/Q1` | YoY quarter comparison |

---