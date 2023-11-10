

/*

		************************	Police Station Management	 ******************************
			   *************			
								Table of Contents: DML

			=> SECTION 01: INSERT DATA USING INSERT INTO KEYWORD
			=> SECTION 02: INSERT DATA THROUGH STORED PROCEDURE
				SUB SECTION => 2.1 : INSERT DATA THROUGH STORED PROCEDURE WITH AN OUTPUT PARAMETER 
				SUB SECTION => 2.2 : INSERT DATA USING SEQUENCE VALUE
			=> SECTION 03: UPDATE DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.1 : UPDATE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.2 : DELETE DATA THROUGH STORED PROCEDURE
				SUB SECTION => 3.3 : STORED PROCEDURE WITH TRY CATCH AND RAISE ERROR
			=> SECTION 04: INSERT UPDATE DELETE DATA THROUGH VIEW
				SUB SECTION => 4.1 : INSERT DATA through view
				SUB SECTION => 4.2 : UPDATE DATA through view
				SUB SECTION => 4.3 : DELETE DATA through view
			=> SECTION 05: RETREIVE DATA USING FUNCTION(SCALAR, SIMPLE TABLE VALUED, MULTISTATEMENT TABLE VALUED)
			=> SECTION 06: TEST TRIGGER (FOR/AFTER TRIGGER ON TABLE, INSTEAD OF TRIGGER ON TABLE & VIEW)
			=> SECTION 07: QUERY
				SUB SECTION => 7.01 : SELECT FROM TABLE
				SUB SECTION => 7.02 : SELECT FROM VIEW
				SUB SECTION => 7.03 : SELECT INTO
				SUB SECTION => 7.04 : IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE
				SUB SECTION => 7.05 : INNER JOIN WITH GROUP BY CLAUSE
				SUB SECTION => 7.06 : OUTER JOIN
				SUB SECTION => 7.07 : CROSS JOIN
				SUB SECTION => 7.08 : TOP CLAUSE WITH TIES
				SUB SECTION => 7.09 : DISTINCT
				SUB SECTION => 7.10 : COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR
				SUB SECTION => 7.11 : LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE
				SUB SECTION => 7.12 : OFFSET FETCH
				SUB SECTION => 7.13 : UNION
				SUB SECTION => 7.14 : EXCEPT INTERSECT
				SUB SECTION => 7.15 : AGGREGATE FUNCTIONS
				SUB SECTION => 7.16 : GROUP BY & HAVING CLAUSE
				SUB SECTION => 7.17 : ROLLUP & CUBE OPERATOR
				SUB SECTION => 7.18 : GROUPING SETS
				SUB SECTION => 7.19 : SUB-QUERIES (INNER, CORRELATED)
				SUB SECTION => 7.20 : EXISTS
				SUB SECTION => 7.21 : CTE
				SUB SECTION => 7.22 : MERGE
				SUB SECTION => 7.23 : BUILT IN FUNCTION
				SUB SECTION => 7.24 : CASE
				SUB SECTION => 7.25 : COALESCE & ISNULL
				SUB SECTION => 7.26 : WHILE
				SUB SECTION => 7.27 : GROPING FUNCTION
				SUB SECTION => 7.28 : IF ELSE & PRINT
		
*/

use PoliceStManagement 
--****** Insert data into Department table
INSERT INTO Department (DepartmentID, DepartmentName, [Location])
VALUES
  (101, 'Detective Unit', 'City A'),
  (102, 'Patrol Division', 'City B');

--****** Insert data into PoliceOfficer table
INSERT INTO PoliceOfficer (OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentID,Salary)
VALUES
  (3, 'Hamki', 'Joo', 'Detective', 12345, 102,54100),
  (4, 'Lome', 'Pok', 'Sergeant', 67890, 101,45000);
  INSERT INTO PoliceOfficer (OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentID,Salary,JoiningDate)
VALUES
  (5, 'Sam', 'LOO', 'Detective', 12345, 102,54100,'2002-01-01'),
  (6, 'Pion', 'Che', 'Sergeant', 67890, 101,45000,'2005-01-01');
  go
  select *from PoliceOfficer

--****** Insert data into Case table
INSERT INTO [Case] (CaseID, [Description], DateReported, [Status], OfficerID) 
VALUES
  (101, 'Theft at the mall', '2023-03-15', 'Inactive', 1),
  (102, 'Vandalism in the park', '2023-04-02', 'Active', 2);
  INSERT INTO [Case] (CaseID, [Description], DateReported, [Status], OfficerID) 
