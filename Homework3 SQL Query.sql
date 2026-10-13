CREATE DATABASE Academy
GO
USE Academy
GO

CREATE TABLE Departments (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Financing MONEY NOT NULL DEFAULT 0 CHECK (Financing >= 0),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (LEN(Name) > 0)
)

CREATE TABLE Faculties (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Dean NVARCHAR(MAX) NOT NULL CHECK (LEN(Dean) > 0),
    Name NVARCHAR(100) NOT NULL UNIQUE CHECK (LEN(Name) > 0)
)

CREATE TABLE Groups (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    Name NVARCHAR(10) NOT NULL UNIQUE CHECK (LEN(Name) > 0),
    Rating INT NOT NULL CHECK (Rating BETWEEN 0 AND 5),
    [Year] INT NOT NULL CHECK ([Year] BETWEEN 1 AND 5)
)

CREATE TABLE Teachers (
    Id INT NOT NULL IDENTITY(1,1) PRIMARY KEY,
    EmploymentDate DATE NOT NULL CHECK (EmploymentDate >= '1990-01-01'),
    IsAssistant BIT NOT NULL DEFAULT 0,
    IsProfessor BIT NOT NULL DEFAULT 0,
    Name NVARCHAR(MAX) NOT NULL CHECK (LEN(Name) > 0),
    Position NVARCHAR(MAX) NOT NULL CHECK (LEN(Position) > 0),
    Premium MONEY NOT NULL DEFAULT 0 CHECK (Premium >= 0),
    Salary MONEY NOT NULL CHECK (Salary > 0),
    Surname NVARCHAR(MAX) NOT NULL CHECK (LEN(Surname) > 0)
)
GO

-- 1. Departments table with fields in reverse order
SELECT Name, Financing, Id
FROM Departments

-- 2. Group names and ratings with custom field names
SELECT Name AS [Group Name], Rating AS [Group Rating]
FROM Groups

-- 3. Surname, wage rate to premium ratio (%), wage rate to (wage rate + premium) ratio (%)
SELECT Surname,
       Salary * 100.0 / NULLIF(Premium, 0) AS [Salary to Premium %],
       Salary * 100.0 / (Salary + Premium) AS [Salary to Total %]
FROM Teachers

-- 4. Faculties as a single field
SELECT 'The dean of faculty ' + Name + ' is ' + Dean AS [Faculty Info]
FROM Faculties

-- 5. Professors with wage rate above 1050
SELECT Name
FROM Teachers
WHERE IsProfessor = 1 AND Salary > 1050

-- 6. Departments with financing below 11000 or above 25000
SELECT Name
FROM Departments
WHERE Financing < 11000 OR Financing > 25000

-- 7. Faculties other than Computer Science
SELECT Name
FROM Faculties
WHERE Name <> 'Computer Science'

-- 8. Names and positions of teachers who are not professors
SELECT Name, Position
FROM Teachers
WHERE IsProfessor = 0

-- 9. Assistants with premium from 160 to 550
SELECT Surname, Position, Salary, Premium
FROM Teachers
WHERE IsAssistant = 1 AND Premium BETWEEN 160 AND 550

-- 10. Surnames and wage rates of assistants
SELECT Surname, Salary
FROM Teachers
WHERE IsAssistant = 1

-- 11. Teachers hired before 01.01.2000
SELECT Surname, Position
FROM Teachers
WHERE EmploymentDate < '2000-01-01'

-- 12. Departments in alphabetical order up to Software Development
SELECT Name AS [Name of Department]
FROM Departments
WHERE Name <= 'Software Development'
ORDER BY Name

-- 13. Assistants whose salary (wage rate + premium) is not more than 1200
SELECT Name
FROM Teachers
WHERE IsAssistant = 1 AND (Salary + Premium) <= 1200

-- 14. 5th year groups with rating from 2 to 4
SELECT Name
FROM Groups
WHERE [Year] = 5 AND Rating BETWEEN 2 AND 4

-- 15. Assistants with wage rate below 550 or premium below 200
SELECT Name
FROM Teachers
WHERE IsAssistant = 1 AND (Salary < 550 OR Premium < 200)
