USE [BaseForDoctors]
GO
/****** Object:  Table [dbo].[Appointment]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Appointment](
	[AppointmentId] [int] NOT NULL,
	[Doctor] [int] NOT NULL,
	[Patient] [int] NOT NULL,
	[Status] [int] NOT NULL,
	[Direction] [int] NOT NULL,
	[DateTemeAppoinment] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[AppointmentId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Date]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Date](
	[DateId] [int] NOT NULL,
	[Date] [date] NOT NULL,
	[StartWork] [time](7) NOT NULL,
	[EndWork] [time](7) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DateId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Date_Doctor]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Date_Doctor](
	[Date] [int] NOT NULL,
	[Doctor] [int] NOT NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Direction]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Direction](
	[DirectionId] [int] NOT NULL,
	[SickLeave] [int] NOT NULL,
	[Diagnosis] [nchar](50) NOT NULL,
	[Recimmendation] [nchar](50) NULL,
	[Medicines] [nchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[DirectionId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Doctor]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Doctor](
	[DoctorId] [int] NOT NULL,
	[Speciality] [int] NOT NULL,
	[Passport] [int] NOT NULL,
	[DateStartWork] [nchar](10) NOT NULL,
	[Login] [nchar](25) NOT NULL,
	[Password] [nchar](30) NOT NULL,
	[root] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[DoctorId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Passport]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Passport](
	[PassportId] [int] NOT NULL,
	[FirstName] [nchar](25) NOT NULL,
	[LastName] [nchar](25) NOT NULL,
	[SecondName] [nchar](25) NULL,
	[Serial] [nchar](5) NULL,
	[Number] [int] NOT NULL,
	[Issued] [nchar](35) NOT NULL,
	[Gender] [nchar](3) NOT NULL,
	[DateIssued] [date] NOT NULL,
	[DateBirth] [date] NOT NULL,
	[PlaceOfBirth] [nchar](50) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[PassportId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Patient]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Patient](
	[HealthInsuranceNumber] [int] NOT NULL,
	[PassportId] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[HealthInsuranceNumber] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SickLeave]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SickLeave](
	[SickLeaveId] [int] NOT NULL,
	[DateStart] [date] NOT NULL,
	[DateEnd] [date] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SickLeaveId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Speciality]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Speciality](
	[SpecialityId] [int] NOT NULL,
	[Speciality] [nchar](30) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[SpecialityId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Status]    Script Date: 15.09.2024 16:50:29 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Status](
	[StatusId] [int] NOT NULL,
	[Status] [nchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[StatusId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Doctor] ADD  DEFAULT ((0)) FOR [root]
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([Direction])
REFERENCES [dbo].[Direction] ([DirectionId])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([Doctor])
REFERENCES [dbo].[Doctor] ([DoctorId])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([Patient])
REFERENCES [dbo].[Patient] ([HealthInsuranceNumber])
GO
ALTER TABLE [dbo].[Appointment]  WITH CHECK ADD FOREIGN KEY([Status])
REFERENCES [dbo].[Status] ([StatusId])
GO
ALTER TABLE [dbo].[Date_Doctor]  WITH CHECK ADD FOREIGN KEY([Doctor])
REFERENCES [dbo].[Doctor] ([DoctorId])
GO
ALTER TABLE [dbo].[Date_Doctor]  WITH CHECK ADD FOREIGN KEY([Date])
REFERENCES [dbo].[Date] ([DateId])
GO
ALTER TABLE [dbo].[Direction]  WITH CHECK ADD FOREIGN KEY([SickLeave])
REFERENCES [dbo].[SickLeave] ([SickLeaveId])
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD FOREIGN KEY([Passport])
REFERENCES [dbo].[Passport] ([PassportId])
GO
ALTER TABLE [dbo].[Doctor]  WITH CHECK ADD FOREIGN KEY([Speciality])
REFERENCES [dbo].[Speciality] ([SpecialityId])
GO
ALTER TABLE [dbo].[Patient]  WITH CHECK ADD FOREIGN KEY([PassportId])
REFERENCES [dbo].[Passport] ([PassportId])
GO
