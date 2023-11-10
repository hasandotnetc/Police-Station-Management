

/*

		************************	Police Station Management	 ******************************
			   *************				DDL


=======INDEX==========

Section			Topics

section 1	:	Database create
section2	:	table Create 
section 3	:	Alter,Drop,Modify
section 4	:	Clustered and Noneclustered
section 5	:	Sequence (create and alter)	
secttion6	:	Create view
section 7	:	Stored Procedure using parameter
				Stored procedure update
				Stored Procedure Delete
section 8	:	scaler funcion 
				multiline function
secttion 9	:	Trigger	
*/

--****************** SECTION:01******************
create database PoliceStManagement
on 
(
	name='PoliceStationManagement_1_Data',
	filename='C:\New folder\project\PoliceStManagement.mdf',
	size=5mb,
	maxsize=70mb,
	filegrowth=2mb
)
log on 
(
	name='PoliceStationManagement_1_Log',
	filename='C:\New folder\project\PoliceStManagement.ldf',
	size=5mb,
	maxsize=70mb,
	filegrowth=2mb
)
go
use PoliceStManagement
GO
--****************** SECTION 02 ******************
-- Create the Police Officer table
CREATE TABLE PoliceOfficer (
  OfficerID INTEGER PRIMARY KEY,
  FirstName TEXT NOT NULL,
  LastName TEXT NOT NULL,
  [Rank] TEXT NOT NULL,
  BadgeNumber INTEGER NOT NULL,
  DepartmentID INT REFERENCES Department(DepartmentID)
);
select *from PoliceOfficer

-- Create the Case table
CREATE TABLE [Case] (
  CaseID INTEGER PRIMARY KEY,
  DateReported DATE NOT NULL,
  OfficerID INTEGER,
  FOREIGN KEY (OfficerID) REFERENCES PoliceOfficer(OfficerID)
);
select *from [Case]


-- Create the Department table
CREATE TABLE Department (
  DepartmentID INT  PRIMARY KEY,
  DepartmentName TEXT NOT NULL,
  [Location] TEXT NOT NULL
);
select *from Department

CREATE TABLE Suspect
(
	SuspectID int primary key,
	[Name] nvarchar (60),				
	Age varchar(30),
	[Adress] text,
	CaseID INT REFERENCES [Case](CaseID)
);
SELECT *FROM Suspect


