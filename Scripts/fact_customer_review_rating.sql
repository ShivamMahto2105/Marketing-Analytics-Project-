--************************************************************
--************************************************************

-- Query to clean the whitespace issues in the ReviewText Column

SELECT 
	ReviewID,
	CustomerID,
	ProductID,
	ReviewDate,
	Rating,
	--Cleans up the ReviewText by replacing the double space with single space to ensure the text is more readable.
	REPLACE(ReviewText, '  ', ' ') AS ReviewText
FROM 
	dbo.customer_reviews