ALTER TABLE Sales_Office
ALTER COLUMN Manager_ID INT NULL;
--------------------------------------------------

-- Insert Sample Data into Sales_Office
ALTER TABLE Sales_Office
DROP CONSTRAINT UQ__Sales_Of__AE5FEF4C8C890BA5;

CREATE UNIQUE INDEX UQ_SalesOffice_Manager
ON Sales_Office(Manager_ID)
WHERE Manager_ID IS NOT NULL;

INSERT INTO Sales_Office (Office_Number, Location, Manager_ID)
VALUES
(1, 'Cairo', NULL),
(2, 'Alexandria', NULL);
SELECT * FROM Sales_Office;
---------------------------------------------------------------------
-- Insert Sample Data into Employee
INSERT INTO Employee (Employee_ID, Employee_Name, Office_Number)
VALUES
(101, 'Ahmed Mohamed', 1),
(102, 'Mohamed Ali', 1),
(103, 'Omar Hassan', 2),
(104, 'Youssef Ibrahim', 2);

SELECT * FROM Employee;
-------------------------------------------------------------------------
-- Assign Managers to Sales Offices
UPDATE Sales_Office
SET Manager_ID = 101
WHERE Office_Number = 1;

UPDATE Sales_Office
SET Manager_ID = 103
WHERE Office_Number = 2;
-------------------------------------------------------------------------
--Display offices and their associated managers
SELECT
    S.Office_Number,
    S.Location,
    S.Manager_ID,
    E.Employee_Name AS Manager_Name
FROM Sales_Office S
INNER JOIN Employee E
    ON S.Manager_ID = E.Employee_ID;
-------------------------------------------------------------------------
-- Insert Sample Data into Property
INSERT INTO Property
    (Property_ID, Address, City, State, Zip_Code, Office_Number)
VALUES
    (1001, '15 Tahrir Street', 'Cairo', 'Cairo', '11511', 1),
    (1002, '20 Nasr Street', 'Cairo', 'Cairo', '11765', 1),
    (1003, '10 Corniche Street', 'Alexandria', 'Alexandria', '21500', 2);

SELECT * FROM Property;
-------------------------------------------------------------------------
-- Insert Sample Data into Owner
INSERT INTO Owner (Owner_ID, Owner_Name)
VALUES
(201, 'Ali Hassan'),
(202, 'Mahmoud Samir'),
(203, 'Khaled Ahmed');

SELECT * FROM Owner;
-------------------------------------------------------------------------
-- Insert Sample Data into Owner_Property
INSERT INTO Owner_Property
    (Owner_ID, Property_ID, Percent_Owned)
VALUES
(201, 1001, 60.00),
(202, 1001, 40.00),
(201, 1002, 100.00),
(202, 1003, 50.00),
(203, 1003, 50.00);

SELECT * FROM Owner_Property;
-------------------------------------------------------------------------
--Display of Properties and their associated offices
SELECT
    P.Property_ID,
    P.Address,
    P.City,
    S.Location AS Office_Location
FROM Property P
INNER JOIN Sales_Office S
    ON P.Office_Number = S.Office_Number;
-------------------------------------------------------------------------
--Property listings, owners, and ownership percentages:
SELECT
    P.Property_ID,
    P.Address,
    O.Owner_Name,
    OP.Percent_Owned
FROM Property P
INNER JOIN Owner_Property OP
    ON P.Property_ID = OP.Property_ID
INNER JOIN Owner O
    ON OP.Owner_ID = O.Owner_ID
ORDER BY P.Property_ID;
-------------------------------------------------------------------------
--Verify the total ownership percentage for each property:
SELECT
    Property_ID,
    SUM(Percent_Owned) AS Total_Ownership
FROM Owner_Property
GROUP BY Property_ID;
---------------------------------------------------------
--Negative Testing
INSERT INTO Employee (Employee_ID, Employee_Name, Office_Number)
VALUES (101, 'Test Employee', 1);

INSERT INTO Employee (Employee_ID, Employee_Name, Office_Number)
VALUES (105, 'Test Employee', 99);

UPDATE Sales_Office
SET Manager_ID = 101
WHERE Office_Number = 2;

INSERT INTO Owner_Property (Owner_ID, Property_ID, Percent_Owned)
VALUES (201, 1002, 150.00);