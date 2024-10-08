﻿INSERT INTO [dbo].[Passport] ([PassportId], [FirstName], [LastName], [SecondName], [Serial], [Number], [Issued], [Gender], [DateIssued], [DateBirth], [PlaceOfBirth]) VALUES (1, N'Иван', N'Иванов', N'Иванович', N'1234 ', 567890, N'ОВД города Москвы', N'М  ', N'2010-05-15', N'1985-03-22', N'Москва')
INSERT INTO [dbo].[Passport] ([PassportId], [FirstName], [LastName], [SecondName], [Serial], [Number], [Issued], [Gender], [DateIssued], [DateBirth], [PlaceOfBirth]) VALUES (2, N'Мария', N'Петрова                  ', N'Сергеевна                ', N'4321 ', 987654, N'ОВД города Санкт-Петербурга        ', N'Ж  ', N'2012-07-10', N'1990-09-17', N'Санкт-Петербург                                   ')
INSERT INTO [dbo].[Passport] ([PassportId], [FirstName], [LastName], [SecondName], [Serial], [Number], [Issued], [Gender], [DateIssued], [DateBirth], [PlaceOfBirth]) VALUES (3, N'Михаил ', N'Михалыч                  ', N'Михалков                 ', N'1235 ', 234666, N'МОМОМОМ                            ', N'М  ', N'2001-07-10', N'1960-09-17', N'Зажопинск                                         ')
INSERT INTO [dbo].[Passport] ([PassportId], [FirstName], [LastName], [SecondName], [Serial], [Number], [Issued], [Gender], [DateIssued], [DateBirth], [PlaceOfBirth]) VALUES (4, N'Лева', N'Лёвов                    ', N'Левченко                 ', N'6546 ', 546545, N'Кукуево                            ', N'М  ', N'2000-07-09', N'1990-09-17', N'Кукуево                                           ')
INSERT INTO [dbo].[Passport] ([PassportId], [FirstName], [LastName], [SecondName], [Serial], [Number], [Issued], [Gender], [DateIssued], [DateBirth], [PlaceOfBirth]) VALUES (5, N'Леня', N'Гойдов                   ', N'Леонидович               ', N'0954 ', 957654, N'Пятёрочка                          ', N'М  ', N'2009-06-10', N'1920-09-17', N'Магнит                                            ')
INSERT INTO [dbo].[Speciality] ([SpecialityId], [Speciality]) VALUES (1, N'Терапевт')
INSERT INTO [dbo].[Speciality] ([SpecialityId], [Speciality]) VALUES (2, N'Хирург')
INSERT INTO [dbo].[Speciality] ([SpecialityId], [Speciality]) VALUES (3, N'Кардиолог')
INSERT INTO [dbo].[Speciality] ([SpecialityId], [Speciality]) VALUES (4, N'Окулист')
INSERT INTO [dbo].[Speciality] ([SpecialityId], [Speciality]) VALUES (5, N'Простата')
INSERT INTO [dbo].[Doctor] ([DoctorId], [Speciality], [Passport], [DateStartWork], [Login], [Password], [root]) VALUES (1, 1, 1, N'2015-09-01', N'dr_ivanov', N'password123', 1)
INSERT INTO [dbo].[Doctor] ([DoctorId], [Speciality], [Passport], [DateStartWork], [Login], [Password], [root]) VALUES (2, 2, 2, N'2018-06-15', N'dr_petrov', N'secret456', 0)
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (1, N'2024-09-15', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (2, N'2024-09-16', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (3, N'2024-09-17', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (4, N'2024-09-18', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (5, N'2024-09-19', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (6, N'2024-09-20', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (7, N'2024-09-21', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (8, N'2024-09-22', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date] ([DateId], [Date], [StartWork], [EndWork]) VALUES (9, N'2024-09-23', N'08:00:00', N'18:00:00')
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (1, 1)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (1, 2)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (2, 2)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (3, 2)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (4, 2)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (5, 1)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (6, 1)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (7, 1)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (8, 1)
INSERT INTO [dbo].[Date_Doctor] ([Date], [Doctor]) VALUES (9, 1)
INSERT INTO [dbo].[Patient] ([HealthInsuranceNumber], [PassportId]) VALUES (N'1234567890123456', 3)
INSERT INTO [dbo].[Patient] ([HealthInsuranceNumber], [PassportId]) VALUES (N'7894561230789456', 4)
INSERT INTO [dbo].[Patient] ([HealthInsuranceNumber], [PassportId]) VALUES (N'7412589632145698', 5)
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (1, N'Записан   ')
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (2, N'Не пришёл ')
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (3, N'Началась  ')
INSERT INTO [dbo].[Status] ([StatusId], [Status]) VALUES (4, N'Закончена ')
INSERT INTO [dbo].[Appointment] ([AppointmentId], [Doctor], [Patient], [Status], [DateTemeAppoinment]) VALUES (1, 1, N'1234567890123456 ', 1, N'2024-09-16 12:00:00')
INSERT INTO [dbo].[Appointment] ([AppointmentId], [Doctor], [Patient], [Status], [DateTemeAppoinment]) VALUES (2, 2, N'1234567890123456 ', 1, N'2024-09-16 14:00:00')
INSERT INTO [dbo].[Appointment] ([AppointmentId], [Doctor], [Patient], [Status], [DateTemeAppoinment]) VALUES (3, 2, N'7894561230789456 ', 1, N'2024-09-16 15:00:00')
INSERT INTO [dbo].[Appointment] ([AppointmentId], [Doctor], [Patient], [Status], [DateTemeAppoinment]) VALUES (4, 1, N'7894561230789456 ', 1, N'2024-09-16 16:00:00')
INSERT INTO [dbo].[SickLeave] ([SickLeaveId], [DateStart], [DateEnd]) VALUES (1, N'2024-04-12', N'2024-04-21')
INSERT INTO [dbo].[SickLeave] ([SickLeaveId], [DateStart], [DateEnd]) VALUES (2, N'2023-05-13', N'2023-06-27')
INSERT INTO [dbo].[Direction] ([DirectionId], [AppointId], [SickLeave], [Diagnosis], [Recimmendation], [Medicines]) VALUES (1, 1, NULL, N'Рак', N'лежать', N'Тримбалон')
INSERT INTO [dbo].[Direction] ([DirectionId], [AppointId], [SickLeave], [Diagnosis], [Recimmendation], [Medicines]) VALUES (2, 2, 1, N'Казинак', N'сидеть', N'Героинчикк')
