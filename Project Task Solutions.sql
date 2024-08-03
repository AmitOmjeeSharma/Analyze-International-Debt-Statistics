USE the_worldbank_data;

SELECT * FROM debt_data;

/* 1.	What is the total amount of debt that is owed by the countries listed in the dataset? */
SELECT `Country Name` ,CONCAT('$ ', ROUND(`Value`/1000000000,2), ' bn') as Debt
FROM debt_data
WHERE `Series Code` = 'DT.DOD.DECT.CD' AND Years = 2022;


/* 2.	Which country owns the maximum amount of debt and what does that amount look like? */
SELECT `Country Name` ,CONCAT('$ ', ROUND(`Value`/1000000000000,2), ' T') as Debt
FROM debt_data
WHERE `Series Code` = 'DT.DOD.DECT.CD' AND Years = 2022
ORDER BY `Value` DESC
LIMIT 1;

/* 3.	What is the average amount of debt owed by countries across different debt indicators? */

SELECT `Series Name`, CONCAT('$ ', ROUND(AVG(`Value`)/1000000000,2), ' bn') AS avg_debt FROM debt_data
WHERE `Series Name` IN (
    'External debt stocks, total (DOD, current US$)',
    'External debt stocks, long-term (DOD, current US$)',
    'External debt stocks, short-term (DOD, current US$)',
    'External debt stocks, public and publicly guaranteed (PPG) (DOD, current US$)',
    'External debt stocks, private nonguaranteed (PNG) (DOD, current US$)',
    'PPG, bilateral (DOD, current US$)',
    'PPG, multilateral (DOD, current US$)',
    'PPG, official creditors (DOD, current US$)',
    'PPG, private creditors (DOD, current US$)',
    'PPG, bonds (DOD, current US$)',
    'PPG, commercial banks (DOD, current US$)',
    'PNG, bonds (DOD, current US$)',
    'PNG, commercial banks and other creditors (DOD, current US$)',
    'Use of IMF credit (DOD, current US$)'
)
AND Years = 2022
GROUP BY `Series Name`
ORDER BY AVG(`Value`) DESC;



/* 4.	How many unique countries are represented in the dataset? */

SELECT COUNT(DISTINCT(`Country Name`)) AS Total_Countries
FROM debt_data;

/* 5.	What are the different types of debt indicators present in the dataset? */

SELECT DISTINCT `Series Name`
FROM debt_data
WHERE `Series Name` LIKE 'External debt stocks%' 
   OR `Series Name` LIKE 'PPG%'
ORDER BY `Series Name`;

/* 6.	What is the total amount of debt owed by all countries combined? */

SELECT CONCAT('$ ',ROUND(SUM(`Value`)/1000000000000,3), ' T') AS Total_Debt 
FROM debt_data
WHERE `Series Code` = 'DT.DOD.DECT.CD' AND Years = 2022;

/* 7.	Which country has accumulated the highest total debt when all debt indicators are considered together? */

SELECT `Country Name`, CONCAT('$ ',ROUND(SUM(`Value`)/1000000000000,3), ' T') AS Total_Debt
FROM debt_data
WHERE `Series Name` IN (
    'External debt stocks, total (DOD, current US$)',
    'External debt stocks, long-term (DOD, current US$)',
    'External debt stocks, short-term (DOD, current US$)',
    'External debt stocks, public and publicly guaranteed (PPG) (DOD, current US$)',
    'External debt stocks, private nonguaranteed (PNG) (DOD, current US$)',
    'PPG, bilateral (DOD, current US$)',
    'PPG, multilateral (DOD, current US$)',
    'PPG, official creditors (DOD, current US$)',
    'PPG, private creditors (DOD, current US$)',
    'PPG, bonds (DOD, current US$)',
    'PPG, commercial banks (DOD, current US$)',
    'PNG, bonds (DOD, current US$)',
    'PNG, commercial banks and other creditors (DOD, current US$)',
    'Use of IMF credit (DOD, current US$)'
)
AND Years = 2022
GROUP BY `Country Name`
ORDER BY Total_Debt DESC
LIMIT 1;


/* 8.	What is the maximum amount of principal repayments made by any country in a single year? */

SELECT `Country Name`, CONCAT('$ ',ROUND(MAX(`Value`)/1000000000,2), ' B') AS Max_PR
FROM debt_data
WHERE `Series Code` = 'DT.AMT.DLXF.CD' AND Years = 2022
GROUP BY `Country Name`
ORDER BY MAX(`Value`) DESC
LIMIT 1;

/* 9.	Which debt indicator appears most frequently in the dataset? */

SELECT `Series Name`, COUNT(*) AS Indicator_Frequency
FROM debt_data
WHERE Years = 2022
GROUP BY `Series Name`
ORDER BY Indicator_Frequency DESC, `Series Name` ASC 


