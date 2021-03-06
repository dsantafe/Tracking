USE [master]
GO
/****** Object:  Database [Tracking]    Script Date: 18/05/2020 20:54:25 ******/
CREATE DATABASE [Tracking]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Tracking', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Tracking.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Tracking_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.SQLEXPRESS\MSSQL\DATA\Tracking_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
GO
ALTER DATABASE [Tracking] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Tracking].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Tracking] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Tracking] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Tracking] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Tracking] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Tracking] SET ARITHABORT OFF 
GO
ALTER DATABASE [Tracking] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [Tracking] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Tracking] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Tracking] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Tracking] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Tracking] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Tracking] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Tracking] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Tracking] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Tracking] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Tracking] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Tracking] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Tracking] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Tracking] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Tracking] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Tracking] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Tracking] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Tracking] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Tracking] SET  MULTI_USER 
GO
ALTER DATABASE [Tracking] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Tracking] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Tracking] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Tracking] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Tracking] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Tracking] SET QUERY_STORE = OFF
GO
USE [Tracking]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [Tracking]
GO
USE [Tracking]
GO
/****** Object:  Sequence [dbo].[SEQ_COURSE]    Script Date: 18/05/2020 20:54:26 ******/
CREATE SEQUENCE [dbo].[SEQ_COURSE] 
 AS [bigint]
 START WITH 1
 INCREMENT BY 1
 MINVALUE -9223372036854775808
 MAXVALUE 9223372036854775807
 CACHE 
