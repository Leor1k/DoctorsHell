/*
Скрипт развертывания для BaseForDoctors

Этот код был создан программным средством.
Изменения, внесенные в этот файл, могут привести к неверному выполнению кода и будут потеряны
в случае его повторного формирования.
*/

GO
SET ANSI_NULLS, ANSI_PADDING, ANSI_WARNINGS, ARITHABORT, CONCAT_NULL_YIELDS_NULL, QUOTED_IDENTIFIER ON;

SET NUMERIC_ROUNDABORT OFF;


GO
:setvar DatabaseName "BaseForDoctors"
:setvar DefaultFilePrefix "BaseForDoctors"
:setvar DefaultDataPath "C:\Users\317_4\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"
:setvar DefaultLogPath "C:\Users\317_4\AppData\Local\Microsoft\Microsoft SQL Server Local DB\Instances\MSSQLLocalDB\"

GO
:on error exit
GO
/*
Проверьте режим SQLCMD и отключите выполнение скрипта, если режим SQLCMD не поддерживается.
Чтобы повторно включить скрипт после включения режима SQLCMD выполните следующую инструкцию:
SET NOEXEC OFF; 
*/
:setvar __IsSqlCmdEnabled "True"
GO
IF N'$(__IsSqlCmdEnabled)' NOT LIKE N'True'
    BEGIN
        PRINT N'Для успешного выполнения этого скрипта должен быть включен режим SQLCMD.';
        SET NOEXEC ON;
    END


GO
USE [master];


GO

IF (DB_ID(N'$(DatabaseName)') IS NOT NULL) 
BEGIN
    ALTER DATABASE [$(DatabaseName)]
    SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE [$(DatabaseName)];
END

GO
PRINT N'Идет создание базы данных $(DatabaseName)…'
GO
CREATE DATABASE [$(DatabaseName)]
    ON 
    PRIMARY(NAME = [$(DatabaseName)], FILENAME = N'$(DefaultDataPath)$(DefaultFilePrefix)_Primary.mdf')
    LOG ON (NAME = [$(DatabaseName)_log], FILENAME = N'$(DefaultLogPath)$(DefaultFilePrefix)_Primary.ldf') COLLATE SQL_Latin1_General_CP1_CI_AS
GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CLOSE OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
USE [$(DatabaseName)];


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ANSI_NULLS ON,
                ANSI_PADDING ON,
                ANSI_WARNINGS ON,
                ARITHABORT ON,
                CONCAT_NULL_YIELDS_NULL ON,
                NUMERIC_ROUNDABORT OFF,
                QUOTED_IDENTIFIER ON,
                ANSI_NULL_DEFAULT ON,
                CURSOR_DEFAULT LOCAL,
                CURSOR_CLOSE_ON_COMMIT OFF,
                AUTO_CREATE_STATISTICS ON,
                AUTO_SHRINK OFF,
                AUTO_UPDATE_STATISTICS ON,
                RECURSIVE_TRIGGERS OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET ALLOW_SNAPSHOT_ISOLATION OFF;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET READ_COMMITTED_SNAPSHOT OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_UPDATE_STATISTICS_ASYNC OFF,
                PAGE_VERIFY NONE,
                DATE_CORRELATION_OPTIMIZATION OFF,
                DISABLE_BROKER,
                PARAMETERIZATION SIMPLE,
                SUPPLEMENTAL_LOGGING OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET TRUSTWORTHY OFF,
        DB_CHAINING OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
IF IS_SRVROLEMEMBER(N'sysadmin') = 1
    BEGIN
        IF EXISTS (SELECT 1
                   FROM   [master].[dbo].[sysdatabases]
                   WHERE  [name] = N'$(DatabaseName)')
            BEGIN
                EXECUTE sp_executesql N'ALTER DATABASE [$(DatabaseName)]
    SET HONOR_BROKER_PRIORITY OFF 
    WITH ROLLBACK IMMEDIATE';
            END
    END
ELSE
    BEGIN
        PRINT N'Параметры базы данных изменить нельзя. Применить эти параметры может только пользователь SysAdmin.';
    END


GO
ALTER DATABASE [$(DatabaseName)]
    SET TARGET_RECOVERY_TIME = 0 SECONDS 
    WITH ROLLBACK IMMEDIATE;


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET FILESTREAM(NON_TRANSACTED_ACCESS = OFF),
                CONTAINMENT = NONE 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET AUTO_CREATE_STATISTICS ON(INCREMENTAL = OFF),
                MEMORY_OPTIMIZED_ELEVATE_TO_SNAPSHOT = OFF,
                DELAYED_DURABILITY = DISABLED 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE (QUERY_CAPTURE_MODE = ALL, DATA_FLUSH_INTERVAL_SECONDS = 900, INTERVAL_LENGTH_MINUTES = 60, MAX_PLANS_PER_QUERY = 200, CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 367), MAX_STORAGE_SIZE_MB = 100) 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET QUERY_STORE = OFF 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
        ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
        ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
    END


