/* select top 5 *
from train; */

-- Q1) Find customers with a Credit_Score below the average for all customers.

/* select *
from train
where Credit_Score < (select AVG(Credit_Score) from train) */

-- 44% customers have a credit score below average for all customers

-- To exclude NULL values: Credit_Score<(select AVG(Credit_Score) from train) AND Credit_Score IS NOT NULL

-- Q2) Identify the most common Policy_Type for customers with Health_Score greater than 20.

/* select TOP 1 Policy_Type, count(Policy_Type) as Policy_Count
from train
where Health_Score > 20
group by Policy_Type
order by Policy_Count DESC; */

-- There are slightly more Premium policies as compared to Basic and Comprehensive

-- Q3) Retrieve the top 2 locations by the total Premium_Amount collected.

/* SELECT TOP 2 Location, SUM(Premium_Amount) as Total_Premium
from train
group by Location
order by Total_Premium DESC; */

-- There was more premium collected from Suburban and Rural as compared to Urban

-- Q4) Find the percentage of customers who have provided Customer_Feedback as "Poor."
/* SELECT count(*) * 100.0/(SELECT count(*) FROM train) AS 'Percentage'
FROM train
WHERE Customer_Feedback = 'Poor';
*/

-- 31.3% customers felt that their customer experience with the insurance was poor

-- Q5) List all customers whose Policy_Start_Date falls in the last 6 months.

/*
select id, Policy_Start_Date
from train 
where Policy_Start_Date >= DATEADD(MONTH, -6, (select max(Policy_Start_Date) from train));

SELECT Policy_Start_Date
FROM train
WHERE ISDATE(Policy_Start_Date) = 0;

ALTER TABLE train
ALTER COLUMN Policy_Start_Date DATETIME;

select month(Policy_Start_Date)
from train;
*/

-- Q6) Identify the number of customers grouped by Education_Level and Marital_Status.

/*
select Education_Level, Marital_Status, count(*) as 'NumberofCustomers'
from train
group by Education_Level, Marital_Status
order by NumberofCustomers;
*/

-- Q7) Find the Occupation with the highest average Premium_Amount

/*
SELECT TOP 1 Occupation, AVG(Premium_Amount) as AvgPremium
FROM train
WHERE Occupation IS NOT NULL
GROUP BY Occupation 
ORDER BY AvgPremium DESC;
*/

-- Q8) Calculate the average Health_Score for customers who smoke (Smoking_Status = 1) compared to those who don’t.

/*
SELECT Smoking_Status, count(*), AVG(Health_Score)
FROM train
GROUP BY Smoking_Status
ORDER BY Smoking_Status DESC;
*/

-- There is insignificant difference between people who smoke vs who do not smoke

-- Difficult Level Questions

-- Q9) Find customers who are "Self-Employed" and have both a Health_Score greater than 30 and a Credit_Score greater than 500.
/*
SELECT id, Occupation, Health_Score, Credit_Score
FROM train
WHERE Occupation = 'Self-Employed' AND Health_Score > 30 AND Credit_Score > 500;
*/

-- Q10) Identify customers whose Insurance_Duration is in the top 10% of all durations.
/*
WITH RankedDurations AS (
    SELECT PERCENTILE_CONT(0.9) WITHIN GROUP (ORDER BY Insurance_Duration) OVER() AS Percentile
    FROM train
)
SELECT *
FROM train
WHERE Insurance_Duration >= (SELECT Percentile from RankedDurations);
*/

/*
WITH RankedDurations AS (
    SELECT *, NTILE(10) OVER (ORDER BY Insurance_Duration DESC) AS Decile
    FROM train
)
SELECT *
FROM RankedDurations
WHERE Decile=1;
*/

-- Q11) Calculate the monthly Premium_Amount collected in 2024, grouped by Policy_Type.
/*
SELECT Policy_Type, month(Policy_Start_Date) as MonthS, SUM(Premium_Amount) as MontlyPremiumAmount
FROM train
WHERE YEAR(Policy_Start_Date) = 2024
GROUP BY Policy_Type, month(Policy_Start_Date);
*/

-- Q12) Find the Location with the highest number of customers who made more than 2 Previous_Claims.
/* 
SELECT TOP 1
    Location,
    COUNT(*) AS Customer_Count
FROM train
WHERE Previous_Claims > 2
GROUP BY Location
ORDER BY Customer_Count DESC;
*/

-- Suburban has the highest number of customers with more than 2 claims

-- Q13) List all customers whose Vehicle_Age is below the average and who provided Customer_Feedback as "Good."
/*
SELECT id, Vehicle_Age, Customer_Feedback
FROM train
WHERE Vehicle_Age < (SELECT AVG(Vehicle_Age) FROM train) AND Customer_Feedback = 'Good';
*/

-- Q14) Identify the Property_Type with the most customers having a Marital_Status of "Single."
/*
SELECT TOP 1 Property_Type, count(*) as SinglePropCount
FROM train
WHERE Marital_Status = 'Single'
GROUP BY Property_Type
ORDER BY SinglePropCount DESC;
*/

-- Singles prefer to own Apartments more as compared to others

-- Q15) Determine how many customers fall into each Exercise_Frequency category, grouped by Location.
/*
SELECT Location, Exercise_Frequency, Count(*) as NoOfCustomers
FROM train
GROUP BY Location, Exercise_Frequency;
*/

-- Q16) Find the difference in the total Premium_Amount collected between Urban and Rural customers.
/*
WITH a1 as (SELECT SUM(Premium_Amount) as Urban_Premium FROM train WHERE Location = 'Urban'),
WITH a2 as (SELECT SUM(Premium_Amount) as Rural_Premium FROM train WHERE Location = 'Rural');

SELECT (a1.Urban_Premium - a2.Rural_Premium) as DiffPrem
FROM a1, a2;
*/

/*
SELECT (Urban_Premium - Rural_Premium) as DiffPrem
FROM
	(SELECT SUM(CASE WHEN Location = 'Urban' THEN Premium_Amount ELSE 0 END) AS 'Urban_Premium', 
			SUM(CASE WHEN Location = 'Rural' THEN Premium_Amount ELSE 0 END) AS 'Rural_Premium'
	FROM train) AS train2;
*/

-- Rural collects more premium than Urban

--Q17) Identify customers whose Policy_Type is "Comprehensive" but their Premium_Amount is in the bottom 25%
/*
WITH Bottom25 AS (
    SELECT 
        PERCENTILE_CONT(0.25) WITHIN GROUP (ORDER BY Premium_Amount) 
        OVER () AS Percentile
    FROM train
    WHERE Policy_Type = 'Comprehensive'
)
SELECT *
FROM train
WHERE Premium_Amount < (SELECT DISTINCT Percentile FROM Bottom25);
*/

-- Q18) List all customers whose Annual_Income is greater than the maximum Annual_Income of customers in "Rural" locations.
/*
SELECT id, Annual_Income, Location
FROM train
WHERE Annual_Income > (SELECT max(Annual_Income) FROM train WHERE Location = 'Rural');
*/