CREATE TABLE Evidence (
	EvidenceID INT Primary KEY,
	[Description] TEXT,					
	CaseID INT REFERENCES [Case](CaseID)
)
CREATE TABLE [Witness ]
(
	WitnessID INT PRIMARY KEY,
	ContactNumber VARCHAR (20) CHECK (ContactNumber like '[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
	[Statement] NVARCHAR (100),
	CaseID INT REFERENCES [Case](CaseID)
);
go

CREATE TABLE Staff    ---new table for procedure 
(
	StaffID int,
	[Name] nvarchar(60),
	Phone char,
	Salary money
)

--****************** SECTION 03 ******************
--CREATE SCHEMA 
CREATE SCHEMA PSM
go 
--Add Column in a table 
ALTER TABLE [Case]
ADD [Description] text, 
	[Status] text


--update column defination
ALTER TABLE Department 
alter column DepartmentName nvarchar(50)
GO
ALTER TABLE PoliceOfficer
ALTER COLUMN LastName TEXT null
GO
ALTER TABLE PoliceOfficer
ALTER COLUMN [Rank] TEXT null
GO


--ADD COLUMN WITH CHECK CONSTRAINT 
ALTER TABLE [Witness]
ADD Email nvarchar(30) check (Email like '%@')
go
ALTER TABLE PoliceOfficer
ADD Salary MONEY null
go 
ALTER TABLE PoliceOfficer
ADD JoiningDate Date 
go 

--DROP COLUMN

ALTER TABLE [Witness]
Drop COLUMN Ëmail
go
ALTER TABLE Staff
Drop COLUMN Phone

--DROP SCHEMA 
DROP SCHEMA PSM
go


--****************** SECTION 04 ******************
	------Clustered and Noneclustered---------

-- Clustered Index
CREATE CLUSTERED INDEX IX_StaffInfo
ON Staff
(
	StaffID
)
GO

-- Nonclustered Index
CREATE UNIQUE NONCLUSTERED INDEX IX_CaseInfo
ON [Case]
(
	OfficerID
)
GO

--****************** SECTION 05 ******************--
----------Sequence (create and alter)--------------

CREATE SEQUENCE StaffID
	AS INT
	START WITH 1
	INCREMENT BY 1
	MINVALUE 0
	MAXVALUE 100
	CYCLE
	CACHE 10
GO

--============== ALTER SEQUENCE ============--

ALTER SEQUENCE StaffID
	RESTART WITH 1
GO

--****************** SECTION 06 ******************
---create view 
CREATE VIEW VW_OfficerInfo
AS 
SELECT OfficerID, FirstName, BadgeNumber FROM PoliceOfficer
Go 

---VIEW WITH ENCRYPTION,SCHEMABINGING AND WITH CHECK OPTION

CREATE VIEW VW_Suspect
WITH SCHEMABINDING, ENCRYPTION
AS
SELECT SuspectID,Age,Adress FROM  [dbo].[Suspect]
WHERE Age>=20
WITH CHECK OPTION
GO


--****************** SECTIION 07 ******************

--============== STORED PROCEDURE for insert data using parameter ============--

CREATE PROCEDURE  PSStaff	@StaffID INT,
							@Name VARCHAR(50), 
							@Salary MONEY							
AS
BEGIN
	INSERT INTO Staff(StaffID, Name, Salary)
	VALUES (@StaffID, @Name, @Salary)
END
GO

--============== STORED PROCEDURE for insert data with OUTPUT parameter ============--

CREATE PROCEDURE  sp_psStaff @Name VARCHAR(50), 
							 @Salary MONEY,
							 @StaffID INT OUTPUT								
AS
BEGIN
	INSERT INTO Staff([Name], Salary)
	VALUES (@Name, @Salary)
	SELECT @StaffID = IDENT_CURRENT('Staff')
END
GO


-- CREATE A STORE PROCEDURE FOR UPDATE DATA

CREATE PROC spUpdateStaff  @StaffID INT,
						   @Salary MONEY
AS
BEGIN
	UPDATE Staff
	SET Salary = @Salary
	WHERE StaffID = @StaffID
END
GO

-- CREATE A STORE PROCEDURE FOR DELETE DATA

CREATE PROC spDeleteStaff  @StaffID INT
AS
BEGIN
	DELETE FROM Staff
	WHERE StaffID = @StaffID
END
GO

-----ALTER STORED PROCEDURE----

ALTER PROC spUpdateStaff  @StaffID INT,
						   @Salary MONEY
AS
BEGIN
	UPDATE Staff
	SET Salary = @Salary
	WHERE StaffID = @StaffID
END
GO


--****************** SECTION 08 ******************
--FUNCTION

--SCALAER FUNCTION
CREATE FUNCTION fnGetTotalSalary()
RETURNS MONEY
AS 
	BEGIN
		DECLARE @TotalSalary MONEY
		SELECT @TotalSalary = SUM(Salary) FROM Staff
		RETURN @TotalSalary
	END
GO

----Inline Table Valued Function

CREATE FUNCTION fnInlineTable ()
RETURNS TABLE 
AS
RETURN
(
	SELECT FirstName, Salary, DepartmentName  
	FROM  Department DP, PoliceOfficer PO
	WHERE DP.DepartmentID=PO.DepartmentID
	ORDER BY Salary ASC
)
GO


-------A MultiStatement Table Function----
CREATE FUNCTION  FnDetails ()
RETURNS @Salary Table
(
	OfficerID int, 
	[Rank] TEXT,
	Salary MONEY
)
AS
	BEGIN
		INSERT INTO @Salary SELECT 
		PO.FirstName ,DP.DepartmentName ,DP.Location ,EV.CaseID
		FROM PoliceOfficer PO
		INNER JOIN Department DP
		ON PO.DepartmentID =DP.DepartmentID
		INNER JOIN Evidence EV
		ON DP.DepartmentID=EV.EvidenceID 
		RETURN
	END
GO

--****************** SECTION 09 ******************--

---Create trigger for update and delete

CREATE TRIGGER trUpdateDelete
ON PoliceOfficer
AFTER UPDATE,DELETE
AS
BEGIN
	IF(UPDATE(OfficerID))
	BEGIN
		PRINT 'OfficerID not allow to Update!!'
		ROLLBACK TRANSACTION
	END
END
GO

---Create trigger for insert

CREATE TRIGGER trInsert_PoliceOfficer
ON PoliceOfficer
FOR INSERT
AS
BEGIN
	INSERT INTO PoliceOfficer (OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentID)
	SELECT OfficerID, FirstName, LastName, [Rank], BadgeNumber, DepartmentID
	FROM inserted
END
GO

--------Create trigger (Instead of Insert)-------

CREATE TRIGGER trInsteadInsert
ON VW_OfficerInfo
INSTEAD OF INSERT
AS
BEGIN
	INSERT INTO PoliceOfficer (OfficerID, FirstName, BadgeNumber)
	SELECT OfficerID, FirstName, BadgeNumber
	FROM inserted
END
GO

--------Create trigger (Instead of Update)-------

CREATE TRIGGER trInsteadofUpdate_VW_OfficerInfo
ON VW_OfficerInfo
INSTEAD OF UPDATE
AS
BEGIN
	DECLARE @ID INT
	SELECT @ID = OfficerID FROM VW_OfficerInfo
	UPDATE VW_OfficerInfo SET OfficerID = @ID
	FROM inserted
END
GO

--------Create trigger (Instead of Delete)-------

CREATE TRIGGER trInsteadofDelete_VW_OfficerInfo
ON VW_OfficerInfo
INSTEAD OF DELETE
AS
BEGIN
	DELETE FROM VW_OfficerInfo
	WHERE OfficerID IN (SELECT OfficerID FROM deleted)
END
GO

--************************************* FINISHING  ******************************************************--