GO
IF EXISTS (SELECT 1
           FROM   [master].[dbo].[sysdatabases]
           WHERE  [name] = N'$(DatabaseName)')
    BEGIN
        ALTER DATABASE [$(DatabaseName)]
            SET TEMPORAL_HISTORY_RETENTION ON 
            WITH ROLLBACK IMMEDIATE;
    END


GO
IF fulltextserviceproperty(N'IsFulltextInstalled') = 1
    EXECUTE sp_fulltext_database 'enable';


GO
PRINT N'Идет создание Таблица [dbo].[Appointment]…';


GO
CREATE TABLE [dbo].[Appointment] (
    [AppointmentId]      INT        NOT NULL,
    [Doctor]             INT        NOT NULL,
    [Patient]            NCHAR (17) NOT NULL,
    [Status]             INT        NOT NULL,
    [Direction]          INT        NULL,
    [DateTemeAppoinment] DATETIME   NOT NULL,
    PRIMARY KEY CLUSTERED ([AppointmentId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Date]…';


GO
CREATE TABLE [dbo].[Date] (
    [DateId]    INT      NOT NULL,
    [Date]      DATE     NOT NULL,
    [StartWork] TIME (7) NOT NULL,
    [EndWork]   TIME (7) NOT NULL,
    PRIMARY KEY CLUSTERED ([DateId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Date_Doctor]…';


GO
CREATE TABLE [dbo].[Date_Doctor] (
    [Date]   INT NOT NULL,
    [Doctor] INT NOT NULL
);


GO
PRINT N'Идет создание Таблица [dbo].[Direction]…';


GO
CREATE TABLE [dbo].[Direction] (
    [DirectionId]    INT        NOT NULL,
    [SickLeave]      INT        NULL,
    [Diagnosis]      NCHAR (50) NOT NULL,
    [Recimmendation] NCHAR (50) NULL,
    [Medicines]      NCHAR (50) NULL,
    PRIMARY KEY CLUSTERED ([DirectionId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Doctor]…';


GO
CREATE TABLE [dbo].[Doctor] (
    [DoctorId]      INT        NOT NULL,
    [Speciality]    INT        NOT NULL,
    [Passport]      INT        NOT NULL,
    [DateStartWork] DATE       NOT NULL,
    [Login]         NCHAR (25) NOT NULL,
    [Password]      NCHAR (30) NOT NULL,
    [root]          BIT        NOT NULL,
    PRIMARY KEY CLUSTERED ([DoctorId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Passport]…';


GO
CREATE TABLE [dbo].[Passport] (
    [PassportId]   INT        NOT NULL,
    [FirstName]    NCHAR (25) NOT NULL,
    [LastName]     NCHAR (25) NOT NULL,
    [SecondName]   NCHAR (25) NULL,
    [Serial]       NCHAR (5)  NULL,
    [Number]       INT        NOT NULL,
    [Issued]       NCHAR (35) NOT NULL,
    [Gender]       NCHAR (3)  NOT NULL,
    [DateIssued]   DATE       NOT NULL,
    [DateBirth]    DATE       NOT NULL,
    [PlaceOfBirth] NCHAR (50) NOT NULL,
    PRIMARY KEY CLUSTERED ([PassportId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Patient]…';


GO
CREATE TABLE [dbo].[Patient] (
    [HealthInsuranceNumber] NCHAR (17) NOT NULL,
    [PassportId]            INT        NOT NULL,
    PRIMARY KEY CLUSTERED ([HealthInsuranceNumber] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[SickLeave]…';


GO
CREATE TABLE [dbo].[SickLeave] (
    [SickLeaveId] INT  NOT NULL,
    [DateStart]   DATE NOT NULL,
    [DateEnd]     DATE NOT NULL,
    PRIMARY KEY CLUSTERED ([SickLeaveId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Speciality]…';


GO
CREATE TABLE [dbo].[Speciality] (
    [SpecialityId] INT        NOT NULL,
    [Speciality]   NCHAR (30) NOT NULL,
    PRIMARY KEY CLUSTERED ([SpecialityId] ASC)
);


GO
PRINT N'Идет создание Таблица [dbo].[Status]…';


GO
CREATE TABLE [dbo].[Status] (
    [StatusId] INT        NOT NULL,
    [Status]   NCHAR (10) NOT NULL,
    PRIMARY KEY CLUSTERED ([StatusId] ASC)
);


GO
PRINT N'Идет создание Ограничение по умолчанию ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor]
    ADD DEFAULT 0 FOR [root];


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Appointment]…';


GO
ALTER TABLE [dbo].[Appointment]
    ADD FOREIGN KEY ([Doctor]) REFERENCES [dbo].[Doctor] ([DoctorId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Appointment]…';


GO
ALTER TABLE [dbo].[Appointment]
    ADD FOREIGN KEY ([Patient]) REFERENCES [dbo].[Patient] ([HealthInsuranceNumber]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Appointment]…';


GO
ALTER TABLE [dbo].[Appointment]
    ADD FOREIGN KEY ([Status]) REFERENCES [dbo].[Status] ([StatusId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Appointment]…';


GO
ALTER TABLE [dbo].[Appointment]
    ADD FOREIGN KEY ([Direction]) REFERENCES [dbo].[Direction] ([DirectionId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Date_Doctor]…';


GO
ALTER TABLE [dbo].[Date_Doctor]
    ADD FOREIGN KEY ([Date]) REFERENCES [dbo].[Date] ([DateId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Date_Doctor]…';


GO
ALTER TABLE [dbo].[Date_Doctor]
    ADD FOREIGN KEY ([Doctor]) REFERENCES [dbo].[Doctor] ([DoctorId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Direction]…';


GO
ALTER TABLE [dbo].[Direction]
    ADD FOREIGN KEY ([SickLeave]) REFERENCES [dbo].[SickLeave] ([SickLeaveId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor]
    ADD FOREIGN KEY ([Speciality]) REFERENCES [dbo].[Speciality] ([SpecialityId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Doctor]…';


GO
ALTER TABLE [dbo].[Doctor]
    ADD FOREIGN KEY ([Passport]) REFERENCES [dbo].[Passport] ([PassportId]);


GO
PRINT N'Идет создание Внешний ключ ограничение без названия для [dbo].[Patient]…';


GO
ALTER TABLE [dbo].[Patient]
    ADD FOREIGN KEY ([PassportId]) REFERENCES [dbo].[Passport] ([PassportId]);


GO
-- Выполняется этап рефакторинга для обновления развернутых журналов транзакций на целевом сервере

IF OBJECT_ID(N'dbo.__RefactorLog') IS NULL
BEGIN
    CREATE TABLE [dbo].[__RefactorLog] (OperationKey UNIQUEIDENTIFIER NOT NULL PRIMARY KEY)
    EXEC sp_addextendedproperty N'microsoft_database_tools_support', N'refactoring log', N'schema', N'dbo', N'table', N'__RefactorLog'
END
GO
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'b83bbe40-b091-474c-957c-63a0a3504824')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('b83bbe40-b091-474c-957c-63a0a3504824')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'f34000d3-cb7b-4da1-981a-73e6cb9b90ee')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('f34000d3-cb7b-4da1-981a-73e6cb9b90ee')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '26337cd8-5547-4cec-b314-ea818a6dd053')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('26337cd8-5547-4cec-b314-ea818a6dd053')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '991ae07c-51e4-47b1-bc55-986cdb017efb')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('991ae07c-51e4-47b1-bc55-986cdb017efb')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'af96d4ec-851d-435e-8c06-7b6eae987afc')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('af96d4ec-851d-435e-8c06-7b6eae987afc')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'bab8210b-086e-4586-877a-e73035081f08')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('bab8210b-086e-4586-877a-e73035081f08')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = 'abc4c7da-02ff-4631-af6f-b07bab749c0f')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('abc4c7da-02ff-4631-af6f-b07bab749c0f')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '371b4393-9abc-4b5b-9bc4-be33a64f6c8e')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('371b4393-9abc-4b5b-9bc4-be33a64f6c8e')
IF NOT EXISTS (SELECT OperationKey FROM [dbo].[__RefactorLog] WHERE OperationKey = '3b957154-256b-40ec-b8cf-e22894266bb1')
INSERT INTO [dbo].[__RefactorLog] (OperationKey) values ('3b957154-256b-40ec-b8cf-e22894266bb1')

GO

GO
DECLARE @VarDecimalSupported AS BIT;

SELECT @VarDecimalSupported = 0;

IF ((ServerProperty(N'EngineEdition') = 3)
    AND (((@@microsoftversion / power(2, 24) = 9)
          AND (@@microsoftversion & 0xffff >= 3024))
         OR ((@@microsoftversion / power(2, 24) = 10)
             AND (@@microsoftversion & 0xffff >= 1600))))
    SELECT @VarDecimalSupported = 1;

IF (@VarDecimalSupported > 0)
    BEGIN
        EXECUTE sp_db_vardecimal_storage_format N'$(DatabaseName)', 'ON';
    END


GO
PRINT N'Обновление завершено.';


GO