VALUES
  (103, 'Evtessing', '2023-03-15', 'Inactive', 4),
  (104, 'Vandalism in the park', '2023-04-02', 'Active', 3);
  SELECT *FROM [Case]

  --****** Suspectt Data Input 

  INSERT INTO Suspect (SuspectID,[Name],Age,[Adress] ) values 
  (101,'Mansur Ahmed','24','Monipur')
  INSERT INTO Suspect (SuspectID,[Name],Age,[Adress] ) values 
  (107,'Rajib Molla','25','Rampura')
  INSERT INTO Suspect (SuspectID,[Name],Age,[Adress],CaseID ) values 
  (103,'Piyas','27','Rampura',102)
  INSERT INTO Suspect (SuspectID,[Name],Age,[Adress],CaseID ) values 
  (104,'Jakir','45','Badda',103)
  INSERT INTO Suspect (SuspectID,[Name],Age,[Adress],CaseID ) values 
  (105,'Maruf','35','Rampura',104)
  select *from Suspect
  GO
  INSERT INTO Evidence (EvidenceID,[Description]) VALUES 
(102,'Evidence -1'),
(105,'Evidence -4')
 INSERT INTO Evidence (EvidenceID,[Description],CaseID) VALUES 
 (103,'Evedence-3', 103),
 (104,'Evedence-4',104),
 (101,'Evedence-10',102)
 Select *from Evidence
INSERT INTO [Witness] (WitnessID,ContactNumber,[Statement]) values
(107,'017845484775','Statement 1'),
(112,'017000770212','Statment 5')
go
SELECT *FROM Witness


--****** A Statement that calls the Procedure

EXEC SPoliceOfficer;
GO
---****** STORED PROCEDURE for insert data  

EXEC PSStaff 102, 'Sakib', 41000 
GO
EXEC PSStaff 103, 'Munna', 31000
GO

--****** stored procedure data update 

EXEC spUpdateStaff 102, 35000
GO

-- ****** PROC INPUT AND OUTPUT RESULT 
EXEC SPoliceOfficerTotal 25000; 
GO


/*
******************************  SECTION 04  ******************************
					INSERT UPDATE DELETE DATA THROUGH VIEW
==========================================================================
*/

--****** INSERT DATA through view  -
SELECT * FROM VW_OfficerInfo
GO

INSERT INTO VW_OfficerInfo(OfficerID, FirstName, Salary,BadgeNumber) VALUES(7,'NazruL Hauque',52000,4520)
INSERT INTO VW_OfficerInfo(OfficerID, FirstName, Salary,BadgeNumber) VALUES(8,'Rafuqul',41520,12450)
INSERT INTO VW_OfficerInfo(OfficerID, FirstName, Salary,BadgeNumber) VALUES(9,'Subahan',52000,47410)
GO
SELECT * FROM VW_OfficerInfo
GO
--****** UPDATE DATA through view  
UPDATE VW_OfficerInfo
SET Salary = Salary+9500
WHERE Salary<=45000
GO
SELECT * FROM VW_OfficerInfo
GO

--****** DELETE DATA through view  
DELETE FROM VW_OfficerInfo
WHERE OfficerID = 8
GO
SELECT * FROM VW_OfficerInfo
GO

/*
******************************  SECTION 05  ************************
						RETREIVE DATA USING FUNCTION			      
==========================================================================
*/

-- A Scalar Function to get total sum of salary

SELECT dbo.fnGetTotalSalary() AS 'TOTAL SALARY'
GO

-- Inline Table Valued Function

SELECT * FROM fnInlineTable()
GO

-------A MultiStatement Table Function----

SELECT * FROM FnDetails()
GO

/*
****************************  SECTION 07  ************************
*******************				QUERY			******************
*/


--****** 7.01 A SELECT STATEMENT TO GET RESULT SET FROM A TABLE 

SELECT * FROM PoliceOfficer
GO
SELECT * FROM Staff
--***** 7.02 A SELECT STATEMENT TO GET today course sales information FROM A VIEW 

SELECT * FROM VW_OfficerInfo
GO
--***** 7.03 SELECT INTO > SAVE RESULT SET TO A NEW TEMPORARY TABLE 

SELECT * INTO #StaffCopy
FROM Staff
GO

SELECT * FROM #StaffCopy
GO
																						
--***** 7.04 IMPLICIT JOIN WITH WHERE BY CLAUSE, ORDER BY CLAUSE 

-- GET DESIGNATION UNDER DEPARTMENT
SELECT FirstName, Salary, DepartmentName  FROM  Department DP, PoliceOfficer PO
WHERE DP.DepartmentID=PO.DepartmentID
ORDER BY Salary ASC
GO
--***** 7.05 INNER JOIN WITH GROUP BY CLAUSE 
SELECT	S.Name,C.Status ,COUNT(S.Age ) AS SAgeCount, E.Description	FROM [Case] C	
	INNER JOIN	 Suspect S	
		ON	C.CaseID=S.CaseID 
	INNER JOIN Evidence E
		ON S.CaseID=E.CaseID 
