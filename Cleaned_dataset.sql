CREATE SCHEMA IF NOT EXISTS Dirtydataset;


SET search_path TO dirtydataset;


CREATE TABLE IF NOT EXISTS dirtydata (
	Name TEXT,
	Age	TEXT,
	Gender	TEXT,
	Salary	TEXT,
	Department	TEXT,
	Start_Date	TEXT,
	Email	TEXT,
	Phone_Number	TEXT,
	Address	TEXT,
	Project_Assigned	TEXT

);


SELECT * FROM dirtydata;

COPY dirtydata
FROM 'C:\Users\haroon traders\Desktop\SQL Project\dirtydataset.csv'
DELIMITER ',' HEADER;


SELECT * FROM dirtydata;


----------- COPY THE TABLE -----------------------------------

CREATE TABLE dirtydata_backup (LIKE dirtydata INCLUDING ALL );

INSERT INTO dirtydata_backup 
SELECT * FROM dirtydata;


SELECT * FROM dirtydata_backup ;



----------------- Let's handle Duplicates ------------------

SELECT * FROM dirtydata;

WITH duplicates_cte AS( SELECT row_number() OVER 
	(PARTITION BY 
		Name,
		Age,
		Gender,
		Salary,	
		Department,
		Start_Date,
		Email,	
		Phone_Number,
		Address,
		Project_Assigned) as row_num, *
FROM dirtydata)
SELECT * FROM duplicates_cte
WHERE row_num > 1;



WITH duplicates_cte AS (
    SELECT 
        row_number() OVER (
            PARTITION BY 
                Name, Age, 
				Gender, Salary, 
				Department, Start_Date, 
                Email, Phone_Number, 
				Address, Project_Assigned
        ) AS row_num, *
    FROM dirtydata
)
DELETE FROM dirtydata
WHERE EXISTS (
    SELECT 1
    FROM duplicates_cte
    WHERE duplicates_cte.row_num > 1
    AND duplicates_cte.Name = dirtydata.Name
    AND duplicates_cte.Age = dirtydata.Age
    AND duplicates_cte.Gender = dirtydata.Gender
    AND duplicates_cte.Salary = dirtydata.Salary
    AND duplicates_cte.Department = dirtydata.Department
    AND duplicates_cte.Start_Date = dirtydata.Start_Date
    AND duplicates_cte.Email = dirtydata.Email
    AND duplicates_cte.Phone_Number = dirtydata.Phone_Number
    AND duplicates_cte.Address = dirtydata.Address
    AND duplicates_cte.Project_Assigned = dirtydata.Project_Assigned
);





-----------------------  Standardization & Handling Missing Values -----------------------


select * from dirtydata;

select *
from dirtydata
order by 2;


UPDATE dirtydata
SET name = CONCAT('Name_', 
  SUBSTRING(email FROM POSITION(SUBSTRING(email FROM '[0-9]+') IN email) 
  FOR (POSITION('@' IN email) - POSITION(SUBSTRING(email FROM '[0-9]+') IN email)))
)
WHERE email IS NOT NULL;


UPDATE dirtydata
SET name = 'Unknown'
WHERE name = 'Name_'


UPDATE dirtydata
SET age = 'Unknown'
WHERE age is NULL OR TRIM(age) = '';


UPDATE dirtydata
SET gender = 'Not Mentioned'
WHERE gender is NULL OR TRIM(gender) = '';


UPDATE dirtydata
SET salary = 'Not Mentioned'
WHERE salary IS NULL OR TRIM(salary) = '';


UPDATE dirtydata
SET department = 'Not Decided'
WHERE department IS NULL OR TRIM(department) = '';


UPDATE dirtydata
SET start_date = 'Unknown'
WHERE start_date IS NULL OR TRIM(start_date) = '';


UPDATE dirtydata
SET email = 'Unknown'
where email ILIKE 'invalid%';

UPDATE dirtydata
SET email = 'Unknown'
where email ILIKE 'invalid%' OR TRIM(email) =''
;


select *
from dirtydata
ORDER BY 6;
UPDATE dirtydata
SET email = CASE 
    WHEN email = 'jane.doe#example.com' THEN 'jane.doe@domain.com'
    WHEN email = 'jane.doe@example.com' THEN 'jane.doe@domain.com'
    WHEN email = 'john.doe@example.com' THEN 'john.doe@domain.com'
    WHEN email = 'emily.jones@domain' THEN 'jemily.jones@domain.com'
    WHEN email = 'alan_smith@example.com' THEN 'alan_smith@domain.com'
    WHEN email = 'michael.doe@example.com' THEN 'michael.doe@domain.com'
    ELSE email  -- Keeps the email unchanged if no condition matches
END;



UPDATE dirtydata
SET phone_number = 'Unknown'
where phone_number is null or TRIM(phone_number) =''
;

UPDATE dirtydata
SET address = 'Unknown'
where address is null or TRIM(address) =''
;


---------------- Final Cleaned Dataset
select *
from dirtydata;

