CREATE TABLE [dbo].[Direction]
(
	[DirectionId] INT NOT NULL PRIMARY KEY, 
    [AppointId]  INT NULL foreign key references [Appointment] ([AppointmentId]), 
    [SickLeave] INT NULL foreign key references [SickLeave] ([SickLeaveId]), 
    [Diagnosis] NCHAR(50) NOT NULL, 
    [Recimmendation] NCHAR(50) NULL, 
    [Medicines] NCHAR(50) NULL
)