GROUP BY S.Name 
Go 

--***** 7.06 OUTER JOIN 
SELECT	S.Name,C.Status , E.Description	FROM [Case] C	
	LEFT JOIN	 Suspect S	
		ON	C.CaseID=S.CaseID 
	RIGHT JOIN Evidence E
		ON S.CaseID=E.CaseID 
GROUP BY S.Name 
Go 

--****** 7.07 CROSS JOIN 

SELECT TOP 5* FROM PoliceOfficer
	CROSS JOIN Department
WHERE Salary>50000
GO
--******  7.08 TOP CLAUSE WITH TIES 

SELECT TOP 5 WITH TIES
 OfficerID,FirstName,Rank 
FROM  PoliceOfficer
ORDER BY OfficerID DESC
GO
	
--****** 7.09 DISTINCT

SELECT DISTINCT 
  [Name]
FROM  Staff
GO

--***** 7.10 COMPARISON, LOGICAL(AND OR NOT) & BETWEEN OPERATOR 
SELECT *FROM PoliceOfficer
WHERE BadgeNumber=67890
	AND DepartmentID >=103
	OR OfficerID <2
GO
--*****  7.11 LIKE, IN, NOT IN, OPERATOR & IS NULL CLAUSE 

SELECT * FROM PoliceOfficer
WHERE FirstName  LIKE '%J%'
AND DepartmentID  NOT IN (101)
AND JoiningDate IS NULL
GO

--****** 7.12 OFFSET FETCH  

-- OFFSET 5 ROWS
SELECT * FROM PoliceOfficer
ORDER BY OfficerID
OFFSET 5 ROWS
GO

--****** OFFSET 10 ROWS AND GET NEXT 5 ROWS

SELECT * FROM PoliceOfficer
ORDER BY OfficerID
OFFSET 10 ROWS
FETCH NEXT 5 ROWS ONLY
GO

--******* 7.13 UNION 

	SELECT * FROM PoliceOfficer
	WHERE OfficerID IN (1,2,3)
UNION
	SELECT * FROM PoliceOfficer
	WHERE OfficerID  IN (3,4)
GO

--******  7.14 EXCEPT INTERSECT *********

-- EXCEPT
SELECT * FROM Staff 
EXCEPT
SELECT * FROM Staff
WHERE Salary=25000.00
GO

--***** INTERSECT ********

SELECT * FROM Staff 
INTERSECT
SELECT * FROM Staff
WHERE Salary>=25000.00
GO
--***** 7.15 AGGREGATE FUNCTION 
 
SELECT	COUNT(*) 'Total Sales Count',
		SUM(Salary) 'Total Salary',
		AVG(Salary) 'Average Sale',
		MIN(Salary) 'MIN Salary',
		MAX(BadgeNumber) 'MAX BadgeNumber'
FROM PoliceOfficer
GO

--****** 7.16 AGGREGATE FUNCTION WITH GROUP BY & HAVING CLAUSE  

SELECT OfficerID, count(OfficerID) AS Total, SUM(Salary) 'Total Salary' FROM PoliceOfficer
INNER JOIN Department ON PoliceOfficer.DepartmentID =Department.DepartmentID
GROUP BY OfficerID
HAVING SUM(Salary) > 50000
GO

--****** 7.17 ROLLUP & CUBE OPERATOR  

--****** ROLLUP
SELECT   SUM(Salary) AS Salary FROM PoliceOfficer P
INNER JOIN Department D ON p.DepartmentID =D.DepartmentID
GROUP BY  ROLLUP (P.Salary)
ORDER BY P.Salary  DESC
GO

-- ****** CUBE
 SELECT   SUM(Salary) AS Salary FROM PoliceOfficer P
INNER JOIN Department D ON p.DepartmentID =D.DepartmentID
GROUP BY  CUBE (P.Salary)
ORDER BY P.Salary  DESC
GO
--****** 7.18 GROUPING SETS  

SELECT   SUM(Salary) AS Salary FROM PoliceOfficer P
INNER JOIN Department D ON p.DepartmentID =D.DepartmentID
GROUP BY  GROUPING SETS (P.Salary)
ORDER BY P.Salary  DESC
GO

--****** 7.19 SUB-QUERIES 


--****** A subquery to findout trainees who have not enrolled yet
SELECT * FROM Staff 
WHERE Salary NOT IN (SELECT StaffID  FROM Staff)
ORDER BY [Name]
GO

