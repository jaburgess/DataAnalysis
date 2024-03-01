select *
from DataJobsDB.dbo.DataProfessionalSurvey


--Working on Cleaning Current Role Column

select [Q1 - Which Title Best Fits your Current Role?]
from DataJobsDB.dbo.DataProfessionalSurvey

select [Q1 - Which Title Best Fits your Current Role?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q1 - Which Title Best Fits your Current Role?] like '%:BI %'


--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q1 - Which Title Best Fits your Current Role?] = 'BI Analyst'
--WHERE [Q1 - Which Title Best Fits your Current Role?] LIKE '%:BI %';


select [Q1 - Which Title Best Fits your Current Role?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q1 - Which Title Best Fits your Current Role?] like '%:Business %'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q1 - Which Title Best Fits your Current Role?] = 'Business Analyst'
--WHERE [Q1 - Which Title Best Fits your Current Role?] like '%:Business %'


select [Q1 - Which Title Best Fits your Current Role?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q1 - Which Title Best Fits your Current Role?] like '%:Software %'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q1 - Which Title Best Fits your Current Role?] = 'Software Engineer'
--WHERE [Q1 - Which Title Best Fits your Current Role?] like '%:Software %'

select [Q1 - Which Title Best Fits your Current Role?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q1 - Which Title Best Fits your Current Role?] like '%:Analytics Engineer%'

UPDATE DataJobsDB.dbo.DataProfessionalSurvey
SET [Q1 - Which Title Best Fits your Current Role?] = 'Analytics Engineer'
WHERE [Q1 - Which Title Best Fits your Current Role?] like '%:Analytics Engineer%'

select [Q1 - Which Title Best Fits your Current Role?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q1 - Which Title Best Fits your Current Role?] like '%Manager%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q1 - Which Title Best Fits your Current Role?] = 'Database Manager'
--WHERE [Q1 - Which Title Best Fits your Current Role?] like '%Manager%'


--Working on Cleaning Programming Language Column

select [Q5 - Favorite Programming Language]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q5 - Favorite Programming Language] like '%Other:%SQL%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q5 - Favorite Programming Language] = 'SQL'
--WHERE [Q5 - Favorite Programming Language] like '%Other:%SQL%'

select [Q5 - Favorite Programming Language]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q5 - Favorite Programming Language] like '%Other:%Excel%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q5 - Favorite Programming Language] = 'Excel'
--WHERE [Q5 - Favorite Programming Language] like '%Other:%Excel%'

select [Q5 - Favorite Programming Language]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q5 - Favorite Programming Language] like '%None%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q5 - Favorite Programming Language] = 'None'
--WHERE [Q5 - Favorite Programming Language] like '%None%'

select [Q5 - Favorite Programming Language]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q5 - Favorite Programming Language] like '%Other%'

--Working on Cleaning Country of Origin

select *
from DataJobsDB.dbo.DataProfessionalSurvey

select [Q11 - Which Country do you live in?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q11 - Which Country do you live in?] like '%Argent%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q11 - Which Country do you live in?] = 'Argentina'
--WHERE [Q11 - Which Country do you live in?] like '%Argent%'

select [Q11 - Which Country do you live in?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q11 - Which Country do you live in?] like '%Other%'

select [Q11 - Which Country do you live in?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q11 - Which Country do you live in?] like '%Other%Australia%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q11 - Which Country do you live in?] = 'Kenya'
--WHERE [Q11 - Which Country do you live in?] like '%Other%Kenya%'


SELECT [Q11 - Which Country do you live in?], COUNT(*) AS CountryCount
FROM DataJobsDB.dbo.DataProfessionalSurvey
WHERE [Q11 - Which Country do you live in?] LIKE 'Other%'
GROUP BY [Q11 - Which Country do you live in?]
order by CountryCount desc;

--Working on Cleaning Industry

select [Q4 - What Industry do you work in?]
from DataJobsDB.dbo.DataProfessionalSurvey

select [Q4 - What Industry do you work in?]
from DataJobsDB.dbo.DataProfessionalSurvey
where [Q4 - What Industry do you work in?] like '%Other%'

SELECT [Q4 - What Industry do you work in?], COUNT(*) AS IndustryCount
FROM DataJobsDB.dbo.DataProfessionalSurvey
WHERE [Q4 - What Industry do you work in?] LIKE '%Other%'
GROUP BY [Q4 - What Industry do you work in?]
order by IndustryCount desc;

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q4 - What Industry do you work in?] = 'Consulting'
--WHERE [Q4 - What Industry do you work in?] like '%Other%Consulting%'

--UPDATE DataJobsDB.dbo.DataProfessionalSurvey
--SET [Q4 - What Industry do you work in?] = 'Marketing'
--WHERE [Q4 - What Industry do you work in?] like '%Other%Marketing%'


select *
from DataJobsDB.dbo.DataProfessionalSurvey