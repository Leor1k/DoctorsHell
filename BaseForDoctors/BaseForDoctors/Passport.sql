CREATE TABLE [dbo].[Passport]
(
	[PassportId] INT NOT NULL PRIMARY KEY, 
    [FirstName] NCHAR(25) NOT NULL, 
    [LastName] NCHAR(25) NOT NULL, 
    [SecondName] NCHAR(25) NULL, 
    [Serial] NCHAR(5) NULL, 
    [Number] INT NOT NULL, 
    [Issued] NCHAR(35) NOT NULL, 
    [Gender] NCHAR(3) NOT NULL, 
    [DateIssued] DATE NOT NULL, 
    [DateBirth] DATE NOT NULL, 
    [PlaceOfBirth] NCHAR(50) NOT NULL
)
