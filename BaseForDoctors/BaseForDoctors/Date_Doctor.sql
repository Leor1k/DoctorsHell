CREATE TABLE [dbo].[Date_Doctor]
(
	[Date] INT NOT NULL foreign key references [Date] ([DateId]),
	[Doctor] int not null foreign key references [Doctor] ([DoctorId])
)