--****** 7.20 EXISTS  

SELECT * FROM Staff 
WHERE   NOT EXISTS (SELECT StaffID   FROM Staff where StaffID =102 )
ORDER BY [Name]
GO

--****** 7.21 CTE (Common Table Expression)--------

WITH PoliceOfficerInfo (OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentName)
AS
(
	SELECT OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentName
	FROM PoliceOfficer
	JOIN Department
	ON PoliceOfficer.DepartmentID = Department.DepartmentID
)
SELECT OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentName
FROM PoliceOfficerInfo

--****** A CTE TO GET MAXIMUM 

WITH courseCount AS
(
SELECT D.DepartmentName , count(PO.Salary ) TotalSalary  FROM PoliceOfficer PO
INNER JOIN Department D ON D.DepartmentID= PO.DepartmentID 
GROUP BY D.DepartmentName 
)
SELECT * from PoliceOfficer
WHERE Salary = (SELECT MAX(Salary) FROM PoliceOfficer)
GO

--****** 7.22 MERGE 

SELECT * FROM PoliceOfficer
SELECT * FROM Department
GO
MERGE PoliceOfficer AS PO
USING Department AS DP
 ON DP.DepartmentID= PO.DepartmentID 
WHEN MATCHED THEN
		UPDATE SET
		DepartmentID=DP.DepartmentID;
GO
--****** 7.23 BUILT IN FUNCTION 

-- Get current date and time
SELECT GETDATE()
GO

--****** GET STRING LENGTH
SELECT [Name], LEN(Name) 'Name Length' FROM Staff 
GO

--****** CONVERT DATA USING CAST()
SELECT CAST(1500 AS decimal(17,2)) AS DecimalNumber
GO

--****** CONVERT DATA USING CONVERT()
DECLARE @currTime DATETIME = GETDATE()
SELECT CONVERT(VARCHAR, @currTime, 108) AS ConvertToTime
GO

--****** CONVERT DATA USING TRY_CONVERT()
SELECT TRY_CONVERT(FLOAT, 'HELLO', 1) AS ReturnNull
GO

--****** GET DIFFERENCE OF DATES
SELECT DATEDIFF(DAY, '2021-01-01', '2022-01-01') AS DAYinYear
GO

-- GET A MONTH NAME
SELECT DATENAME(MONTH, GETDATE()) AS 'Month'
GO

--=****** 7.24 CASE  

SELECT DP.DepartmentName , 
PO.Salary,
	CASE 
		WHEN (PO.Salary < 40000) THEN 'Lower Salary'
		WHEN (PO.Salary > 40000) THEN 'Good Salary'
		WHEN (PO.Salary > 50000) THEN 'Better Salary'
		WHEN (PO.Salary > 50000) THEN 'Great Salary'
END AS 'Status'
FROM PoliceOfficer PO
INNER JOIN Department DP  ON DP.DepartmentID= PO.DepartmentID 
GO

--****** 7.25 WHILE  

	DECLARE @counter int
	SET @counter = 0
	WHILE @counter < 20
	BEGIN
	  SET @counter = @counter + 1
	  INSERT INTO Staff([Name]) VALUES((NEXT VALUE FOR [dbo].[Staff])) 
	END
	SELECT * FROM Staff 
GO

--****** 7.26 GROPING FUNCTION  
SELECT				
	CASE 
		WHEN GROUPING(DP.DepartmentName) = 103 THEN 'All Department'
		ELSE DP.DepartmentName
		END AS Department,
		SUM(PO.Salary ) as Salary
FROM PoliceOfficer PO 
INNER JOIN Department DP
ON PO.DepartmentID = DP.DepartmentID
GROUP BY  ROLLUP (PO.Salary )
ORDER BY DP.DepartmentID DESC 
GO

----------GROPING FUNCTION---------

SELECT FirstName, [Rank], DepartmentName, COUNT(*) AS TotalOfficer
FROM PoliceOfficer
JOIN Department
ON PoliceOfficer.DepartmentID = Department.DepartmentID
GROUP BY GROUPING SETS (FirstName, [Rank], DepartmentName)
ORDER BY GROUPING ([Rank]), GROUPING (DepartmentName)


--****** 7.27 IF ELSE & PRINT 

DECLARE @TotalSalary MONEY
SELECT @TotalSalary = SUM((Salary))
FROM Staff
WHERE StaffID >=100
IF @TotalSalary > 30000

	BEGIN
		PRINT 'Great Salary For a Standard Job !!'
	END
ELSE
	BEGIN
		PRINT 'Try to Hard for Promotion !'
	END
GO