GO
/****** Object:  UserDefinedFunction [dbo].[GetCoursesFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date, ,>
-- Description:	<Description, ,>
-- =============================================
CREATE FUNCTION [dbo].[GetCoursesFn]()
RETURNS INT
AS
BEGIN
	DECLARE @Count INT = (SELECT COUNT(*) FROM [dbo].[Course]);
	RETURN @Count;
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDetailParameterFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAVID SANTAFE
-- Create date: 2020-05-17
-- Description:	GetDetailParameterFn
-- =============================================
CREATE FUNCTION [dbo].[GetDetailParameterFn]
(
	@ParameterName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	RETURN 
	(SELECT
	master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', CONCAT([Id],
	[Name],
	[Value],
	[Active],
	[Type],
	[CreateDate],
	[ModifyDate]))) SHA
	FROM [dbo].[ParametersGlobal]
	WHERE [Name] = @ParameterName);

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDetailRoutinesFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAVID SANTAFE
-- Create date: 2020-05-17
-- Description:	GetDetailRoutinesFn
-- =============================================
CREATE FUNCTION [dbo].[GetDetailRoutinesFn]
(
	@RoutineName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	RETURN
	(SELECT 
	master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', CONCAT(ROUTINE_CATALOG,
	ROUTINE_SCHEMA,
	ROUTINE_NAME,
	ROUTINE_TYPE,
	DATA_TYPE,
	CHARACTER_MAXIMUM_LENGTH,
	NUMERIC_PRECISION,
	LEN(ROUTINE_DEFINITION),
	CREATED,
	LAST_ALTERED))) SHA
	FROM INFORMATION_SCHEMA.ROUTINES R 
	WHERE CONCAT(R.ROUTINE_SCHEMA,'.',R.ROUTINE_NAME) = @RoutineName);

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDetailSequenceFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAVID SANTAFE
-- Create date: 2020-05-17
-- Description:	GetDetailSequenceFn
-- =============================================
CREATE FUNCTION [dbo].[GetDetailSequenceFn]
(
	@SeqName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	RETURN
	(SELECT 
	master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', CONCAT(SEQUENCE_CATALOG,
	SEQUENCE_SCHEMA,
	SEQUENCE_NAME,
	DATA_TYPE,
	NUMERIC_PRECISION,
	NUMERIC_PRECISION_RADIX,
	NUMERIC_SCALE,
	CAST(START_VALUE AS NVARCHAR),
	CAST(MINIMUM_VALUE AS NVARCHAR),
	CAST(MAXIMUM_VALUE AS NVARCHAR),
	CAST(INCREMENT AS NVARCHAR),
	CYCLE_OPTION,
	DECLARED_DATA_TYPE,
	DECLARED_NUMERIC_PRECISION,
	DECLARED_NUMERIC_SCALE))) SHA
	FROM SYS.SCHEMAS S 
	JOIN SYS.OBJECTS O ON O.SCHEMA_ID = S.SCHEMA_ID
	JOIN INFORMATION_SCHEMA.SEQUENCES SEQ ON OBJECT_ID(CONCAT(SEQ.SEQUENCE_SCHEMA,'.',SEQ.SEQUENCE_NAME)) = O.OBJECT_ID
	WHERE O.OBJECT_ID = OBJECT_ID(@SeqName));

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDetailTableFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAVID SANTAFE
-- Create date: 2020-05-17
-- Description:	GetDetailTableFn
-- =============================================
CREATE FUNCTION [dbo].[GetDetailTableFn]
(
	@TableName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	DECLARE @SHA VARCHAR(MAX),
		@Description VARCHAR(MAX)

	DECLARE DetailTable CURSOR FOR 
		SELECT 
		master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', CONCAT(TABLE_CATALOG, 
		TABLE_SCHEMA, 
		TABLE_NAME, 
		COLUMN_NAME, 
		ORDINAL_POSITION, 
		IS_NULLABLE, 
		DATA_TYPE, 
		CHARACTER_MAXIMUM_LENGTH, 
		NUMERIC_PRECISION,
		O.CREATE_DATE,
		O.MODIFY_DATE))) SHA
		FROM SYS.SCHEMAS S 
		JOIN SYS.OBJECTS O ON O.SCHEMA_ID = S.SCHEMA_ID
		JOIN INFORMATION_SCHEMA.COLUMNS C ON OBJECT_ID(CONCAT(C.TABLE_SCHEMA,'.',C.TABLE_NAME)) = O.OBJECT_ID
		WHERE O.OBJECT_ID = OBJECT_ID(@TableName);

	OPEN DetailTable
	FETCH NEXT FROM DetailTable INTO @Description

	WHILE @@fetch_status = 0

	BEGIN
    
		SET @SHA = CONCAT(@SHA,@Description);		
		FETCH NEXT FROM DetailTable INTO @Description	

	END

	CLOSE DetailTable

	DEALLOCATE DetailTable

	RETURN @SHA

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDetailTriggerFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAVID SANTAFE
-- Create date: 2020-05-17
-- Description:	GetDetailTriggerFn
-- =============================================
CREATE FUNCTION [dbo].[GetDetailTriggerFn]
(
	@TriggerName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN
	
	RETURN
	(SELECT 
	master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', CONCAT(NAME,
	PARENT_CLASS,
	PARENT_CLASS_DESC,
	TYPE,
	TYPE_DESC,
	CREATE_DATE,
	MODIFY_DATE,
	IS_MS_SHIPPED,
	IS_DISABLED,
	IS_NOT_FOR_REPLICATION,
	IS_INSTEAD_OF_TRIGGER,
	STUFF((SELECT ',' + TE.TYPE_DESC FROM SYS.TRIGGERS T JOIN SYS.TRIGGER_EVENTS TE ON TE.OBJECT_ID = T.OBJECT_ID WHERE T.NAME = @TriggerName FOR XML PATH('')), 1, 1, '')))) SHA
	FROM SYS.TRIGGERS T 
	WHERE T.NAME = @TriggerName);

END
GO
/****** Object:  UserDefinedFunction [dbo].[GetDetailViewFn]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		DAVID SANTAFE ZORRILLA
-- Create date: 2020-05-17
-- Description:	GetDetailView
-- =============================================
CREATE FUNCTION [dbo].[GetDetailViewFn] 
(
	@ViewName VARCHAR(100)
)
RETURNS VARCHAR(MAX)
AS
BEGIN

	RETURN	
	(SELECT 
	master.dbo.fn_varbintohexstr(HASHBYTES('SHA2_256', CONCAT(TABLE_CATALOG,
	TABLE_SCHEMA,
	TABLE_NAME,
	LEN(VIEW_DEFINITION),
	O.CREATE_DATE,O.MODIFY_DATE))) SHA
	FROM SYS.SCHEMAS S 
	JOIN SYS.OBJECTS O ON O.SCHEMA_ID = S.SCHEMA_ID
	JOIN INFORMATION_SCHEMA.VIEWS V ON OBJECT_ID(CONCAT(V.TABLE_SCHEMA,'.',V.TABLE_NAME)) = O.OBJECT_ID
	WHERE O.OBJECT_ID = OBJECT_ID(@ViewName));

END
GO
/****** Object:  Table [dbo].[Course]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Course](
	[CourseID] [int] NOT NULL,
	[Title] [varchar](50) NULL,
	[Credits] [int] NULL,
 CONSTRAINT [PK_Course] PRIMARY KEY CLUSTERED 
(
	[CourseID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[GetCoursesVw]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[GetCoursesVw]
AS
SELECT        CourseID AS Expr1, dbo.Course.*
FROM            dbo.Course
GO
/****** Object:  Table [dbo].[AuditEvents]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditEvents](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchemaName] [varchar](100) NULL,
	[ObjectName] [varchar](100) NULL,
	[ObjectType] [varchar](100) NULL,
	[EventTime] [datetime] NULL,
	[ObjectKey] [varchar](max) NULL,
	[ReleaseName] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[ModifyDate] [datetime] NULL,
	[ObjectId] [bigint] NULL,
 CONSTRAINT [PK_AuditEvents] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditEventsDDL]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditEventsDDL](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[DDLObjectName] [varchar](100) NULL,
	[DDLObjectType] [varchar](100) NULL,
	[DDLEventTime] [datetime] NULL,
	[DDLCommand] [varchar](max) NULL,
	[DDLLoginName] [varchar](150) NULL,
	[DDLUserName] [varchar](150) NULL,
	[DDLDatabaseName] [varchar](150) NULL,
	[DDLSchemaName] [varchar](150) NULL,
 CONSTRAINT [PK_AuditEventsDDL] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AuditEventsTmp]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AuditEventsTmp](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SchemaName] [varchar](100) NULL,
	[ObjectName] [varchar](100) NULL,
	[ObjectType] [varchar](100) NULL,
	[EventTime] [datetime] NULL,
	[ObjectKey] [varchar](max) NULL,
	[ObjectKeyCompare] [varchar](max) NULL,
	[Flag] [bit] NULL,
	[ReleaseName] [varchar](50) NULL,
	[CreateDate] [datetime] NULL,
	[ModifyDate] [datetime] NULL,
	[ObjectId] [bigint] NULL,
 CONSTRAINT [PK_AuditEventsTmp] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[DocumentTypes]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[DocumentTypes](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[Active] [bit] NULL,
 CONSTRAINT [PK_DocumentTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Enrollment]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Enrollment](
	[EnrollmentID] [int] IDENTITY(1,1) NOT NULL,
	[CourseID] [int] NULL,
	[StudentID] [int] NULL,
	[Grade] [char](1) NULL,
 CONSTRAINT [PK_Enrollment] PRIMARY KEY CLUSTERED 
(
	[EnrollmentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[ParametersGlobal]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ParametersGlobal](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](100) NULL,
	[Value] [varchar](max) NULL,
	[Active] [bit] NULL,
	[Type] [varchar](100) NULL,
	[CreateDate] [datetime] NULL,
	[ModifyDate] [datetime] NULL,
 CONSTRAINT [PK_ParametersGlobal] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Student]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Student](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[LastName] [varchar](50) NULL,
	[FirstMidName] [varchar](50) NULL,
	[EnrollmentDate] [datetime] NULL,
	[Address] [varchar](50) NULL,
 CONSTRAINT [PK_Student] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Course] FOREIGN KEY([CourseID])
REFERENCES [dbo].[Course] ([CourseID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Course]
GO
ALTER TABLE [dbo].[Enrollment]  WITH CHECK ADD  CONSTRAINT [FK_Enrollment_Student] FOREIGN KEY([StudentID])
REFERENCES [dbo].[Student] ([ID])
GO
ALTER TABLE [dbo].[Enrollment] CHECK CONSTRAINT [FK_Enrollment_Student]
GO
/****** Object:  StoredProcedure [dbo].[CompareRelease]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [CompareRelease] 'Release v1';

CREATE PROCEDURE [dbo].[CompareRelease]
	@ReleaseName VARCHAR(50)
AS

TRUNCATE TABLE [dbo].[AuditEventsTmp];

DECLARE @SchemaName VARCHAR(100), 
		@ObjectName VARCHAR(100), 
		@ObjectType VARCHAR(100),
		@EventTime	DATETIME,
		@ObjectKey VARCHAR(MAX),
		@ObjectNameFull VARCHAR(100),
		@ObjectKeyCompare VARCHAR(MAX),
		@ObjectId BIGINT;

DECLARE ObjectsDB CURSOR FOR 
	
	SELECT [SchemaName],
	[ObjectName],
	[ObjectType],
	[EventTime],
	[ObjectKey],
	[ObjectId]
	FROM [dbo].[AuditEvents]
	WHERE [ReleaseName] = @ReleaseName;
	
OPEN ObjectsDB
FETCH NEXT FROM ObjectsDB INTO @SchemaName, @ObjectName, @ObjectType, @EventTime, @ObjectKey, @ObjectId

WHILE @@fetch_status = 0

BEGIN
    	
	SET @ObjectNameFull = CONCAT(@SchemaName,'.',@ObjectName);
	SET @ObjectKeyCompare = CASE WHEN @ObjectType = 'USER_TABLE' THEN [dbo].[GetDetailTableFn](@ObjectNameFull)
								  WHEN @ObjectType IN ('SQL_STORED_PROCEDURE','SQL_SCALAR_FUNCTION') THEN [dbo].[GetDetailRoutinesFn](@ObjectNameFull)
								  WHEN @ObjectType = 'VIEW' THEN [dbo].[GetDetailViewFn](@ObjectNameFull) 
								  WHEN @ObjectType = 'SEQUENCE_OBJECT' THEN [dbo].[GetDetailSequenceFn](@ObjectNameFull)
								  WHEN @ObjectType = 'SQL_TRIGGER' THEN [dbo].[GetDetailTriggerFn](@ObjectName)
								  WHEN @ObjectType = 'PARAMETER' THEN [dbo].[GetDetailParameterFn](@ObjectName)
							END


	INSERT INTO [dbo].[AuditEventsTmp]
           ([SchemaName]
           ,[ObjectName]
           ,[ObjectType]
           ,[EventTime]
           ,[ObjectKey]
		   ,[ObjectKeyCompare]
		   ,[Flag]
           ,[ReleaseName]
           ,[CreateDate]
		   ,[ObjectId])
	VALUES(@SchemaName
			,@ObjectName
			,@ObjectType
			,@EventTime
			,@ObjectKey
			,@ObjectKeyCompare
			,CASE WHEN @ObjectKey <> ISNULL(@ObjectKeyCompare,'') THEN 1 ELSE 0 END			
			,@ReleaseName
			,GETDATE(),
			@ObjectId)

    FETCH NEXT FROM ObjectsDB INTO @SchemaName, @ObjectName, @ObjectType, @EventTime, @ObjectKey, @ObjectId
END

CLOSE ObjectsDB

DEALLOCATE ObjectsDB

SELECT [Id]
      ,[SchemaName]
      ,[ObjectName]
      ,[ObjectType]
      ,[EventTime]
      ,[ObjectKey]
	  ,[ObjectKeyCompare]
      ,CASE WHEN [ObjectKeyCompare] IS NULL THEN 	(SELECT CONCAT(S.NAME,'.',O.NAME) 
													FROM SYS.OBJECTS O
													JOIN SYS.SCHEMAS S ON S.SCHEMA_ID = O.SCHEMA_ID
													WHERE O.OBJECT_ID = [ObjectId]) 
	   END Rename
	  ,[Flag]
      ,[ReleaseName]
      ,[CreateDate]
      ,[ModifyDate]	  
	  ,[ObjectId]
  FROM [dbo].[AuditEventsTmp]
  WHERE [ReleaseName] = @ReleaseName
  ORDER BY [ObjectType];

GO
/****** Object:  StoredProcedure [dbo].[CreateRelease]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--EXEC [dbo].[CreateRelease] 'Release v1';

CREATE PROCEDURE [dbo].[CreateRelease]
	@ReleaseName VARCHAR(50),
	@Message VARCHAR(50) OUTPUT
AS

BEGIN TRAN CreateReleaseTran

IF EXISTS (SELECT 1 FROM [dbo].[AuditEvents] WHERE UPPER([ReleaseName]) = UPPER(@ReleaseName))
BEGIN
	SET @Message = 'There is already a release with that name'
	ROLLBACK TRAN CreateReleaseTran	
	RETURN
END

DECLARE @SchemaName VARCHAR(100), 
		@ObjectName VARCHAR(100), 
		@ObjectType VARCHAR(100),
		@ObjectId	BIGINT,
		@ObjectNameFull VARCHAR(100)

DECLARE ObjectsDB CURSOR FOR 
	
	--ALL OBJECTS
	SELECT S.NAME	SchemaName,
	O.NAME			ObjectName,
	O.TYPE_DESC		ObjectType,
	O.OBJECT_ID
	FROM SYS.OBJECTS O
	JOIN SYS.SCHEMAS S on S.SCHEMA_ID = O.SCHEMA_ID
	WHERE O.TYPE_DESC IN ('USER_TABLE','SQL_STORED_PROCEDURE','SQL_SCALAR_FUNCTION','VIEW','SEQUENCE_OBJECT')	
	AND O.NAME NOT IN ('CreateRelease','CompareRelease','GetReleases','GetDDLObject',
	'GetDetailParameterFn','GetDetailRoutinesFn','GetDetailSequenceFn','GetDetailTableFn','GetDetailTriggerFn','GetDetailViewFn',
	'AuditEvents','AuditEventsDDL','AuditEventsTmp')

	UNION ALL

	--TRIGGERS
	SELECT ''	SchemaName,
	T.NAME		ObjectName,
	T.TYPE_DESC	ObjectType,
	T.OBJECT_ID
	FROM SYS.TRIGGERS T

	UNION ALL

	--PARAMETERS
	SELECT ''	SchemaName,
	[Name]		ObjectName,
	'PARAMETER'	ObjectType,
	[Id]
	FROM [dbo].[ParametersGlobal];
	
OPEN ObjectsDB
FETCH NEXT FROM ObjectsDB INTO @SchemaName, @ObjectName, @ObjectType, @ObjectId

WHILE @@fetch_status = 0

BEGIN
    	
	SET @ObjectNameFull = CONCAT(@SchemaName,'.',@ObjectName)

	INSERT INTO [dbo].[AuditEvents]
           ([SchemaName]
           ,[ObjectName]
           ,[ObjectType]
           ,[EventTime]
           ,[ObjectKey]
           ,[ReleaseName]
           ,[CreateDate]
		   ,[ObjectId])
	VALUES(@SchemaName
			,@ObjectName
			,@ObjectType
			,GETDATE() 
			,CASE WHEN @ObjectType = 'USER_TABLE' THEN [dbo].[GetDetailTableFn](@ObjectNameFull)
				  WHEN @ObjectType IN ('SQL_STORED_PROCEDURE','SQL_SCALAR_FUNCTION') THEN [dbo].[GetDetailRoutinesFn](@ObjectNameFull)
				  WHEN @ObjectType = 'VIEW' THEN [dbo].[GetDetailViewFn](@ObjectNameFull) 
				  WHEN @ObjectType = 'SEQUENCE_OBJECT' THEN [dbo].[GetDetailSequenceFn](@ObjectNameFull)
				  WHEN @ObjectType = 'SQL_TRIGGER' THEN [dbo].[GetDetailTriggerFn](@ObjectName)
				  WHEN @ObjectType = 'PARAMETER' THEN [dbo].[GetDetailParameterFn](@ObjectName)
			END
			,@ReleaseName
			,GETDATE()
			,@ObjectId)

    FETCH NEXT FROM ObjectsDB INTO @SchemaName, @ObjectName, @ObjectType, @ObjectId
END

CLOSE ObjectsDB

DEALLOCATE ObjectsDB

COMMIT TRAN CreateReleaseTran

SET @Message = 'The process has been executed successfully'

IF @@ERROR != 0
BEGIN
	SET @Message = ERROR_MESSAGE()
	ROLLBACK TRAN CreateReleaseTran	
END
GO
/****** Object:  StoredProcedure [dbo].[GetCoursesSp]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetCoursesSp]
AS

SELECT [CourseID]
      ,[Title]
      ,[Credits]
  FROM [dbo].[Course]
GO
/****** Object:  StoredProcedure [dbo].[GetDDLObject]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetDDLObject]
	@Id INT
AS

DECLARE @ObjectNameFullName VARCHAR(100),
		@EventTimeIni	DATETIME,
		@ReleaseName	VARCHAR(100),
		@EventTimeFin	DATETIME

SELECT @ObjectNameFullName = CONCAT([SchemaName],'.',[ObjectName]), 
@EventTimeIni = [EventTime], 
@ReleaseName = [ReleaseName]
FROM [dbo].[AuditEventsTmp]
WHERE [Id] = @Id

SELECT [Id]
      ,[DDLObjectName]
      ,[DDLObjectType]
      ,[DDLEventTime]
      ,REPLACE([DDLCommand],'&#x0D;','') [DDLCommand]	  
      ,[DDLLoginName]
      ,[DDLUserName]
      ,[DDLDatabaseName]
      ,[DDLSchemaName]
FROM [dbo].[AuditEventsDDL]
WHERE [DDLEventTime] BETWEEN @EventTimeIni AND GETDATE()
AND CONCAT([DDLSchemaName],'.',[DDLObjectName]) = @ObjectNameFullName;
GO
/****** Object:  StoredProcedure [dbo].[GetReleases]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

--EXEC [dbo].[GetReleases]
CREATE PROCEDURE [dbo].[GetReleases]	
AS

SELECT [Id]
      ,[SchemaName]
      ,[ObjectName]
      ,[ObjectType]
      ,[EventTime]
      ,[ObjectKey]
      ,[ReleaseName]
      ,[CreateDate]
      ,[ModifyDate]
      ,[ObjectId]
  FROM [dbo].[AuditEvents]
  ORDER BY [ReleaseName],[ObjectType]
GO
/****** Object:  DdlTrigger [AuditEventsDDLTr]    Script Date: 18/05/2020 20:54:26 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE TRIGGER [AuditEventsDDLTr]
ON DATABASE
    FOR CREATE_TABLE, ALTER_TABLE, DROP_TABLE
AS
     DECLARE
        @event xml;
     SET
     @event = EVENTDATA();
     INSERT INTO AuditEventsDDL
     VALUES
     (
	 CONVERT(varchar(150),@event.query('data(/EVENT_INSTANCE/ObjectName)')),
     CONVERT(varchar(150),@event.query('data(/EVENT_INSTANCE/ObjectType)')),
     REPLACE(CONVERT(varchar(50),@event.query('data(/EVENT_INSTANCE/PostTime)')), 'T', ' '),
	 CONVERT(varchar(max),@event.query('data(/EVENT_INSTANCE/TSQLCommand/CommandText)')),
     CONVERT(varchar(150),@event.query('data(/EVENT_INSTANCE/LoginName)')),
     CONVERT(varchar(150),@event.query('data(/EVENT_INSTANCE/UserName)')),
     CONVERT(varchar(150),@event.query('data(/EVENT_INSTANCE/DatabaseName)')),
     CONVERT(varchar(150),@event.query('data(/EVENT_INSTANCE/SchemaName)')));     
GO
ENABLE TRIGGER [AuditEventsDDLTr] ON DATABASE
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[40] 4[20] 2[20] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
         Begin Table = "Course"
            Begin Extent = 
               Top = 6
               Left = 38
               Bottom = 119
               Right = 208
            End
            DisplayFlags = 280
            TopColumn = 0
         End
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GetCoursesVw'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'GetCoursesVw'
GO
USE [master]
GO
ALTER DATABASE [Tracking] SET  READ_WRITE 
GO
