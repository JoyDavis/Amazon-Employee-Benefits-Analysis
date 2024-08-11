-- 1. Amazon’s employee benefits
SELECT 
    company_name,
    paid_time_off_days,
    maternity_leave_weeks,
    avg_employee_tenure
FROM 
    fortune_companies
WHERE 
    company_name = 'Amazon.com Inc.';

-- 2. Average technology industry employee benefits
SELECT 
    industry,
    ROUND(AVG(paid_time_off_days),1) AS avg_paid_time_off,
    ROUND(AVG(maternity_leave_weeks),1) AS avg_maternity_leave,
    ROUND(AVG(avg_employee_tenure), 1) AS avg_tenure
FROM 
    fortune_companies
WHERE 
    industry = 'Technology'
GROUP BY 
    industry;

-- 3. Temp table for Amazon's employee benefits
CREATE TEMPORARY TABLE amazon_benefits AS
SELECT 
    company_name,
    paid_time_off_days,
    maternity_leave_weeks,
    avg_employee_tenure
FROM 
    fortune_companies
WHERE 
    company_name = 'Amazon.com Inc.';

-- 4. Temp table storing tech industry average for employee benefits
CREATE TEMPORARY TABLE tech_industry_averages AS
SELECT 
    industry,
    ROUND(AVG(paid_time_off_days), 1) AS avg_paid_time_off,
    ROUND(AVG(maternity_leave_weeks), 1) AS avg_maternity_leave,
    ROUND(AVG(avg_employee_tenure), 1) AS avg_tenure
FROM 
    fortune_companies
WHERE 
    industry = 'Technology'
GROUP BY 
    industry;

-- 5. Joining Amazon’s benefits with the Technology industry averages
SELECT 
    a.company_name,
    a.paid_time_off_days AS amazon_paid_time_off,
    t.avg_paid_time_off AS industry_avg_paid_time_off,
    a.maternity_leave_weeks AS amazon_maternity_leave,
    t.avg_maternity_leave AS industry_avg_maternity_leave,
    a.avg_employee_tenure AS amazon_tenure,
    t.avg_tenure AS industry_avg_tenure
FROM 
    amazon_benefits a
JOIN 
    tech_industry_averages t 
ON 
    t.industry = 'Technology';

-- 6. Tech companies that outperform Amazon in all three key employee benefits categories
SELECT 
    company_name,
    paid_time_off_days,
    maternity_leave_weeks,
    avg_employee_tenure
FROM 
    fortune_companies
WHERE 
    (paid_time_off_days > 22 
    AND maternity_leave_weeks > 14 
    AND avg_employee_tenure > 5.1)
    AND industry = 'Technology'
    AND company_name <> 'Amazon.com Inc.';
