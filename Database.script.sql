CREATE DATABASE Alarmsystem
GO
USE [Alarmsystem]
GO
/****** Object:  Table [dbo].[Abonenter]    Script Date: 01/04/2019 12:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Abonenter](
	[Mailaddresse] [nvarchar](100) NOT NULL,
	[Fornavn] [nvarchar](50) NULL,
	[Etternavn] [nvarchar](50) NULL,
	[Telefonnummer] [nvarchar](50) NULL,
	[Postnummer] [char](4) NULL,
 CONSTRAINT [PK__Abonente__15B7BC8FD8D414D9] PRIMARY KEY CLUSTERED 
(
	[Mailaddresse] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlarmData]    Script Date: 01/04/2019 12:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmData](
	[Mailaddresse] [nvarchar](100) NOT NULL,
	[TypeId] [int] NOT NULL,
	[Abonnerer] [bit] NOT NULL,
 CONSTRAINT [PK_AlarmData] PRIMARY KEY CLUSTERED 
(
	[Mailaddresse] ASC,
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Alarmer]    Script Date: 01/04/2019 12:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Alarmer](
	[AlarmId] [int] IDENTITY(1,1) NOT NULL,
	[Beskrivelse] [nvarchar](100) NULL,
	[GrenseId] [int] NOT NULL,
	[TypeId] [int] NOT NULL,
	[Tidspunkt] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[AlarmId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlarmGrenser]    Script Date: 01/04/2019 12:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmGrenser](
	[GrenseId] [int] NOT NULL,
	[GrenseNavn] [varchar](50) NOT NULL,
	[GrenseVerdi] [float] NOT NULL,
 CONSTRAINT [PK__AlarmGre__FC9912536222A215] PRIMARY KEY CLUSTERED 
(
	[GrenseId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[AlarmTyper]    Script Date: 01/04/2019 12:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[AlarmTyper](
	[TypeId] [int] NOT NULL,
	[TypeNavn] [varchar](50) NULL,
 CONSTRAINT [PK_AlarmTyper] PRIMARY KEY CLUSTERED 
(
	[TypeId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[Postaddresse]    Script Date: 01/04/2019 12:41:52 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Postaddresse](
	[Postnummer] [char](4) NOT NULL,
	[Poststed] [nvarchar](50) NULL,
PRIMARY KEY CLUSTERED 
(
	[Postnummer] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempAlarm]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempAlarm](
	[TempId] [int] NOT NULL,
	[AlarmId] [int] NOT NULL,
	[AlarmType] [nvarchar](50) NOT NULL,
	[Temperatur] [float] NOT NULL,
 CONSTRAINT [PK_TempAlarm] PRIMARY KEY CLUSTERED 
(
	[TempId] ASC,
	[AlarmId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempData]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempData](
	[TempId] [int] IDENTITY(1,1) NOT NULL,
	[Måletidspunkt] [datetime] NULL,
	[Temperatur] [float] NULL,
PRIMARY KEY CLUSTERED 
(
	[TempId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[Abonenter]  WITH CHECK ADD  CONSTRAINT [FK_Abonenter_ToTable] FOREIGN KEY([Postnummer])
REFERENCES [dbo].[Postaddresse] ([Postnummer])
GO
ALTER TABLE [dbo].[Abonenter] CHECK CONSTRAINT [FK_Abonenter_ToTable]
GO
ALTER TABLE [dbo].[AlarmData]  WITH CHECK ADD  CONSTRAINT [FK_AlarmData_Abonenter] FOREIGN KEY([Mailaddresse])
REFERENCES [dbo].[Abonenter] ([Mailaddresse])
GO
ALTER TABLE [dbo].[AlarmData] CHECK CONSTRAINT [FK_AlarmData_Abonenter]
GO
ALTER TABLE [dbo].[AlarmData]  WITH CHECK ADD  CONSTRAINT [FK_AlarmData_AlarmTyper] FOREIGN KEY([TypeId])
REFERENCES [dbo].[AlarmTyper] ([TypeId])
GO
ALTER TABLE [dbo].[AlarmData] CHECK CONSTRAINT [FK_AlarmData_AlarmTyper]
GO
ALTER TABLE [dbo].[Alarmer]  WITH CHECK ADD  CONSTRAINT [FK_Alarmer_AlarmGrenser] FOREIGN KEY([GrenseId])
REFERENCES [dbo].[AlarmGrenser] ([GrenseId])
GO
ALTER TABLE [dbo].[Alarmer] CHECK CONSTRAINT [FK_Alarmer_AlarmGrenser]
GO
ALTER TABLE [dbo].[Alarmer]  WITH CHECK ADD  CONSTRAINT [FK_Alarmer_AlarmTyper] FOREIGN KEY([TypeId])
REFERENCES [dbo].[AlarmTyper] ([TypeId])
GO
ALTER TABLE [dbo].[Alarmer] CHECK CONSTRAINT [FK_Alarmer_AlarmTyper]
GO
ALTER TABLE [dbo].[TempAlarm]  WITH CHECK ADD  CONSTRAINT [FK_TempAlarm_Alarmer] FOREIGN KEY([AlarmId])
REFERENCES [dbo].[Alarmer] ([AlarmId])
GO
ALTER TABLE [dbo].[TempAlarm] CHECK CONSTRAINT [FK_TempAlarm_Alarmer]
GO
ALTER TABLE [dbo].[TempAlarm]  WITH CHECK ADD  CONSTRAINT [FK_TempAlarm_TempData] FOREIGN KEY([TempId])
REFERENCES [dbo].[TempData] ([TempId])
GO
ALTER TABLE [dbo].[TempAlarm] CHECK CONSTRAINT [FK_TempAlarm_TempData]
GO
/****** Object:  StoredProcedure [dbo].[Abonner]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[Abonner]
@mail varchar(100), @typeId int, @abonner bit
AS
INSERT INTO AlarmData
VALUES(@mail, @typeId, @abonner)
GO
/****** Object:  StoredProcedure [dbo].[AddAbonnent]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAbonnent]
(@Mail nvarchar(100), @Fornavn nvarchar(50), @Etternavn varchar(50),@TlfNum varchar(50), @Postnum char(4))
AS
BEGIN
INSERT INTO Abonenter(Mailaddresse, Fornavn, Etternavn,Telefonnummer,Postnummer)
VALUES(@Mail,@Fornavn,@Etternavn,@TlfNum,@Postnum)
END
GO
/****** Object:  StoredProcedure [dbo].[AddAlarm]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAlarm]
@soneType varchar(100),@grenseId int,@typeId int, @tid datetime
AS
INSERT INTO Alarmer
VALUES(@soneType,@grenseId, @typeId, @tid)
GO
/****** Object:  StoredProcedure [dbo].[AddAlarmGrense]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAlarmGrense]
@grenseId int, @beskrivelse varchar(100),@verdi float
AS
INSERT INTO AlarmGrenser
VALUES(@grenseId,@beskrivelse,@verdi)
GO
/****** Object:  StoredProcedure [dbo].[AddAlarmTyper]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddAlarmTyper]
@typeId int, @typeNavn varchar(50)
AS
INSERT INTO AlarmTyper
VALUES(@typeId, @typeNavn)
GO
/****** Object:  StoredProcedure [dbo].[AddMåling]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddMåling]
@Temp float, @time datetime
as
INSERT INTO TempData(Måletidspunkt,Temperatur)
VALUES(@time,@Temp)
GO
/****** Object:  StoredProcedure [dbo].[AddTempALarm]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTempALarm]
@tempId int, @alarmId int, @type varchar(50),@temp float
AS
INSERT INTO TempAlarm(TempId,AlarmId,AlarmType,Temperatur)
VALUES(@tempId, @alarmId, @type,@temp)
GO
/****** Object:  StoredProcedure [dbo].[DeleteAbonnent]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAbonnent]
@Mail nvarchar(100)
AS
DELETE
FROM Abonenter
WHERE Mailaddresse = @Mail
GO
/****** Object:  StoredProcedure [dbo].[GetAbonnentMails]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAbonnentMails]
AS
SELECT Mailaddresse
FROM Abonenter
ORDER BY Mailaddresse
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmGrense]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmGrense]
@grenseId int, @beskrivelse varchar(100)
AS
SELECT GrenseVerdi
FROM AlarmGrenser
WHERE GrenseId = @grenseId
AND GrenseNavn = @beskrivelse
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmHistory]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmHistory]
AS
SELECT A.AlarmId, A.Beskrivelse,AG.GrenseVerdi,A.Tidspunkt,AT.TypeNavn
FROM Alarmer A, AlarmGrenser AG, AlarmTyper AT
WHERE A.GrenseId = AG.GrenseId
AND A.TypeId = AT.TypeId
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmId]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmId]
AS
SELECT AlarmId
FROM Alarmer
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmTyper]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmTyper]
AS
SELECT TypeNavn
FROM AlarmTyper
GO
/****** Object:  StoredProcedure [dbo].[GetMåleTidsPunkt]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetMåleTidsPunkt]
@GrenseLav float, @GrenseHøy float
AS
SELECT Måletidspunkt
FROM TempData
WHERE Temperatur > @GrenseHøy
OR Temperatur < @GrenseLav
GO
/****** Object:  StoredProcedure [dbo].[GetTempId]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTempId]
AS
SELECT TempId
FROM TempData
GO
/****** Object:  StoredProcedure [dbo].[UpdateAlarmGrense]    Script Date: 01/04/2019 12:41:53 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[UpdateAlarmGrense]
@grenseId int, @beskrivelse varchar(100),@verdi int
AS
UPDATE AlarmGrenser
SET GrenseVerdi =@verdi
WHERE GrenseId = @grenseId
AND GrenseNavn = @beskrivelse
GO
