1 Clicks = SUM(fact_engagement_data[Clicks])
2 Likes = SUM(fact_engagement_data[Likes]) 
3 Number of Campaigns = DISTINCTCOUNT(fact_engagement_data[CampaignID])
4 Number of Customer Journeys = DISTINCTCOUNT(fact_customer_journey[JourneyID]) 
5 Number of Customer Reviews = DISTINCTCOUNT(fact_customer_review[ReviewID]) 
6 Rating(Average) = AVERAGE(fact_customer_review[Rating])
7 Views = SUM(fact_engagement_data[Views])
8 Conversion Rate = 
VAR TotalVisitors = CALCULATE( COUNT (fact_customer_journey[JourneyID]) , fact_customer_journey[Action] = "View" )
VAR TotalPurchases = CALCULATE(
    COUNT(fact_customer_journey[JourneyID]),
    fact_customer_journey[Action] = "Purchase"
)
RETURN
IF(
    TotalVisitors = 0, 
    0, 
    DIVIDE(TotalPurchases, TotalVisitors)
)


## Calendar DAX 
Calendar = 
ADDCOLUMNS (
    CALENDAR ( DATE ( 2023, 1, 1 ), DATE ( 2025, 12, 31 ) ),
    "DateAsInteger", FORMAT ( [Date], "YYYYMMDD" ),
    "Year", YEAR ( [Date] ),
    "Monthnumber", FORMAT ( [Date], "MM" ),
    "YearMonthnumber", FORMAT ( [Date], "YYYY/MM" ),
    "YearMonthShort", FORMAT ( [Date], "YYYY/mmm" ),
    "MonthNameShort", FORMAT ( [Date], "mmm" ),
    "MonthNameLong", FORMAT ( [Date], "mmmm" ),
    "DayOfWeekNumber", WEEKDAY ( [Date] ),
    "DayOfWeek", FORMAT ( [Date], "dddd" ),
    "DayOfWeekShort", FORMAT ( [Date], "ddd" ),
    "Quarter", "Q" & FORMAT ( [Date], "Q" ),
    "YearQuarter",
        FORMAT ( [Date], "YYYY" ) & "/Q"
            & FORMAT ( [Date], "Q" )
)