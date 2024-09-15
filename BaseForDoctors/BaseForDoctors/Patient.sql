CREATE TABLE [dbo].[Patient]
(
	[HealthInsuranceNumber] NCHAR(17) NOT NULL PRIMARY KEY, 
    [PassportId] INT NOT NULL foreign key references [Passport] ([PassportId])
)
