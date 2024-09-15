CREATE TABLE [dbo].[Direction]
(
	[DirectionId] INT NOT NULL PRIMARY KEY, 
    [SickLeave] INT NOT NULL foreign key references [SickLeave] ([SickLeaveId]), 
    [Diagnosis] NCHAR(50) NOT NULL, 
    [Recimmendation] NCHAR(50) NULL, 
    [Medicines] NCHAR(50) NULL
)
