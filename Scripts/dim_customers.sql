--************************************************************
--************************************************************

-- SQL Statement to join dim_customers with dim_geography to enrich customer data with geographic infornation
SELECT 
	c.CustomerID,
	c.CustomerName,
	c.Email,
	c.Gender,
	c.Age,
	g.Country,
	g.City
FROM dbo.customers as c
LEFT JOIN dbo.geography as g
ON 
	c.GeographyID = g.GeographyID  -- Joins the two tables on the GeographyID field to match customers with their geographic information