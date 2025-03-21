USE [master]
GO
/****** Object:  Database [Progress_Students]    Script Date: 18.03.2025 17:30:11 ******/
CREATE DATABASE [Progress_Students]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'Progress_Students', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Progress_Students.mdf' , SIZE = 8192KB , MAXSIZE = UNLIMITED, FILEGROWTH = 65536KB )
 LOG ON 
( NAME = N'Progress_Students_log', FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL15.SQLEXPRESS\MSSQL\DATA\Progress_Students_log.ldf' , SIZE = 8192KB , MAXSIZE = 2048GB , FILEGROWTH = 65536KB )
 WITH CATALOG_COLLATION = DATABASE_DEFAULT
GO
ALTER DATABASE [Progress_Students] SET COMPATIBILITY_LEVEL = 150
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [Progress_Students].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [Progress_Students] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [Progress_Students] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [Progress_Students] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [Progress_Students] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [Progress_Students] SET ARITHABORT OFF 
GO
ALTER DATABASE [Progress_Students] SET AUTO_CLOSE ON 
GO
ALTER DATABASE [Progress_Students] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [Progress_Students] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [Progress_Students] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [Progress_Students] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [Progress_Students] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [Progress_Students] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [Progress_Students] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [Progress_Students] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [Progress_Students] SET  DISABLE_BROKER 
GO
ALTER DATABASE [Progress_Students] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [Progress_Students] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [Progress_Students] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [Progress_Students] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [Progress_Students] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [Progress_Students] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [Progress_Students] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [Progress_Students] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [Progress_Students] SET  MULTI_USER 
GO
ALTER DATABASE [Progress_Students] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [Progress_Students] SET DB_CHAINING OFF 
GO
ALTER DATABASE [Progress_Students] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [Progress_Students] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [Progress_Students] SET DELAYED_DURABILITY = DISABLED 
GO
ALTER DATABASE [Progress_Students] SET ACCELERATED_DATABASE_RECOVERY = OFF  
GO
ALTER DATABASE [Progress_Students] SET QUERY_STORE = OFF
GO
USE [Progress_Students]
GO
/****** Object:  User [TeacherUser]    Script Date: 18.03.2025 17:30:12 ******/
CREATE USER [TeacherUser] FOR LOGIN [Teacher] WITH DEFAULT_SCHEMA=[TeacherRole]
GO
/****** Object:  User [SysUser]    Script Date: 18.03.2025 17:30:12 ******/
CREATE USER [SysUser] FOR LOGIN [SysLogin] WITH DEFAULT_SCHEMA=[SysUser]
GO
/****** Object:  User [StudentUser]    Script Date: 18.03.2025 17:30:12 ******/
CREATE USER [StudentUser] FOR LOGIN [Student] WITH DEFAULT_SCHEMA=[StudentUser]
GO
/****** Object:  DatabaseRole [TeacherRole]    Script Date: 18.03.2025 17:30:12 ******/
CREATE ROLE [TeacherRole]
GO
/****** Object:  DatabaseRole [SystemRole]    Script Date: 18.03.2025 17:30:12 ******/
CREATE ROLE [SystemRole]
GO
/****** Object:  DatabaseRole [StudentRole]    Script Date: 18.03.2025 17:30:12 ******/
CREATE ROLE [StudentRole]
GO
ALTER ROLE [TeacherRole] ADD MEMBER [TeacherUser]
GO
ALTER ROLE [SystemRole] ADD MEMBER [SysUser]
GO
ALTER ROLE [StudentRole] ADD MEMBER [StudentUser]
GO
/****** Object:  Schema [Progress_Students]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [Progress_Students]
GO
/****** Object:  Schema [StudentRole]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [StudentRole]
GO
/****** Object:  Schema [StudentUser]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [StudentUser]
GO
/****** Object:  Schema [SystemRole]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [SystemRole]
GO
/****** Object:  Schema [SysUser]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [SysUser]
GO
/****** Object:  Schema [TeacherRole]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [TeacherRole]
GO
/****** Object:  Schema [TeacherUser]    Script Date: 18.03.2025 17:30:12 ******/
CREATE SCHEMA [TeacherUser]
GO
/****** Object:  UserDefinedFunction [dbo].[Calculator]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE FUNCTION [dbo].[Calculator]
(@Opd1 bigint, @Opd2 bigint, @Oprt char(1))
RETURNS bigint
AS
begin
DECLARE @Result bigint
if @Oprt = '+'
	set @Result = @Opd1 + @Opd2
else if @Oprt = '-'
	set @Result = @Opd1 - @Opd2
else if @Oprt = '*'
	set @Result = @Opd1 * @Opd2
else if @Oprt = '/' and @Opd2 !=0 
	set @Result = @Opd1 / @Opd2
else 
	set @Result = null
Return @Result
END
GO
/****** Object:  UserDefinedFunction [dbo].[GetTeachers]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[GetTeachers] (@id int)
returns nvarchar(50)
as
begin
	declare @teacher nvarchar(50)
	select @teacher = TeacherFullName from Teachers
	where TeacherID = @id
	return @teacher
end
GO
/****** Object:  UserDefinedFunction [dbo].[SelColumn]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SelColumn] (@colid int, @tablename nvarchar(max))
returns nvarchar (max)
as
begin
declare @colname nvarchar(max)
set @colname = (SELECT name 
FROM sys.columns WHERE object_id = OBJECT_ID(@tablename)
and column_id = @colid)
return @colname
end
GO
/****** Object:  UserDefinedFunction [dbo].[SelColumn2]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[SelColumn2] (@count int, @tablename nvarchar(max))
returns nvarchar(max)
as begin
	declare @countend int
	set @countend = 1
	declare @query nvarchar(max)
	set @query = 'select '
	while (@countend < @count + 1)
	begin
	if(@countend = @count)
	begin
			set @query = @query + dbo.SelColumn(@countend, @tablename) + ' ';
			set @countend = @countend+ 1
	end
	else
	begin
			set @query = @query + dbo.SelColumn(@countend, @tablename) + ',';
			set @countend = @countend+ 1
	end
	end
	set @query = @query + ' from '+ @tablename
	return @query
end
GO
/****** Object:  Table [dbo].[Summary]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Summary](
	[SummaryID] [int] IDENTITY(1,1) NOT NULL,
	[SummaryClass] [int] NOT NULL,
	[SummaryTeacher] [int] NOT NULL,
	[SummaryDiscipline] [int] NOT NULL,
	[SummarySemester] [int] NOT NULL,
 CONSTRAINT [PK_Summary] PRIMARY KEY CLUSTERED 
(
	[SummaryID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Students]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Students](
	[StudentID] [int] IDENTITY(1,1) NOT NULL,
	[StudentSurname] [nvarchar](20) NOT NULL,
	[StudentName] [nvarchar](20) NOT NULL,
	[StudentPatronymic] [nvarchar](20) NULL,
	[StudentClass] [int] NOT NULL,
	[StudentDateOfBirth] [date] NOT NULL,
	[StudentGender] [int] NOT NULL,
	[StudentAdress] [nvarchar](50) NOT NULL,
	[StudentCity] [nvarchar](20) NOT NULL,
	[StudentPhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK_Students] PRIMARY KEY CLUSTERED 
(
	[StudentID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[SubordinatesSummary]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[SubordinatesSummary](
	[SubID] [int] IDENTITY(1,1) NOT NULL,
	[SubSummary] [int] NOT NULL,
	[SubStudent] [int] NOT NULL,
	[SubGrade] [nvarchar](25) NOT NULL,
 CONSTRAINT [PK_SubordinatesSummary] PRIMARY KEY CLUSTERED 
(
	[SubID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Discipline]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Discipline](
	[DisciplineID] [int] IDENTITY(1,1) NOT NULL,
	[DisciplineName] [nvarchar](100) NOT NULL,
	[DisciplinePulpit] [int] NOT NULL,
	[DisciplineHours] [int] NOT NULL,
	[DisciplineFormatControl] [int] NOT NULL,
	[DisciplineTeacher] [int] NOT NULL,
 CONSTRAINT [PK__Discipli__2909375035C3C774] PRIMARY KEY CLUSTERED 
(
	[DisciplineID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_1]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_1]
as select top (35) StudentSurname AS 'Фамилия', 
StudentName AS 'Имя', StudentPatronymic AS 'Отчество', 
DisciplineName AS 'Дисциплина', SubGrade AS 'Оценка'
FROM  Students
inner join SubordinatesSummary on  SubStudent = StudentID
inner join Summary on SubSummary = SummaryID
inner join Discipline on SummaryDiscipline = DisciplineID
WHERE StudentClass = '2'
order by StudentSurname asc
with check option
GO
/****** Object:  Table [dbo].[Teachers]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Teachers](
	[TeacherID] [int] IDENTITY(1,1) NOT NULL,
	[TeacherFullName] [nvarchar](50) NOT NULL,
	[TeacherPost] [nvarchar](50) NOT NULL,
	[TeacherExperience]  AS (datediff(year,[TeacherDayWork],getdate())),
	[TeacherPulpit] [int] NOT NULL,
	[TeacherDayOfBirth] [date] NOT NULL,
	[TeacherDayWork] [date] NULL,
 CONSTRAINT [PK__Teachers__EDF25944057104B6] PRIMARY KEY CLUSTERED 
(
	[TeacherID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_2]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_2] as
SELECT TeacherFullName AS 'ФИО Преподавателя', 
TeacherExperience AS 'Опыт преподавания', TeacherDayOfBirth AS 'Дата рождения'
FROM Teachers
WHERE TeacherDayOfBirth BETWEEN '1950-01-01' and '1960-01-01'
with check option
GO
/****** Object:  Table [dbo].[Pulpit]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Pulpit](
	[PulpitID] [int] IDENTITY(1,1) NOT NULL,
	[PulpitName] [nvarchar](max) NOT NULL,
	[PulpitFacultyID] [int] NOT NULL,
	[PulpitManagerFullName] [nvarchar](max) NOT NULL,
	[PulpitOfficenumber] [nvarchar](max) NULL,
	[PulpitHousingNumber] [int] NOT NULL,
	[PulpitPhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK__Pulpit__1F0CFE23A6A85ABA] PRIMARY KEY CLUSTERED 
(
	[PulpitID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_3]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_3] as
select PulpitName as 'Кафедра', PulpitManagerFullName as 'ФИО заведующего кафедрой',
PulpitPhoneNumber as 'Номер телефона кафедры', DisciplineName as 'Дисциплина'
from Pulpit 
full outer join Discipline on Pulpit.PulpitID = DisciplinePulpit
where PulpitFacultyID=4

GO
/****** Object:  Table [dbo].[Faculty]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Faculty](
	[FacultyID] [int] IDENTITY(1,1) NOT NULL,
	[FacultyName] [nvarchar](max) NOT NULL,
	[FacultyDean] [nvarchar](max) NOT NULL,
	[FacultyOfficeNumber] [nvarchar](10) NULL,
	[FacultyHousingNumber] [int] NOT NULL,
	[FacultyPhoneNumber] [nvarchar](20) NULL,
 CONSTRAINT [PK__Faculty__306F636ED0ED9375] PRIMARY KEY CLUSTERED 
(
	[FacultyID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_4]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_4] as
select PulpitName as 'Кафедра', TeacherFullName as 'ФИО Преподавателя', 
FacultyName from Pulpit
join Faculty on FacultyID = PulpitFacultyID
join Teachers on TeacherPulpit = PulpitID
where FacultyID = '2'

GO
/****** Object:  Table [dbo].[Class]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Class](
	[ClassID] [int] NOT NULL,
	[ClassName] [nvarchar](10) NOT NULL,
	[ClassYearOfAdmission] [int] NOT NULL,
	[ClassCourse] [int] NOT NULL,
	[ClassPulpit] [int] NOT NULL,
	[ClassQuantityStudent] [int] NULL,
 CONSTRAINT [PK__Class__CB1927A023D4702A] PRIMARY KEY CLUSTERED 
(
	[ClassID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  View [dbo].[View_1_1]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_1_1]
as select top (35) StudentSurname AS 'Фамилия', 
StudentName AS 'Имя', StudentPatronymic AS 'Отчество', 
DisciplineName AS 'Дисциплина', SubGrade AS 'Оценка', ClassName as 'Группа' 
FROM  Students
inner join SubordinatesSummary on  SubStudent = StudentID
inner join Summary on SubSummary = SummaryID
inner join Discipline on SummaryDiscipline = DisciplineID
inner join Class on StudentClass = ClassID
WHERE StudentClass = '2'
order by StudentSurname asc
with check option
GO
/****** Object:  View [dbo].[View_2_1]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE view [dbo].[View_2_1] as
SELECT TeacherFullName AS 'ФИО Преподавателя', 
TeacherExperience AS 'Опыт преподавания', TeacherDayOfBirth AS 'Дата рождения',
DisciplineName as 'Дисциплина'
FROM Teachers
full outer join Discipline on DisciplineTeacher = TeacherID
WHERE TeacherDayOfBirth BETWEEN '1950-01-01' and '1960-01-01'
with check option
GO
/****** Object:  UserDefinedFunction [dbo].[grades]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[grades] (@Discipline int)
returns table as
return
	SELECT top (100)ClassName as 'Группа', StudentSurname AS 'Фамилия', 
	StudentName AS 'Имя',StudentPatronymic AS 'Отчество', 
	DisciplineName AS 'Дисциплина', SubGrade AS 'Оценка' FROM Students 
	INNER JOIN SubordinatesSummary ON SubStudent = StudentID 
	INNER JOIN Summary ON SubSummary = SummaryID 
	INNER JOIN Discipline ON SummaryDiscipline = DisciplineID
	INNER JOIN Class on ClassID = StudentClass
	WHERE (DisciplineID = @Discipline)
	order by ClassName
GO
/****** Object:  UserDefinedFunction [dbo].[CutSTR]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create function [dbo].[CutSTR] (@string nvarchar (max))
returns table
as
return
select value as 'Разделенная строка'
from string_split (@string, ' ')
GO
/****** Object:  Table [dbo].[FormatControl]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[FormatControl](
	[FormatID] [int] IDENTITY(1,1) NOT NULL,
	[FormatName] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK__FormatCo__5D3DCB79BF169F16] PRIMARY KEY CLUSTERED 
(
	[FormatID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Gender]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Gender](
	[GenderID] [int] NOT NULL,
	[GenderName] [nvarchar](10) NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[GenderID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON, OPTIMIZE_FOR_SEQUENTIAL_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[stud]    Script Date: 18.03.2025 17:30:12 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[stud](
	[StudentID] [int] IDENTITY(542,1) NOT NULL,
	[StudentSurname] [nvarchar](20) NOT NULL,
	[StudentName] [nvarchar](20) NOT NULL,
	[StudentPatronymic] [nvarchar](20) NULL,
	[StudentClass] [int] NOT NULL,
	[StudentDateOfBirth] [date] NOT NULL,
	[StudentGender] [int] NOT NULL,
	[StudentAdress] [nvarchar](50) NOT NULL,
	[StudentCity] [nvarchar](20) NOT NULL,
	[StudentPhoneNumber] [nvarchar](20) NULL
) ON [PRIMARY]
GO
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (1, N'БНГС-21-1', 2021, 3, 3, 15)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (2, N'БНГС-23', 2023, 1, 3, 21)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (3, N'БНГС-22', 2022, 2, 3, 22)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (4, N'БНГС-20', 2020, 4, 3, 21)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (5, N'БНГС-21-2', 2021, 3, 3, 21)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (6, N'БНГС-21-3', 2021, 3, 3, 17)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (7, N'БНГС-21-4', 2021, 3, 3, 15)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (8, N'ППБ-20', 2020, 4, 8, 25)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (9, N'ППБ-22', 2022, 2, 8, 16)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (10, N'ППБ-21-1', 2021, 3, 8, 16)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (11, N'ППБ-21-2', 2021, 3, 8, 18)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (12, N'НХТ-21-1', 2021, 3, 9, 17)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (13, N'НХТ-21-2', 2021, 3, 9, 15)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (14, N'НХТ-23', 2023, 1, 9, 16)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (15, N'НХТ-22', 2022, 2, 9, 17)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (16, N'ТМО-21', 2021, 3, 28, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (17, N'ТМО-23', 2023, 1, 28, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (18, N'ТМО-22', 2022, 2, 28, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (19, N'ТГРС-20', 2020, 4, 44, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (20, N'ТГРС-21-1', 2021, 3, 44, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (21, N'ТГРС-21-2', 2021, 3, 44, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (22, N'ОХТ-21', 2021, 3, 57, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (23, N'ОХТ-21', 2021, 3, 57, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (24, N'РРНГМ-21', 2021, 3, 4, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (25, N'РНГМ-21', 2021, 3, 4, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (26, N'РНГМ-21', 2021, 3, 4, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (27, N'РНГМ-23', 2023, 1, 4, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (28, N'ФВ-22', 2022, 2, 34, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (29, N'ФВ-21', 2021, 3, 34, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (30, N'ФВ-23', 2023, 1, 34, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (31, N'ФВ-22', 2022, 2, 34, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (32, N'МЗК-20', 2020, 4, 30, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (33, N'МЗК-21', 2021, 3, 30, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (34, N'МЗК-23', 2023, 1, 30, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (35, N'ГСЭН-21', 2021, 3, 51, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (36, N'ГСЭН-23', 2023, 1, 51, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (37, N'ГСЭН-22', 2022, 2, 51, NULL)
INSERT [dbo].[Class] ([ClassID], [ClassName], [ClassYearOfAdmission], [ClassCourse], [ClassPulpit], [ClassQuantityStudent]) VALUES (38, N'ГСЭН-20', 2020, 4, 51, NULL)
GO
SET IDENTITY_INSERT [dbo].[Discipline] ON 

INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (1, N'Основы аэрогеодезии и современные методы изысканий автомобильных дорог;', 54, 136, 2, 1)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (2, N'Геодезическое сопровождение дорожно-строительных работ;', 61, 136, 1, 2)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (3, N'История и перспективы развития дорожного строительства;', 44, 220, 3, 3)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (4, N'Методы повышения несущей способности и стабильности грунтов;', 26, 264, 1, 4)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (5, N'Дорожное материаловедение и технология дорожно-строительных материалов;', 19, 180, 1, 5)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (6, N'Изыскания и автоматизированное проектирование автомобильных дорог в трехмерном виде;', 52, 108, 2, 6)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (7, N'Дорожные и строительные машины;', 12, 148, 1, 7)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (8, N'Строительство автомобильных дорог;', 45, 102, 3, 8)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (9, N'Инженерные сооружения в транспортном строительстве;', 57, 40, 1, 9)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (10, N'Геоинформационные системы в дорожном строительстве;', 24, 240, 1, 10)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (11, N'Инженерно-геодезические работы в строительстве;', 33, 182, 2, 11)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (12, N'Методы управления и контроль качества в дорожном строительстве;', 30, 150, 3, 12)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (13, N'Дорожные условия и безопасность движения;', 53, 225, 3, 13)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (14, N'Реконструкция автомобильных дорог;', 32, 201, 3, 14)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (15, N'Вычислительная техника, экономика и организация производства, основы маркетинга и менеджмента.', 11, 210, 2, 15)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (16, N'Водоснабжение', 52, 189, 2, 16)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (17, N' Водоотведение и очистка сточных вод', 35, 137, 1, 17)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (18, N'Санитарно-техническое оборудование зданий,', 9, 40, 3, 18)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (19, N'Основы промышленного водоснабжения и водоотведения,', 15, 254, 2, 19)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (20, N'Специальные методы очистки природных и сточных вод,', 60, 123, 3, 20)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (21, N'Пуско-наладка систем водоснабжения и водоотведения,', 10, 200, 1, 21)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (22, N' Эксплуатация систем водоснабжения и водоотведения,', 56, 120, 2, 22)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (23, N'Комплексное использование водных ресурсов,', 31, 229, 1, 23)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (24, N'Вычислительные методы и компьютерное проектирование систем водоснабжения и водоотведения', 24, 159, 3, 24)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (25, N'Реконструкция систем водоснабжения и водоотведения.', 59, 54, 1, 25)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (26, N'правление производственной безопасностью;', 50, 142, 2, 26)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (27, N'Безопасная организация строительных работ;', 45, 228, 3, 27)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (28, N'Информационные технологии в сфере безопасности;', 58, 182, 1, 28)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (29, N'Промышленная экология;', 44, 301, 1, 29)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (30, N'Мониторинг эксплуатационной безопасности зданий и сооружений;', 31, 129, 2, 30)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (31, N'Малоотходные и ресурсосберегающие технологии в строительной индустрии;', 5, 257, 3, 31)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (32, N'Защита населения и территорий в чрезвычайных ситуациях;', 39, 273, 1, 32)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (33, N'Иностранный язык делового и профессионального общения;', 29, 153, 3, 33)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (34, N'Защита объектов интеллектуальной собственности;', 40, 284, 1, 34)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (35, N'Математическое моделирование в задачах строительной отрасли;', 45, 154, 3, 35)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (36, N'Приоритетные направления развития науки, техники и технологии строительства.', 46, 85, 3, 36)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (37, N'Теория пространственной организации города ;', 17, 203, 2, 37)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (38, N'Социально-демографические вопросы развития городов;', 34, 81, 2, 38)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (39, N'Культурный ландшафт города;', 59, 251, 1, 39)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (40, N'Современные проблемы истории и теории архитектуры и градостроительства;', 9, 181, 1, 40)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (41, N'Экономика города', 54, 136, 1, 1)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (42, N'Теория и практика разрешения противоречий в городском планировании', 61, 136, 1, 2)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (43, N'Архитектурное законодательство и авторский надзор', 44, 141, 3, 3)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (44, N'Архитектурно-градостроительное проектирование и исследования', 26, 122, 3, 4)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (45, N'Технологии транспортного планирования;', 19, 116, 1, 5)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (46, N'Городские данные и CIM-технологии', 52, 270, 1, 6)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (47, N'Теория сварочных процессов', 12, 83, 2, 7)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (48, N'Основы сварки', 45, 75, 3, 8)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (49, N'Источники питания для сварки', 57, 145, 3, 9)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (50, N' Технология и проектирование сварных соединений', 24, 297, 1, 10)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (51, N' Автоматизация сварочных процессов', 33, 179, 1, 11)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (52, N' Проектирование сварных конструкций', 30, 75, 3, 12)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (53, N' Технологические основы сварки плавлением и давлением', 53, 143, 2, 13)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (54, N' Производство сварных конструкций', 32, 249, 3, 14)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (55, N' Проектирование цехов и участков сварочного производства', 11, 216, 1, 15)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (56, N' Диагностика технического состояния и оценка ресурса оборудования', 52, 248, 3, 16)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (57, N' Монтаж и ремонт оборудования нефтехимических производств', 35, 228, 1, 17)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (58, N' Методы и средства неразрушающего контроля оборудования', 9, 213, 1, 18)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (59, N' Диагностика и контроль качества сварных конструкций', 15, 216, 3, 19)
INSERT [dbo].[Discipline] ([DisciplineID], [DisciplineName], [DisciplinePulpit], [DisciplineHours], [DisciplineFormatControl], [DisciplineTeacher]) VALUES (60, N' Аттестация сварочного производства.', 60, 295, 1, 20)
SET IDENTITY_INSERT [dbo].[Discipline] OFF
GO
SET IDENTITY_INSERT [dbo].[Faculty] ON 

INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (1, N'Горно-нефтяной факультет (ГНФ)', N'Сысоев Нинель Тарасович', N'415-a', 4, N'7 (987) 370-23-14')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (2, N'Технологический факультет (ТФ)', N'Авдеев Нисон Робертович', N'445-a', 3, N'7 (956) 316-01-15')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (3, N'Институт цифровых систем, автоматизации и энергетики (IT-институт)', N'Борисов Ким Антонинович', N'166-a', 6, N'7 (913) 752-10-70')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (4, N'Факультет трубопроводного транспорта (ФТТ)', N'Исаков Пантелеймон Созонович', N'231-a', 15, N'7 (987) 998-22-84')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (5, N'Институт нефтегазового инжиниринга и цифровых технологий (ИНИЦТ)', N'Антонов Семен Леонидович', N'405-a', 12, N'7 (964) 369-53-02')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (6, N'Высшая школа информационных и социальных технологий (ВыШка ИнСоТех)', N'Смирнов Игнатий Аристархович', N'340-a', 7, N'7 (924) 492-95-36')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (7, N'Факультет заочного обучения (ФЗО)', N'Белозёров Альфред Эльдарович', N'457-a', 10, N'7 (938) 726-84-59')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (8, N'Институт нефтегазового бизнеса (ИНБ)', N'Николаева Виктория Викторовна', N'332-a', 8, N'7 (918) 731-24-57')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (9, N'Уфимская высшая школа экономики и управления (УВШЭУ)', N'Беспалова Виолетта Михаиловна', N'420-a', 2, N'7 (966) 068-31-93')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (10, N'Архитектурно-строительный институт (АСИ)', N'Стрелкова Лика Тарасовна', N'229-a', 1, N'7 (933) 282-65-01')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (11, N'Институт экосистем бизнеса и креативных индустрий (ИЭС)', N'Яковлева Валентина Даниловна', N'373-a', 5, N'7 (962) 529-71-48')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (12, N'Евразийская политехническая школа', N'Борисова Алевтина Парфеньевна', N'287-a', 11, N'7 (965) 656-69-71')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (13, N'Институт нефти и газа ФГБОУ ВО «УГНТУ» в г. Октябрьском', N'Давыдова Наталья Богдановна', N'292-a', 13, N'7 (904) 683-48-39')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (14, N'Институт нефтепереработки и нефтехимии ФГБОУ ВО «УГНТУ» в г. Салавате', N'Силина Ляля Мартыновна', N'217-a', 9, N'7 (901) 138-25-60')
INSERT [dbo].[Faculty] ([FacultyID], [FacultyName], [FacultyDean], [FacultyOfficeNumber], [FacultyHousingNumber], [FacultyPhoneNumber]) VALUES (15, N'Институт химических технологий и инжиниринга ФГБОУ ВО «УГНТУ» в г. Стерлитамаке', N'Блинова Радмила Антониновна', N'205-a', 14, N'7 (930) 969-56-85')
SET IDENTITY_INSERT [dbo].[Faculty] OFF
GO
SET IDENTITY_INSERT [dbo].[FormatControl] ON 

INSERT [dbo].[FormatControl] ([FormatID], [FormatName]) VALUES (1, N'диф. зачет')
INSERT [dbo].[FormatControl] ([FormatID], [FormatName]) VALUES (2, N'зачет')
INSERT [dbo].[FormatControl] ([FormatID], [FormatName]) VALUES (3, N'экзамен')
SET IDENTITY_INSERT [dbo].[FormatControl] OFF
GO
INSERT [dbo].[Gender] ([GenderID], [GenderName]) VALUES (1, N'мужской')
INSERT [dbo].[Gender] ([GenderID], [GenderName]) VALUES (2, N'женский')
GO
SET IDENTITY_INSERT [dbo].[Pulpit] ON 

INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (1, N'Геология и разведка нефтяных и газовых месторождений (Геология)', 1, N'Соколова Фанни Валерьяновна', N'286', 4, N'7 (933) 675-85-43')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (2, N'Геофизические методы исследований (Геофизики)', 1, N'Александрова Элиза Всеволодовна', N'183', 4, N'7 (961) 742-57-79')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (3, N'Бурение нефтяных и газовых скважин (БНГС)', 1, N'Веселова Ираида Викторовна', N'402', 4, N'7 (961) 451-28-90')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (4, N'Разработка и эксплуатация нефтяных и газонефтяных месторождений (РНГМ)', 1, N'Полякова Габи Лукьевна', N'155', 4, N'7 (922) 714-56-11')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (5, N'Разработка и эксплуатация газовых и нефтегазоконденсатных месторождений (РГКМ)', 1, N'Кабанов Клемент Геннадиевич', N'106', 4, N'7 (904) 233-05-43')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (6, N'Цифровые технологии в разработке и эксплуатации нефтяных и газовых месторождений (ЦТРНГМ)', 1, N'Зуев Кондрат Натанович', N'464', 4, N'7 (994) 254-46-38')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (7, N'Машины и оборудование нефтегазовых промыслов (МОНГП)', 1, N'Петров Альберт Максимович', N'473', 4, N'7 (953) 584-81-68')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (8, N'Пожарная и промышленная безопасность (ППБ)', 1, N'Мышкин Адольф Иванович', N'499', 4, N'7 (983) 239-22-65')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (9, N'Нефтехимия и химическая технология (НХТ)', 2, N'Логинов Оскар Владиславович', N'358', 3, N'7 (920) 478-77-74')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (10, N'Технология нефти и газа (ТНГ)', 2, N'Комиссаров Анатолий Федорович', N'447', 3, N'7 (909) 901-57-57')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (11, N'Биохимия и технология микробиологических производств (БТМП)', 2, N'Дмитриев Панкрат Антонович', N'176', 3, N'7 (988) 662-93-08')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (12, N'Физическая и органическая химия (ФОХ)', 2, N'Доронин Харитон Геласьевич', N'353', 3, N'7 (938) 449-73-55')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (13, N'Прикладная экология (ПЭ)', 2, N'Голубева Дана Владленовна', N'370', 3, N'7 (902) 697-37-51')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (14, N'Промышленная безопасность и охрана труда (ПБиОТ)', 2, N'Пестова Франсуаза Мэлоровна', N'347', 3, N'7 (962) 673-35-51')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (15, N'Газохимия и моделирование химико-технологических процессов (ГМХТП)', 2, N'Беляева Архелия Александровна', N'498', 3, N'7 (912) 563-61-84')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (16, N'Школа молекулярных технологий (ШколМонТех)', 2, N'Калашникова Эрика Юлиановна', N'107', 3, N'7 (917) 018-45-13')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (17, N'Вычислительная техника и инженерная кибернетика (ВТИК)', 3, N'Елисеева Кристина Адольфовна', N'329', 6, N'7 (987) 116-10-03')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (18, N'Кафедра Газпрома «Цифровые технологии в газовой промышленности» (ЦТГ)', 3, N'Корнилова Ирина Филипповна', N'211', 6, N'7 (916) 204-30-27')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (19, N'Электротехника и электрооборудование предприятий (ЭЭП)', 3, N'Попова Аида Валентиновна', N'363', 6, N'7 (978) 017-33-71')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (20, N'Автоматизация, телекоммуникация и метрология (АТМ)', 3, N'Егорова Руслана Фроловна', N'213', 6, N'7 (923) 393-49-08')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (21, N'Транспорт и хранение нефти и газа (ТХНГ)', 4, N'Лыткина Гражина Парфеньевна', N'379', 15, N'7 (917) 572-97-82')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (22, N'Промышленная теплоэнергетика (ПТЭ)', 4, N'Маслова Эрида Кирилловна', N'190', 15, N'7 (921) 579-96-82')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (23, N'Проектирование и строительство объектов нефтяной и газовой промышленности (СТ)', 4, N'Красильникова Марта Никитевна', N'252', 15, N'7 (917) 842-50-76')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (24, N'Гидрогазодинамики трубопроводных систем и гидромашины (ГТ)', 4, N'Шарова Эстелла Якововна', N'469', 15, N'7 (917) 337-49-28')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (25, N'Промысловые трубопроводные системы (ПТС)', 4, N'Цветков Клим Николаевич', N'488', 15, N'7 (954) 610-57-53')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (26, N'Технология металлов в нефтегазовом машиностроении (ТМНМ)', 5, N'Лебедева Милана Максимовна', N'337', 12, N'7 (950) 469-72-60')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (27, N'Механика и конструирование машин (МКМ)', 5, N'Быкова Лира Якуновна', N'334', 12, N'7 (916) 952-37-13')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (28, N'Технологические машины и оборудование (ТМО)', 5, N'Мясникова Сафина Дамировна', N'348', 12, N'7 (994) 669-58-06')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (29, N'Оборудование и технологии сварки и контроля (ОТСК)', 5, N'Емельянов Аким Иринеевич', N'254', 12, N'7 (984) 623-68-10')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (30, N'Материаловедение и защита от коррозии (МЗК)', 5, N'Владимиров Максим Георгиевич', N'191', 12, N'7 (962) 291-97-21')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (31, N'Комплексный инжиниринг и компьютерная графика (КИКГ)', 5, N'Виноградов Алексей Антонович', N'302', 12, N'7 (900) 098-58-39')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (32, N'Философия, история и социальный инжиниринг (ФИСИ)', 6, N'Воронцов Эрик Вячеславович', N'265', 7, N'7 (933) 296-72-85')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (33, N'Русский язык и литература (РЯЛ)', 6, N'Силин Иннокентий Ефимович', N'129', 7, N'7 (999) 924-13-48')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (34, N'Физическое воспитание (ФВ)', 6, N'Кошелев Иннокентий Иосифович', N'402', 7, N'7 (978) 241-88-57')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (35, N'ФизикаИностранные языки (ИЯ)', 6, N'Громова Агата Тихоновна', N'265', 7, N'7 (900) 372-06-51')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (36, N'Общая, аналитическая и прикладная химия (ОАПХ)', 6, N'Кудрявцева Видана Рубеновна', N'471', 7, N'7 (967) 524-62-40')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (37, N'Информационные технологии и прикладная математика (ИТМ)', 6, N'Тарасова Флора Георгьевна', N'446', 7, N'7 (960) 463-64-22')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (38, N'Социальных и политических коммуникаций (СПК)', 8, N'Костина Моника Егоровна', N'469', 8, N'7 (900) 699-44-06')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (39, N'Правовое обеспечение деятельности предприятий нефтяной и газовой промышленностиЭкономика и стратегическое развитие (ЭСР)', 8, N'Лихачёва Каролина Дмитриевна', N'488', 8, N'7 (914) 396-18-95')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (40, N'Корпоративных финансов и учетных технологий (КФУ)', 8, N'Гущина Виргиния Егоровна', N'337', 8, N'7 (923) 826-93-17')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (41, N'Международные отношения, история и востоковедение (МОИВ)', 11, N'Кононова Лаура Феликсовна', N'213', 5, N'7 (987) 600-25-01')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (42, N'Региональная экономика и управление (РЭУ)', 11, N'Кулагина Эмма Ивановна', N'379', 5, N'7 (924) 662-42-09')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (43, N'Экономическая безопасность (ЭБ)', 11, N'Ильина Лаура Германовна', N'190', 5, N'7 (928) 848-74-48')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (44, N'Туризм, гостиничный и ресторанный сервис (ТГРС)', 11, N'Соболев Тарас Мэлсович', N'191', 5, N'7 (983) 246-40-38')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (45, N'Технология и конструирование одежды (ТКО)', 11, N'Лыткин Гурий Тихонович', N'302', 5, N'7 (917) 800-50-26')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (46, N'Проектный менеджмент и экономика (ПМЭП)', 11, N'Денисов Аскольд Глебович', N'265', 5, N'7 (925) 306-84-76')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (47, N'Кафедра "Разведка и разработка нефтяных и газовых месторождений" (РРНГМ)', 13, N'Лаврентьев Варлам Рудольфович', N'286', 13, N'7 (912) 821-08-15')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (48, N'Кафедра "Нефтепромысловые машины и оборудование" (НПМО)', 13, N'Одинцов Илья Юрьевич', N'183', 13, N'7 (955) 082-30-08')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (49, N'Кафедра "Механика и технология машиностроения" (МТМ)', 13, N'Михеев Ермолай Донатович', N'337', 13, N'7 (955) 088-96-45')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (50, N'Кафедра "Информационных технологий, математики и естественных наук" (ИТМЕН)', 13, N'Борисов Аким Викторович', N'213', 13, N'7 (925) 245-36-24')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (51, N'Кафедра "Гуманитарных и социально-экономических наук" (ГСЭН)', 13, N'Богданов Игнатий Робертович', N'254', 13, N'7 (928) 176-34-08')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (52, N'Кафедра "Информационных технологий, математики и естественных наук" (ИТМЕН)', 13, N'Якушева Валерия Кирилловна', N'191', 13, N'7 (929) 469-98-17')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (53, N'Кафедра "Химико-технологических процессов" (ХТП)', 14, N'Веселова Эмилия Семеновна', N'337', 9, N'7 (936) 701-28-22')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (54, N'Кафедра "Оборудование предприятий нефтехимии и нефтепереработки" (ОПНН)', 14, N'Борисова Зоя Тимофеевна', N'213', 9, N'7 (938) 583-66-27')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (55, N'Кафедра "Информационных технологий" (ИнТех)', 14, N'Мельникова Эллина Серапионовна', N'402', 9, N'7 (977) 746-87-22')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (56, N'Кафедра "Электрооборудование и автоматика промышленных предприятий" (ЭАПП)', 14, N'Евдокимова Адель Авксентьевна', N'265', 9, N'7 (918) 744-10-59')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (57, N'Кафедра "Общая химическая технология" (ОХТ)', 15, N'Самсонова Аделия Александровна', N'337', 14, N'7 (995) 662-71-40')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (58, N'Кафедра "Оборудование нефтехимических заводов" (ОНХЗ)', 15, N'Князева Надежда Онисимовна', N'213', 14, N'7 (962) 707-97-84')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (59, N'Кафедра "Автоматизированных технологических и информационных систем" (АТИС)', 15, N'Доронина Патрисия Созоновна', N'379', 14, N'7 (928) 158-96-67')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (60, N'Кафедра "Информатика, математика и физика" (ИМФ)', 15, N'Шубин Панкратий Григорьевич', N'190', 14, N'7 (912) 997-66-94')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (61, N'Кафедра "Гуманитарных наук" (ГН)', 15, N'Панов Кассиан Геласьевич', N'109', 14, N'7 (977) 304-42-49')
INSERT [dbo].[Pulpit] ([PulpitID], [PulpitName], [PulpitFacultyID], [PulpitManagerFullName], [PulpitOfficenumber], [PulpitHousingNumber], [PulpitPhoneNumber]) VALUES (62, N'Кафедра нейросетей', 3, N'Уразбаев Газинур Ришатович', N'227', 6, N'7(964) 965 29-69')
SET IDENTITY_INSERT [dbo].[Pulpit] OFF
GO
SET IDENTITY_INSERT [dbo].[stud] ON 

INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (543, N'Тимофеева', N'Злата', N'Степановна', 1, CAST(N'2004-04-07' AS Date), 2, N'Ленина 28 кв. 16', N'Уфа ', N'+7 (965) 097-66-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (544, N'Лукьянова', N'Мила', N'Ивановна', 1, CAST(N'2002-04-09' AS Date), 2, N'Фрунзе 25 кв. 38', N'Тольятти ', N'+7 (933) 660-99-19')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (545, N'Сорокина', N'Алиса', N'Кирилловна', 1, CAST(N'2005-02-08' AS Date), 2, N'Дзержинского 44 кв. 40', N'Воронеж ', N'+7 (962) 261-92-35')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (546, N'Воронин', N'Али', N'Сергеевич', 1, CAST(N'1996-07-18' AS Date), 1, N'Матросова 8 кв. 97', N'Уфа ', N'+7 (964) 319-69-92')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (547, N'Филиппов', N'Тимофей', N'Иванович', 1, CAST(N'1999-06-23' AS Date), 1, N'Нагорная 49 кв. 56', N'Тюмень ', N'+7 (964) 925-33-90')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (548, N'Волков', N'Владимир', N'Михайлович', 1, CAST(N'1991-08-06' AS Date), 1, N'Парковая 42 кв. 55', N'Самара ', N'+7 (933) 032-19-25')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (549, N'Баранов', N'Андрей', N'Кириллович', 1, CAST(N'1996-10-08' AS Date), 1, N'Трактовая 30 кв. 70', N'Омск ', N'+7 (904) 711-33-78')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (550, N'Новиков', N'Николай', N'Михайлович', 1, CAST(N'1994-05-05' AS Date), 1, N'Дзержинского 33 кв. 42', N'Саратов ', N'+7 (992) 841-87-69')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (551, N'Золотов', N'Илья', N'Матвеевич', 1, CAST(N'1999-04-14' AS Date), 1, N'Светлая 36 кв. 88', N'Новосибирск ', N'+7 (967) 849-87-87')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (552, N'Селезнева', N'Виктория', N'Дмитриевна', 1, CAST(N'2002-01-21' AS Date), 2, N'Гагарина 12 кв. 49', N'Тюмень ', N'+7 (977) 298-22-35')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (554, N'Колосова', N'Екатерина', N'Александровна', 1, CAST(N'2002-05-01' AS Date), 2, N'Дзержинского 1 кв. 67', N'Тольятти ', N'+7 (951) 262-45-22')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (556, N'Карпова', N'Сафия', N'Ивановна', 1, CAST(N'1996-11-28' AS Date), 2, N'Комарова 17 кв. 14', N'Волгоград ', N'+7 (992) 835-46-23')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (557, N'Антонов', N'Фёдор', N'Дмитриевич', 1, CAST(N'1998-03-26' AS Date), 1, N'Чехова 8 кв. 56', N'Саратов ', N'+7 (982) 206-53-75')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (558, N'Карпова', N'Айлин', N'Артёмовна', 2, CAST(N'1992-08-28' AS Date), 2, N'8 Марта50 кв. 77', N'Краснодар ', N'+7 (963) 843-22-80')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (559, N'Карпов', N'Лев', N'Максимович', 2, CAST(N'2005-03-17' AS Date), 1, N'Лермонтова 33 кв. 83', N'Волгоград ', N'+7 (954) 304-58-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (561, N'Карпов', N'Даниил', N'Тимурович', 2, CAST(N'1998-09-25' AS Date), 1, N'Коммунистическая 31 кв. 33', N'Санкт-Петербург ', N'+7 (917) 026-86-50')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (563, N'Дмитриева', N'Агния', N'Артёмовна', 2, CAST(N'1994-04-29' AS Date), 2, N'Речная 19 кв. 92', N'Саратов ', N'+7 (928) 012-12-48')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (564, N'Зайцева', N'Анастасия', N'Львовна', 2, CAST(N'2003-06-02' AS Date), 2, N'Сосновая 33 кв. 53', N'Омск ', N'+7 (956) 859-53-39')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (565, N'Романова', N'Милана', N'Глебовна', 2, CAST(N'1990-12-26' AS Date), 2, N'Березовая 3 кв. 85', N'Санкт-Петербург ', N'+7 (918) 948-46-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (566, N'Кузнецова', N'Варвара', N'Максимовна', 2, CAST(N'2000-03-20' AS Date), 2, N'Овражная 15 кв. 61', N'Волгоград ', N'+7 (980) 740-74-22')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (567, N'Овсянникова', N'Варвара', N'Фёдоровна', 2, CAST(N'1998-02-05' AS Date), 2, N'8 Марта21 кв. 58', N'Челябинск ', N'+7 (958) 814-90-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (568, N'Кудряшов', N'Лев', N'Дмитриевич', 2, CAST(N'2005-03-08' AS Date), 1, N'Энергетиков 5 кв. 54', N'Воронеж ', N'+7 (981) 697-46-07')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (569, N'Михайлов', N'Матвей', N'Александрович', 2, CAST(N'1999-06-07' AS Date), 1, N'Парковая 37 кв. 25', N'Омск ', N'+7 (989) 992-09-67')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (570, N'Лаптева', N'Ксения', N'Тимофеевна', 2, CAST(N'2001-08-17' AS Date), 2, N'Светлая 2 кв. 87', N'Уфа ', N'+7 (941) 280-13-03')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (571, N'Петров', N'Владимир', N'Николаевич', 2, CAST(N'2001-05-11' AS Date), 1, N'Школьная 22 кв. 75', N'Челябинск ', N'+7 (956) 076-42-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (572, N'Кукушкин', N'Роберт', N'Львович', 2, CAST(N'1991-07-30' AS Date), 1, N'Красная 28 кв. 60', N'Новосибирск ', N'+7 (970) 863-44-90')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (573, N'Богомолов', N'Адам', N'Глебович', 2, CAST(N'1992-08-27' AS Date), 1, N'Красная 5 кв. 19', N'Челябинск ', N'+7 (988) 242-28-12')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (574, N'Гришин', N'Макар', N'Романович', 2, CAST(N'2000-05-18' AS Date), 1, N'Мира 47 кв. 55', N'Тольятти ', N'+7 (962) 832-67-01')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (575, N'Захарова', N'Амалия', N'Дмитриевна', 2, CAST(N'2001-10-05' AS Date), 2, N'Энергетиков 42 кв. 26', N'Нижний Новгород', N'+7 (958) 422-50-15')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (576, N'Колпакова', N'Алина', N'Михайловна', 2, CAST(N'1995-01-12' AS Date), 2, N'Советская 16 кв. 98', N'Челябинск ', N'+7 (983) 347-31-68')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (577, N'Завьялова', N'Ольга', N'Кирилловна', 2, CAST(N'1991-01-18' AS Date), 2, N'Березовая 31 кв. 31', N'Ижевск ', N'+7 (966) 366-41-36')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (578, N'Волкова', N'Маргарита', N'Викторовна', 2, CAST(N'1991-01-04' AS Date), 2, N'Заречная 46 кв. 55', N'Волгоград ', N'+7 (960) 352-26-50')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (579, N'Петрова', N'Василиса', N'Николаевна', 3, CAST(N'2000-02-08' AS Date), 2, N'Молодежная 17 кв. 69', N'Пермь ', N'+7 (931) 993-06-03')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (580, N'Серебрякова', N'Мадина', N'Юрьевна', 3, CAST(N'1991-10-11' AS Date), 2, N'1 Мая31 кв. 92', N'Воронеж ', N'+7 (941) 047-52-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (581, N'Краснов', N'Кирилл', N'Леонович', 3, CAST(N'1992-04-09' AS Date), 1, N'Строителей 39 кв. 57', N'Тюмень ', N'+7 (997) 337-92-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (582, N'Хабиров', N'Марат', N'Петрович', 3, CAST(N'1996-07-29' AS Date), 1, N'Больничная 27 кв. 83', N'Красноярск ', N'+7 (921) 778-84-64')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (583, N'Калинина', N'Анна', N'Алиевна', 3, CAST(N'1991-05-22' AS Date), 2, N'Светлая 22 кв. 41', N'Воронеж ', N'+7 (988) 321-08-04')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (584, N'Моргунова', N'Анастасия', N'Николаевна', 3, CAST(N'1996-12-05' AS Date), 2, N'Чкалова 28 кв. 83', N'Волгоград ', N'+7 (955) 385-45-87')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (585, N'Царева', N'Дарья', N'Тимуровна', 3, CAST(N'2005-01-19' AS Date), 2, N'Молодежная 21 кв. 8', N'Новосибирск ', N'+7 (912) 327-54-58')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (586, N'Воронцова', N'София', N'Юрьевна', 3, CAST(N'1996-03-05' AS Date), 2, N'Заводская 14 кв. 82', N'Волгоград ', N'+7 (917) 569-85-66')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (587, N'Хабиров', N'Александр', N'Артёмович', 3, CAST(N'2004-05-12' AS Date), 1, N'Шоссейная 2 кв. 42', N'Пермь ', N'+7 (900) 387-52-37')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (588, N'Романов', N'Сергей', N'Михайлович', 3, CAST(N'2004-09-13' AS Date), 1, N'1 Мая14 кв. 21', N'Тюмень ', N'+7 (914) 745-89-23')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (589, N'Сухарева', N'Злата', N'Демидовна', 3, CAST(N'1991-04-09' AS Date), 2, N'Строителей 48 кв. 81', N'Санкт-Петербург ', N'+7 (929) 496-48-78')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (590, N'Кукушкин', N'Роберт', N'Львович', 3, CAST(N'1998-12-25' AS Date), 1, N'Мичурина 32 кв. 73', N'Нижний Новгород', N'+7 (981) 605-45-21')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (591, N'Михайлов', N'Дмитрий', N'Степанович', 3, CAST(N'2002-02-25' AS Date), 1, N'Вишневая 4 кв. 63', N'Самара ', N'+7 (931) 491-68-84')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (592, N'Горбачев', N'Арсен', N'Михайлович', 3, CAST(N'1995-05-04' AS Date), 1, N'Мичурина 25 кв. 37', N'Пермь ', N'+7 (999) 876-87-95')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (593, N'Крючкова', N'Ева', N'Германовна', 3, CAST(N'2004-08-30' AS Date), 2, N'Маяковского 36 кв. 18', N'Санкт-Петербург ', N'+7 (937) 631-03-19')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (594, N'Соколова', N'Мария', N'Ярославовна', 3, CAST(N'2003-10-23' AS Date), 2, N'Победы 42 кв. 34', N'Уфа ', N'+7 (952) 242-25-59')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (595, N'Ермилов', N'Дмитрий', N'Иванович', 3, CAST(N'1992-12-21' AS Date), 1, N'Светлая 39 кв. 81', N'Самара ', N'+7 (978) 935-42-91')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (596, N'Полякова', N'Виктория', N'Марковна', 3, CAST(N'1994-09-23' AS Date), 2, N'Энергетиков 36 кв. 33', N'Красноярск ', N'+7 (967) 143-31-40')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (597, N'Тарасов', N'Андрей', N'Степанович', 3, CAST(N'1994-01-27' AS Date), 1, N'Весенняя 30 кв. 16', N'Краснодар ', N'+7 (953) 229-31-71')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (598, N'Глушков', N'Олег', N'Дмитриевич', 3, CAST(N'1998-08-31' AS Date), 1, N'Родниковая 19 кв. 9', N'Красноярск ', N'+7 (931) 866-91-23')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (599, N'Астахова', N'Кира', N'Степановна', 3, CAST(N'1996-02-15' AS Date), 2, N'Вокзальная 4 кв. 31', N'Москва ', N'+7 (994) 057-77-35')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (600, N'Баранова', N'Анна', N'Саввична', 3, CAST(N'1994-08-08' AS Date), 2, N'Красная 20 кв. 41', N'Караганда', N'+7 (984) 997-38-59')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (601, N'Платонов', N'Лев', N'Максимович', 4, CAST(N'2000-10-06' AS Date), 1, N'Мичурина 38 кв. 4', N'Новосибирск ', N'+7 (904) 697-53-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (602, N'Мельников', N'Дмитрий', N'Даниэльевич', 4, CAST(N'2001-10-09' AS Date), 1, N'Комсомольская 5 кв. 57', N'Ижевск ', N'+7 (913) 901-88-91')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (603, N'Демьянова', N'Алиса', N'Михайловна', 4, CAST(N'1999-06-10' AS Date), 2, N'Победы 33 кв. 16', N'Тюмень ', N'+7 (969) 783-94-34')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (604, N'Богданов', N'Даниэль', N'Артёмович', 4, CAST(N'1995-01-17' AS Date), 1, N'Свердлова 18 кв. 66', N'Уфа ', N'+7 (991) 315-36-69')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (605, N'Кузнецов', N'Гордей', N'Алексеевич', 4, CAST(N'2002-06-07' AS Date), 1, N'Дорожная 26 кв. 47', N'Ижевск ', N'+7 (989) 256-05-93')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (606, N'Устинов', N'Ибрагим', N'Артурович', 4, CAST(N'2004-07-20' AS Date), 1, N'Строительная 17 кв. 50', N'Воронеж ', N'+7 (981) 380-00-33')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (607, N'Зуев', N'Ибрагим', N'Романович', 4, CAST(N'2002-02-12' AS Date), 1, N'Совхозная 12 кв. 34', N'Челябинск ', N'+7 (921) 928-24-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (608, N'Иванов', N'Константин', N'Даниилович', 4, CAST(N'2000-12-13' AS Date), 1, N'Центральная 38 кв. 31', N'Москва ', N'+7 (901) 214-89-63')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (609, N'Свиридов', N'Алексей', N'Ильич', 4, CAST(N'2002-11-01' AS Date), 1, N'Комсомольская 28 кв. 7', N'Казань ', N'+7 (906) 710-13-62')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (610, N'Васильев', N'Николай', N'Артемьевич', 4, CAST(N'2004-01-06' AS Date), 1, N'Заречная 34 кв. 65', N'Санкт-Петербург ', N'+7 (956) 347-44-22')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (611, N'Зимина', N'София', N'Владиславовна', 4, CAST(N'1994-02-21' AS Date), 2, N'Железнодорожная 18 кв. 67', N'Пермь ', N'+7 (925) 083-41-43')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (612, N'Зайцева', N'Полина', N'Никитична', 4, CAST(N'1995-12-18' AS Date), 2, N'Куйбышева 27 кв. 51', N'Казань ', N'+7 (939) 364-25-37')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (613, N'Панков', N'Марк', N'Демьянович', 4, CAST(N'1994-07-22' AS Date), 1, N'Кирова 42 кв. 10', N'Новосибирск ', N'+7 (969) 939-48-66')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (614, N'Михайлов', N'Артём', N'Ильич', 4, CAST(N'2004-01-30' AS Date), 1, N'Подгорная 48 кв. 88', N'Санкт-Петербург ', N'+7 (900) 280-87-69')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (615, N'Прокофьева', N'Анна', N'Максимовна', 4, CAST(N'1993-12-29' AS Date), 2, N'Куйбышева 26 кв. 96', N'Саратов ', N'+7 (986) 810-31-87')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (616, N'Горшкова', N'Софья', N'Владимировна', 4, CAST(N'1992-11-04' AS Date), 2, N'Трудовая 22 кв. 52', N'Ростов-на-Дону ', N'+7 (923) 324-97-44')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (617, N'Павлова', N'Виктория', N'Егоровна', 4, CAST(N'1992-08-11' AS Date), 2, N'Степная 50 кв. 44', N'Омск ', N'+7 (996) 151-94-66')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (618, N'Матвеев', N'Михаил', N'Михайлович', 4, CAST(N'2001-07-09' AS Date), 1, N'Гагарина 31 кв. 80', N'Ростов-на-Дону ', N'+7 (996) 150-32-79')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (619, N'Рябов', N'Никита', N'Алексеевич', 4, CAST(N'2002-02-08' AS Date), 1, N'Заречная  кв. 46', N'Нижний Новгород', N'+7 (906) 983-00-79')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (620, N'Леонтьева', N'Елизавета', N'Вячеславовна', 4, CAST(N'1998-05-26' AS Date), 2, N'Некрасова 34 кв. 69', N'Краснодар ', N'+7 (970) 357-78-98')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (621, N'Скворцов', N'Андрей', N'Романович', 4, CAST(N'1995-09-12' AS Date), 1, N'Некрасова 5 кв. 75', N'Волгоград ', N'+7 (941) 286-43-39')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (622, N'Лосева', N'Фатима', N'Данииловна', 5, CAST(N'1998-06-11' AS Date), 2, N'Кирова 19 кв. 43', N'Воронеж ', N'+7 (993) 881-35-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (623, N'Тихомиров', N'Денис', N'Сергеевич', 5, CAST(N'1995-11-29' AS Date), 1, N'Свободы 29 кв. 80', N'Волгоград ', N'+7 (904) 380-12-16')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (624, N'Кочетов', N'Григорий', N'Константинович', 5, CAST(N'1998-11-27' AS Date), 1, N'Гоголя 17 кв. 50', N'Краснодар ', N'+7 (930) 115-73-52')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (625, N'Титов', N'Максим', N'Максимович', 5, CAST(N'1999-05-03' AS Date), 1, N'Интернациональная  кв. 79', N'Нижний Новгород', N'+7 (965) 862-17-78')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (626, N'Смирнова', N'Маргарита', N'Владимировна', 5, CAST(N'1996-06-19' AS Date), 2, N'Чехова 6 кв. 66', N'Санкт-Петербург ', N'+7 (961) 986-96-38')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (627, N'Мельникова', N'Милана', N'Артуровна', 5, CAST(N'1999-04-22' AS Date), 2, N'Вокзальная 17 кв. 12', N'Самара ', N'+7 (991) 535-42-57')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (628, N'Козловская', N'Маргарита', N'Всеволодовна', 5, CAST(N'1992-01-07' AS Date), 2, N'Свердлова 13 кв. 99', N'Омск ', N'+7 (937) 908-92-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (629, N'Евсеева', N'Алёна', N'Тихоновна', 5, CAST(N'1995-05-03' AS Date), 2, N'Кооперативная 48 кв. 54', N'Челябинск ', N'+7 (937) 407-49-39')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (630, N'Еремина', N'Екатерина', N'Кирилловна', 5, CAST(N'2005-01-03' AS Date), 2, N'Шоссейная 18 кв. 22', N'Краснодар ', N'+7 (967) 242-05-51')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (631, N'Пирогов', N'Платон', N'Леонович', 5, CAST(N'1991-05-10' AS Date), 1, N'Интернациональная 44 кв. 8', N'Челябинск ', N'+7 (928) 280-27-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (632, N'Степанова', N'Мария', N'Владиславовна', 5, CAST(N'2001-08-20' AS Date), 2, N'Солнечная 18 кв. 22', N'Пермь ', N'+7 (928) 506-24-33')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (633, N'Емельянова', N'Мирослава', N'Александровна', 5, CAST(N'2000-01-26' AS Date), 2, N'Свободы 1 кв. 91', N'Тольятти ', N'+7 (933) 820-92-60')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (634, N'Панфилова', N'Есения', N'Ильинична', 5, CAST(N'1992-02-14' AS Date), 2, N'Некрасова 38 кв. 21', N'Екатеринбург ', N'+7 (999) 663-10-13')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (635, N'Долгов', N'Олег', N'Олегович', 5, CAST(N'1995-05-12' AS Date), 1, N'Рабочая 5 кв. 15', N'Ижевск ', N'+7 (954) 887-28-92')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (636, N'Тарасова', N'Юлия', N'Романовна', 5, CAST(N'1995-08-15' AS Date), 2, N'Победы 1 кв. 83', N'Омск ', N'+7 (980) 966-44-32')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (637, N'Астафьева', N'Виктория', N'Савельевна', 5, CAST(N'1994-11-15' AS Date), 2, N'Центральная 19 кв. 16', N'Саратов ', N'+7 (955) 004-31-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (638, N'Васильева', N'Ева', N'Константиновна', 5, CAST(N'1991-11-11' AS Date), 2, N'Московская 29 кв. 90', N'Ижевск ', N'+7 (987) 185-29-91')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (639, N'Артамонова', N'Полина', N'Владиславовна', 5, CAST(N'1992-10-23' AS Date), 2, N'Сосновая 13 кв. 87', N'Москва ', N'+7 (952) 165-75-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (640, N'Бочаров', N'Юрий', N'Михайлович', 5, CAST(N'1990-07-16' AS Date), 1, N'Северная 22 кв. 30', N'Тольятти ', N'+7 (981) 643-06-27')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (641, N'Петрова', N'Яна', N'Алексеевна', 5, CAST(N'1991-11-15' AS Date), 2, N'Заречная 28 кв. 46', N'Омск ', N'+7 (996) 332-29-94')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (642, N'Калашников', N'Матвей', N'Саввич', 5, CAST(N'1994-09-14' AS Date), 1, N'Мичурина 12 кв. 67', N'Волгоград ', N'+7 (951) 659-78-90')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (643, N'Евдокимова', N'Елизавета', N'Максимовна', 6, CAST(N'1996-12-17' AS Date), 2, N'Куйбышева 21 кв. 10', N'Тюмень ', N'+7 (978) 189-81-02')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (644, N'Леонтьев', N'Кирилл', N'Арсентьевич', 6, CAST(N'1991-02-22' AS Date), 1, N'Береговая 7 кв. 59', N'Екатеринбург ', N'+7 (941) 983-44-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (645, N'Кочетов', N'Филипп', N'Данилович', 6, CAST(N'1999-12-29' AS Date), 1, N'Куйбышева 15 кв. 79', N'Санкт-Петербург ', N'+7 (937) 256-76-67')
GO
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (647, N'Панков', N'Михаил', N'Алексеевич', 6, CAST(N'1991-04-08' AS Date), 1, N'Юбилейная 42 кв. 11', N'Москва ', N'+7 (996) 977-05-96')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (648, N'Фролова', N'Анна', N'Тимофеевна', 6, CAST(N'1994-04-22' AS Date), 2, N'Энергетиков 11 кв. 35', N'Волгоград ', N'+7 (934) 693-17-65')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (649, N'Куприянова', N'Анна', N'Алексеевна', 6, CAST(N'1993-09-13' AS Date), 2, N'Красноармейская 38 кв. 33', N'Санкт-Петербург ', N'+7 (964) 926-99-93')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (650, N'Прохоров', N'Леонид', N'Тимурович', 6, CAST(N'1997-03-06' AS Date), 1, N'Партизанская 49 кв. 92', N'Новосибирск ', N'+7 (911) 926-52-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (651, N'Герасимова', N'Виктория', N'Денисовна', 6, CAST(N'1993-07-14' AS Date), 2, N'Энергетиков 5 кв. 77', N'Воронеж ', N'+7 (960) 884-03-03')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (653, N'Родионова', N'Екатерина', N'Александровна', 6, CAST(N'1990-11-06' AS Date), 2, N'Рабочая 11 кв. 89', N'Воронеж ', N'+7 (941) 693-73-71')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (654, N'Титова', N'Александра', N'Александровна', 6, CAST(N'2001-07-20' AS Date), 2, N'Вокзальная 2 кв. 26', N'Пермь ', N'+7 (909) 614-38-52')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (655, N'Комаров', N'Григорий', N'Владиславович', 6, CAST(N'1991-02-27' AS Date), 1, N'Спортивная 2 кв. 64', N'Краснодар ', N'+7 (991) 325-81-17')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (656, N'Масленникова', N'Анастасия', N'Александровна', 6, CAST(N'1993-01-06' AS Date), 2, N'Фрунзе 20 кв. 98', N'Самара ', N'+7 (967) 267-18-08')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (657, N'Кудрявцев', N'Даниил', N'Александрович', 6, CAST(N'2004-07-21' AS Date), 1, N'Заречная 13 кв. 49', N'Тольятти ', N'+7 (922) 743-24-44')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (658, N'Некрасова', N'Яна', N'Андреевна', 6, CAST(N'1992-12-11' AS Date), 2, N'Калинина 17 кв. 97', N'Пермь ', N'+7 (981) 271-36-54')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (659, N'Макарова', N'Полина', N'Дмитриевна', 6, CAST(N'2000-12-15' AS Date), 2, N'Береговая 30 кв. 88', N'Пермь ', N'+7 (938) 738-67-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (660, N'Кожевникова', N'Марта', N'Макаровна', 7, CAST(N'1992-10-09' AS Date), 2, N'Энергетиков 46 кв. 88', N'Санкт-Петербург ', N'+7 (960) 849-58-32')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (661, N'Ларионов', N'Егор', N'Григорьевич', 7, CAST(N'1991-12-09' AS Date), 1, N'Трудовая 16 кв. 57', N'Самара ', N'+7 (955) 686-55-89')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (662, N'Лебедев', N'Дмитрий', N'Андреевич', 7, CAST(N'2004-07-29' AS Date), 1, N'Весенняя 23 кв. 41', N'Омск ', N'+7 (908) 848-33-92')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (663, N'Федорова', N'Александра', N'Леонидовна', 7, CAST(N'2004-11-24' AS Date), 2, N'Московская 39 кв. 42', N'Екатеринбург ', N'+7 (963) 284-88-53')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (664, N'Кукушкин', N'Роберт', N'Львович', 7, CAST(N'1991-04-12' AS Date), 1, N'Березовая 34 кв. 45', N'Пермь ', N'+7 (955) 882-78-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (665, N'Алексеева', N'Арина', N'Никитична', 7, CAST(N'1998-09-30' AS Date), 2, N'Матросова 9 кв. 36', N'Омск ', N'+7 (962) 675-29-21')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (666, N'Смирнов', N'Артур', N'Алексеевич', 7, CAST(N'1998-05-08' AS Date), 1, N'Больничная 20 кв. 54', N'Санкт-Петербург ', N'+7 (981) 411-62-63')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (667, N'Николаева', N'Алиса', N'Юрьевна', 7, CAST(N'2001-08-21' AS Date), 2, N'Северная 36 кв. 69', N'Москва ', N'+7 (956) 893-80-26')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (668, N'Ефремова', N'Анна', N'Антоновна', 7, CAST(N'1998-05-22' AS Date), 2, N'Больничная 29 кв. 76', N'Пермь ', N'+7 (958) 076-47-48')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (669, N'Титова', N'Анна', N'Лукинична', 7, CAST(N'1993-12-27' AS Date), 2, N'Заречная 27 кв. 62', N'Волгоград ', N'+7 (926) 777-55-70')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (670, N'Аникина', N'Камилла', N'Ярославовна', 7, CAST(N'2004-06-24' AS Date), 2, N'Некрасова 21 кв. 8', N'Ростов-на-Дону ', N'+7 (941) 074-69-29')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (671, N'Мухина', N'Мира', N'Александровна', 7, CAST(N'2001-04-04' AS Date), 2, N'Подгорная 2 кв. 48', N'Москва ', N'+7 (988) 886-68-93')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (672, N'Кузьмина', N'Эвелина', N'Максимовна', 7, CAST(N'1990-08-22' AS Date), 2, N'Заводская 49 кв. 5', N'Екатеринбург ', N'+7 (966) 530-42-00')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (673, N'Щербакова', N'Виктория', N'Ильинична', 7, CAST(N'2003-10-27' AS Date), 2, N'Рабочая 33 кв. 2', N'Саратов ', N'+7 (908) 906-22-65')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (674, N'Минаев', N'Владимир', N'Максимович', 7, CAST(N'2004-04-01' AS Date), 1, N'Комарова 12 кв. 7', N'Саратов ', N'+7 (911) 380-58-69')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (675, N'Кошелева', N'Виктория', N'Романовна', 8, CAST(N'1997-06-25' AS Date), 2, N'Строительная 15 кв. 75', N'Москва ', N'+7 (960) 129-37-75')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (676, N'Белякова', N'Вероника', N'Александровна', 8, CAST(N'2004-01-06' AS Date), 2, N'Овражная 43 кв. 82', N'Воронеж ', N'+7 (958) 547-60-42')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (677, N'Розанова', N'Дарина', N'Матвеевна', 8, CAST(N'1995-07-14' AS Date), 2, N'Комарова 20 кв. 43', N'Санкт-Петербург ', N'+7 (932) 057-05-21')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (678, N'Зайцев', N'Артём', N'Матвеевич', 8, CAST(N'2001-04-03' AS Date), 1, N'Нагорная 45 кв. 18', N'Челябинск ', N'+7 (950) 628-46-42')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (679, N'Фролов', N'Сергей', N'Богданович', 8, CAST(N'1992-07-07' AS Date), 1, N'8 Марта30 кв. 40', N'Саратов ', N'+7 (968) 282-96-72')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (680, N'Куликов', N'Артём', N'Арсенович', 8, CAST(N'2000-11-01' AS Date), 1, N'Полевая 13 кв. 77', N'Красноярск ', N'+7 (987) 136-80-68')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (681, N'Маркина', N'Эмилия', N'Тимофеевна', 8, CAST(N'2004-12-03' AS Date), 2, N'Береговая 3 кв. 62', N'Ростов-на-Дону ', N'+7 (965) 599-35-77')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (682, N'Давыдов', N'Фёдор', N'Маркович', 8, CAST(N'2000-03-22' AS Date), 1, N'Партизанская 43 кв. 47', N'Омск ', N'+7 (997) 949-79-22')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (683, N'Овчинников', N'Георгий', N'Максимович', 8, CAST(N'2000-10-05' AS Date), 1, N'Подгорная 14 кв. 98', N'Омск ', N'+7 (963) 930-80-63')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (684, N'Фирсова', N'Полина', N'Арсентьевна', 8, CAST(N'1996-10-17' AS Date), 2, N'Садовая 40 кв. 44', N'Красноярск ', N'+7 (928) 132-36-32')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (685, N'Логинова', N'Виктория', N'Викторовна', 8, CAST(N'1993-12-21' AS Date), 2, N'Озерная 30 кв. 92', N'Самара ', N'+7 (909) 557-56-54')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (686, N'Дроздова', N'Кира', N'Давидовна', 8, CAST(N'1993-01-28' AS Date), 2, N'Калинина 45 кв. 17', N'Ижевск ', N'+7 (937) 433-24-99')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (687, N'Тарасов', N'Марк', N'Иванович', 8, CAST(N'1993-12-06' AS Date), 1, N'Нагорная 45 кв. 66', N'Казань ', N'+7 (930) 196-20-16')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (688, N'Шилов', N'Андрей', N'Михайлович', 8, CAST(N'1999-02-25' AS Date), 1, N'Первомайская 33 кв. 3', N'Тюмень ', N'+7 (928) 470-38-41')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (689, N'Панов', N'Святослав', N'Ильич', 8, CAST(N'2000-10-16' AS Date), 1, N'Березовая 16 кв. 56', N'Краснодар ', N'+7 (924) 750-64-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (690, N'Тихомиров', N'Пётр', N'Андреевич', 8, CAST(N'1997-01-06' AS Date), 1, N'Почтовая 34 кв. 64', N'Омск ', N'+7 (925) 521-14-43')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (691, N'Шаповалова', N'Варвара', N'Львовна', 8, CAST(N'1990-04-06' AS Date), 2, N'Заводская 49 кв. 70', N'Краснодар ', N'+7 (941) 580-50-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (692, N'Егоров', N'Егор', N'Егорович', 8, CAST(N'1998-12-29' AS Date), 1, N'Майская 10 кв. 33', N'Новосибирск ', N'+7 (996) 067-62-60')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (693, N'Колесникова', N'Лилия', N'Александровна', 8, CAST(N'2005-01-12' AS Date), 2, N'Карла Маркса37 кв. 20', N'Пермь ', N'+7 (962) 425-92-28')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (694, N'Дементьев', N'Андрей', N'Лукич', 8, CAST(N'2001-12-19' AS Date), 1, N'Нагорная 12 кв. 98', N'Саратов ', N'+7 (984) 667-66-24')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (695, N'Осипов', N'Ярослав', N'Кириллович', 8, CAST(N'1999-10-25' AS Date), 1, N'Энергетиков 30 кв. 31', N'Новосибирск ', N'+7 (905) 753-88-66')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (696, N'Литвинов', N'Вячеслав', N'Маркович', 8, CAST(N'2002-02-08' AS Date), 1, N'Сосновая 4 кв. 67', N'Челябинск ', N'+7 (956) 974-42-87')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (697, N'Терехова', N'Аделина', N'Арсентьевна', 8, CAST(N'2001-05-14' AS Date), 2, N'Советская 21 кв. 3', N'Челябинск ', N'+7 (956) 580-28-52')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (698, N'Парамонов', N'Глеб', N'Михайлович', 8, CAST(N'1992-11-18' AS Date), 1, N'Коммунистическая 17 кв. 14', N'Челябинск ', N'+7 (982) 049-83-85')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (699, N'Петрова', N'София', N'Робертовна', 8, CAST(N'1990-11-05' AS Date), 2, N'Интернациональная 7 кв. 18', N'Пермь ', N'+7 (986) 194-54-61')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (700, N'Никитина', N'Амина', N'Андреевна', 9, CAST(N'1993-02-16' AS Date), 2, N'Новая 29 кв. 23', N'Санкт-Петербург ', N'+7 (952) 750-90-58')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (701, N'Кузнецова', N'Ксения', N'Святославовна', 9, CAST(N'2002-10-24' AS Date), 2, N'Верхняя 18 кв. 6', N'Москва ', N'+7 (900) 926-66-47')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (702, N'Полякова', N'Мария', N'Лукинична', 9, CAST(N'1996-04-22' AS Date), 2, N'Юбилейная 1 кв. 40', N'Уфа ', N'+7 (969) 981-97-59')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (703, N'Столяров', N'Михаил', N'Игоревич', 9, CAST(N'2002-05-23' AS Date), 1, N'Гоголя 20 кв. 45', N'Санкт-Петербург ', N'+7 (916) 066-53-05')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (704, N'Смирнова', N'Екатерина', N'Елисеевна', 9, CAST(N'2001-04-17' AS Date), 2, N'Трудовая 8 кв. 38', N'Екатеринбург ', N'+7 (991) 953-96-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (705, N'Дмитриев', N'Фёдор', N'Даниилович', 9, CAST(N'1990-05-09' AS Date), 1, N'Трактовая 35 кв. 89', N'Санкт-Петербург ', N'+7 (937) 116-84-19')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (706, N'Щукин', N'Дмитрий', N'Иванович', 9, CAST(N'1995-04-19' AS Date), 2, N'Пионерская 23 кв. 79', N'Омск ', N'+7 (911) 086-84-36')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (707, N'Степанов', N'Роман', N'Степанович', 9, CAST(N'1993-09-27' AS Date), 1, N'Светлая 6 кв. 66', N'Новосибирск ', N'+7 (925) 780-16-18')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (708, N'Иванов', N'Георгий', N'Ярославович', 9, CAST(N'1995-01-17' AS Date), 1, N'Речная 28 кв. 51', N'Пермь ', N'+7 (956) 313-42-52')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (709, N'Рубцова', N'Татьяна', N'Альбертовна', 9, CAST(N'1998-07-27' AS Date), 2, N'Строителей 42 кв. 31', N'Краснодар ', N'+7 (960) 018-75-91')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (710, N'Карташова', N'Таисия', N'Руслановна', 9, CAST(N'1997-05-27' AS Date), 2, N'Строителей 18 кв. 57', N'Санкт-Петербург ', N'+7 (922) 399-00-73')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (711, N'Леонов', N'Дмитрий', N'Кириллович', 9, CAST(N'2004-09-20' AS Date), 1, N'Трудовая 27 кв. 84', N'Ижевск ', N'+7 (989) 915-03-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (712, N'Фадеев', N'Фёдор', N'Артёмович', 9, CAST(N'2000-03-08' AS Date), 1, N'Вишневая 8 кв. 97', N'Пермь ', N'+7 (928) 406-94-21')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (713, N'Романова', N'Александра', N'Алексеевна', 9, CAST(N'2004-07-28' AS Date), 2, N'Северная 43 кв. 70', N'Нижний Новгород', N'+7 (929) 464-31-58')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (715, N'Кондратьев', N'Александр', N'Демьянович', 9, CAST(N'1995-09-15' AS Date), 1, N'Чехова 43 кв. 51', N'Москва ', N'+7 (936) 012-53-33')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (716, N'Волошин', N'Константин', N'Маркович', 10, CAST(N'1997-03-28' AS Date), 1, N'Подгорная 50 кв. 42', N'Омск ', N'+7 (925) 910-17-83')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (717, N'Леонова', N'София', N'Львовна', 10, CAST(N'2004-01-23' AS Date), 2, N'Новая 34 кв. 68', N'Пермь ', N'+7 (917) 992-61-72')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (718, N'Винокуров', N'Владимир', N'Леонович', 10, CAST(N'1992-02-20' AS Date), 1, N'Береговая 12 кв. 41', N'Саратов ', N'+7 (968) 254-90-96')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (719, N'Осипова', N'Дарья', N'Андреевна', 10, CAST(N'1992-09-08' AS Date), 2, N'Западная 19 кв. 22', N'Москва ', N'+7 (922) 232-18-25')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (720, N'Булгакова', N'Анастасия', N'Михайловна', 10, CAST(N'1993-10-01' AS Date), 2, N'Сосновая 25 кв. 65', N'Волгоград ', N'+7 (985) 642-69-88')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (721, N'Козлова', N'Вероника', N'Александровна', 10, CAST(N'2001-12-21' AS Date), 2, N'Береговая 20 кв. 91', N'Санкт-Петербург ', N'+7 (900) 924-31-00')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (722, N'Бурова', N'Анна', N'Савельевна', 10, CAST(N'1999-04-28' AS Date), 2, N'Верхняя 19 кв. 10', N'Воронеж ', N'+7 (934) 772-38-80')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (723, N'Туманов', N'Родион', N'Петрович', 10, CAST(N'1991-02-06' AS Date), 1, N'Чкалова 18 кв. 29', N'Самара ', N'+7 (936) 332-81-41')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (724, N'Михеева', N'Алёна', N'Кирилловна', 10, CAST(N'1992-12-31' AS Date), 2, N'Трудовая 9 кв. 90', N'Уфа ', N'+7 (961) 517-53-23')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (725, N'Яковлева', N'Анна', N'Ивановна', 10, CAST(N'2001-11-07' AS Date), 2, N'Спортивная 14 кв. 61', N'Саратов ', N'+7 (953) 762-96-29')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (726, N'Пантелеева', N'Ясмина', N'Владимировна', 10, CAST(N'1997-12-26' AS Date), 2, N'Горная 10 кв. 85', N'Екатеринбург ', N'+7 (920) 158-58-78')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (727, N'Бирюков', N'Дмитрий', N'Максимович', 10, CAST(N'2004-11-03' AS Date), 1, N'Дорожная 17 кв. 94', N'Казань ', N'+7 (912) 158-77-22')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (728, N'Новикова', N'Арина', N'Данииловна', 10, CAST(N'2000-07-20' AS Date), 2, N'Березовая 14 кв. 41', N'Ростов-на-Дону ', N'+7 (934) 651-55-84')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (729, N'Захаров', N'Тимур', N'Владимирович', 10, CAST(N'1990-09-14' AS Date), 1, N'Заречная 35 кв. 50', N'Тюмень ', N'+7 (991) 945-35-13')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (730, N'Соболева', N'Полина', N'Денисовна', 10, CAST(N'1990-11-09' AS Date), 2, N'Зеленая 30 кв. 84', N'Екатеринбург ', N'+7 (938) 629-29-86')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (731, N'Софронов', N'Даниил', N'Михайлович', 10, CAST(N'1999-04-09' AS Date), 1, N'Матросова 5 кв. 30', N'Челябинск ', N'+7 (954) 664-13-26')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (732, N'Антонов', N'Владимир', N'Ильич', 11, CAST(N'2003-04-18' AS Date), 1, N'Дзержинского 2 кв. 1', N'Тюмень ', N'+7 (994) 266-31-84')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (733, N'Яковлева', N'Ксения', N'Артуровна', 11, CAST(N'2002-04-05' AS Date), 2, N'Горная 38 кв. 4', N'Москва ', N'+7 (900) 024-86-59')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (734, N'Кузнецов', N'Григорий', N'Даниэльевич', 11, CAST(N'1992-03-02' AS Date), 1, N'Озерная 27 кв. 64', N'Санкт-Петербург ', N'+7 (985) 501-83-99')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (735, N'Попов', N'Демид', N'Давидович', 11, CAST(N'1999-02-04' AS Date), 1, N'Спортивная 18 кв. 65', N'Волгоград ', N'+7 (903) 924-14-40')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (736, N'Кузнецов', N'Илья', N'Глебович', 11, CAST(N'1991-11-01' AS Date), 1, N'Ленина 34 кв. 99', N'Ижевск ', N'+7 (952) 933-10-80')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (737, N'Потапов', N'Дмитрий', N'Артёмович', 11, CAST(N'2004-12-16' AS Date), 1, N'Маяковского 30 кв. 4', N'Красноярск ', N'+7 (997) 611-19-49')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (738, N'Белоусова', N'Ариана', N'Арсентьевна', 11, CAST(N'1992-06-02' AS Date), 2, N'Маяковского 47 кв. 38', N'Красноярск ', N'+7 (919) 159-03-37')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (739, N'Воробьев', N'Руслан', N'Ярославович', 11, CAST(N'1992-06-08' AS Date), 1, N'Пионерская 2 кв. 60', N'Тюмень ', N'+7 (980) 574-57-29')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (740, N'Зайцева', N'Дарья', N'Фёдоровна', 11, CAST(N'2003-03-13' AS Date), 2, N'Чкалова 14 кв. 22', N'Ижевск ', N'+7 (939) 475-65-75')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (741, N'Поляков', N'Алексей', N'Михайлович', 11, CAST(N'1993-01-19' AS Date), 1, N'Дружбы 37 кв. 2', N'Пермь ', N'+7 (978) 056-76-04')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (742, N'Богданова', N'Кристина', N'Сергеевна', 11, CAST(N'2003-04-03' AS Date), 2, N'Строительная 37 кв. 92', N'Ижевск ', N'+7 (991) 635-97-37')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (743, N'Акимов', N'Макар', N'Игоревич', 11, CAST(N'1991-05-22' AS Date), 1, N'Лермонтова 50 кв. 23', N'Уфа ', N'+7 (951) 975-83-04')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (744, N'Шишкин', N'Иван', N'Павлович', 11, CAST(N'2004-09-06' AS Date), 1, N'Клубная 16 кв. 5', N'Пермь ', N'+7 (930) 531-34-05')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (745, N'Бобров', N'Виктор', N'Иванович', 11, CAST(N'2004-10-05' AS Date), 1, N'Молодежная 3 кв. 73', N'Ростов-на-Дону ', N'+7 (988) 924-76-80')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (746, N'Ушаков', N'Евгений', N'Алексеевич', 11, CAST(N'1995-05-18' AS Date), 1, N'Спортивная 13 кв. 91', N'Пермь ', N'+7 (977) 643-04-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (747, N'Миронов', N'Евгений', N'Русланович', 11, CAST(N'2002-12-12' AS Date), 1, N'Советская 21 кв. 23', N'Москва ', N'+7 (958) 472-16-48')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (748, N'Зайцева', N'Василиса', N'Владимировна', 11, CAST(N'2004-11-04' AS Date), 2, N'Победы 23 кв. 30', N'Волгоград ', N'+7 (981) 483-02-38')
GO
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (749, N'Воробьева', N'Таисия', N'Егоровна', 12, CAST(N'2001-08-03' AS Date), 2, N'Верхняя 11 кв. 21', N'Москва ', N'+7 (991) 529-48-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (750, N'Некрасов', N'Марк', N'Викторович', 12, CAST(N'1991-11-20' AS Date), 1, N'Советская 34 кв. 14', N'Воронеж ', N'+7 (906) 648-45-76')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (751, N'Романов', N'Михаил', N'Елисеевич', 12, CAST(N'1995-02-13' AS Date), 1, N'Октябрьская 12 кв. 50', N'Ижевск ', N'+7 (991) 208-80-04')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (752, N'Александров', N'Савелий', N'Владиславович', 12, CAST(N'1995-03-17' AS Date), 1, N'Трактовая 43 кв. 88', N'Волгоград ', N'+7 (902) 423-39-48')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (753, N'Леонова', N'Полина', N'Степановна', 12, CAST(N'1990-07-11' AS Date), 2, N'Парковая 11 кв. 45', N'Воронеж ', N'+7 (902) 085-51-14')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (754, N'Юдина', N'Валерия', N'Алексеевна', 12, CAST(N'1993-01-28' AS Date), 2, N'Дружбы 28 кв. 52', N'Волгоград ', N'+7 (914) 196-20-85')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (755, N'Лапин', N'Иван', N'Никитич', 12, CAST(N'1997-09-23' AS Date), 1, N'Центральная 34 кв. 66', N'Санкт-Петербург ', N'+7 (980) 625-73-87')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (756, N'Пономарева', N'Алина', N'Данииловна', 12, CAST(N'1991-07-05' AS Date), 2, N'Светлая 11 кв. 49', N'Новосибирск ', N'+7 (999) 120-73-12')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (757, N'Завьялов', N'Пётр', N'Никитич', 12, CAST(N'2001-02-26' AS Date), 1, N'Красноармейская 5 кв. 47', N'Волгоград ', N'+7 (964) 250-15-93')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (758, N'Логинов', N'Илья', N'Максимович', 12, CAST(N'1999-07-30' AS Date), 1, N'Овражная 43 кв. 93', N'Саратов ', N'+7 (917) 448-12-18')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (759, N'Левин', N'Тимофей', N'Серафимович', 12, CAST(N'1995-12-20' AS Date), 2, N'Октябрьская 16 кв. 17', N'Челябинск ', N'+7 (967) 437-47-64')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (760, N'Дроздов', N'Максим', N'Макарович', 12, CAST(N'2001-01-24' AS Date), 1, N'Красноармейская 50 кв. 73', N'Пермь ', N'+7 (929) 173-08-16')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (761, N'Лебедева', N'Амалия', N'Артёмовна', 12, CAST(N'1999-06-15' AS Date), 2, N'Центральная 31 кв. 14', N'Ижевск ', N'+7 (981) 641-65-83')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (762, N'Попова', N'Анастасия', N'Михайловна', 12, CAST(N'1997-07-23' AS Date), 2, N'Мичурина 19 кв. 67', N'Омск ', N'+7 (963) 406-80-43')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (763, N'Денисова', N'Ариана', N'Алексеевна', 12, CAST(N'1991-10-11' AS Date), 2, N'Солнечная 8 кв. 41', N'Волгоград ', N'+7 (978) 435-92-86')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (764, N'Нефедова', N'Ольга', N'Константиновна', 12, CAST(N'1991-06-12' AS Date), 2, N'Солнечная 46 кв. 16', N'Тольятти ', N'+7 (967) 366-52-40')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (765, N'Егоров', N'Константин', N'Артемьевич', 12, CAST(N'1990-06-22' AS Date), 1, N'Дорожная 39 кв. 78', N'Челябинск ', N'+7 (937) 919-17-09')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (766, N'Пименова', N'Таисия', N'Макаровна', 13, CAST(N'2002-06-13' AS Date), 2, N'Энергетиков 22 кв. 85', N'Ростов-на-Дону ', N'+7 (986) 227-20-09')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (767, N'Фролова', N'Таисия', N'Ивановна', 13, CAST(N'2001-07-16' AS Date), 2, N'Дружбы 30 кв. 61', N'Уфа ', N'+7 (961) 800-60-78')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (768, N'Басова', N'Марианна', N'Артемьевна', 13, CAST(N'1990-08-15' AS Date), 2, N'Нагорная 7 кв. 3', N'Челябинск ', N'+7 (955) 224-07-20')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (769, N'Титова', N'Анна', N'Максимовна', 13, CAST(N'1995-10-25' AS Date), 2, N'Центральная 7 кв. 37', N'Воронеж ', N'+7 (920) 810-93-64')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (770, N'Ильинская', N'Злата', N'Богдановна', 13, CAST(N'2002-01-18' AS Date), 2, N'Победы 45 кв. 30', N'Новосибирск ', N'+7 (980) 846-05-77')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (771, N'Колесов', N'Борис', N'Максимович', 13, CAST(N'1990-04-30' AS Date), 1, N'Набережная 2 кв. 36', N'Челябинск ', N'+7 (978) 292-68-93')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (772, N'Виноградов', N'Максим', N'Романович', 13, CAST(N'1997-03-14' AS Date), 1, N'Клубная 28 кв. 24', N'Тольятти ', N'+7 (909) 435-96-89')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (773, N'Молчанов', N'Дмитрий', N'Дмитриевич', 13, CAST(N'1991-07-01' AS Date), 1, N'Весенняя 4 кв. 94', N'Челябинск ', N'+7 (962) 802-20-92')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (774, N'Михайлова', N'Мария', N'Дмитриевна', 13, CAST(N'1993-03-19' AS Date), 2, N'Маяковского 1 кв. 100', N'Москва ', N'+7 (970) 757-83-02')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (775, N'Громов', N'Матвей', N'Глебович', 13, CAST(N'1993-03-26' AS Date), 1, N'Чехова 35 кв. 88', N'Новосибирск ', N'+7 (903) 887-80-44')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (776, N'Еремин', N'Виктор', N'Леонидович', 13, CAST(N'2000-01-17' AS Date), 2, N'Красная 50 кв. 29', N'Нижний Новгород', N'+7 (955) 334-65-88')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (778, N'Чернова', N'Сафия', N'Романовна', 13, CAST(N'1996-11-04' AS Date), 2, N'Гагарина 18 кв. 49', N'Волгоград ', N'+7 (941) 770-46-11')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (779, N'Карасева', N'София', N'Матвеевна', 13, CAST(N'1997-05-07' AS Date), 2, N'Калинина 6 кв. 14', N'Казань ', N'+7 (968) 659-19-98')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (780, N'Быков', N'Максим', N'Егорович', 13, CAST(N'1999-09-07' AS Date), 1, N'8 Марта27 кв. 14', N'Ростов-на-Дону ', N'+7 (913) 028-77-54')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (781, N'Максимова', N'Полина', N'Захаровна', 14, CAST(N'1991-07-19' AS Date), 2, N'Цветочная 29 кв. 75', N'Казань ', N'+7 (915) 962-16-53')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (782, N'Чернов', N'Глеб', N'Матвеевич', 14, CAST(N'1998-06-26' AS Date), 1, N'Горького 36 кв. 9', N'Пермь ', N'+7 (997) 572-25-83')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (783, N'Осипова', N'София', N'Андреевна', 14, CAST(N'1992-09-07' AS Date), 2, N'Свердлова 28 кв. 90', N'Краснодар ', N'+7 (982) 861-99-99')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (784, N'Баранова', N'Анастасия', N'Георгиевна', 14, CAST(N'1994-05-04' AS Date), 2, N'Свободы 9 кв. 28', N'Тюмень ', N'+7 (981) 105-67-32')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (785, N'Островский', N'Адам', N'Степанович', 14, CAST(N'1994-07-18' AS Date), 1, N'Строительная 16 кв. 89', N'Екатеринбург ', N'+7 (929) 640-03-55')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (786, N'Островская', N'София', N'Дмитриевна', 14, CAST(N'2004-08-13' AS Date), 2, N'Северная 7 кв. 24', N'Тюмень ', N'+7 (984) 420-11-88')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (787, N'Баженова', N'Алина', N'Дмитриевна', 14, CAST(N'2003-11-18' AS Date), 2, N'Садовая 28 кв. 89', N'Нижний Новгород', N'+7 (906) 483-55-28')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (788, N'Панкова', N'Алиса', N'Михайловна', 14, CAST(N'1995-03-13' AS Date), 2, N'Зеленая 31 кв. 10', N'Челябинск ', N'+7 (917) 457-34-92')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (789, N'Сафонов', N'Марк', N'Андреевич', 14, CAST(N'1993-08-11' AS Date), 1, N'Карла Маркса10 кв. 79', N'Саратов ', N'+7 (905) 066-28-35')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (790, N'Семенов', N'Максим', N'Владимирович', 14, CAST(N'1995-01-31' AS Date), 1, N'Свободы 37 кв. 72', N'Тюмень ', N'+7 (931) 186-09-75')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (791, N'Волков', N'Олег', N'Даниилович', 14, CAST(N'2000-07-14' AS Date), 1, N'Вишневая 12 кв. 69', N'Тюмень ', N'+7 (965) 380-87-95')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (792, N'Кузнецов', N'Тихон', N'Александрович', 14, CAST(N'2001-07-02' AS Date), 1, N'Кооперативная 34 кв. 50', N'Воронеж ', N'+7 (936) 134-49-71')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (793, N'Комарова', N'Елизавета', N'Артёмовна', 14, CAST(N'2001-11-28' AS Date), 2, N'Горная 48 кв. 93', N'Екатеринбург ', N'+7 (934) 487-27-49')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (794, N'Никольский', N'Тимофей', N'Тимурович', 14, CAST(N'1995-01-04' AS Date), 1, N'Чапаева 13 кв. 63', N'Тюмень ', N'+7 (905) 874-33-94')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (795, N'Шестаков', N'Иван', N'Эмильевич', 14, CAST(N'1991-11-19' AS Date), 1, N'Фрунзе 9 кв. 28', N'Тюмень ', N'+7 (932) 326-77-97')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (796, N'Москвин', N'Михаил', N'Дамирович', 14, CAST(N'1993-03-08' AS Date), 1, N'Маяковского 44 кв. 44', N'Челябинск ', N'+7 (952) 964-07-52')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (797, N'Беспалова', N'Анастасия', N'Фёдоровна', 15, CAST(N'1998-02-05' AS Date), 2, N'Трактовая 48 кв. 67', N'Омск ', N'+7 (933) 707-66-87')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (798, N'Михеева', N'Виктория', N'Ильинична', 15, CAST(N'2003-08-12' AS Date), 2, N'Юбилейная 48 кв. 10', N'Тольятти ', N'+7 (961) 186-27-85')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (799, N'Сергеев', N'Степан', N'Фёдорович', 15, CAST(N'1994-06-29' AS Date), 1, N'Новая 6 кв. 4', N'Ижевск ', N'+7 (927) 725-24-33')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (800, N'Артемов', N'Денис', N'Арсентьевич', 15, CAST(N'1993-07-26' AS Date), 1, N'Восточная 27 кв. 74', N'Екатеринбург ', N'+7 (917) 896-03-10')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (801, N'Соловьев', N'Роман', N'Алексеевич', 15, CAST(N'1993-10-14' AS Date), 1, N'Клубная 7 кв. 91', N'Краснодар ', N'+7 (978) 571-57-56')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (802, N'Булатов', N'Дмитрий', N'Егорович', 15, CAST(N'2002-05-10' AS Date), 1, N'Маяковского 42 кв. 59', N'Самара ', N'+7 (965) 068-81-96')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (803, N'Зайцева', N'Мелисса', N'Вадимовна', 15, CAST(N'1995-04-14' AS Date), 2, N'Вокзальная 14 кв. 46', N'Челябинск ', N'+7 (988) 549-35-13')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (804, N'Кукушкин', N'Роберт', N'Львович', 15, CAST(N'1992-09-17' AS Date), 1, N'Нагорная 12 кв. 70', N'Пермь ', N'+7 (965) 125-71-81')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (805, N'Зайцева', N'Анастасия', N'Фёдоровна', 15, CAST(N'1991-02-20' AS Date), 2, N'Западная 40 кв. 96', N'Саратов ', N'+7 (914) 787-55-05')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (806, N'Исакова', N'Анна', N'Александровна', 15, CAST(N'2003-04-03' AS Date), 2, N'Береговая 22 кв. 35', N'Тюмень ', N'+7 (909) 201-48-88')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (807, N'Иванов', N'Максим', N'Максимович', 15, CAST(N'1992-06-19' AS Date), 1, N'Речная 27 кв. 21', N'Самара ', N'+7 (931) 246-79-54')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (808, N'Поляков', N'Даниил', N'Даниилович', 15, CAST(N'1995-04-28' AS Date), 1, N'Подгорная 33 кв. 71', N'Краснодар ', N'+7 (961) 667-97-79')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (809, N'Лебедева', N'Полина', N'Александровна', 15, CAST(N'1996-04-05' AS Date), 2, N'Центральная 21 кв. 88', N'Екатеринбург ', N'+7 (912) 593-65-53')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (811, N'Афанасьев', N'Сергей', N'Денисович', 15, CAST(N'2002-01-11' AS Date), 1, N'Колхозная 15 кв. 1', N'Омск ', N'+7 (967) 509-16-22')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (812, N'Шаров', N'Артём', N'Тимофеевич', 15, CAST(N'1990-05-30' AS Date), 1, N'Луговая 41 кв. 30', N'Волгоград ', N'+7 (991) 797-84-32')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (813, N'Павловский', N'Константин', N'Ильич', 15, CAST(N'1991-05-06' AS Date), 1, N'Чапаева 13 кв. 43', N'Уфа ', N'+7 (937) 073-07-37')
INSERT [dbo].[stud] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (814, N'Шафиков', N'Марат', N'Ильгизович', 11, CAST(N'2005-03-14' AS Date), 1, N'Гагарина 15 кв. 34', N'Москва', N'+7 (999)000-89-99')
SET IDENTITY_INSERT [dbo].[stud] OFF
GO
SET IDENTITY_INSERT [dbo].[Students] ON 

INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (1, N'Тимофеева', N'Злата', N'Степановна', 1, CAST(N'2004-04-07' AS Date), 2, N'Ленина 28 кв. 16', N'Уфа ', N'+7 (965) 097-66-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (2, N'Лукьянова', N'Мила', N'Ивановна', 1, CAST(N'2002-04-09' AS Date), 2, N'Фрунзе 25 кв. 38', N'Тольятти ', N'+7 (933) 660-99-19')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (3, N'Сорокина', N'Алиса', N'Кирилловна', 1, CAST(N'2005-02-08' AS Date), 2, N'Дзержинского 44 кв. 40', N'Воронеж ', N'+7 (962) 261-92-35')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (4, N'Воронин', N'Али', N'Сергеевич', 1, CAST(N'1996-07-18' AS Date), 1, N'Матросова 8 кв. 97', N'Уфа ', N'+7 (964) 319-69-92')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (5, N'Филиппов', N'Тимофей', N'Иванович', 1, CAST(N'1999-06-23' AS Date), 1, N'Нагорная 49 кв. 56', N'Тюмень ', N'+7 (964) 925-33-90')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (6, N'Волков', N'Владимир', N'Михайлович', 1, CAST(N'1991-08-06' AS Date), 1, N'Парковая 42 кв. 55', N'Самара ', N'+7 (933) 032-19-25')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (7, N'Баранов', N'Андрей', N'Кириллович', 1, CAST(N'1996-10-08' AS Date), 1, N'Трактовая 30 кв. 70', N'Омск ', N'+7 (904) 711-33-78')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (8, N'Новиков', N'Николай', N'Михайлович', 1, CAST(N'1994-05-05' AS Date), 1, N'Дзержинского 33 кв. 42', N'Саратов ', N'+7 (992) 841-87-69')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (9, N'Золотов', N'Илья', N'Матвеевич', 1, CAST(N'1999-04-14' AS Date), 1, N'Светлая 36 кв. 88', N'Новосибирск ', N'+7 (967) 849-87-87')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (10, N'Селезнева', N'Виктория', N'Дмитриевна', 1, CAST(N'2002-01-21' AS Date), 2, N'Гагарина 12 кв. 49', N'Тюмень ', N'+7 (977) 298-22-35')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (11, N'Иванова', N'Дарья', N'Артёмовна', 1, CAST(N'1994-05-18' AS Date), 2, N'Свободы 13 кв. 89', N'Казань ', N'+7 (966) 402-10-26')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (12, N'Колосова', N'Екатерина', N'Александровна', 1, CAST(N'2002-05-01' AS Date), 2, N'Дзержинского 1 кв. 67', N'Тольятти ', N'+7 (951) 262-45-22')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (13, N'Тимофеев', N'Адам', N'Константинович', 1, CAST(N'1993-09-28' AS Date), 1, N'Родниковая 7 кв. 94', N'Ижевск ', N'+7 (910) 966-14-93')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (14, N'Карпова', N'Сафия', N'Ивановна', 1, CAST(N'1996-11-28' AS Date), 2, N'Комарова 17 кв. 14', N'Волгоград ', N'+7 (992) 835-46-23')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (15, N'Антонов', N'Фёдор', N'Дмитриевич', 1, CAST(N'1998-03-26' AS Date), 1, N'Чехова 8 кв. 56', N'Саратов ', N'+7 (982) 206-53-75')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (16, N'Карпова', N'Айлин', N'Артёмовна', 2, CAST(N'1992-08-28' AS Date), 2, N'8 Марта50 кв. 77', N'Краснодар ', N'+7 (963) 843-22-80')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (17, N'Карпов', N'Лев', N'Максимович', 2, CAST(N'2005-03-17' AS Date), 1, N'Лермонтова 33 кв. 83', N'Волгоград ', N'+7 (954) 304-58-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (18, N'Иванова', N'Антонина', N'Ильинична', 2, CAST(N'1996-06-21' AS Date), 2, N'Гагарина 32 кв. 51', N'Волгоград ', N'+7 (919) 491-50-94')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (19, N'Карпов', N'Даниил', N'Тимурович', 2, CAST(N'1998-09-25' AS Date), 1, N'Коммунистическая 31 кв. 33', N'Санкт-Петербург ', N'+7 (917) 026-86-50')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (20, N'Тимофеев', N'Пётр', N'Никитич', 2, CAST(N'1993-09-17' AS Date), 2, N'Маяковского 19 кв. 86', N'Ижевск ', N'+7 (983) 487-70-38')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (21, N'Дмитриева', N'Агния', N'Артёмовна', 2, CAST(N'1994-04-29' AS Date), 2, N'Речная 19 кв. 92', N'Саратов ', N'+7 (928) 012-12-48')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (22, N'Зайцева', N'Анастасия', N'Львовна', 2, CAST(N'2003-06-02' AS Date), 2, N'Сосновая 33 кв. 53', N'Омск ', N'+7 (956) 859-53-39')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (23, N'Романова', N'Милана', N'Глебовна', 2, CAST(N'1990-12-26' AS Date), 2, N'Березовая 3 кв. 85', N'Санкт-Петербург ', N'+7 (918) 948-46-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (24, N'Кузнецова', N'Варвара', N'Максимовна', 2, CAST(N'2000-03-20' AS Date), 2, N'Овражная 15 кв. 61', N'Волгоград ', N'+7 (980) 740-74-22')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (25, N'Овсянникова', N'Варвара', N'Фёдоровна', 2, CAST(N'1998-02-05' AS Date), 2, N'8 Марта21 кв. 58', N'Челябинск ', N'+7 (958) 814-90-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (26, N'Кудряшов', N'Лев', N'Дмитриевич', 2, CAST(N'2005-03-08' AS Date), 1, N'Энергетиков 5 кв. 54', N'Воронеж ', N'+7 (981) 697-46-07')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (27, N'Михайлов', N'Матвей', N'Александрович', 2, CAST(N'1999-06-07' AS Date), 1, N'Парковая 37 кв. 25', N'Омск ', N'+7 (989) 992-09-67')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (28, N'Лаптева', N'Ксения', N'Тимофеевна', 2, CAST(N'2001-08-17' AS Date), 2, N'Светлая 2 кв. 87', N'Уфа ', N'+7 (941) 280-13-03')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (29, N'Петров', N'Владимир', N'Николаевич', 2, CAST(N'2001-05-11' AS Date), 1, N'Школьная 22 кв. 75', N'Челябинск ', N'+7 (956) 076-42-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (30, N'Кукушкин', N'Роберт', N'Львович', 2, CAST(N'1991-07-30' AS Date), 1, N'Красная 28 кв. 60', N'Новосибирск ', N'+7 (970) 863-44-90')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (31, N'Богомолов', N'Адам', N'Глебович', 2, CAST(N'1992-08-27' AS Date), 1, N'Красная 5 кв. 19', N'Челябинск ', N'+7 (988) 242-28-12')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (32, N'Гришин', N'Макар', N'Романович', 2, CAST(N'2000-05-18' AS Date), 1, N'Мира 47 кв. 55', N'Тольятти ', N'+7 (962) 832-67-01')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (33, N'Захарова', N'Амалия', N'Дмитриевна', 2, CAST(N'2001-10-05' AS Date), 2, N'Энергетиков 42 кв. 26', N'Нижний Новгород', N'+7 (958) 422-50-15')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (34, N'Колпакова', N'Алина', N'Михайловна', 2, CAST(N'1995-01-12' AS Date), 2, N'Советская 16 кв. 98', N'Челябинск ', N'+7 (983) 347-31-68')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (35, N'Завьялова', N'Ольга', N'Кирилловна', 2, CAST(N'1991-01-18' AS Date), 2, N'Березовая 31 кв. 31', N'Ижевск ', N'+7 (966) 366-41-36')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (36, N'Волкова', N'Маргарита', N'Викторовна', 2, CAST(N'1991-01-04' AS Date), 2, N'Заречная 46 кв. 55', N'Волгоград ', N'+7 (960) 352-26-50')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (37, N'Петрова', N'Василиса', N'Николаевна', 3, CAST(N'2000-02-08' AS Date), 2, N'Молодежная 17 кв. 69', N'Пермь ', N'+7 (931) 993-06-03')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (38, N'Серебрякова', N'Мадина', N'Юрьевна', 3, CAST(N'1991-10-11' AS Date), 2, N'1 Мая31 кв. 92', N'Воронеж ', N'+7 (941) 047-52-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (39, N'Краснов', N'Кирилл', N'Леонович', 3, CAST(N'1992-04-09' AS Date), 1, N'Строителей 39 кв. 57', N'Тюмень ', N'+7 (997) 337-92-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (40, N'Буров', N'Марат', N'Петрович', 3, CAST(N'1996-07-29' AS Date), 1, N'Больничная 27 кв. 83', N'Красноярск ', N'+7 (921) 778-84-64')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (41, N'Калинина', N'Анна', N'Алиевна', 3, CAST(N'1991-05-22' AS Date), 2, N'Светлая 22 кв. 41', N'Воронеж ', N'+7 (988) 321-08-04')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (42, N'Моргунова', N'Анастасия', N'Николаевна', 3, CAST(N'1996-12-05' AS Date), 2, N'Чкалова 28 кв. 83', N'Волгоград ', N'+7 (955) 385-45-87')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (43, N'Царева', N'Дарья', N'Тимуровна', 3, CAST(N'2005-01-19' AS Date), 2, N'Молодежная 21 кв. 8', N'Новосибирск ', N'+7 (912) 327-54-58')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (44, N'Воронцова', N'София', N'Юрьевна', 3, CAST(N'1996-03-05' AS Date), 2, N'Заводская 14 кв. 82', N'Волгоград ', N'+7 (917) 569-85-66')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (45, N'Черняев', N'Александр', N'Артёмович', 3, CAST(N'2004-05-12' AS Date), 1, N'Шоссейная 2 кв. 42', N'Пермь ', N'+7 (900) 387-52-37')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (46, N'Романов', N'Сергей', N'Михайлович', 3, CAST(N'2004-09-13' AS Date), 1, N'1 Мая14 кв. 21', N'Тюмень ', N'+7 (914) 745-89-23')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (47, N'Сухарева', N'Злата', N'Демидовна', 3, CAST(N'1991-04-09' AS Date), 2, N'Строителей 48 кв. 81', N'Санкт-Петербург ', N'+7 (929) 496-48-78')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (48, N'Стариков', N'Роберт', N'Львович', 3, CAST(N'1998-12-25' AS Date), 1, N'Мичурина 32 кв. 73', N'Нижний Новгород', N'+7 (981) 605-45-21')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (49, N'Михайлов', N'Дмитрий', N'Степанович', 3, CAST(N'2002-02-25' AS Date), 1, N'Вишневая 4 кв. 63', N'Самара ', N'+7 (931) 491-68-84')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (50, N'Горбачев', N'Арсен', N'Михайлович', 3, CAST(N'1995-05-04' AS Date), 1, N'Мичурина 25 кв. 37', N'Пермь ', N'+7 (999) 876-87-95')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (51, N'Крючкова', N'Ева', N'Германовна', 3, CAST(N'2004-08-30' AS Date), 2, N'Маяковского 36 кв. 18', N'Санкт-Петербург ', N'+7 (937) 631-03-19')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (52, N'Соколова', N'Мария', N'Ярославовна', 3, CAST(N'2003-10-23' AS Date), 2, N'Победы 42 кв. 34', N'Уфа ', N'+7 (952) 242-25-59')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (53, N'Ермилов', N'Дмитрий', N'Иванович', 3, CAST(N'1992-12-21' AS Date), 1, N'Светлая 39 кв. 81', N'Самара ', N'+7 (978) 935-42-91')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (54, N'Полякова', N'Виктория', N'Марковна', 3, CAST(N'1994-09-23' AS Date), 2, N'Энергетиков 36 кв. 33', N'Красноярск ', N'+7 (967) 143-31-40')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (55, N'Тарасов', N'Андрей', N'Степанович', 3, CAST(N'1994-01-27' AS Date), 1, N'Весенняя 30 кв. 16', N'Краснодар ', N'+7 (953) 229-31-71')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (56, N'Глушков', N'Олег', N'Дмитриевич', 3, CAST(N'1998-08-31' AS Date), 1, N'Родниковая 19 кв. 9', N'Красноярск ', N'+7 (931) 866-91-23')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (57, N'Астахова', N'Кира', N'Степановна', 3, CAST(N'1996-02-15' AS Date), 2, N'Вокзальная 4 кв. 31', N'Москва ', N'+7 (994) 057-77-35')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (58, N'Баранова', N'Анна', N'Саввична', 3, CAST(N'1994-08-08' AS Date), 2, N'Красная 20 кв. 41', N'Санкт-Петербург ', N'+7 (984) 997-38-59')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (59, N'Платонов', N'Лев', N'Максимович', 4, CAST(N'2000-10-06' AS Date), 1, N'Мичурина 38 кв. 4', N'Новосибирск ', N'+7 (904) 697-53-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (60, N'Мельников', N'Дмитрий', N'Даниэльевич', 4, CAST(N'2001-10-09' AS Date), 1, N'Комсомольская 5 кв. 57', N'Ижевск ', N'+7 (913) 901-88-91')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (61, N'Демьянова', N'Алиса', N'Михайловна', 4, CAST(N'1999-06-10' AS Date), 2, N'Победы 33 кв. 16', N'Тюмень ', N'+7 (969) 783-94-34')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (62, N'Богданов', N'Даниэль', N'Артёмович', 4, CAST(N'1995-01-17' AS Date), 1, N'Свердлова 18 кв. 66', N'Уфа ', N'+7 (991) 315-36-69')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (63, N'Кузнецов', N'Гордей', N'Алексеевич', 4, CAST(N'2002-06-07' AS Date), 1, N'Дорожная 26 кв. 47', N'Ижевск ', N'+7 (989) 256-05-93')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (64, N'Устинов', N'Ибрагим', N'Артурович', 4, CAST(N'2004-07-20' AS Date), 1, N'Строительная 17 кв. 50', N'Воронеж ', N'+7 (981) 380-00-33')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (65, N'Зуев', N'Ибрагим', N'Романович', 4, CAST(N'2002-02-12' AS Date), 1, N'Совхозная 12 кв. 34', N'Челябинск ', N'+7 (921) 928-24-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (66, N'Иванов', N'Константин', N'Даниилович', 4, CAST(N'2000-12-13' AS Date), 1, N'Центральная 38 кв. 31', N'Москва ', N'+7 (901) 214-89-63')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (67, N'Свиридов', N'Алексей', N'Ильич', 4, CAST(N'2002-11-01' AS Date), 1, N'Комсомольская 28 кв. 7', N'Казань ', N'+7 (906) 710-13-62')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (68, N'Васильев', N'Николай', N'Артемьевич', 4, CAST(N'2004-01-06' AS Date), 1, N'Заречная 34 кв. 65', N'Санкт-Петербург ', N'+7 (956) 347-44-22')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (69, N'Зимина', N'София', N'Владиславовна', 4, CAST(N'1994-02-21' AS Date), 2, N'Железнодорожная 18 кв. 67', N'Пермь ', N'+7 (925) 083-41-43')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (70, N'Зайцева', N'Полина', N'Никитична', 4, CAST(N'1995-12-18' AS Date), 2, N'Куйбышева 27 кв. 51', N'Казань ', N'+7 (939) 364-25-37')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (71, N'Панков', N'Марк', N'Демьянович', 4, CAST(N'1994-07-22' AS Date), 1, N'Кирова 42 кв. 10', N'Новосибирск ', N'+7 (969) 939-48-66')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (72, N'Михайлов', N'Артём', N'Ильич', 4, CAST(N'2004-01-30' AS Date), 1, N'Подгорная 48 кв. 88', N'Санкт-Петербург ', N'+7 (900) 280-87-69')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (73, N'Прокофьева', N'Анна', N'Максимовна', 4, CAST(N'1993-12-29' AS Date), 2, N'Куйбышева 26 кв. 96', N'Саратов ', N'+7 (986) 810-31-87')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (74, N'Горшкова', N'Софья', N'Владимировна', 4, CAST(N'1992-11-04' AS Date), 2, N'Трудовая 22 кв. 52', N'Ростов-на-Дону ', N'+7 (923) 324-97-44')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (75, N'Павлова', N'Виктория', N'Егоровна', 4, CAST(N'1992-08-11' AS Date), 2, N'Степная 50 кв. 44', N'Омск ', N'+7 (996) 151-94-66')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (76, N'Матвеев', N'Михаил', N'Михайлович', 4, CAST(N'2001-07-09' AS Date), 1, N'Гагарина 31 кв. 80', N'Ростов-на-Дону ', N'+7 (996) 150-32-79')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (77, N'Рябов', N'Никита', N'Алексеевич', 4, CAST(N'2002-02-08' AS Date), 1, N'Заречная  кв. 46', N'Нижний Новгород', N'+7 (906) 983-00-79')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (78, N'Леонтьева', N'Елизавета', N'Вячеславовна', 4, CAST(N'1998-05-26' AS Date), 2, N'Некрасова 34 кв. 69', N'Краснодар ', N'+7 (970) 357-78-98')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (79, N'Скворцов', N'Андрей', N'Романович', 4, CAST(N'1995-09-12' AS Date), 1, N'Некрасова 5 кв. 75', N'Волгоград ', N'+7 (941) 286-43-39')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (80, N'Лосева', N'Фатима', N'Данииловна', 5, CAST(N'1998-06-11' AS Date), 2, N'Кирова 19 кв. 43', N'Воронеж ', N'+7 (993) 881-35-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (81, N'Тихомиров', N'Денис', N'Сергеевич', 5, CAST(N'1995-11-29' AS Date), 1, N'Свободы 29 кв. 80', N'Волгоград ', N'+7 (904) 380-12-16')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (82, N'Кочетов', N'Григорий', N'Константинович', 5, CAST(N'1998-11-27' AS Date), 1, N'Гоголя 17 кв. 50', N'Краснодар ', N'+7 (930) 115-73-52')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (83, N'Титов', N'Максим', N'Максимович', 5, CAST(N'1999-05-03' AS Date), 1, N'Интернациональная  кв. 79', N'Нижний Новгород', N'+7 (965) 862-17-78')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (84, N'Смирнова', N'Маргарита', N'Владимировна', 5, CAST(N'1996-06-19' AS Date), 2, N'Чехова 6 кв. 66', N'Санкт-Петербург ', N'+7 (961) 986-96-38')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (85, N'Мельникова', N'Милана', N'Артуровна', 5, CAST(N'1999-04-22' AS Date), 2, N'Вокзальная 17 кв. 12', N'Самара ', N'+7 (991) 535-42-57')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (86, N'Козловская', N'Маргарита', N'Всеволодовна', 5, CAST(N'1992-01-07' AS Date), 2, N'Свердлова 13 кв. 99', N'Омск ', N'+7 (937) 908-92-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (87, N'Евсеева', N'Алёна', N'Тихоновна', 5, CAST(N'1995-05-03' AS Date), 2, N'Кооперативная 48 кв. 54', N'Челябинск ', N'+7 (937) 407-49-39')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (88, N'Еремина', N'Екатерина', N'Кирилловна', 5, CAST(N'2005-01-03' AS Date), 2, N'Шоссейная 18 кв. 22', N'Краснодар ', N'+7 (967) 242-05-51')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (89, N'Пирогов', N'Платон', N'Леонович', 5, CAST(N'1991-05-10' AS Date), 1, N'Интернациональная 44 кв. 8', N'Челябинск ', N'+7 (928) 280-27-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (90, N'Степанова', N'Мария', N'Владиславовна', 5, CAST(N'2001-08-20' AS Date), 2, N'Солнечная 18 кв. 22', N'Пермь ', N'+7 (928) 506-24-33')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (91, N'Емельянова', N'Мирослава', N'Александровна', 5, CAST(N'2000-01-26' AS Date), 2, N'Свободы 1 кв. 91', N'Тольятти ', N'+7 (933) 820-92-60')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (92, N'Панфилова', N'Есения', N'Ильинична', 5, CAST(N'1992-02-14' AS Date), 2, N'Некрасова 38 кв. 21', N'Екатеринбург ', N'+7 (999) 663-10-13')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (93, N'Долгов', N'Олег', N'Олегович', 5, CAST(N'1995-05-12' AS Date), 1, N'Рабочая 5 кв. 15', N'Ижевск ', N'+7 (954) 887-28-92')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (94, N'Тарасова', N'Юлия', N'Романовна', 5, CAST(N'1995-08-15' AS Date), 2, N'Победы 1 кв. 83', N'Омск ', N'+7 (980) 966-44-32')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (95, N'Астафьева', N'Виктория', N'Савельевна', 5, CAST(N'1994-11-15' AS Date), 2, N'Центральная 19 кв. 16', N'Саратов ', N'+7 (955) 004-31-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (96, N'Васильева', N'Ева', N'Константиновна', 5, CAST(N'1991-11-11' AS Date), 2, N'Московская 29 кв. 90', N'Ижевск ', N'+7 (987) 185-29-91')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (97, N'Артамонова', N'Полина', N'Владиславовна', 5, CAST(N'1992-10-23' AS Date), 2, N'Сосновая 13 кв. 87', N'Москва ', N'+7 (952) 165-75-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (98, N'Бочаров', N'Юрий', N'Михайлович', 5, CAST(N'1990-07-16' AS Date), 1, N'Северная 22 кв. 30', N'Тольятти ', N'+7 (981) 643-06-27')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (99, N'Петрова', N'Яна', N'Алексеевна', 5, CAST(N'1991-11-15' AS Date), 2, N'Заречная 28 кв. 46', N'Омск ', N'+7 (996) 332-29-94')
GO
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (100, N'Калашников', N'Матвей', N'Саввич', 5, CAST(N'1994-09-14' AS Date), 1, N'Мичурина 12 кв. 67', N'Волгоград ', N'+7 (951) 659-78-90')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (101, N'Евдокимова', N'Елизавета', N'Максимовна', 6, CAST(N'1996-12-17' AS Date), 2, N'Куйбышева 21 кв. 10', N'Тюмень ', N'+7 (978) 189-81-02')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (102, N'Леонтьев', N'Кирилл', N'Арсентьевич', 6, CAST(N'1991-02-22' AS Date), 1, N'Береговая 7 кв. 59', N'Екатеринбург ', N'+7 (941) 983-44-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (103, N'Кочетов', N'Филипп', N'Данилович', 6, CAST(N'1999-12-29' AS Date), 1, N'Куйбышева 15 кв. 79', N'Санкт-Петербург ', N'+7 (937) 256-76-67')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (104, N'Иванова', N'Дарья', N'Сергеевна', 6, CAST(N'2003-09-12' AS Date), 2, N'Коммунистическая 35 кв. 38', N'Санкт-Петербург ', N'+7 (932) 603-77-19')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (105, N'Панков', N'Михаил', N'Алексеевич', 6, CAST(N'1991-04-08' AS Date), 1, N'Юбилейная 42 кв. 11', N'Москва ', N'+7 (996) 977-05-96')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (106, N'Фролова', N'Анна', N'Тимофеевна', 6, CAST(N'1994-04-22' AS Date), 2, N'Энергетиков 11 кв. 35', N'Волгоград ', N'+7 (934) 693-17-65')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (107, N'Куприянова', N'Анна', N'Алексеевна', 6, CAST(N'1993-09-13' AS Date), 2, N'Красноармейская 38 кв. 33', N'Санкт-Петербург ', N'+7 (964) 926-99-93')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (108, N'Прохоров', N'Леонид', N'Тимурович', 6, CAST(N'1997-03-06' AS Date), 1, N'Партизанская 49 кв. 92', N'Новосибирск ', N'+7 (911) 926-52-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (109, N'Герасимова', N'Виктория', N'Денисовна', 6, CAST(N'1993-07-14' AS Date), 2, N'Энергетиков 5 кв. 77', N'Воронеж ', N'+7 (960) 884-03-03')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (110, N'Иванова', N'Кира', N'Андреевна', 6, CAST(N'2002-08-07' AS Date), 2, N'Советская 6 кв. 62', N'Омск ', N'+7 (937) 084-92-65')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (111, N'Родионова', N'Екатерина', N'Александровна', 6, CAST(N'1990-11-06' AS Date), 2, N'Рабочая 11 кв. 89', N'Воронеж ', N'+7 (941) 693-73-71')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (112, N'Титова', N'Александра', N'Александровна', 6, CAST(N'2001-07-20' AS Date), 2, N'Вокзальная 2 кв. 26', N'Пермь ', N'+7 (909) 614-38-52')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (113, N'Комаров', N'Григорий', N'Владиславович', 6, CAST(N'1991-02-27' AS Date), 1, N'Спортивная 2 кв. 64', N'Краснодар ', N'+7 (991) 325-81-17')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (114, N'Масленникова', N'Анастасия', N'Александровна', 6, CAST(N'1993-01-06' AS Date), 2, N'Фрунзе 20 кв. 98', N'Самара ', N'+7 (967) 267-18-08')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (115, N'Кудрявцев', N'Даниил', N'Александрович', 6, CAST(N'2004-07-21' AS Date), 1, N'Заречная 13 кв. 49', N'Тольятти ', N'+7 (922) 743-24-44')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (116, N'Некрасова', N'Яна', N'Андреевна', 6, CAST(N'1992-12-11' AS Date), 2, N'Калинина 17 кв. 97', N'Пермь ', N'+7 (981) 271-36-54')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (117, N'Макарова', N'Полина', N'Дмитриевна', 6, CAST(N'2000-12-15' AS Date), 2, N'Береговая 30 кв. 88', N'Пермь ', N'+7 (938) 738-67-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (118, N'Кожевникова', N'Марта', N'Макаровна', 7, CAST(N'1992-10-09' AS Date), 2, N'Энергетиков 46 кв. 88', N'Санкт-Петербург ', N'+7 (960) 849-58-32')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (119, N'Ларионов', N'Егор', N'Григорьевич', 7, CAST(N'1991-12-09' AS Date), 1, N'Трудовая 16 кв. 57', N'Самара ', N'+7 (955) 686-55-89')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (120, N'Лебедев', N'Дмитрий', N'Андреевич', 7, CAST(N'2004-07-29' AS Date), 1, N'Весенняя 23 кв. 41', N'Омск ', N'+7 (908) 848-33-92')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (121, N'Федорова', N'Александра', N'Леонидовна', 7, CAST(N'2004-11-24' AS Date), 2, N'Московская 39 кв. 42', N'Екатеринбург ', N'+7 (963) 284-88-53')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (122, N'Шестаков', N'Владимир', N'Львович', 7, CAST(N'1991-04-12' AS Date), 1, N'Березовая 34 кв. 45', N'Пермь ', N'+7 (955) 882-78-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (123, N'Алексеева', N'Арина', N'Никитична', 7, CAST(N'1998-09-30' AS Date), 2, N'Матросова 9 кв. 36', N'Омск ', N'+7 (962) 675-29-21')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (124, N'Смирнов', N'Артур', N'Алексеевич', 7, CAST(N'1998-05-08' AS Date), 1, N'Больничная 20 кв. 54', N'Санкт-Петербург ', N'+7 (981) 411-62-63')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (125, N'Николаева', N'Алиса', N'Юрьевна', 7, CAST(N'2001-08-21' AS Date), 2, N'Северная 36 кв. 69', N'Москва ', N'+7 (956) 893-80-26')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (126, N'Ефремова', N'Анна', N'Антоновна', 7, CAST(N'1998-05-22' AS Date), 2, N'Больничная 29 кв. 76', N'Пермь ', N'+7 (958) 076-47-48')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (127, N'Титова', N'Анна', N'Лукинична', 7, CAST(N'1993-12-27' AS Date), 2, N'Заречная 27 кв. 62', N'Волгоград ', N'+7 (926) 777-55-70')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (128, N'Аникина', N'Камилла', N'Ярославовна', 7, CAST(N'2004-06-24' AS Date), 2, N'Некрасова 21 кв. 8', N'Ростов-на-Дону ', N'+7 (941) 074-69-29')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (129, N'Мухина', N'Мира', N'Александровна', 7, CAST(N'2001-04-04' AS Date), 2, N'Подгорная 2 кв. 48', N'Москва ', N'+7 (988) 886-68-93')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (130, N'Кузьмина', N'Эвелина', N'Максимовна', 7, CAST(N'1990-08-22' AS Date), 2, N'Заводская 49 кв. 5', N'Екатеринбург ', N'+7 (966) 530-42-00')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (131, N'Щербакова', N'Виктория', N'Ильинична', 7, CAST(N'2003-10-27' AS Date), 2, N'Рабочая 33 кв. 2', N'Саратов ', N'+7 (908) 906-22-65')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (132, N'Минаев', N'Владимир', N'Максимович', 7, CAST(N'2004-04-01' AS Date), 1, N'Комарова 12 кв. 7', N'Саратов ', N'+7 (911) 380-58-69')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (133, N'Кошелева', N'Виктория', N'Романовна', 8, CAST(N'1997-06-25' AS Date), 2, N'Строительная 15 кв. 75', N'Москва ', N'+7 (960) 129-37-75')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (134, N'Белякова', N'Вероника', N'Александровна', 8, CAST(N'2004-01-06' AS Date), 2, N'Овражная 43 кв. 82', N'Воронеж ', N'+7 (958) 547-60-42')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (135, N'Розанова', N'Дарина', N'Матвеевна', 8, CAST(N'1995-07-14' AS Date), 2, N'Комарова 20 кв. 43', N'Санкт-Петербург ', N'+7 (932) 057-05-21')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (136, N'Зайцев', N'Артём', N'Матвеевич', 8, CAST(N'2001-04-03' AS Date), 1, N'Нагорная 45 кв. 18', N'Челябинск ', N'+7 (950) 628-46-42')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (137, N'Фролов', N'Сергей', N'Богданович', 8, CAST(N'1992-07-07' AS Date), 1, N'8 Марта30 кв. 40', N'Саратов ', N'+7 (968) 282-96-72')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (138, N'Куликов', N'Артём', N'Арсенович', 8, CAST(N'2000-11-01' AS Date), 1, N'Полевая 13 кв. 77', N'Красноярск ', N'+7 (987) 136-80-68')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (139, N'Маркина', N'Эмилия', N'Тимофеевна', 8, CAST(N'2004-12-03' AS Date), 2, N'Береговая 3 кв. 62', N'Ростов-на-Дону ', N'+7 (965) 599-35-77')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (140, N'Давыдов', N'Фёдор', N'Маркович', 8, CAST(N'2000-03-22' AS Date), 1, N'Партизанская 43 кв. 47', N'Омск ', N'+7 (997) 949-79-22')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (141, N'Овчинников', N'Георгий', N'Максимович', 8, CAST(N'2000-10-05' AS Date), 1, N'Подгорная 14 кв. 98', N'Омск ', N'+7 (963) 930-80-63')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (142, N'Фирсова', N'Полина', N'Арсентьевна', 8, CAST(N'1996-10-17' AS Date), 2, N'Садовая 40 кв. 44', N'Красноярск ', N'+7 (928) 132-36-32')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (143, N'Логинова', N'Виктория', N'Викторовна', 8, CAST(N'1993-12-21' AS Date), 2, N'Озерная 30 кв. 92', N'Самара ', N'+7 (909) 557-56-54')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (144, N'Дроздова', N'Кира', N'Давидовна', 8, CAST(N'1993-01-28' AS Date), 2, N'Калинина 45 кв. 17', N'Ижевск ', N'+7 (937) 433-24-99')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (145, N'Тарасов', N'Марк', N'Иванович', 8, CAST(N'1993-12-06' AS Date), 1, N'Нагорная 45 кв. 66', N'Казань ', N'+7 (930) 196-20-16')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (146, N'Шилов', N'Андрей', N'Михайлович', 8, CAST(N'1999-02-25' AS Date), 1, N'Первомайская 33 кв. 3', N'Тюмень ', N'+7 (928) 470-38-41')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (147, N'Панов', N'Святослав', N'Ильич', 8, CAST(N'2000-10-16' AS Date), 1, N'Березовая 16 кв. 56', N'Краснодар ', N'+7 (924) 750-64-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (148, N'Тихомиров', N'Пётр', N'Андреевич', 8, CAST(N'1997-01-06' AS Date), 1, N'Почтовая 34 кв. 64', N'Омск ', N'+7 (925) 521-14-43')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (149, N'Шаповалова', N'Варвара', N'Львовна', 8, CAST(N'1990-04-06' AS Date), 2, N'Заводская 49 кв. 70', N'Краснодар ', N'+7 (941) 580-50-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (150, N'Егоров', N'Егор', N'Егорович', 8, CAST(N'1998-12-29' AS Date), 1, N'Майская 10 кв. 33', N'Новосибирск ', N'+7 (996) 067-62-60')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (151, N'Колесникова', N'Лилия', N'Александровна', 8, CAST(N'2005-01-12' AS Date), 2, N'Карла Маркса37 кв. 20', N'Пермь ', N'+7 (962) 425-92-28')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (152, N'Дементьев', N'Андрей', N'Лукич', 8, CAST(N'2001-12-19' AS Date), 1, N'Нагорная 12 кв. 98', N'Саратов ', N'+7 (984) 667-66-24')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (153, N'Осипов', N'Ярослав', N'Кириллович', 8, CAST(N'1999-10-25' AS Date), 1, N'Энергетиков 30 кв. 31', N'Новосибирск ', N'+7 (905) 753-88-66')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (154, N'Литвинов', N'Вячеслав', N'Маркович', 8, CAST(N'2002-02-08' AS Date), 1, N'Сосновая 4 кв. 67', N'Челябинск ', N'+7 (956) 974-42-87')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (155, N'Терехова', N'Аделина', N'Арсентьевна', 8, CAST(N'2001-05-14' AS Date), 2, N'Советская 21 кв. 3', N'Челябинск ', N'+7 (956) 580-28-52')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (156, N'Парамонов', N'Глеб', N'Михайлович', 8, CAST(N'1992-11-18' AS Date), 1, N'Коммунистическая 17 кв. 14', N'Челябинск ', N'+7 (982) 049-83-85')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (157, N'Петрова', N'София', N'Робертовна', 8, CAST(N'1990-11-05' AS Date), 2, N'Интернациональная 7 кв. 18', N'Пермь ', N'+7 (986) 194-54-61')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (158, N'Никитина', N'Амина', N'Андреевна', 9, CAST(N'1993-02-16' AS Date), 2, N'Новая 29 кв. 23', N'Санкт-Петербург ', N'+7 (952) 750-90-58')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (159, N'Кузнецова', N'Ксения', N'Святославовна', 9, CAST(N'2002-10-24' AS Date), 2, N'Верхняя 18 кв. 6', N'Москва ', N'+7 (900) 926-66-47')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (160, N'Полякова', N'Мария', N'Лукинична', 9, CAST(N'1996-04-22' AS Date), 2, N'Юбилейная 1 кв. 40', N'Уфа ', N'+7 (969) 981-97-59')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (161, N'Столяров', N'Михаил', N'Игоревич', 9, CAST(N'2002-05-23' AS Date), 1, N'Гоголя 20 кв. 45', N'Санкт-Петербург ', N'+7 (916) 066-53-05')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (162, N'Смирнова', N'Екатерина', N'Елисеевна', 9, CAST(N'2001-04-17' AS Date), 2, N'Трудовая 8 кв. 38', N'Екатеринбург ', N'+7 (991) 953-96-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (163, N'Дмитриев', N'Фёдор', N'Даниилович', 9, CAST(N'1990-05-09' AS Date), 1, N'Трактовая 35 кв. 89', N'Санкт-Петербург ', N'+7 (937) 116-84-19')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (164, N'Щукин', N'Дмитрий', N'Иванович', 9, CAST(N'1995-04-19' AS Date), 2, N'Пионерская 23 кв. 79', N'Омск ', N'+7 (911) 086-84-36')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (165, N'Степанов', N'Роман', N'Степанович', 9, CAST(N'1993-09-27' AS Date), 1, N'Светлая 6 кв. 66', N'Новосибирск ', N'+7 (925) 780-16-18')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (166, N'Иванов', N'Георгий', N'Ярославович', 9, CAST(N'1995-01-17' AS Date), 1, N'Речная 28 кв. 51', N'Пермь ', N'+7 (956) 313-42-52')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (167, N'Рубцова', N'Татьяна', N'Альбертовна', 9, CAST(N'1998-07-27' AS Date), 2, N'Строителей 42 кв. 31', N'Краснодар ', N'+7 (960) 018-75-91')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (168, N'Карташова', N'Таисия', N'Руслановна', 9, CAST(N'1997-05-27' AS Date), 2, N'Строителей 18 кв. 57', N'Санкт-Петербург ', N'+7 (922) 399-00-73')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (169, N'Леонов', N'Дмитрий', N'Кириллович', 9, CAST(N'2004-09-20' AS Date), 1, N'Трудовая 27 кв. 84', N'Ижевск ', N'+7 (989) 915-03-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (170, N'Фадеев', N'Фёдор', N'Артёмович', 9, CAST(N'2000-03-08' AS Date), 1, N'Вишневая 8 кв. 97', N'Пермь ', N'+7 (928) 406-94-21')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (171, N'Романова', N'Александра', N'Алексеевна', 9, CAST(N'2004-07-28' AS Date), 2, N'Северная 43 кв. 70', N'Нижний Новгород', N'+7 (929) 464-31-58')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (172, N'Иванова', N'Олеся', N'Александровна', 9, CAST(N'2003-09-05' AS Date), 2, N'Дзержинского 4 кв. 7', N'Ижевск ', N'+7 (969) 951-72-90')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (173, N'Кондратьев', N'Александр', N'Демьянович', 9, CAST(N'1995-09-15' AS Date), 1, N'Чехова 43 кв. 51', N'Москва ', N'+7 (936) 012-53-33')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (174, N'Волошин', N'Константин', N'Маркович', 10, CAST(N'1997-03-28' AS Date), 1, N'Подгорная 50 кв. 42', N'Омск ', N'+7 (925) 910-17-83')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (175, N'Леонова', N'София', N'Львовна', 10, CAST(N'2004-01-23' AS Date), 2, N'Новая 34 кв. 68', N'Пермь ', N'+7 (917) 992-61-72')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (176, N'Винокуров', N'Владимир', N'Леонович', 10, CAST(N'1992-02-20' AS Date), 1, N'Береговая 12 кв. 41', N'Саратов ', N'+7 (968) 254-90-96')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (177, N'Осипова', N'Дарья', N'Андреевна', 10, CAST(N'1992-09-08' AS Date), 2, N'Западная 19 кв. 22', N'Москва ', N'+7 (922) 232-18-25')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (178, N'Булгакова', N'Анастасия', N'Михайловна', 10, CAST(N'1993-10-01' AS Date), 2, N'Сосновая 25 кв. 65', N'Волгоград ', N'+7 (985) 642-69-88')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (179, N'Козлова', N'Вероника', N'Александровна', 10, CAST(N'2001-12-21' AS Date), 2, N'Береговая 20 кв. 91', N'Санкт-Петербург ', N'+7 (900) 924-31-00')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (180, N'Бурова', N'Анна', N'Савельевна', 10, CAST(N'1999-04-28' AS Date), 2, N'Верхняя 19 кв. 10', N'Воронеж ', N'+7 (934) 772-38-80')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (181, N'Туманов', N'Родион', N'Петрович', 10, CAST(N'1991-02-06' AS Date), 1, N'Чкалова 18 кв. 29', N'Самара ', N'+7 (936) 332-81-41')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (182, N'Михеева', N'Алёна', N'Кирилловна', 10, CAST(N'1992-12-31' AS Date), 2, N'Трудовая 9 кв. 90', N'Уфа ', N'+7 (961) 517-53-23')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (183, N'Яковлева', N'Анна', N'Ивановна', 10, CAST(N'2001-11-07' AS Date), 2, N'Спортивная 14 кв. 61', N'Саратов ', N'+7 (953) 762-96-29')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (184, N'Пантелеева', N'Ясмина', N'Владимировна', 10, CAST(N'1997-12-26' AS Date), 2, N'Горная 10 кв. 85', N'Екатеринбург ', N'+7 (920) 158-58-78')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (185, N'Бирюков', N'Дмитрий', N'Максимович', 10, CAST(N'2004-11-03' AS Date), 1, N'Дорожная 17 кв. 94', N'Казань ', N'+7 (912) 158-77-22')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (186, N'Новикова', N'Арина', N'Данииловна', 10, CAST(N'2000-07-20' AS Date), 2, N'Березовая 14 кв. 41', N'Ростов-на-Дону ', N'+7 (934) 651-55-84')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (187, N'Захаров', N'Тимур', N'Владимирович', 10, CAST(N'1990-09-14' AS Date), 1, N'Заречная 35 кв. 50', N'Тюмень ', N'+7 (991) 945-35-13')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (188, N'Соболева', N'Полина', N'Денисовна', 10, CAST(N'1990-11-09' AS Date), 2, N'Зеленая 30 кв. 84', N'Екатеринбург ', N'+7 (938) 629-29-86')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (189, N'Софронов', N'Даниил', N'Михайлович', 10, CAST(N'1999-04-09' AS Date), 1, N'Матросова 5 кв. 30', N'Челябинск ', N'+7 (954) 664-13-26')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (190, N'Антонов', N'Владимир', N'Ильич', 11, CAST(N'2003-04-18' AS Date), 1, N'Дзержинского 2 кв. 1', N'Тюмень ', N'+7 (994) 266-31-84')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (191, N'Яковлева', N'Ксения', N'Артуровна', 11, CAST(N'2002-04-05' AS Date), 2, N'Горная 38 кв. 4', N'Москва ', N'+7 (900) 024-86-59')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (192, N'Кузнецов', N'Григорий', N'Даниэльевич', 11, CAST(N'1992-03-02' AS Date), 1, N'Озерная 27 кв. 64', N'Санкт-Петербург ', N'+7 (985) 501-83-99')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (193, N'Попов', N'Демид', N'Давидович', 11, CAST(N'1999-02-04' AS Date), 1, N'Спортивная 18 кв. 65', N'Волгоград ', N'+7 (903) 924-14-40')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (194, N'Кузнецов', N'Илья', N'Глебович', 11, CAST(N'1991-11-01' AS Date), 1, N'Ленина 34 кв. 99', N'Ижевск ', N'+7 (952) 933-10-80')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (195, N'Потапов', N'Дмитрий', N'Артёмович', 11, CAST(N'2004-12-16' AS Date), 1, N'Маяковского 30 кв. 4', N'Красноярск ', N'+7 (997) 611-19-49')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (196, N'Белоусова', N'Ариана', N'Арсентьевна', 11, CAST(N'1992-06-02' AS Date), 2, N'Маяковского 47 кв. 38', N'Красноярск ', N'+7 (919) 159-03-37')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (197, N'Воробьев', N'Руслан', N'Ярославович', 11, CAST(N'1992-06-08' AS Date), 1, N'Пионерская 2 кв. 60', N'Тюмень ', N'+7 (980) 574-57-29')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (198, N'Зайцева', N'Дарья', N'Фёдоровна', 11, CAST(N'2003-03-13' AS Date), 2, N'Чкалова 14 кв. 22', N'Ижевск ', N'+7 (939) 475-65-75')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (199, N'Поляков', N'Алексей', N'Михайлович', 11, CAST(N'1993-01-19' AS Date), 1, N'Дружбы 37 кв. 2', N'Пермь ', N'+7 (978) 056-76-04')
GO
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (200, N'Богданова', N'Кристина', N'Сергеевна', 11, CAST(N'2003-04-03' AS Date), 2, N'Строительная 37 кв. 92', N'Ижевск ', N'+7 (991) 635-97-37')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (201, N'Акимов', N'Макар', N'Игоревич', 11, CAST(N'1991-05-22' AS Date), 1, N'Лермонтова 50 кв. 23', N'Уфа ', N'+7 (951) 975-83-04')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (202, N'Шишкин', N'Иван', N'Павлович', 11, CAST(N'2004-09-06' AS Date), 1, N'Клубная 16 кв. 5', N'Пермь ', N'+7 (930) 531-34-05')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (203, N'Бобров', N'Виктор', N'Иванович', 11, CAST(N'2004-10-05' AS Date), 1, N'Молодежная 3 кв. 73', N'Ростов-на-Дону ', N'+7 (988) 924-76-80')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (204, N'Ушаков', N'Евгений', N'Алексеевич', 11, CAST(N'1995-05-18' AS Date), 1, N'Спортивная 13 кв. 91', N'Пермь ', N'+7 (977) 643-04-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (205, N'Миронов', N'Евгений', N'Русланович', 11, CAST(N'2002-12-12' AS Date), 1, N'Советская 21 кв. 23', N'Москва ', N'+7 (958) 472-16-48')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (206, N'Зайцева', N'Василиса', N'Владимировна', 11, CAST(N'2004-11-04' AS Date), 2, N'Победы 23 кв. 30', N'Волгоград ', N'+7 (981) 483-02-38')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (207, N'Воробьева', N'Таисия', N'Егоровна', 12, CAST(N'2001-08-03' AS Date), 2, N'Верхняя 11 кв. 21', N'Москва ', N'+7 (991) 529-48-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (208, N'Некрасов', N'Марк', N'Викторович', 12, CAST(N'1991-11-20' AS Date), 1, N'Советская 34 кв. 14', N'Воронеж ', N'+7 (906) 648-45-76')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (209, N'Романов', N'Михаил', N'Елисеевич', 12, CAST(N'1995-02-13' AS Date), 1, N'Октябрьская 12 кв. 50', N'Ижевск ', N'+7 (991) 208-80-04')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (210, N'Александров', N'Савелий', N'Владиславович', 12, CAST(N'1995-03-17' AS Date), 1, N'Трактовая 43 кв. 88', N'Волгоград ', N'+7 (902) 423-39-48')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (211, N'Леонова', N'Полина', N'Степановна', 12, CAST(N'1990-07-11' AS Date), 2, N'Парковая 11 кв. 45', N'Воронеж ', N'+7 (902) 085-51-14')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (212, N'Юдина', N'Валерия', N'Алексеевна', 12, CAST(N'1993-01-28' AS Date), 2, N'Дружбы 28 кв. 52', N'Волгоград ', N'+7 (914) 196-20-85')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (213, N'Лапин', N'Иван', N'Никитич', 12, CAST(N'1997-09-23' AS Date), 1, N'Центральная 34 кв. 66', N'Санкт-Петербург ', N'+7 (980) 625-73-87')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (214, N'Пономарева', N'Алина', N'Данииловна', 12, CAST(N'1991-07-05' AS Date), 2, N'Светлая 11 кв. 49', N'Новосибирск ', N'+7 (999) 120-73-12')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (215, N'Завьялов', N'Пётр', N'Никитич', 12, CAST(N'2001-02-26' AS Date), 1, N'Красноармейская 5 кв. 47', N'Волгоград ', N'+7 (964) 250-15-93')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (216, N'Логинов', N'Илья', N'Максимович', 12, CAST(N'1999-07-30' AS Date), 1, N'Овражная 43 кв. 93', N'Саратов ', N'+7 (917) 448-12-18')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (217, N'Левин', N'Тимофей', N'Серафимович', 12, CAST(N'1995-12-20' AS Date), 2, N'Октябрьская 16 кв. 17', N'Челябинск ', N'+7 (967) 437-47-64')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (218, N'Дроздов', N'Максим', N'Макарович', 12, CAST(N'2001-01-24' AS Date), 1, N'Красноармейская 50 кв. 73', N'Пермь ', N'+7 (929) 173-08-16')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (219, N'Лебедева', N'Амалия', N'Артёмовна', 12, CAST(N'1999-06-15' AS Date), 2, N'Центральная 31 кв. 14', N'Ижевск ', N'+7 (981) 641-65-83')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (220, N'Попова', N'Анастасия', N'Михайловна', 12, CAST(N'1997-07-23' AS Date), 2, N'Мичурина 19 кв. 67', N'Омск ', N'+7 (963) 406-80-43')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (221, N'Денисова', N'Ариана', N'Алексеевна', 12, CAST(N'1991-10-11' AS Date), 2, N'Солнечная 8 кв. 41', N'Волгоград ', N'+7 (978) 435-92-86')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (222, N'Нефедова', N'Ольга', N'Константиновна', 12, CAST(N'1991-06-12' AS Date), 2, N'Солнечная 46 кв. 16', N'Тольятти ', N'+7 (967) 366-52-40')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (223, N'Егоров', N'Константин', N'Артемьевич', 12, CAST(N'1990-06-22' AS Date), 1, N'Дорожная 39 кв. 78', N'Челябинск ', N'+7 (937) 919-17-09')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (224, N'Пименова', N'Таисия', N'Макаровна', 13, CAST(N'2002-06-13' AS Date), 2, N'Энергетиков 22 кв. 85', N'Ростов-на-Дону ', N'+7 (986) 227-20-09')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (225, N'Фролова', N'Таисия', N'Ивановна', 13, CAST(N'2001-07-16' AS Date), 2, N'Дружбы 30 кв. 61', N'Уфа ', N'+7 (961) 800-60-78')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (226, N'Басова', N'Марианна', N'Артемьевна', 13, CAST(N'1990-08-15' AS Date), 2, N'Нагорная 7 кв. 3', N'Челябинск ', N'+7 (955) 224-07-20')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (227, N'Титова', N'Анна', N'Максимовна', 13, CAST(N'1995-10-25' AS Date), 2, N'Центральная 7 кв. 37', N'Воронеж ', N'+7 (920) 810-93-64')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (228, N'Ильинская', N'Злата', N'Богдановна', 13, CAST(N'2002-01-18' AS Date), 2, N'Победы 45 кв. 30', N'Новосибирск ', N'+7 (980) 846-05-77')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (229, N'Колесов', N'Борис', N'Максимович', 13, CAST(N'1990-04-30' AS Date), 1, N'Набережная 2 кв. 36', N'Челябинск ', N'+7 (978) 292-68-93')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (230, N'Виноградов', N'Максим', N'Романович', 13, CAST(N'1997-03-14' AS Date), 1, N'Клубная 28 кв. 24', N'Тольятти ', N'+7 (909) 435-96-89')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (231, N'Молчанов', N'Дмитрий', N'Дмитриевич', 13, CAST(N'1991-07-01' AS Date), 1, N'Весенняя 4 кв. 94', N'Челябинск ', N'+7 (962) 802-20-92')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (232, N'Михайлова', N'Мария', N'Дмитриевна', 13, CAST(N'1993-03-19' AS Date), 2, N'Маяковского 1 кв. 100', N'Москва ', N'+7 (970) 757-83-02')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (233, N'Громов', N'Матвей', N'Глебович', 13, CAST(N'1993-03-26' AS Date), 1, N'Чехова 35 кв. 88', N'Новосибирск ', N'+7 (903) 887-80-44')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (234, N'Еремин', N'Виктор', N'Леонидович', 13, CAST(N'2000-01-17' AS Date), 2, N'Красная 50 кв. 29', N'Нижний Новгород', N'+7 (955) 334-65-88')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (235, N'Иванова', N'Анна', N'Ильинична', 13, CAST(N'1994-08-25' AS Date), 2, N'Почтовая 33 кв. 87', N'Воронеж ', N'+7 (963) 817-45-78')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (236, N'Чернова', N'Сафия', N'Романовна', 13, CAST(N'1996-11-04' AS Date), 2, N'Гагарина 18 кв. 49', N'Волгоград ', N'+7 (941) 770-46-11')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (237, N'Карасева', N'София', N'Матвеевна', 13, CAST(N'1997-05-07' AS Date), 2, N'Калинина 6 кв. 14', N'Казань ', N'+7 (968) 659-19-98')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (238, N'Быков', N'Максим', N'Егорович', 13, CAST(N'1999-09-07' AS Date), 1, N'8 Марта27 кв. 14', N'Ростов-на-Дону ', N'+7 (913) 028-77-54')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (239, N'Максимова', N'Полина', N'Захаровна', 14, CAST(N'1991-07-19' AS Date), 2, N'Цветочная 29 кв. 75', N'Казань ', N'+7 (915) 962-16-53')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (240, N'Чернов', N'Глеб', N'Матвеевич', 14, CAST(N'1998-06-26' AS Date), 1, N'Горького 36 кв. 9', N'Пермь ', N'+7 (997) 572-25-83')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (241, N'Осипова', N'София', N'Андреевна', 14, CAST(N'1992-09-07' AS Date), 2, N'Свердлова 28 кв. 90', N'Краснодар ', N'+7 (982) 861-99-99')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (242, N'Баранова', N'Анастасия', N'Георгиевна', 14, CAST(N'1994-05-04' AS Date), 2, N'Свободы 9 кв. 28', N'Тюмень ', N'+7 (981) 105-67-32')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (243, N'Островский', N'Адам', N'Степанович', 14, CAST(N'1994-07-18' AS Date), 1, N'Строительная 16 кв. 89', N'Екатеринбург ', N'+7 (929) 640-03-55')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (244, N'Островская', N'София', N'Дмитриевна', 14, CAST(N'2004-08-13' AS Date), 2, N'Северная 7 кв. 24', N'Тюмень ', N'+7 (984) 420-11-88')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (245, N'Баженова', N'Алина', N'Дмитриевна', 14, CAST(N'2003-11-18' AS Date), 2, N'Садовая 28 кв. 89', N'Нижний Новгород', N'+7 (906) 483-55-28')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (246, N'Панкова', N'Алиса', N'Михайловна', 14, CAST(N'1995-03-13' AS Date), 2, N'Зеленая 31 кв. 10', N'Челябинск ', N'+7 (917) 457-34-92')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (247, N'Сафонов', N'Марк', N'Андреевич', 14, CAST(N'1993-08-11' AS Date), 1, N'Карла Маркса10 кв. 79', N'Саратов ', N'+7 (905) 066-28-35')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (248, N'Семенов', N'Максим', N'Владимирович', 14, CAST(N'1995-01-31' AS Date), 1, N'Свободы 37 кв. 72', N'Тюмень ', N'+7 (931) 186-09-75')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (249, N'Волков', N'Олег', N'Даниилович', 14, CAST(N'2000-07-14' AS Date), 1, N'Вишневая 12 кв. 69', N'Тюмень ', N'+7 (965) 380-87-95')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (250, N'Кузнецов', N'Тихон', N'Александрович', 14, CAST(N'2001-07-02' AS Date), 1, N'Кооперативная 34 кв. 50', N'Воронеж ', N'+7 (936) 134-49-71')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (251, N'Комарова', N'Елизавета', N'Артёмовна', 14, CAST(N'2001-11-28' AS Date), 2, N'Горная 48 кв. 93', N'Екатеринбург ', N'+7 (934) 487-27-49')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (252, N'Никольский', N'Тимофей', N'Тимурович', 14, CAST(N'1995-01-04' AS Date), 1, N'Чапаева 13 кв. 63', N'Тюмень ', N'+7 (905) 874-33-94')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (253, N'Шестаков', N'Иван', N'Эмильевич', 14, CAST(N'1991-11-19' AS Date), 1, N'Фрунзе 9 кв. 28', N'Тюмень ', N'+7 (932) 326-77-97')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (254, N'Москвин', N'Михаил', N'Дамирович', 14, CAST(N'1993-03-08' AS Date), 1, N'Маяковского 44 кв. 44', N'Челябинск ', N'+7 (952) 964-07-52')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (255, N'Беспалова', N'Анастасия', N'Фёдоровна', 15, CAST(N'1998-02-05' AS Date), 2, N'Трактовая 48 кв. 67', N'Омск ', N'+7 (933) 707-66-87')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (256, N'Михеева', N'Виктория', N'Ильинична', 15, CAST(N'2003-08-12' AS Date), 2, N'Юбилейная 48 кв. 10', N'Тольятти ', N'+7 (961) 186-27-85')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (257, N'Сергеев', N'Степан', N'Фёдорович', 15, CAST(N'1994-06-29' AS Date), 1, N'Новая 6 кв. 4', N'Ижевск ', N'+7 (927) 725-24-33')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (258, N'Артемов', N'Денис', N'Арсентьевич', 15, CAST(N'1993-07-26' AS Date), 1, N'Восточная 27 кв. 74', N'Екатеринбург ', N'+7 (917) 896-03-10')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (259, N'Соловьев', N'Роман', N'Алексеевич', 15, CAST(N'1993-10-14' AS Date), 1, N'Клубная 7 кв. 91', N'Краснодар ', N'+7 (978) 571-57-56')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (260, N'Булатов', N'Дмитрий', N'Егорович', 15, CAST(N'2002-05-10' AS Date), 1, N'Маяковского 42 кв. 59', N'Самара ', N'+7 (965) 068-81-96')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (261, N'Зайцева', N'Мелисса', N'Вадимовна', 15, CAST(N'1995-04-14' AS Date), 2, N'Вокзальная 14 кв. 46', N'Челябинск ', N'+7 (988) 549-35-13')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (262, N'Жуков', N'Михаил', N'Львович', 15, CAST(N'1992-09-17' AS Date), 1, N'Нагорная 12 кв. 70', N'Пермь ', N'+7 (965) 125-71-81')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (263, N'Зайцева', N'Анастасия', N'Фёдоровна', 15, CAST(N'1991-02-20' AS Date), 2, N'Западная 40 кв. 96', N'Саратов ', N'+7 (914) 787-55-05')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (264, N'Исакова', N'Анна', N'Александровна', 15, CAST(N'2003-04-03' AS Date), 2, N'Береговая 22 кв. 35', N'Тюмень ', N'+7 (909) 201-48-88')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (265, N'Иванов', N'Максим', N'Максимович', 15, CAST(N'1992-06-19' AS Date), 1, N'Речная 27 кв. 21', N'Самара ', N'+7 (931) 246-79-54')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (266, N'Поляков', N'Даниил', N'Даниилович', 15, CAST(N'1995-04-28' AS Date), 1, N'Подгорная 33 кв. 71', N'Краснодар ', N'+7 (961) 667-97-79')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (267, N'Лебедева', N'Полина', N'Александровна', 15, CAST(N'1996-04-05' AS Date), 2, N'Центральная 21 кв. 88', N'Екатеринбург ', N'+7 (912) 593-65-53')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (268, N'Иванова', N'Анна', N'Александровна', 15, CAST(N'2002-05-15' AS Date), 2, N'Энергетиков 15 кв. 50', N'Омск ', N'+7 (906) 302-29-34')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (269, N'Афанасьев', N'Сергей', N'Денисович', 15, CAST(N'2002-01-11' AS Date), 1, N'Колхозная 15 кв. 1', N'Омск ', N'+7 (967) 509-16-22')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (270, N'Шаров', N'Артём', N'Тимофеевич', 15, CAST(N'1990-05-30' AS Date), 1, N'Луговая 41 кв. 30', N'Волгоград ', N'+7 (991) 797-84-32')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (271, N'Павловский', N'Константин', N'Ильич', 15, CAST(N'1991-05-06' AS Date), 1, N'Чапаева 13 кв. 43', N'Уфа ', N'+7 (937) 073-07-37')
INSERT [dbo].[Students] ([StudentID], [StudentSurname], [StudentName], [StudentPatronymic], [StudentClass], [StudentDateOfBirth], [StudentGender], [StudentAdress], [StudentCity], [StudentPhoneNumber]) VALUES (272, N'Шафиков', N'Марат', N'Ильгизович', 11, CAST(N'2005-03-14' AS Date), 1, N'Гагарина 15 кв. 34', N'Москва', N'+7 (999)000-89-99')
SET IDENTITY_INSERT [dbo].[Students] OFF
GO
SET IDENTITY_INSERT [dbo].[SubordinatesSummary] ON 

INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1, 1, 1, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (2, 1, 2, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (3, 1, 3, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (4, 1, 4, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (5, 1, 5, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (6, 1, 6, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (7, 1, 7, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (8, 1, 8, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (9, 1, 9, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (10, 1, 10, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (11, 1, 11, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (12, 1, 12, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (13, 1, 13, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (14, 1, 14, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (15, 1, 15, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (16, 2, 16, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (17, 2, 17, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (18, 2, 18, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (19, 2, 19, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (20, 2, 20, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (21, 2, 21, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (22, 2, 22, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (23, 2, 23, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (24, 2, 24, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (25, 2, 25, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (26, 2, 26, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (27, 2, 27, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (28, 2, 28, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (29, 2, 29, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (30, 2, 30, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (31, 2, 31, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (32, 2, 32, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (33, 2, 33, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (34, 2, 34, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (35, 2, 35, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (36, 2, 36, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (37, 3, 37, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (38, 3, 38, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (39, 3, 39, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (40, 3, 40, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (41, 3, 41, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (42, 3, 42, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (43, 3, 43, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (44, 3, 44, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (45, 3, 45, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (46, 3, 46, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (47, 3, 47, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (48, 3, 48, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (49, 3, 49, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (50, 3, 50, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (51, 3, 51, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (52, 3, 52, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (53, 3, 53, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (54, 3, 54, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (55, 3, 55, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (56, 3, 56, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (57, 3, 57, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (58, 3, 58, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (59, 4, 59, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (60, 4, 60, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (61, 4, 61, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (62, 4, 62, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (63, 4, 63, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (64, 4, 64, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (65, 4, 65, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (66, 4, 66, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (67, 4, 67, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (68, 4, 68, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (69, 4, 69, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (70, 4, 70, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (71, 4, 71, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (72, 4, 72, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (73, 4, 73, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (74, 4, 74, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (75, 4, 75, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (76, 4, 76, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (77, 4, 77, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (78, 4, 78, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (79, 4, 79, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (80, 5, 80, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (81, 5, 81, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (82, 5, 82, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (83, 5, 83, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (84, 5, 84, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (85, 5, 85, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (86, 5, 86, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (87, 5, 87, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (88, 5, 88, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (89, 5, 89, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (90, 5, 90, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (91, 5, 91, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (92, 5, 92, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (93, 5, 93, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (94, 5, 94, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (95, 5, 95, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (96, 5, 96, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (97, 5, 97, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (98, 5, 98, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (99, 5, 99, N'незач')
GO
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (100, 5, 100, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (101, 6, 101, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (102, 6, 102, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (103, 6, 103, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (104, 6, 104, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (105, 6, 105, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (106, 6, 106, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (107, 6, 107, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (108, 6, 108, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (109, 6, 109, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (110, 6, 110, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (111, 6, 111, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (112, 6, 112, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (113, 6, 113, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (114, 6, 114, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (115, 6, 115, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (116, 6, 116, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (117, 6, 117, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (118, 7, 118, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (119, 7, 119, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (120, 7, 120, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (121, 7, 121, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (122, 7, 122, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (123, 7, 123, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (124, 7, 124, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (125, 7, 125, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (126, 7, 126, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (127, 7, 127, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (128, 7, 128, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (129, 7, 129, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (130, 7, 130, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (131, 7, 131, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (132, 7, 132, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (133, 8, 133, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (134, 8, 134, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (135, 8, 135, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (136, 8, 136, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (137, 8, 137, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (138, 8, 138, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (139, 8, 139, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (140, 8, 140, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (141, 8, 141, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (142, 8, 142, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (143, 8, 143, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (144, 8, 144, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (145, 8, 145, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (146, 8, 146, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (147, 8, 147, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (148, 8, 148, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (149, 8, 149, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (150, 8, 150, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (151, 8, 151, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (152, 8, 152, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (153, 8, 153, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (154, 8, 154, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (155, 8, 155, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (156, 8, 156, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (157, 8, 157, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (158, 9, 158, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (159, 9, 159, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (160, 9, 160, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (161, 9, 161, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (162, 9, 162, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (163, 9, 163, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (164, 9, 164, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (165, 9, 165, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (166, 9, 166, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (167, 9, 167, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (168, 9, 168, N'незач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (169, 9, 169, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (170, 9, 170, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (171, 9, 171, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (172, 9, 172, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (173, 9, 173, N'зач')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (174, 10, 174, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (175, 10, 175, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (176, 10, 176, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (177, 10, 177, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (178, 10, 178, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (179, 10, 179, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (180, 10, 180, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (181, 10, 181, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (182, 10, 182, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (183, 10, 183, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (184, 10, 184, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (185, 10, 185, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (186, 10, 186, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (187, 10, 187, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (188, 10, 188, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (189, 10, 189, N'3')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (190, 11, 190, N'4')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (191, 11, 191, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (192, 11, 192, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (193, 11, 193, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (194, 11, 194, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (195, 11, 195, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (196, 11, 196, N'2')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (197, 11, 197, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (198, 11, 198, N'5')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (199, 11, 199, N'3')
GO
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1423, 107, 1, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1424, 107, 2, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1425, 107, 3, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1426, 107, 4, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1427, 107, 5, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1428, 107, 6, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1429, 107, 7, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1430, 107, 8, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1431, 107, 9, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1432, 107, 10, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1433, 107, 11, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1434, 107, 12, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1435, 107, 13, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1436, 107, 14, N'Введите оценку')
INSERT [dbo].[SubordinatesSummary] ([SubID], [SubSummary], [SubStudent], [SubGrade]) VALUES (1437, 107, 15, N'Введите оценку')
SET IDENTITY_INSERT [dbo].[SubordinatesSummary] OFF
GO
SET IDENTITY_INSERT [dbo].[Summary] ON 

INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (1, 1, 24, 24, 6)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (2, 2, 6, 6, 2)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (3, 3, 31, 31, 4)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (4, 4, 4, 4, 8)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (5, 5, 1, 1, 6)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (6, 6, 22, 22, 6)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (7, 7, 9, 9, 6)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (8, 8, 37, 37, 8)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (9, 9, 6, 6, 4)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (10, 10, 10, 10, 6)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (11, 11, 9, 9, 6)
INSERT [dbo].[Summary] ([SummaryID], [SummaryClass], [SummaryTeacher], [SummaryDiscipline], [SummarySemester]) VALUES (107, 1, 1, 2, 2)
SET IDENTITY_INSERT [dbo].[Summary] OFF
GO
SET IDENTITY_INSERT [dbo].[Teachers] ON 

INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (1, N'Рязанов Александр Николаевич', N'заведующий кафедрой,', 54, CAST(N'1960-04-09' AS Date), CAST(N'1992-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (2, N'Хабирова Рената Рамисовна', N'профессор', 61, CAST(N'1977-08-30' AS Date), CAST(N'2000-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (3, N'Анваров Аскар Рамилевич', N'доцент, кандидат наук', 44, CAST(N'1966-12-21' AS Date), CAST(N'2004-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (4, N'Архипов Вячеслав Георгиевич', N'старший преподаватель', 26, CAST(N'1962-02-14' AS Date), CAST(N'1999-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (5, N'Ахмадуллин Ришат Рашитович', N'доцент, кандидат наук', 19, CAST(N'1975-09-26' AS Date), CAST(N'2013-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (6, N'Бабков Вадим Васильевич', N'профессор, доктор наук', 52, CAST(N'1966-12-02' AS Date), CAST(N'1997-01-15' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (7, N'Балобанов Александр Вениаминович', N'доцент, кандидат наук', 12, CAST(N'1975-05-01' AS Date), CAST(N'2012-01-23' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (8, N'Вагапов Руслан Фанилевич', N'доцент, кандидат наук', 45, CAST(N'1951-01-16' AS Date), CAST(N'1990-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (9, N'Габитов Азат Исмагилович', N'профессор, доктор наук', 57, CAST(N'1952-09-25' AS Date), CAST(N'1999-01-27' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (10, N'Гайсин Аскар Миниярович', N'доцент, кандидат наук', 24, CAST(N'1956-12-11' AS Date), CAST(N'1980-02-13' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (11, N'Гильмутдинов Тимур Зиннурович', N'ассистент', 33, CAST(N'1962-10-17' AS Date), CAST(N'1980-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (12, N'Далецкий Александр Петрович', N'доцент, кандидат наук', 30, CAST(N'1975-07-30' AS Date), CAST(N'2010-01-09' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (13, N'Зарипов Ильшат Флоредович', N'старший преподаватель', 53, CAST(N'1964-07-31' AS Date), CAST(N'1999-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (14, N'Климин Виктор Николаевич', N'доцент, кандидат наук', 32, CAST(N'1964-10-06' AS Date), CAST(N'1989-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (15, N'Кузнецов Дмитрий Валерьевич', N'доцент, кандидат наук', 11, CAST(N'1977-09-29' AS Date), CAST(N'2014-05-19' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (16, N'Латыпов Валерий Марказович', N'профессор, доктор наук', 52, CAST(N'1975-09-09' AS Date), CAST(N'2010-01-09' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (17, N'Ломакина Лилия Наилевна', N'доцент, кандидат наук', 35, CAST(N'1953-08-13' AS Date), CAST(N'1980-02-13' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (18, N'Луцык Екатерина Валерьевна', N'доцент, кандидат наук', 9, CAST(N'1956-05-30' AS Date), CAST(N'1989-02-13' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (19, N'Недосеко Игорь Вадимович', N'профессор, доктор наук', 15, CAST(N'1960-11-08' AS Date), CAST(N'1999-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (20, N'Порываев Илья Аркадьевич', N'старший преподаватель', 60, CAST(N'1951-08-10' AS Date), CAST(N'1990-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (21, N'Пудовкин Александр Николаевич', N'доцент, кандидат наук', 10, CAST(N'1966-11-11' AS Date), CAST(N'1992-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (22, N'Резвова Валентина Петровна', N'старший преподаватель', 56, CAST(N'1963-10-18' AS Date), CAST(N'1980-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (23, N'Рязанова Виктория Альбертовна', N'доцент, кандидат наук', 31, CAST(N'1965-05-19' AS Date), CAST(N'1975-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (24, N'Сафина Ольга Михайловна', N'доцент, кандидат наук', 24, CAST(N'1978-04-12' AS Date), CAST(N'2000-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (25, N'Сафронова Екатерина Павловна', N'старший преподаватель', 59, CAST(N'1977-09-26' AS Date), CAST(N'1999-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (26, N'Семенов Александр Александрович', N'профессор, кандидат наук', 50, CAST(N'1957-03-22' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (27, N'Синицина Екатерина Александровна', N'ассистент', 45, CAST(N'1954-02-16' AS Date), CAST(N'1999-02-09' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (28, N'Старцева Луиза Владимировна', N'профессор, кандидат наук', 58, CAST(N'1959-02-10' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (29, N'Федоров Павел Анатольевич', N'доцент, кандидат наук', 44, CAST(N'1979-12-27' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (30, N'Хабабутдинова Наркас Булатовна', N'ассистент', 31, CAST(N'1958-01-16' AS Date), CAST(N'1999-02-09' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (31, N'Хуснутдинов Булат Рамзиевич', N'старший преподаватель', 5, CAST(N'1960-08-17' AS Date), CAST(N'1989-09-01' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (32, N'Хуснутдинов Рамзи Файзиевич', N'доцент, кандидат наук', 39, CAST(N'1971-04-15' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (33, N'Чуйкин Александр Евгеньевич', N'доцент, кандидат наук', 29, CAST(N'1954-04-08' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (34, N'Шабаев Виктор Тимофеевич', N'доцент, кандидат наук', 40, CAST(N'1979-11-08' AS Date), CAST(N'2014-05-19' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (35, N'Шаймухаметов Ахмет Ахметович', N'доцент, кандидат наук', 45, CAST(N'1967-03-17' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (36, N'Шагигалин Газинур Юлдашевич', N'Зав. учебными лабораториями', 46, CAST(N'1950-10-23' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (37, N'Калмыкова Елена Николаевна', N'Специалист по УМР', 17, CAST(N'1974-10-03' AS Date), CAST(N'2014-05-19' AS Date))
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (38, N'Ахмадуллина Лилия Ильдусовна', N'Инженер', 34, CAST(N'1969-03-17' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (39, N'Нестеров Константин Михайлович', N'Инженер', 59, CAST(N'1955-09-16' AS Date), NULL)
INSERT [dbo].[Teachers] ([TeacherID], [TeacherFullName], [TeacherPost], [TeacherPulpit], [TeacherDayOfBirth], [TeacherDayWork]) VALUES (40, N'Сергунина Татьяна Борисовна', N'Инженер', 9, CAST(N'1960-06-20' AS Date), CAST(N'1983-03-20' AS Date))
SET IDENTITY_INSERT [dbo].[Teachers] OFF
GO
ALTER TABLE [dbo].[SubordinatesSummary] ADD  CONSTRAINT [DF_SubordinatesSummary_SubGrade]  DEFAULT (N'Введите оценку') FOR [SubGrade]
GO
ALTER TABLE [dbo].[Summary] ADD  CONSTRAINT [DF_Summary_SummarySemester]  DEFAULT ((0)) FOR [SummarySemester]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [FK__Class__ClassPulp__49C3F6B7] FOREIGN KEY([ClassPulpit])
REFERENCES [dbo].[Pulpit] ([PulpitID])
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [FK__Class__ClassPulp__49C3F6B7]
GO
ALTER TABLE [dbo].[Discipline]  WITH CHECK ADD  CONSTRAINT [FK__Disciplin__Disci__66603565] FOREIGN KEY([DisciplinePulpit])
REFERENCES [dbo].[Pulpit] ([PulpitID])
GO
ALTER TABLE [dbo].[Discipline] CHECK CONSTRAINT [FK__Disciplin__Disci__66603565]
GO
ALTER TABLE [dbo].[Discipline]  WITH CHECK ADD  CONSTRAINT [FK__Disciplin__Disci__6754599E] FOREIGN KEY([DisciplineFormatControl])
REFERENCES [dbo].[FormatControl] ([FormatID])
GO
ALTER TABLE [dbo].[Discipline] CHECK CONSTRAINT [FK__Disciplin__Disci__6754599E]
GO
ALTER TABLE [dbo].[Discipline]  WITH CHECK ADD  CONSTRAINT [FK_Discipline_Teachers] FOREIGN KEY([DisciplineTeacher])
REFERENCES [dbo].[Teachers] ([TeacherID])
GO
ALTER TABLE [dbo].[Discipline] CHECK CONSTRAINT [FK_Discipline_Teachers]
GO
ALTER TABLE [dbo].[Pulpit]  WITH CHECK ADD  CONSTRAINT [FK__Pulpit__PulpitFa__44FF419A] FOREIGN KEY([PulpitFacultyID])
REFERENCES [dbo].[Faculty] ([FacultyID])
GO
ALTER TABLE [dbo].[Pulpit] CHECK CONSTRAINT [FK__Pulpit__PulpitFa__44FF419A]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK__Student__Student__4E88ABD4] FOREIGN KEY([StudentClass])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK__Student__Student__4E88ABD4]
GO
ALTER TABLE [dbo].[Students]  WITH CHECK ADD  CONSTRAINT [FK__Student__Student__4F7CD00D] FOREIGN KEY([StudentGender])
REFERENCES [dbo].[Gender] ([GenderID])
GO
ALTER TABLE [dbo].[Students] CHECK CONSTRAINT [FK__Student__Student__4F7CD00D]
GO
ALTER TABLE [dbo].[SubordinatesSummary]  WITH CHECK ADD  CONSTRAINT [FK_SubordinatesSummary_Students] FOREIGN KEY([SubStudent])
REFERENCES [dbo].[Students] ([StudentID])
GO
ALTER TABLE [dbo].[SubordinatesSummary] CHECK CONSTRAINT [FK_SubordinatesSummary_Students]
GO
ALTER TABLE [dbo].[SubordinatesSummary]  WITH CHECK ADD  CONSTRAINT [FK_SubordinatesSummary_Summary] FOREIGN KEY([SubSummary])
REFERENCES [dbo].[Summary] ([SummaryID])
GO
ALTER TABLE [dbo].[SubordinatesSummary] CHECK CONSTRAINT [FK_SubordinatesSummary_Summary]
GO
ALTER TABLE [dbo].[Summary]  WITH CHECK ADD  CONSTRAINT [FK__Summary__Summary__6C190EBB] FOREIGN KEY([SummaryClass])
REFERENCES [dbo].[Class] ([ClassID])
GO
ALTER TABLE [dbo].[Summary] CHECK CONSTRAINT [FK__Summary__Summary__6C190EBB]
GO
ALTER TABLE [dbo].[Summary]  WITH CHECK ADD  CONSTRAINT [FK__Summary__Summary__6D0D32F4] FOREIGN KEY([SummaryTeacher])
REFERENCES [dbo].[Teachers] ([TeacherID])
GO
ALTER TABLE [dbo].[Summary] CHECK CONSTRAINT [FK__Summary__Summary__6D0D32F4]
GO
ALTER TABLE [dbo].[Summary]  WITH CHECK ADD  CONSTRAINT [FK__Summary__Summary__6E01572D] FOREIGN KEY([SummaryDiscipline])
REFERENCES [dbo].[Discipline] ([DisciplineID])
GO
ALTER TABLE [dbo].[Summary] CHECK CONSTRAINT [FK__Summary__Summary__6E01572D]
GO
ALTER TABLE [dbo].[Teachers]  WITH CHECK ADD  CONSTRAINT [FK__Teachers__Teache__5CD6CB2B] FOREIGN KEY([TeacherPulpit])
REFERENCES [dbo].[Pulpit] ([PulpitID])
GO
ALTER TABLE [dbo].[Teachers] CHECK CONSTRAINT [FK__Teachers__Teache__5CD6CB2B]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [CK__Class__ClassCour__47DBAE45] CHECK  (([ClassCourse]>(0) AND [ClassCourse]<(13)))
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [CK__Class__ClassCour__47DBAE45]
GO
ALTER TABLE [dbo].[Class]  WITH CHECK ADD  CONSTRAINT [CK_Class] CHECK  (([ClassQuantityStudent]>(14) AND [ClassQuantityStudent]<(36)))
GO
ALTER TABLE [dbo].[Class] CHECK CONSTRAINT [CK_Class]
GO
ALTER TABLE [dbo].[Faculty]  WITH CHECK ADD  CONSTRAINT [CK__Faculty__Faculty__3F466844] CHECK  (([FacultyHousingNumber]>(0) AND [FacultyHousingNumber]<(16)))
GO
ALTER TABLE [dbo].[Faculty] CHECK CONSTRAINT [CK__Faculty__Faculty__3F466844]
GO
ALTER TABLE [dbo].[Faculty]  WITH CHECK ADD  CONSTRAINT [CK_Faculty] CHECK  ((len(replace(replace(replace(replace([FacultyPhoneNumber],'-',''),' ',''),'(',''),')',''))<(12)))
GO
ALTER TABLE [dbo].[Faculty] CHECK CONSTRAINT [CK_Faculty]
GO
ALTER TABLE [dbo].[Pulpit]  WITH CHECK ADD  CONSTRAINT [CK__Pulpit__PulpitHo__440B1D61] CHECK  (([PulpitHousingNumber]>(0) AND [PulpitHousingNumber]<(16)))
GO
ALTER TABLE [dbo].[Pulpit] CHECK CONSTRAINT [CK__Pulpit__PulpitHo__440B1D61]
GO
ALTER TABLE [dbo].[Summary]  WITH CHECK ADD  CONSTRAINT [CK__Summary__Summary__6B24EA82] CHECK  (([SummarySemester]>(0) AND [SummarySemester]<(11)))
GO
ALTER TABLE [dbo].[Summary] CHECK CONSTRAINT [CK__Summary__Summary__6B24EA82]
GO
/****** Object:  StoredProcedure [dbo].[count_docent]    Script Date: 18.03.2025 17:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[count_docent]
as
select count(*) as 'Количество преподавателей с должностью доцент' from Teachers
where TeacherPost like '%доцент%'
GO
/****** Object:  StoredProcedure [dbo].[Count_teacher_ex]    Script Date: 18.03.2025 17:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Count_teacher_ex]
@Sum_salary as Int
AS
Select TeacherFullName as 'ФИО Преподавателя', TeacherExperience as 'Опыт'
from Teachers
WHERE TeacherExperience > @Sum_salary

GO
/****** Object:  StoredProcedure [dbo].[DisciplineHours]    Script Date: 18.03.2025 17:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DisciplineHours] @par int, @par2 intasif (Select DisciplineHours from Discipline where DisciplineID = @par2) = @par	return 1else 	return 0
GO
/****** Object:  StoredProcedure [dbo].[DisciplineHoursUpdate]    Script Date: 18.03.2025 17:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[DisciplineHoursUpdate] asupdate Discipline set DisciplineHours = DisciplineHours + 1
GO
/****** Object:  StoredProcedure [dbo].[SelectFromFaculty]    Script Date: 18.03.2025 17:30:13 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[SelectFromFaculty] @par intasselect DisciplineName as 'Дисциплина', DisciplineHours as 'Кол-во часов',FormatName as 'Формат контроля' from Disciplineinner join FormatControl on DisciplineFormatControl = FormatIDwhere FormatID = @par
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[21] 4[30] 2[32] 3) )"
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
         Begin Table = "SubordinatesSummary"
            Begin Extent = 
               Top = 175
               Left = 48
               Bottom = 338
               Right = 249
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Students"
            Begin Extent = 
               Top = 7
               Left = 352
               Bottom = 170
               Right = 593
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Summary"
            Begin Extent = 
               Top = 175
               Left = 297
               Bottom = 338
               Right = 519
            End
            DisplayFlags = 280
            TopColumn = 0
         End
         Begin Table = "Discipline"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 304
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 3636
         Alias = 900
         Table = 1176
         Output = 1128
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 2028
         GroupBy = 1356
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 13' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane2', @value=N'50
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=2 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_1'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[3] 4[14] 2[9] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1[50] 2[25] 3) )"
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
         Begin Table = "Teachers"
            Begin Extent = 
               Top = 7
               Left = 48
               Bottom = 170
               Right = 268
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
      Begin ColumnWidths = 9
         Width = 284
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
         Width = 1200
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1176
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1356
         SortOrder = 1416
         GroupBy = 1356
         Filter = 1356
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'View_2'
GO
USE [master]
GO
ALTER DATABASE [Progress_Students] SET  READ_WRITE 
GO
