CREATE DATABASE Real_State_Firm;
Use Real_State_Firm;
--------------------------------------------------------------------
--CREATE EMPLOYEE TABLE
CREATE TABLE Employee
(
Employee_ID INT PRIMARY KEY,
Employee_Name VARCHAR(50) NOT NULL,
Office_Number INT NOT NULL
)
--------------------------------------------------------------------
--CREATE SALES_OFFICE TABLE
CREATE TABLE Sales_Office
(
Office_Number INT PRIMARY KEY,
Location VARCHAR(50) NOT NULL,
Manager_ID INT NOT NULL UNIQUE
)
--------------------------------------------------------------------
--CREATE PROPERTY TABLE
CREATE TABLE Property
(
Property_ID INT PRIMARY KEY,
Address VARCHAR(50) NOT NULL,
City VARCHAR(50) NOT NULL,
State VARCHAR(50) NOT NULL,
Zip_Code VARCHAR(10) NOT NULL,
Office_Number INT NOT NULL
)
--------------------------------------------------------------------
--CRAETE OWNER TABLE
CREATE TABLE Owner
(
Owner_ID INT PRIMARY KEY,
Owner_Name VARCHAR(50) NOT NULL
)
--------------------------------------------------------------------
--CREATE Owner_Property TABLE
CREATE TABLE Owner_Property
(
Owner_ID INT,
Property_ID INT,
Percent_Owned DECIMAL(5,2) NOT NULL,

CONSTRAINT PK_Owner_Property
PRIMARY KEY(Owner_ID,Property_ID),

CONSTRAINT FK_Owner_Property_Owner
FOREIGN KEY(Owner_ID) REFERENCES Owner(Owner_ID),

CONSTRAINT FK_Owner_Property_Property
FOREIGN KEY(Property_ID) REFERENCES Property(Property_ID),

CONSTRAINT CHK_Percent_Owned
CHECK (Percent_Owned > 0 AND Percent_Owned <= 100)
)
---------------------------------------------------------------------
--Alter TABLES ADD FOREIGN KEYS
ALTER TABLE Employee
ADD CONSTRAINT FK_Employee_SalesOffice
FOREIGN KEY (Office_Number)
REFERENCES Sales_Office(Office_Number);

ALTER TABLE Sales_Office
ADD CONSTRAINT FK_SalesOffice_Manager
FOREIGN KEY (Manager_ID)
REFERENCES Employee(Employee_ID);

ALTER TABLE Property
ADD CONSTRAINT FK_Property_SalesOffice
FOREIGN KEY (Office_Number)
REFERENCES Sales_Office(Office_Number);
---------------------------------------------------------------------
-- Review Tables and Columns
SELECT
    TABLE_NAME,
    COLUMN_NAME,
    DATA_TYPE,
    IS_NULLABLE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_CATALOG = DB_NAME()
ORDER BY TABLE_NAME, ORDINAL_POSITION;
---------------------------------------------------------------------
SELECT
    name AS Foreign_Key_Name,
    OBJECT_NAME(parent_object_id) AS Table_Name,
    OBJECT_NAME(referenced_object_id) AS Referenced_Table
FROM sys.foreign_keys;