CREATE TABLE [dbo].[Doctor]
(
	[DoctorId] INT NOT NULL PRIMARY KEY, 
    [Speciality] INT NOT NULL foreign key references [Speciality] ([SpecialityId]), 
    [Passport] INT NOT NULL foreign key references [Passport] ([PassportId]), 
    [DateStartWork] DATE NOT NULL,  
    [Login] NCHAR(25) NOT NULL, 
    [Password] NCHAR(30) NOT NULL, 
    [root] BIT NOT NULL DEFAULT 0
)
