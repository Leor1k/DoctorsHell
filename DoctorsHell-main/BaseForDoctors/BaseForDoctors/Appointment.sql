﻿CREATE TABLE [dbo].[Appointment]
(
	[AppointmentId] INT NOT NULL PRIMARY KEY, 
    [Doctor] INT NOT NULL foreign key references [Doctor] ([DoctorId]), 
    [Patient] NCHAR(17) NOT NULL foreign key references [Patient] ([HealthInsuranceNumber]), 
    [Status] INT NOT NULL foreign key references [Status] ([StatusId]), 
    [Direction] INT NULL foreign key references [Direction] ([DirectionId]), 
    [DateTemeAppoinment] DATETIME NOT NULL
)
