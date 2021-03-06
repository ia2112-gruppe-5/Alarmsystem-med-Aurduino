CREATE DATABASE Alarmsystem
GO

USE [Alarmsystem]
GO
/****** Object:  Table [dbo].[Alarmer]    Script Date: 24/04/2019 13:05:32 ******/
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
/****** Object:  Table [dbo].[AlarmGrenser]    Script Date: 24/04/2019 13:05:32 ******/
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
/****** Object:  Table [dbo].[AlarmTyper]    Script Date: 24/04/2019 13:05:32 ******/
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
/****** Object:  View [dbo].[AlarmHistory]    Script Date: 24/04/2019 13:05:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE VIEW [dbo].[AlarmHistory]
AS
SELECT A.AlarmId, A.Beskrivelse, A.Tidspunkt,AT.TypeNavn, AG.GrenseNavn
FROM Alarmer A, AlarmGrenser AG, AlarmTyper AT
WHERE A.GrenseId = AG.GrenseId
AND A.TypeId = AT.TypeId
GO
/****** Object:  Table [dbo].[Abonenter]    Script Date: 24/04/2019 13:05:32 ******/
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
/****** Object:  Table [dbo].[AlarmData]    Script Date: 24/04/2019 13:05:32 ******/
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
/****** Object:  Table [dbo].[Postaddresse]    Script Date: 24/04/2019 13:05:32 ******/
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
/****** Object:  Table [dbo].[TempAlarm]    Script Date: 24/04/2019 13:05:32 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[TempAlarm](
	[TempId] [int] NOT NULL,
	[AlarmId] [int] NOT NULL,
	[Temperatur] [float] NOT NULL,
 CONSTRAINT [PK_TempAlarm] PRIMARY KEY CLUSTERED 
(
	[TempId] ASC,
	[AlarmId] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[TempData]    Script Date: 24/04/2019 13:05:32 ******/
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
INSERT [dbo].[Abonenter] ([Mailaddresse], [Fornavn], [Etternavn], [Telefonnummer], [Postnummer]) VALUES (N'221951@usn.no', N'sebastian', N'grønning', N'92090827', N'3738')
GO
INSERT [dbo].[AlarmData] ([Mailaddresse], [TypeId], [Abonnerer]) VALUES (N'221951@usn.no', 1, 1)
GO
INSERT [dbo].[AlarmData] ([Mailaddresse], [TypeId], [Abonnerer]) VALUES (N'221951@usn.no', 2, 1)
GO
INSERT [dbo].[AlarmData] ([Mailaddresse], [TypeId], [Abonnerer]) VALUES (N'221951@usn.no', 3, 1)
GO
INSERT [dbo].[AlarmData] ([Mailaddresse], [TypeId], [Abonnerer]) VALUES (N'221951@usn.no', 4, 1)
GO
INSERT [dbo].[AlarmData] ([Mailaddresse], [TypeId], [Abonnerer]) VALUES (N'221951@usn.no', 5, 1)
GO
SET IDENTITY_INSERT [dbo].[Alarmer] ON 
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (1, N'RUN BITCH, RUN!!', 6, 2, CAST(N'2019-04-24T08:33:33.797' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (2, N'RUN BITCH, RUN!!', 6, 2, CAST(N'2019-04-24T08:35:01.847' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (3, N'RUN BITCH, RUN!!', 6, 2, CAST(N'2019-04-24T08:42:35.900' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (4, N'RUN BITCH, RUN!!', 6, 2, CAST(N'2019-04-24T08:44:32.597' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (5, N'RUN BITCH, RUN!!', 6, 2, CAST(N'2019-04-24T08:46:34.217' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (6, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:02:49.940' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (7, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:13:33.090' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (8, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:15:23.853' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (9, N'Temperatur alarm, den målte verdien 0, er mindre enn 10.', 2, 1, CAST(N'2019-04-24T09:24:48.873' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (10, N'Temperatur alarm, den målte verdien 21.78, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:25:04.007' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (11, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:36:47.000' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (12, N'Temperatur alarm, den målte verdien 22.75, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:36:57.483' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (13, N'Temperatur alarm, den målte verdien 0, er mindre enn 10.', 2, 1, CAST(N'2019-04-24T09:39:18.773' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (14, N'Temperatur alarm, den målte verdien 0, er mindre enn 10.', 2, 1, CAST(N'2019-04-24T09:39:32.007' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (15, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:40:12.793' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (16, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:52:43.597' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (17, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:53:17.947' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (18, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:54:54.003' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (19, N'RUN BITCH, RUN!!', 6, 2, CAST(N'2019-04-24T09:56:54.943' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (20, N'Temperatur alarm, den målte verdien 22.27, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:59:00.530' AS DateTime))
GO
INSERT [dbo].[Alarmer] ([AlarmId], [Beskrivelse], [GrenseId], [TypeId], [Tidspunkt]) VALUES (21, N'Temperatur alarm, den målte verdien 21.29, er større enn 21.', 1, 1, CAST(N'2019-04-24T09:59:41.487' AS DateTime))
GO
SET IDENTITY_INSERT [dbo].[Alarmer] OFF
GO
INSERT [dbo].[AlarmGrenser] ([GrenseId], [GrenseNavn], [GrenseVerdi]) VALUES (1, N'TempHøy
', 21)
GO
INSERT [dbo].[AlarmGrenser] ([GrenseId], [GrenseNavn], [GrenseVerdi]) VALUES (2, N'TempLav
', 10)
GO
INSERT [dbo].[AlarmGrenser] ([GrenseId], [GrenseNavn], [GrenseVerdi]) VALUES (3, N'Batteri prosent
', 60)
GO
INSERT [dbo].[AlarmGrenser] ([GrenseId], [GrenseNavn], [GrenseVerdi]) VALUES (4, N'Batteri lading
', 1)
GO
INSERT [dbo].[AlarmGrenser] ([GrenseId], [GrenseNavn], [GrenseVerdi]) VALUES (5, N'Sabotasje
', 99)
GO
INSERT [dbo].[AlarmGrenser] ([GrenseId], [GrenseNavn], [GrenseVerdi]) VALUES (6, N'Bevegelse
', 1)
GO
INSERT [dbo].[AlarmTyper] ([TypeId], [TypeNavn]) VALUES (1, N'Temp
')
GO
INSERT [dbo].[AlarmTyper] ([TypeId], [TypeNavn]) VALUES (2, N'Bevegelse
')
GO
INSERT [dbo].[AlarmTyper] ([TypeId], [TypeNavn]) VALUES (3, N'Sabotasje
')
GO
INSERT [dbo].[AlarmTyper] ([TypeId], [TypeNavn]) VALUES (4, N'Batteri
')
GO
INSERT [dbo].[AlarmTyper] ([TypeId], [TypeNavn]) VALUES (5, N'PDF
')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0010', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0015', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0018', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0021', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0024', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0026', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0028', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0030', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0031', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0032', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0033', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0034', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0037', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0040', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0045', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0046', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0047', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0048', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0050', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0055', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0060', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0081', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0101', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0102', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0103', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0104', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0105', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0106', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0107', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0109', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0110', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0111', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0112', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0113', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0114', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0115', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0116', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0117', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0118', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0119', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0120', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0121', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0122', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0123', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0124', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0125', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0128', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0129', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0130', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0131', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0132', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0133', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0134', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0135', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0136', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0138', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0139', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0140', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0150', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0151', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0152', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0153', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0154', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0155', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0157', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0158', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0159', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0160', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0161', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0162', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0164', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0165', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0166', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0167', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0168', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0169', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0170', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0171', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0172', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0173', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0174', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0175', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0176', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0177', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0178', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0179', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0180', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0181', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0182', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0183', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0184', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0185', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0186', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0187', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0188', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0190', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0191', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0192', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0193', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0194', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0195', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0196', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0198', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0201', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0202', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0203', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0204', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0207', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0208', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0211', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0212', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0213', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0214', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0215', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0216', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0217', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0218', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0230', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0240', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0244', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0247', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0250', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0251', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0252', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0253', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0254', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0255', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0256', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0257', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0258', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0259', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0260', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0262', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0263', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0264', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0265', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0266', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0267', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0268', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0270', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0271', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0272', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0273', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0274', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0275', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0276', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0277', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0278', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0279', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0280', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0281', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0282', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0283', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0284', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0286', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0287', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0301', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0302', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0303', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0304', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0305', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0306', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0307', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0308', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0309', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0311', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0313', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0314', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0315', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0316', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0317', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0318', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0319', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0323', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0330', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0340', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0349', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0350', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0351', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0352', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0353', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0354', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0355', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0356', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0357', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0358', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0359', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0360', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0361', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0362', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0363', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0364', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0365', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0366', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0367', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0368', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0369', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0370', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0371', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0372', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0373', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0374', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0375', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0376', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0377', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0378', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0379', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0380', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0381', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0382', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0383', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0401', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0402', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0403', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0404', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0405', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0406', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0409', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0410', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0411', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0412', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0413', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0415', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0421', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0422', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0423', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0424', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0440', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0441', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0442', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0445', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0450', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0451', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0452', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0454', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0455', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0456', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0457', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0458', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0459', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0460', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0461', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0462', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0463', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0464', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0465', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0467', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0468', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0469', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0470', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0472', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0473', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0474', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0475', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0476', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0477', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0478', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0479', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0480', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0481', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0482', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0483', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0484', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0485', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0486', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0487', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0488', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0489', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0490', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0491', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0492', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0493', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0494', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0495', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0496', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0501', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0502', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0503', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0504', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0505', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0506', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0507', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0508', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0509', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0510', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0511', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0512', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0513', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0515', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0516', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0517', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0518', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0520', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0540', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0550', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0551', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0552', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0553', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0554', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0555', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0556', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0557', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0558', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0559', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0560', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0561', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0562', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0563', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0564', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0565', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0566', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0567', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0568', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0569', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0570', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0571', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0572', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0573', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0574', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0575', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0576', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0577', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0578', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0579', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0580', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0581', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0582', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0583', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0584', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0585', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0586', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0587', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0588', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0589', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0590', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0591', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0592', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0593', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0594', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0595', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0596', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0597', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0598', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0601', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0602', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0603', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0604', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0605', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0606', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0607', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0608', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0609', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0611', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0612', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0613', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0614', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0615', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0616', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0617', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0618', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0619', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0620', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0621', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0622', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0623', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0624', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0626', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0650', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0651', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0652', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0653', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0654', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0655', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0656', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0657', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0658', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0659', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0660', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0661', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0662', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0663', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0664', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0665', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0666', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0667', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0668', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0669', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0670', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0671', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0672', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0673', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0674', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0675', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0676', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0677', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0678', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0679', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0680', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0681', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0682', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0683', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0684', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0685', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0686', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0687', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0688', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0689', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0690', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0691', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0692', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0693', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0694', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0701', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0702', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0705', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0710', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0712', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0750', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0751', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0752', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0753', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0754', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0755', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0756', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0757', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0758', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0760', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0763', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0764', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0765', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0766', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0767', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0768', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0770', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0771', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0772', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0773', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0774', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0775', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0776', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0777', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0778', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0779', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0781', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0782', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0783', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0784', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0785', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0786', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0787', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0788', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0789', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0790', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0791', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0801', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0805', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0806', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0807', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0840', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0850', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0851', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0852', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0853', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0854', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0855', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0856', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0857', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0858', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0860', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0861', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0862', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0863', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0864', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0870', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0871', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0872', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0873', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0874', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0875', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0876', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0877', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0880', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0881', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0882', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0883', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0884', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0890', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0891', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0901', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0902', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0903', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0904', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0905', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0907', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0908', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0913', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0914', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0915', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0950', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0951', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0952', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0953', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0954', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0955', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0956', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0957', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0958', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0959', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0960', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0962', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0963', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0964', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0968', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0969', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0970', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0971', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0972', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0973', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0975', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0976', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0977', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0978', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0979', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0980', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0981', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0982', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0983', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0984', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0985', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0986', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0987', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'0988', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1001', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1003', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1005', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1006', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1007', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1008', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1009', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1011', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1051', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1052', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1053', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1054', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1055', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1056', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1061', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1062', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1063', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1064', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1065', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1067', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1068', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1069', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1071', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1081', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1083', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1084', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1086', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1087', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1088', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1089', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1101', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1102', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1108', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1109', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1112', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1150', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1151', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1152', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1153', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1154', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1155', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1156', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1157', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1158', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1160', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1161', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1162', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1163', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1164', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1165', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1166', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1167', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1168', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1169', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1170', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1172', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1176', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1177', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1178', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1179', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1181', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1182', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1184', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1185', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1187', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1188', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1189', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1201', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1203', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1204', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1205', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1207', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1214', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1215', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1250', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1251', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1252', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1253', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1254', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1255', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1256', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1257', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1258', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1259', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1262', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1263', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1266', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1270', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1271', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1272', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1273', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1274', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1275', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1278', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1279', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1281', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1283', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1284', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1285', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1286', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1290', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1291', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1294', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1295', N'OSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1300', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1301', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1302', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1303', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1304', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1305', N'HASLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1306', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1307', N'FORNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1308', N'JAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1309', N'RUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1311', N'HØVIKODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1312', N'SLEPENDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1313', N'VØYENENGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1314', N'VØYENENGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1316', N'EIKSMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1317', N'BÆRUMS VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1318', N'BEKKESTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1319', N'BEKKESTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1321', N'STABEKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1322', N'HØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1323', N'HØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1324', N'LYSAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1325', N'LYSAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1326', N'LYSAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1327', N'LYSAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1328', N'HØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1329', N'LOMMEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1330', N'FORNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1331', N'FORNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1332', N'ØSTERÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1333', N'KOLSÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1334', N'RYKKINN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1335', N'SNARØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1336', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1337', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1338', N'SANDVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1339', N'VØYENENGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1340', N'SKUI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1341', N'SLEPENDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1342', N'GJETTUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1344', N'HASLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1346', N'GJETTUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1348', N'RYKKINN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1349', N'RYKKINN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1350', N'LOMMEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1351', N'RUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1352', N'KOLSÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1353', N'BÆRUMS VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1354', N'BÆRUMS VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1356', N'BEKKESTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1357', N'BEKKESTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1358', N'JAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1359', N'EIKSMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1360', N'FORNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1361', N'ØSTERÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1362', N'HOSLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1363', N'HØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1364', N'FORNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1365', N'BLOMMENHOLM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1366', N'LYSAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1367', N'SNARØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1368', N'STABEKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1369', N'STABEKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1371', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1372', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1373', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1375', N'BILLINGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1376', N'BILLINGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1377', N'BILLINGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1378', N'NESBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1379', N'NESBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1380', N'HEGGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1381', N'VETTRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1383', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1384', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1385', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1386', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1387', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1388', N'BORGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1389', N'HEGGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1390', N'VOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1391', N'VOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1392', N'VETTRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1393', N'VOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1394', N'NESBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1395', N'HVALSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1396', N'BILLINGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1397', N'NESØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1399', N'ASKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1400', N'SKI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1401', N'SKI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1402', N'SKI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1403', N'LANGHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1404', N'SIGGERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1405', N'LANGHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1406', N'SKI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1407', N'VINTERBRO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1408', N'KRÅKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1409', N'SKOTBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1410', N'KOLBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1411', N'KOLBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1412', N'SOFIEMYR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1413', N'TÅRNÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1414', N'TROLLÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1415', N'OPPEGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1416', N'OPPEGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1417', N'SOFIEMYR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1418', N'KOLBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1419', N'OPPEGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1420', N'SVARTSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1421', N'TROLLÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1422', N'SIGGERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1429', N'VINTERBRO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1430', N'ÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1431', N'ÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1432', N'ÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1433', N'ÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1434', N'ÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1435', N'ÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1440', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1441', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1442', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1443', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1444', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1445', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1446', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1447', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1448', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1449', N'DRØBAK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1450', N'NESODDTANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1451', N'NESODDTANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1452', N'NESODDTANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1453', N'BJØRNEMYR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1454', N'FAGERSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1455', N'NORDRE FROGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1456', N'NESODDTANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1457', N'FAGERSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1458', N'FJELLSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1459', N'NESODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1465', N'STRØMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1466', N'STRØMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1467', N'STRØMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1468', N'FINSTADJORDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1469', N'RASTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1470', N'LØRENSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1471', N'LØRENSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1472', N'FJELLHAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1473', N'LØRENSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1474', N'LØRENSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1475', N'FINSTADJORDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1476', N'RASTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1477', N'FJELLHAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1478', N'LØRENSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1479', N'KURLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1480', N'SLATTUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1481', N'HAGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1482', N'NITTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1483', N'HAGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1484', N'HAKADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1485', N'HAKADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1486', N'NITTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1487', N'HAKADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1488', N'HAKADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1501', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1502', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1503', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1504', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1506', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1508', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1509', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1510', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1511', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1512', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1513', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1514', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1515', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1516', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1517', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1518', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1519', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1520', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1521', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1522', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1523', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1524', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1525', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1526', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1528', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1529', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1530', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1531', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1532', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1533', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1534', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1535', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1536', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1537', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1538', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1539', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1540', N'VESTBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1541', N'VESTBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1545', N'HVITSTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1550', N'HØLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1555', N'SON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1556', N'SON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1560', N'LARKOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1561', N'LARKOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1570', N'DILLING')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1580', N'RYGGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1581', N'RYGGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1590', N'RYGGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1591', N'SPERREBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1592', N'VÅLER I ØSTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1593', N'SVINNDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1594', N'VÅLER I ØSTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1596', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1597', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1598', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1599', N'MOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1601', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1602', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1604', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1605', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1606', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1607', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1608', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1609', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1610', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1612', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1613', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1614', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1615', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1616', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1617', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1618', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1619', N'FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1620', N'GRESSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1621', N'GRESSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1622', N'GRESSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1623', N'GRESSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1624', N'GRESSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1625', N'MANSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1626', N'MANSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1628', N'ENGELSVIKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1629', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1630', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1632', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1633', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1634', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1636', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1637', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1638', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1639', N'GAMLE FREDRIKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1640', N'RÅDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1641', N'RÅDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1642', N'SALTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1650', N'SELLEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1651', N'SELLEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1653', N'SELLEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1654', N'SELLEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1655', N'SELLEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1657', N'TORP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1658', N'TORP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1659', N'TORP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1661', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1662', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1663', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1664', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1665', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1666', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1667', N'ROLVSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1670', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1671', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1672', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1673', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1675', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1676', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1678', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1679', N'KRÅKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1680', N'SKJÆRHALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1682', N'SKJÆRHALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1683', N'VESTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1684', N'VESTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1690', N'HERFØL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1692', N'NEDGÅRDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1701', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1702', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1703', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1704', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1705', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1706', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1707', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1708', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1709', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1710', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1711', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1712', N'GRÅLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1713', N'GRÅLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1714', N'GRÅLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1715', N'YVEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1718', N'GREÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1719', N'GREÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1720', N'GREÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1721', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1722', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1723', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1724', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1725', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1726', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1727', N'SARPSBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1730', N'ISE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1733', N'HAFSLUNDSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1734', N'HAFSLUNDSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1735', N'VARTEIG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1738', N'BORGENHAUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1739', N'BORGENHAUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1740', N'BORGENHAUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1742', N'KLAVESTADHAUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1743', N'KLAVESTADHAUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1745', N'SKJEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1746', N'SKJEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1747', N'SKJEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1751', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1752', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1753', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1754', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1757', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1759', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1760', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1761', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1762', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1763', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1764', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1765', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1766', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1767', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1768', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1769', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1771', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1772', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1776', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1777', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1778', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1779', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1781', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1782', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1783', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1784', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1785', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1786', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1787', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1788', N'HALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1789', N'BERG I ØSTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1790', N'TISTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1791', N'TISTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1792', N'TISTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1793', N'TISTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1794', N'SPONVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1796', N'KORNSJØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1798', N'AREMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1799', N'AREMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1801', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1802', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1803', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1804', N'SPYDEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1805', N'TOMTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1806', N'SKIPTVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1807', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1808', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1809', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1811', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1812', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1813', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1814', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1815', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1816', N'SKIPTVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1820', N'SPYDEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1821', N'SPYDEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1823', N'KNAPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1825', N'TOMTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1827', N'HOBØL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1830', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1831', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1832', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1833', N'ASKIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1850', N'MYSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1851', N'MYSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1852', N'MYSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1859', N'SLITU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1860', N'TRØGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1861', N'TRØGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1866', N'BÅSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1867', N'BÅSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1870', N'ØRJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1871', N'ØRJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1875', N'OTTEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1878', N'HÆRLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1880', N'EIDSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1890', N'RAKKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1891', N'RAKKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1892', N'DEGERNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1893', N'DEGERNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1894', N'RAKKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1900', N'FETSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1901', N'FETSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1903', N'GAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1910', N'ENEBAKKNESET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1911', N'FLATEBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1912', N'ENEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1914', N'YTRE ENEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1916', N'FLATEBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1917', N'YTRE ENEBAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1920', N'SØRUMSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1921', N'SØRUMSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1923', N'SØRUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1924', N'SØRUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1925', N'BLAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1926', N'BLAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1927', N'RÅNÅSFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1928', N'AULI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1929', N'AULI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1930', N'AURSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1931', N'AURSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1940', N'BJØRKELANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1941', N'BJØRKELANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1950', N'RØMSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1954', N'SETSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1960', N'LØKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1961', N'LØKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1963', N'FOSSER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1970', N'HEMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'1971', N'HEMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2000', N'LILLESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2001', N'LILLESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2003', N'LILLESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2004', N'LILLESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2005', N'RÆLINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2006', N'LØVENSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2007', N'KJELLER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2008', N'FJERDINGBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2009', N'NORDBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2010', N'STRØMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2011', N'STRØMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2012', N'LILLESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2013', N'SKJETTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2014', N'BLYSTADLIA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2015', N'LEIRSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2016', N'FROGNER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2017', N'FROGNER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2018', N'LØVENSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2019', N'SKEDSMOKORSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2020', N'SKEDSMOKORSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2021', N'SKEDSMOKORSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2022', N'GJERDRUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2023', N'SKEDSMOKORSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2024', N'GJERDRUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2025', N'FJERDINGBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2026', N'SKJETTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2027', N'KJELLER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2028', N'LILLESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2029', N'RÆLINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2030', N'NANNESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2031', N'NANNESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2032', N'MAURA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2033', N'ÅSGREINA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2034', N'HOLTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2035', N'HOLTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2036', N'MAURA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2040', N'KLØFTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2041', N'KLØFTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2050', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2051', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2052', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2053', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2054', N'MOGREINA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2055', N'NORDKISA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2056', N'ALGARHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2057', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2058', N'SESSVOLLMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2060', N'GARDERMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2061', N'GARDERMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2062', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2063', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2066', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2067', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2068', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2069', N'JESSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2070', N'RÅHOLT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2071', N'RÅHOLT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2072', N'DAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2073', N'BØN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2074', N'EIDSVOLL VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2076', N'DAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2080', N'EIDSVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2081', N'EIDSVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2090', N'HURDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2091', N'HURDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2092', N'MINNESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2093', N'FEIRING')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2094', N'MINNESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2100', N'SKARNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2101', N'SKARNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2110', N'SLÅSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2114', N'DISENÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2116', N'SANDER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2120', N'SAGSTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2121', N'SAGSTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2123', N'BRUVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2130', N'KNAPPER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2132', N'GARDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2133', N'GARDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2134', N'AUSTVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2150', N'ÅRNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2151', N'ÅRNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2160', N'VORMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2161', N'VORMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2162', N'BRÅRUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2163', N'SKOGBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2164', N'SKOGBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2165', N'HVAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2166', N'OPPAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2167', N'HVAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2170', N'FENSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2201', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2202', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2203', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2204', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2205', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2206', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2207', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2208', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2209', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2210', N'GRANLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2211', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2212', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2213', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2214', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2215', N'ROVERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2216', N'ROVERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2217', N'HOKKÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2218', N'LUNDERSÆTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2219', N'BRANDVAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2220', N'ÅBOGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2223', N'GALTERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2224', N'AUSTMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2225', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2226', N'KONGSVINGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2227', N'AUSTMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2230', N'SKOTTERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2231', N'SKOTTERUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2232', N'TOBØL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2233', N'VESTMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2235', N'MATRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2240', N'MAGNOR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2241', N'MAGNOR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2251', N'GRUE FINNSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2256', N'GRUE FINNSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2260', N'KIRKENÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2261', N'KIRKENÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2264', N'GRINDER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2265', N'NAMNÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2266', N'ARNEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2270', N'FLISA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2271', N'FLISA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2280', N'GJESÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2283', N'ÅSNES FINNSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2301', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2302', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2303', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2304', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2305', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2306', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2307', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2308', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2309', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2311', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2312', N'OTTESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2313', N'OTTESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2314', N'OTTESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2315', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2316', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2317', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2318', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2319', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2320', N'FURNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2321', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2322', N'RIDABU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2323', N'INGEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2324', N'VANG PÅ HEDMARKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2325', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2326', N'HAMAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2327', N'FURNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2328', N'RIDABU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2329', N'VANG PÅ HEDMARKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2330', N'VALLSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2331', N'VALLSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2332', N'ÅSVANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2333', N'ROMEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2334', N'ROMEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2335', N'STANGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2336', N'STANGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2337', N'TANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2338', N'ESPA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2339', N'TANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2340', N'LØTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2341', N'LØTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2344', N'ILSENG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2345', N'ÅDALSBRUK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2346', N'ILSENG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2350', N'NES PÅ HEDMARKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2351', N'NES PÅ HEDMARKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2353', N'STAVSJØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2355', N'GAUPEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2360', N'RUDSHØGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2361', N'RUDSHØGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2364', N'NÆROSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2365', N'ÅSMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2372', N'BRØTTUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2373', N'BRØTTUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2380', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2381', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2382', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2383', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2384', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2385', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2386', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2387', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2388', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2389', N'BRUMUNDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2390', N'MOELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2391', N'MOELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2401', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2402', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2403', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2404', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2405', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2406', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2407', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2408', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2409', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2410', N'HERNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2411', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2412', N'SØRSKOGBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2413', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2414', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2415', N'HERADSBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2416', N'JØMNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2417', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2418', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2419', N'ELVERUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2420', N'TRYSIL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2421', N'TRYSIL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2422', N'NYBERGSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2423', N'ØSTBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2424', N'ØSTBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2425', N'LJØRDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2426', N'LJØRDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2427', N'PLASSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2428', N'SØRE OSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2429', N'TØRBERGET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2430', N'JORDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2432', N'SLETTÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2434', N'BRASKEREIDFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2435', N'BRASKEREIDFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2436', N'VÅLER I SOLØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2437', N'HASLEMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2438', N'GRAVBERGET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2439', N'VÅLER I SOLØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2440', N'ENGERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2441', N'ENGERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2442', N'HERADSBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2443', N'DREVSJØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2444', N'DREVSJØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2446', N'ELGÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2447', N'SØRE OSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2448', N'SØMÅDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2450', N'RENA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2451', N'RENA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2460', N'OSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2461', N'OSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2476', N'ATNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2477', N'SOLLIA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2478', N'HANESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2480', N'KOPPANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2481', N'KOPPANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2484', N'RENDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2485', N'RENDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2486', N'RENDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2487', N'RENDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2488', N'RENDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2500', N'TYNSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2501', N'TYNSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2510', N'TYLLDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2512', N'KVIKNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2513', N'KVIKNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2540', N'TOLGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2541', N'TOLGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2542', N'VINGELEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2544', N'ØVERSJØDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2550', N'OS I ØSTERDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2551', N'OS I ØSTERDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2552', N'DALSBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2555', N'TUFSINGDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2560', N'ALVDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2561', N'ALVDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2580', N'FOLLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2581', N'FOLLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2582', N'GRIMSBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2584', N'DALHOLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2601', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2602', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2603', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2604', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2605', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2606', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2607', N'VINGROM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2608', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2609', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2610', N'MESNALI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2611', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2612', N'SJUSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2613', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2614', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2615', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2616', N'LISMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2617', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2618', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2619', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2620', N'MESNALI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2621', N'VINGROM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2622', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2623', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2624', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2625', N'FÅBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2626', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2627', N'FÅBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2628', N'SJUSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2629', N'LILLEHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2630', N'RINGEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2631', N'RINGEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2632', N'VENABYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2633', N'FÅVANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2634', N'FÅVANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2635', N'TRETTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2636', N'ØYER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2637', N'ØYER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2638', N'TRETTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2639', N'VINSTRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2640', N'VINSTRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2641', N'KVAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2642', N'KVAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2643', N'SKÅBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2644', N'SKÅBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2645', N'SØR-FRON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2646', N'GÅLÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2647', N'SØR-FRON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2648', N'SØR-FRON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2649', N'ØSTRE GAUSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2651', N'ØSTRE GAUSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2652', N'SVINGVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2653', N'VESTRE GAUSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2654', N'VESTRE GAUSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2656', N'FOLLEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2657', N'SVATSUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2658', N'ESPEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2659', N'DOMBÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2660', N'DOMBÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2661', N'HJERKINN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2662', N'DOVRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2663', N'DOVRESKOGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2664', N'DOVRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2665', N'LESJA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2666', N'LORA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2667', N'LESJAVERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2668', N'LESJASKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2669', N'BJORLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2670', N'OTTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2671', N'LESJA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2672', N'SEL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2673', N'HØVRINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2674', N'MYSUSÆTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2675', N'OTTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2676', N'HEIDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2677', N'NEDRE HEIDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2678', N'SEL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2679', N'HEIDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2680', N'VÅGÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2681', N'LALM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2682', N'LALM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2683', N'TESSANDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2684', N'VÅGÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2685', N'GARMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2686', N'LOM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2687', N'BØVERDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2688', N'LOM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2690', N'SKJÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2693', N'NORDBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2694', N'SKJÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2695', N'GROTLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2711', N'GRAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2712', N'BRANDBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2713', N'ROA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2714', N'JAREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2715', N'LUNNER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2716', N'HARESTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2717', N'GRUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2718', N'BRANDBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2720', N'GRINDVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2730', N'LUNNER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2740', N'ROA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2742', N'GRUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2743', N'HARESTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2750', N'GRAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2760', N'BRANDBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2770', N'JAREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2801', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2802', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2803', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2804', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2805', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2806', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2807', N'HUNNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2808', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2809', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2810', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2811', N'HUNNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2812', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2815', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2816', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2817', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2818', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2819', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2820', N'NORDRE TOTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2821', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2822', N'BYBRUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2825', N'GJØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2827', N'HUNNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2830', N'RAUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2831', N'RAUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2832', N'BIRI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2833', N'RAUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2834', N'RAUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2835', N'RAUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2836', N'BIRI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2837', N'BIRISTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2838', N'SNERTINGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2839', N'ØVRE SNERTINGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2840', N'REINSVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2841', N'SNERTINGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2843', N'EINA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2844', N'KOLBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2845', N'BØVERBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2846', N'BØVERBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2847', N'KOLBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2848', N'SKREIA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2849', N'KAPP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2850', N'LENA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2851', N'LENA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2853', N'REINSVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2854', N'EINA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2857', N'SKREIA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2858', N'KAPP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2860', N'HOV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2861', N'LANDÅSBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2862', N'FLUBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2864', N'FALL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2866', N'ENGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2867', N'HOV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2870', N'DOKKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2879', N'ODNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2880', N'NORD-TORPA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2881', N'AUST-TORPA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2882', N'DOKKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2890', N'ETNEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2893', N'ETNEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2900', N'FAGERNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2901', N'FAGERNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2907', N'LEIRA I VALDRES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2909', N'AURDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2910', N'AURDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2917', N'SKRAUTVÅL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2918', N'ULNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2920', N'LEIRA I VALDRES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2923', N'TISLEIDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2929', N'BAGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2930', N'BAGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2933', N'REINLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2936', N'BEGNADALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2937', N'BEGNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2939', N'HEGGENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2940', N'HEGGENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2943', N'ROGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2950', N'SKAMMESTEIN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2952', N'BEITO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2953', N'BEITOSTØLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2954', N'BEITOSTØLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2959', N'RØN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2960', N'RØN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2965', N'SLIDRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2966', N'SLIDRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2967', N'LOMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2972', N'RYFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2973', N'RYFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2974', N'VANG I VALDRES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2975', N'VANG I VALDRES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2977', N'ØYE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'2985', N'TYINKRYSSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3001', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3002', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3003', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3004', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3005', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3006', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3007', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3008', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3009', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3010', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3011', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3012', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3013', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3014', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3015', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3016', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3017', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3018', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3019', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3021', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3022', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3023', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3024', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3025', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3026', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3027', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3028', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3029', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3030', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3031', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3032', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3033', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3034', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3035', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3036', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3037', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3038', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3039', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3040', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3041', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3042', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3043', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3044', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3045', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3046', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3047', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3048', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3050', N'MJØNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3051', N'MJØNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3053', N'STEINBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3054', N'KROKSTADELVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3055', N'KROKSTADELVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3056', N'SOLBERGELVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3057', N'SOLBERGELVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3058', N'SOLBERGMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3060', N'SVELVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3061', N'SVELVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3063', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3064', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3065', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3066', N'DRAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3070', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3071', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3072', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3073', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3074', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3075', N'BERGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3076', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3077', N'SANDE I VESTFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3080', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3081', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3082', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3083', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3084', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3085', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3086', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3087', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3088', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3089', N'HOLMESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3090', N'HOF')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3091', N'HOF')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3092', N'SUNDBYFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3095', N'EIDSFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3101', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3103', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3104', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3105', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3106', N'NØTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3107', N'SEM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3108', N'VEAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3109', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3110', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3111', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3112', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3113', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3114', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3115', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3116', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3117', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3118', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3119', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3120', N'NØTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3121', N'NØTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3122', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3123', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3124', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3125', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3126', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3127', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3128', N'NØTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3129', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3131', N'HUSØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3132', N'HUSØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3133', N'DUKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3134', N'TØNSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3135', N'TORØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3137', N'TORØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3138', N'SKALLESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3139', N'SKALLESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3140', N'NØTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3141', N'KJØPMANNSKJÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3142', N'VESTSKOGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3143', N'KJØPMANNSKJÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3144', N'VEIERLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3145', N'TJØME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3148', N'HVASSER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3150', N'TOLVSRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3151', N'TOLVSRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3152', N'TOLVSRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3153', N'TOLVSRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3154', N'TOLVSRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3156', N'MELSOMVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3157', N'BARKÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3158', N'ANDEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3159', N'MELSOMVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3160', N'STOKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3161', N'STOKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3162', N'ANDEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3163', N'NØTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3164', N'REVETAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3165', N'TJØME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3166', N'TOLVSRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3167', N'ÅSGÅRDSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3168', N'MELSOMVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3169', N'STOKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3170', N'SEM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3171', N'SEM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3172', N'VEAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3173', N'VEAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3174', N'REVETAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3175', N'RAMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3176', N'UNDRUMSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3177', N'VÅLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3178', N'VÅLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3179', N'ÅSGÅRDSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3180', N'NYKIRKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3181', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3182', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3183', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3184', N'BORRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3185', N'SKOPPUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3186', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3187', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3188', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3189', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3191', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3192', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3193', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3194', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3195', N'SKOPPUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3196', N'HORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3197', N'NYKIRKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3199', N'BORRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3201', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3202', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3203', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3204', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3205', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3206', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3207', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3208', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3209', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3210', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3211', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3212', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3213', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3214', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3215', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3216', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3217', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3218', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3219', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3220', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3221', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3222', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3223', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3224', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3225', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3226', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3227', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3228', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3229', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3230', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3231', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3232', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3233', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3234', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3235', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3236', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3237', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3238', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3239', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3240', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3241', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3242', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3243', N'KODAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3244', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3245', N'KODAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3246', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3247', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3248', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3249', N'SANDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3251', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3252', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3253', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3254', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3255', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3256', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3257', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3258', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3259', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3260', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3261', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3262', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3263', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3264', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3265', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3267', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3268', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3269', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3270', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3271', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3274', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3275', N'SVARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3276', N'SVARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3277', N'STEINSHOLT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3280', N'TJODALYNG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3281', N'TJODALYNG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3282', N'KVELDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3284', N'KVELDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3285', N'LARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3290', N'STAVERN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3291', N'STAVERN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3292', N'STAVERN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3294', N'STAVERN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3295', N'HELGEROA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3296', N'NEVLUNGHAVN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3297', N'HELGEROA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3300', N'HOKKSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3301', N'HOKKSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3302', N'HOKKSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3303', N'HOKKSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3320', N'VESTFOSSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3321', N'VESTFOSSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3322', N'FISKUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3330', N'SKOTSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3331', N'SKOTSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3340', N'ÅMOT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3341', N'ÅMOT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3342', N'ÅMOT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3350', N'PRESTFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3351', N'PRESTFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3355', N'SOLUMSMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3357', N'EGGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3358', N'NEDRE EGGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3359', N'EGGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3360', N'GEITHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3361', N'GEITHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3370', N'VIKERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3371', N'VIKERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3401', N'LIER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3402', N'LIER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3403', N'LIER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3404', N'LIER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3405', N'LIER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3406', N'TRANBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3407', N'TRANBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3408', N'TRANBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3409', N'TRANBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3410', N'SYLLING')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3411', N'SYLLING')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3412', N'LIERSTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3413', N'LIER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3414', N'LIERSTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3420', N'LIERSKOGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3421', N'LIERSKOGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3425', N'REISTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3426', N'GULLAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3427', N'GULLAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3428', N'GULLAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3430', N'SPIKKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3431', N'SPIKKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3440', N'RØYKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3441', N'RØYKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3442', N'HYGGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3470', N'SLEMMESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3471', N'SLEMMESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3472', N'BØDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3474', N'ÅROS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3475', N'SÆTRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3476', N'SÆTRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3477', N'BÅTSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3478', N'NÆRSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3479', N'NÆRSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3480', N'FILTVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3481', N'TOFTE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3482', N'TOFTE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3483', N'KANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3484', N'HOLMSBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3485', N'FILTVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3490', N'KLOKKARSTUA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3501', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3502', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3503', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3504', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3507', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3510', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3511', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3512', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3513', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3514', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3515', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3516', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3517', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3518', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3519', N'HØNEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3520', N'JEVNAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3521', N'JEVNAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3522', N'BJONEROA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3523', N'NES I ÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3524', N'NES I ÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3525', N'HALLINGBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3526', N'HALLINGBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3527', N'BJONEROA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3528', N'HEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3529', N'RØYSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3530', N'RØYSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3531', N'KROKKLEIVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3532', N'TYRISTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3533', N'TYRISTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3534', N'SOKNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3535', N'KRØDEREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3536', N'NORESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3537', N'KRØDEREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3538', N'SOLLIHØGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3539', N'FLÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3540', N'NESBYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3541', N'NESBYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3543', N'NORESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3544', N'TUNHOVD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3545', N'FLÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3550', N'GOL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3551', N'GOL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3560', N'HEMSEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3561', N'HEMSEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3570', N'ÅL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3571', N'ÅL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3575', N'HOL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3576', N'HOL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3577', N'HOVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3579', N'TORPO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3580', N'GEILO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3581', N'GEILO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3588', N'DAGALI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3593', N'USTAOSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3595', N'HAUGASTØL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3601', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3602', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3603', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3604', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3605', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3606', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3607', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3608', N'HEISTADMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3609', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3610', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3611', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3612', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3613', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3614', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3615', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3616', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3617', N'KONGSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3618', N'SKOLLENBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3619', N'SKOLLENBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3620', N'FLESBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3621', N'LAMPELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3622', N'SVENE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3623', N'LAMPELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3624', N'LYNGDAL I NUMEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3625', N'SKOLLENBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3626', N'ROLLAG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3627', N'VEGGLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3628', N'VEGGLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3629', N'NORE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3630', N'RØDBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3631', N'RØDBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3632', N'UVDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3634', N'NORE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3646', N'HVITTINGFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3647', N'HVITTINGFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3648', N'PASSEBEKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3650', N'TINN AUSTBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3652', N'HOVIN I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3656', N'ATRÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3658', N'MILAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3660', N'RJUKAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3661', N'RJUKAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3665', N'SAULAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3666', N'ATRÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3671', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3672', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3673', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3674', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3675', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3676', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3677', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3678', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3679', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3680', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3681', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3683', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3684', N'NOTODDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3690', N'HJARTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3691', N'GRANSHERAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3692', N'SAULAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3697', N'TUDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3701', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3702', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3703', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3704', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3705', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3707', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3710', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3711', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3712', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3713', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3714', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3715', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3716', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3717', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3718', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3719', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3720', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3721', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3722', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3723', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3724', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3725', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3726', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3727', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3728', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3729', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3730', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3731', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3732', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3733', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3734', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3735', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3736', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3737', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3738', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3739', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3740', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3741', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3742', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3743', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3744', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3746', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3747', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3748', N'SILJAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3749', N'SILJAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3750', N'DRANGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3753', N'TØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3760', N'NESLANDSVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3766', N'SANNIDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3770', N'KRAGERØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3772', N'KRAGERØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3780', N'SKÅTØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3781', N'JOMFRULAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3783', N'KRAGERØ SKJÆRGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3785', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3787', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3788', N'STABBESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3789', N'KRAGERØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3790', N'HELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3791', N'KRAGERØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3792', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3793', N'SANNIDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3794', N'HELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3795', N'DRANGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3796', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3798', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3799', N'SKIEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3800', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3801', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3802', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3803', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3804', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3805', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3810', N'GVARV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3811', N'HØRTE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3812', N'AKKERHAUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3820', N'NORDAGUTU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3825', N'LUNDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3830', N'ULEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3831', N'ULEFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3832', N'LUNDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3833', N'BØ I TELEMARK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3834', N'GVARV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3835', N'SELJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3836', N'KVITESEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3840', N'SELJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3841', N'FLATDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3844', N'ÅMOTSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3848', N'MORGEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3849', N'VRÅLIOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3850', N'KVITESEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3852', N'VRÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3853', N'VRÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3854', N'NISSEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3855', N'TREUNGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3864', N'RAULAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3870', N'FYRESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3880', N'DALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3882', N'ÅMDALS VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3883', N'TREUNGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3884', N'RAULAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3885', N'FYRESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3886', N'DALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3887', N'VINJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3888', N'EDLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3890', N'VINJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3891', N'HØYDALSMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3893', N'VINJESVINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3895', N'EDLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3901', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3902', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3903', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3904', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3905', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3906', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3910', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3911', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3912', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3913', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3914', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3915', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3916', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3917', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3918', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3919', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3920', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3921', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3922', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3924', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3925', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3928', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3929', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3930', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3931', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3933', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3936', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3937', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3939', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3940', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3941', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3942', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3943', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3944', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3946', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3947', N'LANGANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3948', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3949', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3950', N'BREVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3960', N'STATHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3961', N'STATHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3962', N'STATHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3965', N'HERRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3966', N'STATHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3967', N'STATHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3970', N'LANGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3991', N'BREVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3993', N'LANGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3994', N'LANGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3995', N'STATHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3996', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3997', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3998', N'PORSGRUNN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'3999', N'HERRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4001', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4002', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4003', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4004', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4005', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4006', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4007', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4008', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4009', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4010', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4011', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4012', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4013', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4014', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4015', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4016', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4017', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4018', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4019', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4020', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4021', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4022', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4023', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4024', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4025', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4026', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4027', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4028', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4029', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4031', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4032', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4033', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4034', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4035', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4036', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4041', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4042', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4043', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4044', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4045', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4046', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4047', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4048', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4049', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4050', N'SOLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4051', N'SOLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4052', N'RØYNEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4053', N'RÆGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4054', N'TJELTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4055', N'SOLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4056', N'TANANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4057', N'TANANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4058', N'TANANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4059', N'RØYNEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4063', N'TJELTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4064', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4065', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4066', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4067', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4068', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4069', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4070', N'RANDABERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4071', N'RANDABERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4072', N'RANDABERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4073', N'RANDABERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4076', N'VASSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4077', N'HUNDVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4078', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4079', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4081', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4082', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4083', N'HUNDVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4084', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4085', N'HUNDVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4086', N'HUNDVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4087', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4088', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4089', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4090', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4091', N'HAFRSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4092', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4093', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4094', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4095', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4096', N'RANDABERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4097', N'SOLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4098', N'TANANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4099', N'STAVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4100', N'JØRPELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4102', N'IDSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4110', N'FORSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4119', N'FORSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4120', N'TAU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4123', N'SØR-HIDLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4124', N'TAU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4126', N'JØRPELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4127', N'LYSEBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4128', N'FLØYRLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4129', N'SONGESAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4130', N'HJELMELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4134', N'JØSENFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4137', N'ÅRDAL I RYFYLKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4139', N'FISTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4146', N'SKIFTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4148', N'HJELMELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4150', N'RENNESØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4152', N'VESTRE ÅMØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4153', N'BRIMSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4154', N'AUSTRE ÅMØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4156', N'MOSTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4158', N'BRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4159', N'RENNESØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4160', N'FINNØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4161', N'FINNØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4163', N'TALGJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4164', N'FOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4167', N'HELGØY I RYFYLKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4168', N'BYRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4169', N'SØRBOKN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4170', N'SJERNARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4173', N'NORD-HIDLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4174', N'SJERNARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4180', N'KVITSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4181', N'KVITSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4182', N'SKARTVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4187', N'OMBO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4198', N'FOLDØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4200', N'SAUDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4201', N'SAUDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4208', N'SAUDASJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4209', N'VANVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4230', N'SAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4233', N'ERFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4234', N'JELSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4235', N'HEBNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4237', N'SULDALSOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4239', N'SAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4240', N'SULDALSOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4244', N'NESFLATEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4250', N'KOPERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4260', N'TORVASTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4262', N'AVALDSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4264', N'KVALAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4265', N'HÅVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4270', N'ÅKREHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4272', N'SANDVE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4274', N'STOL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4275', N'SÆVELANDSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4276', N'VEAVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4280', N'SKUDENESHAVN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4291', N'KOPERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4294', N'KOPERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4295', N'VEAVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4296', N'ÅKREHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4297', N'SKUDENESHAVN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4298', N'TORVASTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4299', N'AVALDSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4301', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4302', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4306', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4307', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4308', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4309', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4310', N'HOMMERSÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4311', N'HOMMERSÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4312', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4313', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4314', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4315', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4316', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4317', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4318', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4319', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4320', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4321', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4322', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4323', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4324', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4325', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4326', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4327', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4328', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4329', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4330', N'ÅLGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4332', N'FIGGJO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4333', N'OLTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4335', N'DIRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4336', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4337', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4338', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4339', N'ÅLGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4340', N'BRYNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4341', N'BRYNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4342', N'UNDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4343', N'ORRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4344', N'BRYNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4345', N'BRYNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4346', N'BRYNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4347', N'LYE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4348', N'LYE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4349', N'BRYNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4352', N'KLEPPE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4353', N'KLEPP STASJON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4354', N'VOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4355', N'KVERNALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4356', N'KVERNALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4357', N'KLEPP STASJON')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4358', N'KLEPPE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4360', N'VARHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4361', N'SIREVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4362', N'VIGRESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4363', N'BRUSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4364', N'SIREVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4365', N'NÆRBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4367', N'NÆRBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4368', N'VARHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4369', N'VIGRESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4370', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4371', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4372', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4373', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4374', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4375', N'HELLVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4376', N'HELLELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4378', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4379', N'EGERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4380', N'HAUGE I DALANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4381', N'HAUGE I DALANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4384', N'VIKESÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4385', N'HELLELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4387', N'BJERKREIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4389', N'VIKESÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4390', N'OLTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4391', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4392', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4393', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4394', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4395', N'HOMMERSÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4396', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4397', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4398', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4399', N'SANDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4400', N'FLEKKEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4401', N'FLEKKEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4402', N'FLEKKEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4403', N'FLEKKEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4420', N'ÅNA-SIRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4432', N'HIDRASUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4434', N'ANDABELØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4436', N'GYLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4438', N'SIRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4439', N'SIRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4440', N'TONSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4441', N'TONSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4443', N'TJØRHOM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4460', N'MOI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4462', N'HOVSHERAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4463', N'UALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4465', N'MOI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4473', N'KVINLOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4480', N'KVINESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4484', N'ØYESTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4485', N'FEDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4490', N'KVINESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4491', N'KVINESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4492', N'KVINESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4501', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4502', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4503', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4504', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4507', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4508', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4509', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4513', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4514', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4515', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4516', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4517', N'MANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4519', N'HOLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4520', N'LINDESNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4521', N'LINDESNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4522', N'LINDESNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4523', N'LINDESNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4524', N'LINDESNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4525', N'KONSMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4526', N'KONSMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4528', N'KOLLUNGTVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4529', N'BYREMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4532', N'ØYSLEBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4534', N'MARNARDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4535', N'MARNARDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4536', N'BJELLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4540', N'ÅSERAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4541', N'ÅSERAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4544', N'FOSSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4550', N'FARSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4551', N'FARSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4552', N'FARSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4553', N'FARSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4554', N'FARSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4557', N'VANSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4558', N'VANSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4560', N'VANSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4563', N'BORHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4575', N'LYNGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4576', N'LYNGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4577', N'LYNGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4579', N'LYNGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4580', N'LYNGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4586', N'KORSHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4588', N'KVÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4590', N'SNARTEMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4595', N'TINGVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4596', N'EIKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4597', N'EIKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4604', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4605', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4606', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4608', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4609', N'KARDEMOMME BY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4610', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4611', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4612', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4613', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4614', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4615', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4616', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4617', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4618', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4619', N'MOSBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4620', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4621', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4622', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4623', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4624', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4625', N'FLEKKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4626', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4628', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4629', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4630', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4631', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4632', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4633', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4634', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4635', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4636', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4637', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4638', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4639', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4640', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4641', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4642', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4643', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4644', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4645', N'NODELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4646', N'FINSLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4647', N'BRENNÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4649', N'FINSLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4656', N'HAMRESANDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4657', N'KJEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4658', N'TVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4661', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4662', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4663', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4664', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4665', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4666', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4670', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4671', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4672', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4673', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4674', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4675', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4676', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4677', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4678', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4679', N'FLEKKERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4681', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4682', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4683', N'SØGNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4684', N'BRENNÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4685', N'NODELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4686', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4687', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4688', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4689', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4691', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4693', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4694', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4695', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4696', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4697', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4698', N'KRISTIANSAND S')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4699', N'TVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4700', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4701', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4702', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4703', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4705', N'ØVREBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4706', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4707', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4708', N'VENNESLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4715', N'ØVREBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4720', N'HÆGELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4721', N'HÆGELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4724', N'IVELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4725', N'IVELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4730', N'VATNESTRØM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4733', N'EVJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4734', N'EVJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4735', N'EVJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4737', N'HORNNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4741', N'BYGLANDSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4742', N'GRENDI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4744', N'BYGLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4745', N'BYGLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4746', N'VALLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4747', N'VALLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4748', N'RYSSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4749', N'RYSSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4754', N'BYKLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4755', N'HOVDEN I SETESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4756', N'HOVDEN I SETESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4760', N'BIRKELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4766', N'HEREFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4768', N'ENGESLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4770', N'HØVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4780', N'BREKKESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4790', N'LILLESAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4791', N'LILLESAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4792', N'LILLESAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4793', N'HØVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4794', N'LILLESAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4795', N'BIRKELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4801', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4802', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4803', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4804', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4808', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4809', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4810', N'EYDEHAVN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4812', N'KONGSHAVN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4815', N'SALTRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4816', N'KOLBJØRNSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4817', N'HIS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4818', N'FÆRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4820', N'FROLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4821', N'RYKENE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4822', N'RYKENE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4823', N'NEDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4824', N'BJORBEKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4825', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4827', N'FROLANDS VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4828', N'MJÅVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4830', N'HYNNEKLEIV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4832', N'MYKLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4834', N'RISDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4836', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4838', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4839', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4841', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4842', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4843', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4844', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4846', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4847', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4848', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4849', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4851', N'SALTRØD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4852', N'FÆRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4853', N'HIS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4854', N'NEDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4855', N'FROLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4856', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4857', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4858', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4859', N'ARENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4862', N'EYDEHAVN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4863', N'NELAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4864', N'ÅMLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4865', N'ÅMLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4868', N'SELÅSVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4869', N'DØLEMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4870', N'FEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4876', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4877', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4878', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4879', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4884', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4885', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4886', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4887', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4888', N'HOMBORSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4889', N'FEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4891', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4892', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4893', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4894', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4896', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4898', N'GRIMSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4900', N'TVEDESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4901', N'TVEDESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4902', N'TVEDESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4909', N'SONGE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4910', N'LYNGØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4912', N'GJEVING')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4915', N'VESTRE SANDØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4916', N'BORØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4920', N'STAUBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4921', N'STAUBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4934', N'NES VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4950', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4951', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4952', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4953', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4955', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4956', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4957', N'RISØR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4971', N'SUNDEBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4972', N'GJERSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4973', N'VEGÅRSHEI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4974', N'SØNDELED')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4980', N'GJERSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4985', N'VEGÅRSHEI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4990', N'SØNDELED')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4993', N'SUNDEBRU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'4994', N'AKLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5003', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5004', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5005', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5006', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5007', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5008', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5009', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5010', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5011', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5012', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5013', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5014', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5015', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5016', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5017', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5018', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5019', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5020', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5021', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5022', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5031', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5032', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5033', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5034', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5035', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5036', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5037', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5038', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5039', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5041', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5042', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5043', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5045', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5052', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5053', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5054', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5055', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5056', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5057', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5058', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5059', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5063', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5067', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5068', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5072', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5073', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5075', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5081', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5082', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5089', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5093', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5094', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5096', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5097', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5098', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5099', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5101', N'EIDSVÅGNESET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5104', N'EIDSVÅG I ÅSANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5105', N'EIDSVÅG I ÅSANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5106', N'ØVRE ERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5107', N'SALHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5108', N'HORDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5109', N'HYLKJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5111', N'BREISTEIN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5113', N'TERTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5114', N'TERTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5115', N'ULSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5116', N'ULSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5117', N'ULSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5118', N'ULSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5119', N'ULSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5121', N'ULSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5122', N'MORVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5124', N'MORVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5130', N'NYBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5131', N'NYBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5132', N'NYBORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5134', N'FLAKTVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5135', N'FLAKTVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5136', N'MJØLKERÅEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5137', N'MJØLKERÅEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5141', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5142', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5143', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5144', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5145', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5146', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5147', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5148', N'FYLLINGSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5151', N'STRAUMSGREND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5152', N'BØNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5153', N'BØNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5154', N'BØNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5155', N'BØNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5160', N'LAKSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5161', N'LAKSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5162', N'LAKSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5163', N'LAKSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5164', N'LAKSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5165', N'LAKSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5170', N'BJØRNDALSTRÆ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5171', N'LODDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5172', N'LODDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5173', N'LODDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5174', N'MATHOPEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5176', N'LODDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5177', N'BJØRØYHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5178', N'LODDEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5179', N'GODVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5183', N'OLSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5184', N'OLSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5200', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5201', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5202', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5203', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5206', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5207', N'SØFTELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5208', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5209', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5210', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5211', N'OS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5212', N'SØFTELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5213', N'LEPSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5214', N'LYSEKLOSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5215', N'LYSEKLOSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5216', N'LEPSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5217', N'HAGAVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5218', N'NORDSTRØNO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5221', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5222', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5223', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5224', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5225', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5226', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5227', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5228', N'NESTTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5229', N'KALANDSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5230', N'PARADIS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5231', N'PARADIS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5232', N'PARADIS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5235', N'RÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5236', N'RÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5237', N'RÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5238', N'RÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5239', N'RÅDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5243', N'FANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5244', N'FANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5251', N'SØREIDGREND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5252', N'SØREIDGREND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5253', N'SANDSLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5254', N'SANDSLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5257', N'KOKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5258', N'BLOMSTERDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5259', N'HJELLESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5260', N'INDRE ARNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5261', N'INDRE ARNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5262', N'ARNATVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5263', N'TRENGEREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5264', N'GARNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5265', N'YTRE ARNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5267', N'ESPELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5268', N'HAUKELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5281', N'VALESTRANDSFOSSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5282', N'LONEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5283', N'FOTLANDSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5284', N'TYSSEBOTNEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5285', N'BRUVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5286', N'HAUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5291', N'VALESTRANDSFOSSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5293', N'LONEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5299', N'HAUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5300', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5301', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5302', N'STRUSSHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5303', N'FOLLESE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5304', N'HETLEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5305', N'FLORVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5306', N'ERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5307', N'ASK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5308', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5309', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5310', N'HAUGLANDSHELLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5311', N'KJERRGARDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5314', N'KJERRGARDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5315', N'HERDLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5318', N'STRUSSHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5319', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5321', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5322', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5323', N'KLEPPESTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5325', N'FOLLESE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5326', N'ASK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5327', N'HAUGLANDSHELLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5329', N'FLORVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5331', N'RONG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5333', N'TJELDSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5334', N'HELLESØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5335', N'HERNAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5336', N'TJELDSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5337', N'RONG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5341', N'STRAUME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5342', N'STRAUME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5343', N'STRAUME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5345', N'KNARREVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5346', N'ÅGOTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5347', N'ÅGOTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5350', N'BRATTHOLMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5353', N'STRAUME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5354', N'STRAUME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5355', N'KNARREVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5357', N'FJELL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5358', N'FJELL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5360', N'KOLLTVEIT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5363', N'ÅGOTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5365', N'TURØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5366', N'MISJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5371', N'SKOGSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5374', N'STEINSLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5378', N'KLOKKARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5379', N'STEINSLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5380', N'TÆLAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5381', N'GLESVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5382', N'SKOGSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5384', N'TORANGSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5385', N'BAKKASUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5387', N'MØKSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5388', N'LITLAKALSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5392', N'STOREBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5393', N'STOREBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5394', N'KOLBEINSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5396', N'VESTRE VINNESVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5397', N'BEKKJARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5398', N'STOLMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5399', N'BEKKJARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5401', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5402', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5403', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5404', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5406', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5407', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5408', N'SAGVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5409', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5410', N'SAGVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5411', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5412', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5413', N'HUGLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5414', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5415', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5416', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5417', N'STORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5418', N'FITJAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5419', N'FITJAR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5420', N'RUBBESTADNESET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5423', N'BRANDASUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5427', N'URANGSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5428', N'FOLDRØYHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5430', N'BREMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5437', N'FINNÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5440', N'MOSTERHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5443', N'BØMLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5444', N'ESPEVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5445', N'BREMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5447', N'MOSTERHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5449', N'BØMLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5450', N'SUNDE I SUNNHORDLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5451', N'VALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5452', N'SANDVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5453', N'UTÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5454', N'SÆBØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5455', N'HALSNØY KLOSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5457', N'HØYLANDSBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5458', N'ARNAVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5459', N'FJELBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5460', N'HUSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5462', N'HERØYSUNDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5463', N'USKEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5464', N'DIMMELSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5465', N'USKEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5470', N'ROSENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5472', N'SEIMSFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5473', N'SNILSTVEITØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5474', N'LØFALLSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5475', N'ÆNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5476', N'MAURANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5480', N'HUSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5484', N'SÆBØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5486', N'ROSENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5498', N'MATRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5499', N'ÅKRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5501', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5502', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5503', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5504', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5505', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5506', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5507', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5508', N'KARMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5509', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5511', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5512', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5514', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5515', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5516', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5517', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5518', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5519', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5521', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5522', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5523', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5525', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5527', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5528', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5529', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5531', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5532', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5533', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5534', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5535', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5536', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5537', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5538', N'HAUGESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5541', N'KOLNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5542', N'KARMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5544', N'VORMEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5545', N'VORMEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5546', N'RØYKSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5547', N'UTSIRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5548', N'FEØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5549', N'RØVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5550', N'SVEIO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5551', N'AUKLANDSHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5554', N'VALEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5555', N'FØRDE I HORDALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5556', N'FØRDE I HORDALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5559', N'SVEIO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5560', N'NEDSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5561', N'BOKN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5562', N'NEDSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5563', N'FØRRESFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5565', N'TYSVÆRVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5566', N'HERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5567', N'SKJOLDASTRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5568', N'VIKEBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5569', N'BOKN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5570', N'AKSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5574', N'SKJOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5575', N'AKSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5576', N'ØVRE VATS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5578', N'NEDRE VATS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5580', N'ØLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5582', N'ØLENSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5583', N'VIKEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5584', N'BJOA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5585', N'SANDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5586', N'VIKEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5588', N'ØLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5589', N'SANDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5590', N'ETNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5591', N'ETNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5593', N'SKÅNEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5594', N'SKÅNEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5595', N'FØRRESFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5596', N'MARKHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5598', N'FJÆRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5600', N'NORHEIMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5601', N'NORHEIMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5602', N'NORHEIMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5604', N'ØYSTESE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5605', N'ÅLVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5610', N'ØYSTESE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5612', N'STEINSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5614', N'ÅLVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5620', N'TØRVIKBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5626', N'KYSNESSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5627', N'JONDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5628', N'HERAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5629', N'JONDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5630', N'STRANDEBARM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5631', N'STRANDEBARM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5632', N'OMASTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5633', N'OMASTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5635', N'HATLESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5636', N'VARALDSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5637', N'ØLVE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5640', N'EIKELANDSOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5641', N'FUSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5642', N'HOLMEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5643', N'STRANDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5644', N'SÆVAREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5645', N'SÆVAREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5646', N'NORDTVEITGREND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5647', N'BALDERSHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5648', N'FUSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5649', N'EIKELANDSOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5650', N'TYSSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5651', N'TYSSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5652', N'ÅRLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5653', N'ÅRLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5680', N'TYSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5683', N'REKSTEREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5685', N'UGGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5687', N'FLATRÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5690', N'LUNDEGREND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5693', N'ÅRBAKKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5694', N'ONARHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5695', N'UGGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5696', N'TYSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5700', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5701', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5702', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5703', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5704', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5705', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5706', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5707', N'EVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5708', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5709', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5710', N'SKULESTADMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5711', N'SKULESTADMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5712', N'VOSSESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5713', N'VOSSESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5714', N'VOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5715', N'STALHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5718', N'MYRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5719', N'FINSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5720', N'STANGHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5721', N'DALEKVAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5722', N'DALEKVAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5723', N'BOLSTADØYRI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5724', N'STANGHELLE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5725', N'VAKSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5726', N'VAKSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5727', N'STAMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5728', N'EIDSLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5729', N'MODALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5730', N'ULVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5731', N'ULVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5732', N'MODALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5733', N'GRANVIN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5734', N'VALLAVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5736', N'GRANVIN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5741', N'AURLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5742', N'FLÅM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5743', N'FLÅM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5745', N'AURLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5746', N'UNDREDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5747', N'GUDVANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5748', N'STYVI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5750', N'ODDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5751', N'ODDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5752', N'ODDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5760', N'RØLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5763', N'SKARE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5770', N'TYSSEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5773', N'HOVLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5775', N'NÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5776', N'NÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5777', N'GRIMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5778', N'UTNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5779', N'UTNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5780', N'KINSARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5781', N'LOFTHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5782', N'KINSARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5783', N'EIDFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5784', N'ØVRE EIDFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5785', N'VØRINGSFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5786', N'EIDFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5787', N'LOFTHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5788', N'KINSARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5802', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5803', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5804', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5805', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5806', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5807', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5808', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5809', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5810', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5811', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5812', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5813', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5814', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5815', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5816', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5817', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5818', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5819', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5820', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5821', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5822', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5823', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5824', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5825', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5826', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5827', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5828', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5829', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5830', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5831', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5832', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5833', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5834', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5835', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5836', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5837', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5838', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5841', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5843', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5844', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5845', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5847', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5848', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5849', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5851', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5852', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5853', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5854', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5855', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5857', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5858', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5859', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5861', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5862', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5863', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5864', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5865', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5866', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5867', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5868', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5869', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5872', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5873', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5876', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5877', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5878', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5879', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5881', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5884', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5886', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5887', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5888', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5889', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5892', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5893', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5895', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5896', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5899', N'BERGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5902', N'ISDALSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5903', N'ISDALSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5904', N'ISDALSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5906', N'FREKHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5907', N'ALVERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5908', N'ISDALSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5911', N'ALVERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5912', N'SEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5913', N'EIKANGERVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5914', N'ISDALSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5915', N'HJELMÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5916', N'ISDALSTØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5917', N'ROSSLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5918', N'FREKHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5919', N'FREKHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5931', N'MANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5935', N'BØVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5936', N'MANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5937', N'BØVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5938', N'SÆBØVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5939', N'SLETTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5941', N'AUSTRHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5943', N'AUSTRHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5947', N'FEDJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5948', N'FEDJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5951', N'LINDÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5952', N'FONNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5953', N'FONNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5954', N'MONGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5955', N'LINDÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5956', N'HUNDVIN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5957', N'MYKING')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5960', N'DALSØYRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5961', N'BREKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5962', N'BJORDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5963', N'DALSØYRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5964', N'BREKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5965', N'BJORDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5966', N'EIVINDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5967', N'EIVINDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5970', N'BYRKNESØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5977', N'ÅNNELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5978', N'MJØMNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5979', N'BYRKNESØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5981', N'MASFJORDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5982', N'MASFJORDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5983', N'HAUGSVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5984', N'MATREDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5985', N'HAUGSVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5986', N'HOSTELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5987', N'HOSTELAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5991', N'OSTEREIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5993', N'OSTEREIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'5994', N'VIKANES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6001', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6002', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6003', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6004', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6005', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6006', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6007', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6008', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6009', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6010', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6011', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6012', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6013', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6014', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6015', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6016', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6017', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6018', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6019', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6020', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6021', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6022', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6023', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6024', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6025', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6026', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6028', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6030', N'LANGEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6034', N'EIDSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6035', N'FISKARSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6036', N'MAUSEIDVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6037', N'EIDSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6038', N'FISKARSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6039', N'LANGEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6040', N'VIGRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6044', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6045', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6046', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6047', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6048', N'ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6050', N'VALDERØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6051', N'VALDERØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6052', N'GISKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6054', N'GODØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6055', N'GODØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6057', N'ELLINGSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6058', N'VALDERØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6059', N'VIGRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6060', N'HAREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6062', N'BRANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6063', N'HJØRUNGAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6064', N'HADDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6065', N'ULSTEINVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6067', N'ULSTEINVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6068', N'EIKSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6069', N'HAREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6070', N'TJØRVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6075', N'MOLTUSTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6076', N'MOLTUSTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6078', N'GJERDSVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6079', N'GURSKØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6080', N'GURSKØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6082', N'GURSKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6083', N'GJERDSVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6084', N'LARSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6085', N'LARSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6086', N'KVAMSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6087', N'KVAMSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6088', N'SANDSHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6089', N'SANDSHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6090', N'FOSNAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6091', N'FOSNAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6092', N'FOSNAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6094', N'LEINØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6095', N'BØLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6096', N'RUNDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6098', N'NERLANDSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6099', N'FOSNAVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6100', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6101', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6102', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6103', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6104', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6105', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6106', N'VOLDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6110', N'AUSTEFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6120', N'FOLKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6133', N'LAUVSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6134', N'LAUVSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6138', N'SYVDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6139', N'FISKÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6140', N'SYVDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6141', N'ROVDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6142', N'EIDSÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6143', N'FISKÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6144', N'SYLTE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6146', N'ÅHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6147', N'ÅHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6149', N'ÅRAM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6150', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6151', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6152', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6153', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6154', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6155', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6156', N'ØRSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6160', N'HOVDEBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6161', N'HOVDEBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6165', N'SÆBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6166', N'SÆBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6170', N'VARTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6171', N'VARTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6174', N'BARSTADVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6183', N'TRANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6184', N'STORESTANDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6190', N'BJØRKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6196', N'NORANGSFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6200', N'STRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6201', N'STRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6210', N'VALLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6211', N'VALLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6212', N'LIABYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6213', N'TAFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6214', N'NORDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6215', N'EIDSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6216', N'GEIRANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6217', N'GEIRANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6218', N'HELLESYLT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6219', N'HELLESYLT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6220', N'STRAUMGJERDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6222', N'IKORNNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6223', N'IKORNNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6224', N'HUNDEIDVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6230', N'SYKKYLVEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6238', N'STRAUMGJERDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6239', N'SYKKYLVEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6240', N'ØRSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6249', N'ØRSKOG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6250', N'STORDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6255', N'EIDSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6259', N'STORDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6260', N'SKODJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6263', N'SKODJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6264', N'TENNFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6265', N'VATNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6270', N'BRATTVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6272', N'HILDRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6280', N'SØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6281', N'SØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6282', N'BRATTVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6283', N'VATNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6285', N'STOREKALVØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6290', N'HARAMSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6291', N'HARAMSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6292', N'KJERSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6293', N'LONGVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6294', N'FJØRTOFT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6300', N'ÅNDALSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6301', N'ÅNDALSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6310', N'VEBLUNGSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6315', N'INNFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6320', N'ISFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6330', N'VERMA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6331', N'VERMA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6339', N'ISFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6350', N'EIDSBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6360', N'ÅFARNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6361', N'ÅFARNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6363', N'MITTET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6364', N'VISTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6365', N'VISTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6385', N'MÅNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6386', N'MÅNDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6387', N'VÅGSTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6388', N'VÅGSTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6389', N'FIKSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6390', N'VESTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6391', N'TRESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6392', N'VIKEBUKT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6393', N'TOMREFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6394', N'FIKSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6395', N'REKDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6396', N'VIKEBUKT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6397', N'TRESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6398', N'TOMREFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6399', N'VESTNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6401', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6402', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6403', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6404', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6405', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6407', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6408', N'AUREOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6409', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6410', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6411', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6412', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6413', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6414', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6415', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6416', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6418', N'SEKKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6419', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6421', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6422', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6423', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6425', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6429', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6430', N'BUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6431', N'BUD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6433', N'HUSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6434', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6435', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6436', N'MOLDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6440', N'ELNESVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6443', N'TORNES I ROMSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6444', N'FARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6445', N'MALMEFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6446', N'FARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6447', N'ELNESVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6450', N'HJELSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6452', N'KLEIVE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6453', N'KLEIVE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6454', N'HJELSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6455', N'KORTGARDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6456', N'SKÅLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6457', N'BOLSØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6458', N'SKÅLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6460', N'EIDSVÅG I ROMSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6461', N'EIDSVÅG I ROMSDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6462', N'RAUDSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6470', N'ERESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6471', N'ERESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6472', N'EIKESDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6475', N'MIDSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6476', N'MIDSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6480', N'AUKRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6481', N'AUKRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6483', N'ONA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6484', N'SANDØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6485', N'HARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6486', N'ORTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6487', N'HARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6488', N'MYKLEBOST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6490', N'EIDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6493', N'LYNGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6494', N'VEVANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6499', N'EIDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6501', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6502', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6503', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6504', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6506', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6507', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6508', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6509', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6510', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6511', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6512', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6514', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6515', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6516', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6517', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6518', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6520', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6521', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6522', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6523', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6524', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6525', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6527', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6528', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6529', N'FREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6530', N'AVERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6531', N'AVERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6532', N'AVERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6533', N'AVERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6538', N'AVERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6539', N'AVERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6546', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6547', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6548', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6549', N'KRISTIANSUND N')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6570', N'SMØLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6571', N'SMØLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6590', N'TUSTNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6591', N'TUSTNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6600', N'SUNNDALSØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6601', N'SUNNDALSØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6610', N'ØKSENDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6611', N'FURUGRENDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6612', N'GRØA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6613', N'GJØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6614', N'GJØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6620', N'ÅLVUNDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6622', N'ÅLVUNDFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6623', N'ÅLVUNDFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6627', N'TINGVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6628', N'MEISINGSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6629', N'TORJULVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6630', N'TINGVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6631', N'BATNFJORDSØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6632', N'BATNFJORDSØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6633', N'GJEMNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6636', N'ANGVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6637', N'FLEMMA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6638', N'OSMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6639', N'TORVIKBUKT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6640', N'KVANNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6641', N'TORVIKBUKT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6642', N'STANGVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6643', N'BØFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6644', N'BÆVERFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6645', N'TODALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6650', N'SURNADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6652', N'SURNADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6653', N'ØVRE SURNADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6655', N'VINDØLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6656', N'SURNADAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6657', N'RINDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6658', N'RINDALSSKOGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6659', N'RINDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6670', N'ØYDEGARD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6671', N'ØYDEGARD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6674', N'KVISVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6680', N'HALSANAUSTAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6683', N'VÅGLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6686', N'VALSØYBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6687', N'VALSØYFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6688', N'VÅGLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6689', N'AURE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6690', N'AURE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6693', N'MJOSUNDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6694', N'FOLDFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6697', N'VIHALS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6698', N'LESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6699', N'KJØRSVIKBUGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6700', N'MÅLØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6701', N'MÅLØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6702', N'MÅLØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6703', N'MÅLØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6704', N'DEKNEPOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6707', N'RAUDEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6708', N'BRYGGJA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6710', N'RAUDEBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6711', N'BRYGGJA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6713', N'ALMENNINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6714', N'SILDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6715', N'BARMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6716', N'HUSEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6717', N'FLATRAKET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6718', N'DEKNEPOLLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6719', N'SKATESTRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6721', N'SVELGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6723', N'SVELGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6726', N'BREMANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6727', N'BREMANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6728', N'KALVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6729', N'KALVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6730', N'DAVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6734', N'RUGSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6737', N'ÅLFOTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6740', N'SELJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6741', N'SELJE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6750', N'STADLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6751', N'STADLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6761', N'HORNINDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6763', N'HORNINDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6770', N'NORDFJORDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6771', N'NORDFJORDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6772', N'NORDFJORDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6773', N'NORDFJORDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6774', N'NORDFJORDEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6776', N'KJØLSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6777', N'STÅRHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6778', N'LOTE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6779', N'HOLMØYANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6781', N'STRYN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6782', N'STRYN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6783', N'STRYN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6784', N'OLDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6788', N'OLDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6789', N'LOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6790', N'LOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6791', N'OLDEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6792', N'BRIKSDALSBRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6793', N'INNVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6794', N'INNVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6795', N'BLAKSÆTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6796', N'HOPLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6797', N'UTVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6798', N'HJELLEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6799', N'OPPSTRYN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6800', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6801', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6802', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6803', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6804', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6805', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6806', N'NAUSTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6807', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6808', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6809', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6810', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6811', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6812', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6813', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6814', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6815', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6817', N'NAUSTDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6818', N'HAUKEDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6819', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6820', N'FØRDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6821', N'SANDANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6822', N'SANDANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6823', N'SANDANE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6826', N'BYRKJELO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6827', N'BREIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6828', N'HESTENESØYRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6829', N'HYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6830', N'BYRKJELO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6831', N'HYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6841', N'SKEI I JØLSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6843', N'SKEI I JØLSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6844', N'VASSENDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6845', N'FJÆRLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6847', N'VASSENDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6848', N'FJÆRLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6849', N'KAUPANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6851', N'SOGNDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6852', N'SOGNDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6853', N'SOGNDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6854', N'KAUPANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6855', N'FRØNNINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6856', N'SOGNDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6858', N'FARDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6859', N'SLINDE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6861', N'LEIKANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6863', N'LEIKANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6866', N'GAUPNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6867', N'HAFSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6868', N'GAUPNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6869', N'HAFSLO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6870', N'ORNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6871', N'JOSTEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6872', N'LUSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6873', N'MARIFJØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6874', N'LUSTER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6875', N'HØYHEIMSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6876', N'SKJOLDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6877', N'FORTUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6878', N'VEITASTROND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6879', N'SOLVORN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6881', N'ÅRDALSTANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6882', N'ØVRE ÅRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6884', N'ØVRE ÅRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6885', N'ÅRDALSTANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6886', N'LÆRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6887', N'LÆRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6888', N'BORGUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6891', N'VIK I SOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6893', N'VIK I SOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6894', N'VANGSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6895', N'FEIOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6896', N'FRESVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6898', N'BALESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6899', N'BALESTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6900', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6901', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6902', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6903', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6905', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6906', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6907', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6908', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6909', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6910', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6912', N'KINN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6913', N'FLORØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6914', N'SVANØYBUKT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6915', N'ROGNALDSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6916', N'BAREKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6917', N'BATALDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6918', N'SØR-SKORPA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6919', N'TANSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6921', N'HARDBAKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6924', N'HARDBAKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6926', N'KRAKHELLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6927', N'YTRØYGREND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6928', N'KOLGROV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6929', N'HERSVIKBYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6940', N'EIKEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6941', N'EIKEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6942', N'SVORTEVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6944', N'STAVANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6946', N'LAVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6947', N'LAVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6951', N'LEIRVIK I SOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6953', N'LEIRVIK I SOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6957', N'HYLLESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6958', N'SØRBØVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6959', N'SØRBØVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6961', N'DALE I SUNNFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6963', N'DALE I SUNNFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6964', N'KORSSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6966', N'GUDDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6967', N'HELLEVIK I FJALER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6968', N'FLEKKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6969', N'STRAUMSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6971', N'SANDE I SUNNFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6973', N'SANDE I SUNNFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6975', N'SKILBREI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6976', N'BYGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6977', N'BYGSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6978', N'VIKSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6980', N'ASKVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6982', N'HOLMEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6983', N'KVAMMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6984', N'STONGFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6985', N'ATLØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6986', N'VÆRLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6987', N'BULANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6988', N'ASKVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6991', N'HØYANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6993', N'HØYANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6995', N'KYRKJEBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6996', N'VADHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'6997', N'VADHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7003', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7004', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7005', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7006', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7010', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7011', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7012', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7013', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7014', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7015', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7016', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7017', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7018', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7019', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7020', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7021', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7022', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7023', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7024', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7025', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7026', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7027', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7028', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7029', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7030', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7031', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7032', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7033', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7034', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7035', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7036', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7037', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7038', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7039', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7040', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7041', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7042', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7043', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7044', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7045', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7046', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7047', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7048', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7049', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7050', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7051', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7052', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7053', N'RANHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7054', N'RANHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7055', N'RANHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7056', N'RANHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7057', N'JONSVATNET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7058', N'JAKOBSLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7059', N'JAKOBSLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7066', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7067', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7068', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7069', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7070', N'BOSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7071', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7072', N'HEIMDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7074', N'SPONGDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7075', N'TILLER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7078', N'SAUPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7079', N'FLATÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7080', N'HEIMDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7081', N'SJETNEMARKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7082', N'KATTEM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7083', N'LEINSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7088', N'HEIMDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7089', N'HEIMDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7091', N'TILLER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7092', N'TILLER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7093', N'TILLER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7097', N'SAUPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7098', N'SAUPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7099', N'FLATÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7100', N'RISSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7101', N'RISSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7105', N'STADSBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7110', N'FEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7111', N'HASSELVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7112', N'HASSELVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7113', N'HUSBYSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7114', N'RÅKVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7115', N'HUSBYSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7116', N'RÅKVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7119', N'STADSBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7120', N'LEKSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7121', N'LEKSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7125', N'VANVIKAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7126', N'VANVIKAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7127', N'OPPHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7129', N'BREKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7130', N'BREKSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7140', N'OPPHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7142', N'UTHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7150', N'STORFOSNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7151', N'STORFOSNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7152', N'KRÅKVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7153', N'GARTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7156', N'LEKSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7159', N'BJUGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7160', N'BJUGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7164', N'LYSØYSUNDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7165', N'OKSVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7166', N'TARVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7167', N'VALLERSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7168', N'LYSØYSUNDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7169', N'ÅFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7170', N'ÅFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7174', N'REVSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7175', N'STOKKØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7176', N'LINESØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7177', N'REVSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7178', N'STOKKØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7180', N'ROAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7181', N'ROAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7190', N'BESSAKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7194', N'BRANDSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7200', N'KYRKSÆTERØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7201', N'KYRKSÆTERØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7203', N'VINJEØRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7206', N'HELLANDSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7211', N'KORSVEGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7212', N'KORSVEGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7213', N'GÅSBAKKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7221', N'MELHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7223', N'MELHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7224', N'MELHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7227', N'GIMSE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7228', N'KVÅL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7231', N'LUNDAMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7232', N'LUNDAMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7234', N'LER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7235', N'LER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7236', N'HOVIN I GAULDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7238', N'HOVIN I GAULDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7239', N'HITRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7240', N'HITRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7241', N'ANSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7242', N'KNARRLAGSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7243', N'KVENVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7244', N'KNARRLAGSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7245', N'KVENVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7246', N'SANDSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7247', N'HESTVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7250', N'MELANDSJØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7252', N'DOLMØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7255', N'SUNDLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7256', N'HEMNSKJELA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7257', N'SNILLFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7259', N'SNILLFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7260', N'SISTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7261', N'SISTRANDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7263', N'HAMARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7264', N'HAMARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7266', N'KVERVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7267', N'KVERVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7268', N'TITRAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7270', N'DYRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7273', N'NORDDYRØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7274', N'NORDDYRØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7280', N'SULA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7282', N'BOGØYVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7284', N'MAUSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7285', N'GJÆSINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7286', N'SØRBURØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7287', N'SAUØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7288', N'SOKNEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7289', N'SOKNEDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7290', N'STØREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7291', N'STØREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7295', N'ROGNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7298', N'BUDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7300', N'ORKANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7301', N'ORKANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7302', N'ORKANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7310', N'GJØLME')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7315', N'LENSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7316', N'LENSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7318', N'AGDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7319', N'AGDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7320', N'FANNREM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7321', N'FANNREM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7327', N'SVORKMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7329', N'SVORKMO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7331', N'LØKKEN VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7332', N'LØKKEN VERK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7333', N'STORÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7334', N'STORÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7335', N'JERPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7336', N'MELDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7338', N'MELDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7340', N'OPPDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7341', N'OPPDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7342', N'LØNSET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7343', N'VOGNILL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7345', N'DRIVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7350', N'BUVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7351', N'BUVIKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7353', N'BØRSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7354', N'VIGGJA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7355', N'EGGKLEIVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7356', N'SKAUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7357', N'SKAUN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7358', N'BØRSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7361', N'RØROS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7370', N'BREKKEBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7372', N'GLÅMOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7374', N'RØROS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7380', N'ÅLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7383', N'HALTDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7384', N'ÅLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7386', N'SINGSÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7387', N'SINGSÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7388', N'SINGSÅS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7391', N'RENNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7392', N'RENNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7393', N'RENNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7397', N'RENNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7398', N'RENNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7399', N'RENNEBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7400', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7401', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7402', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7403', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7404', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7405', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7406', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7407', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7408', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7409', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7410', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7411', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7412', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7413', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7414', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7415', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7416', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7417', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7418', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7419', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7420', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7421', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7422', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7424', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7425', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7426', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7427', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7428', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7429', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7430', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7431', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7432', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7433', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7434', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7435', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7436', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7437', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7438', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7439', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7440', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7441', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7442', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7443', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7444', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7445', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7446', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7447', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7448', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7449', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7450', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7451', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7452', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7453', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7454', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7455', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7456', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7457', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7458', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7459', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7462', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7463', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7464', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7465', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7466', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7467', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7468', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7469', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7470', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7471', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7472', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7473', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7474', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7475', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7476', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7477', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7478', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7479', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7480', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7481', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7482', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7483', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7484', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7485', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7486', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7487', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7488', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7489', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7490', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7491', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7492', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7493', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7494', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7495', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7496', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7497', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7498', N'TRONDHEIM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7500', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7501', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7502', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7503', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7504', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7505', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7506', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7507', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7508', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7509', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7510', N'SKATVAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7511', N'SKATVAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7512', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7513', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7514', N'STJØRDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7517', N'HELL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7519', N'ELVARLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7520', N'HEGRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7525', N'FLORNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7529', N'HEGRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7530', N'MERÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7531', N'MERÅKER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7533', N'KOPPERÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7540', N'KLÆBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7541', N'KLÆBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7549', N'TANEM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7550', N'HOMMELVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7551', N'HOMMELVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7560', N'VIKHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7562', N'SAKSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7563', N'MALVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7566', N'VIKHAMMER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7570', N'HELL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7580', N'SELBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7581', N'SELBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7583', N'SELBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7584', N'SELBUSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7590', N'TYDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7591', N'TYDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7596', N'FLAKNAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7600', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7601', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7602', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7603', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7604', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7605', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7606', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7607', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7608', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7609', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7610', N'LEVANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7619', N'SKOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7620', N'SKOGN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7622', N'MARKABYGDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7623', N'RONGLAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7624', N'EKNE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7629', N'YTTERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7630', N'ÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7631', N'ÅSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7632', N'ÅSENFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7633', N'FROSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7634', N'FROSTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7650', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7651', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7652', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7653', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7654', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7655', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7656', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7657', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7658', N'VERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7660', N'VUKU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7661', N'VUKU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7670', N'INDERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7671', N'INDERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7672', N'INDERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7690', N'MOSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7691', N'MOSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7701', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7702', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7703', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7704', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7705', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7707', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7708', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7709', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7710', N'SPARBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7711', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7712', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7713', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7714', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7715', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7716', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7717', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7718', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7724', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7725', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7726', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7729', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7730', N'BEITSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7732', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7733', N'SPARBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7734', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7735', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7736', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7737', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7738', N'STEINKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7739', N'BEITSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7740', N'STEINSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7741', N'STEINSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7742', N'YTTERVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7744', N'HEPSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7745', N'OPPLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7746', N'HASVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7748', N'SÆTERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7750', N'NAMDALSEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7751', N'NAMDALSEID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7760', N'SNÅSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7761', N'SNÅSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7770', N'FLATANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7771', N'FLATANGER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7777', N'NORD-STATLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7790', N'MALM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7791', N'MALM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7795', N'FOLLAFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7796', N'FOLLAFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7797', N'VERRABOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7800', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7801', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7802', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7803', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7804', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7805', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7808', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7810', N'NAMSOS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7817', N'SALSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7818', N'LUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7819', N'FOSSLANDSOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7820', N'SPILLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7821', N'SPILLUM')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7822', N'BANGSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7823', N'BANGSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7856', N'JØA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7860', N'SKAGE I NAMDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7863', N'OVERHALLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7864', N'OVERHALLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7869', N'SKAGE I NAMDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7870', N'GRONG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7871', N'GRONG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7873', N'HARRAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7874', N'HARRAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7876', N'KONGSMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7877', N'HØYLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7878', N'HØYLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7881', N'NORDLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7882', N'NORDLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7884', N'SØRLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7885', N'SØRLI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7890', N'NAMSSKOGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7891', N'NAMSSKOGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7892', N'TRONES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7893', N'SKOROVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7896', N'BREKKVASSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7897', N'LIMINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7898', N'LIMINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7900', N'RØRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7901', N'RØRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7902', N'RØRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7940', N'OTTERSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7941', N'OTTERSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7944', N'INDRE NÆRØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7950', N'ABELVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7960', N'SALSBRUKET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7970', N'KOLVEREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7971', N'KOLVEREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7973', N'GJERDINGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7979', N'TERRÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7980', N'TERRÅK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7981', N'HARANGSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7982', N'BINDALSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7983', N'BINDALSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7985', N'FOLDEREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7986', N'FOLDEREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7990', N'NAUSTBUKTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7993', N'GUTVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7994', N'LEKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'7995', N'LEKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8001', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8002', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8003', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8004', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8005', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8006', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8007', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8008', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8009', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8010', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8011', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8012', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8013', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8014', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8015', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8016', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8019', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8020', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8021', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8022', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8023', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8026', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8027', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8028', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8029', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8030', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8031', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8037', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8038', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8041', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8047', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8048', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8049', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8050', N'TVERLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8056', N'SALTSTRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8057', N'SALTSTRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8058', N'TVERLANDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8062', N'VÆRØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8063', N'VÆRØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8064', N'RØST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8065', N'RØST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8070', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8071', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8072', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8073', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8074', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8075', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8076', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8079', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8084', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8086', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8087', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8088', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8089', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8091', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8092', N'BODØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8093', N'KJERRINGØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8094', N'FLEINVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8095', N'HELLIGVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8096', N'BLIKSVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8097', N'GIVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8098', N'LANDEGODE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8099', N'JAN MAYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8100', N'MISVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8102', N'SKJERSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8103', N'BREIVIK I SALTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8108', N'MISVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8110', N'MOLDJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8114', N'TOLLÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8118', N'MOLDJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8120', N'NYGÅRDSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8128', N'YTRE BEIARN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8130', N'SANDHORNØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8134', N'SØRARNØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8135', N'SØRARNØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8136', N'NORDARNØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8138', N'INNDYR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8140', N'INNDYR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8145', N'STORVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8146', N'REIPÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8149', N'NEVERDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8150', N'ØRNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8151', N'ØRNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8157', N'MELØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8158', N'BOLGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8159', N'STØTT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8160', N'GLOMFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8161', N'GLOMFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8168', N'ENGAVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8170', N'ENGAVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8178', N'HALSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8179', N'HALSA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8181', N'MYKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8182', N'MELFJORDBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8183', N'VÅGAHOLMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8184', N'ÅGSKARDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8185', N'VÅGAHOLMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8186', N'TJONGSFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8187', N'JEKTVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8188', N'NORDVERNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8189', N'GJERSVIKGRENDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8190', N'SØRFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8193', N'RØDØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8195', N'GJERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8196', N'SELSØYVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8197', N'STORSELSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8198', N'NORDNESØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8200', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8201', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8202', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8203', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8205', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8206', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8207', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8208', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8209', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8210', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8211', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8214', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8215', N'VALNESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8218', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8219', N'FAUSKE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8220', N'RØSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8226', N'STRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8230', N'SULITJELMA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8231', N'SULITJELMA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8232', N'STRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8233', N'VALNESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8250', N'ROGNAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8251', N'ROGNAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8255', N'RØKLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8256', N'RØKLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8260', N'INNHAVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8261', N'INNHAVET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8264', N'ENGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8266', N'MØRSVIKBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8270', N'DRAG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8271', N'DRAG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8273', N'NEVERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8274', N'MUSKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8275', N'STORJORD I TYSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8276', N'ULVSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8278', N'STORÅ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8281', N'LEINESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8283', N'LEINESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8285', N'LEINES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8286', N'NORDFOLD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8287', N'ENGELØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8288', N'BOGØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8289', N'ENGELØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8290', N'SKUTVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8294', N'HAMARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8297', N'TRANØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8298', N'HAMARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8300', N'SVOLVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8301', N'SVOLVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8305', N'SVOLVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8309', N'KABELVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8310', N'KABELVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8311', N'HENNINGSVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8312', N'HENNINGSVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8313', N'KLEPPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8314', N'GIMSØYSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8315', N'LAUKVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8316', N'LAUPSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8317', N'STRØNSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8320', N'SKROVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8322', N'BRETTESNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8323', N'STORFJELL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8324', N'DIGERMULEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8325', N'TENGELFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8326', N'MYRLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8328', N'STORMOLLA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8340', N'STAMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8352', N'SENNESVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8357', N'VALBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8360', N'BØSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8361', N'BØSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8370', N'LEKNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8372', N'GRAVDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8373', N'BALLSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8374', N'BALLSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8376', N'LEKNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8377', N'GRAVDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8378', N'STAMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8380', N'RAMBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8382', N'NAPP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8384', N'SUND I LOFOTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8387', N'FREDVANG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8388', N'RAMBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8390', N'REINE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8392', N'SØRVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8393', N'SØRVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8398', N'REINE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8400', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8401', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8402', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8403', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8404', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8405', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8406', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8407', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8408', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8409', N'GULLESFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8410', N'LØDINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8411', N'LØDINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8412', N'VESTBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8413', N'KVITNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8414', N'HENNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8415', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8416', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8419', N'SORTLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8426', N'BARKESTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8428', N'TUNSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8430', N'MYRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8432', N'ALSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8438', N'STØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8439', N'MYRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8445', N'MELBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8447', N'LONKAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8450', N'STOKMARKNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8455', N'STOKMARKNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8459', N'MELBU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8465', N'STRAUMSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8469', N'BØ I VESTERÅLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8470', N'BØ I VESTERÅLEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8475', N'STRAUMSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8480', N'ANDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8481', N'BLEIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8483', N'ANDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8484', N'RISØYHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8485', N'DVERBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8488', N'NØSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8489', N'NORDMELA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8493', N'RISØYHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8501', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8502', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8503', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8504', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8505', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8506', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8507', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8508', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8509', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8510', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8512', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8513', N'ANKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8514', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8515', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8516', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8517', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8518', N'NARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8520', N'ANKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8522', N'BEISFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8523', N'ELVEGÅRD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8530', N'BJERKVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8531', N'BJERKVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8533', N'BOGEN I OFOTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8534', N'LILAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8535', N'TÅRSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8536', N'EVENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8539', N'BOGEN I OFOTEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8540', N'BALLANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8543', N'KJELDEBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8546', N'BALLANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8590', N'KJØPSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8591', N'KJØPSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8601', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8602', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8603', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8604', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8607', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8608', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8609', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8610', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8613', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8614', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8615', N'SKONSENG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8616', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8617', N'DALSGRENDA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8618', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8619', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8622', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8624', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8626', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8630', N'STORFORSHEI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8634', N'MO I RANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8638', N'STORFORSHEI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8640', N'HEMNESBERGET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8641', N'HEMNESBERGET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8642', N'FINNEIDFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8643', N'BJERKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8644', N'BJERKA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8646', N'KORGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8647', N'BLEIKVASSLIA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8648', N'KORGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8651', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8652', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8654', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8655', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8656', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8657', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8658', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8659', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8660', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8661', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8663', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8664', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8665', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8666', N'MOSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8672', N'ELSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8680', N'TROFORS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8681', N'TROFORS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8690', N'HATTFJELLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8691', N'HATTFJELLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8700', N'NESNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8701', N'NESNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8720', N'VIKHOLMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8723', N'HUSBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8724', N'SAURA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8725', N'UTSKARPEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8730', N'BRATLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8732', N'ALDRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8733', N'STUVLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8735', N'STOKKVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8740', N'NORD-SOLVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8742', N'SELVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8743', N'INDRE KVARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8750', N'TONNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8752', N'KONSVIKOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8753', N'KONSVIKOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8754', N'ØRESVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8762', N'SLENESET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8764', N'LOVUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8766', N'LURØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8767', N'LURØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8770', N'TRÆNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8800', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8801', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8802', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8803', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8804', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8805', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8809', N'SANDNESSJØEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8813', N'LØKTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8820', N'DØNNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8827', N'DØNNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8830', N'VANDVE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8842', N'BRASØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8844', N'SANDVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8850', N'HERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8851', N'HERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8852', N'HERØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8854', N'AUSTBØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8860', N'TJØTTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8861', N'TJØTTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8865', N'TRO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8870', N'VISTHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8880', N'BÆRØYVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8890', N'LEIRFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8891', N'LEIRFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8892', N'SUNDØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8897', N'BARDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8900', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8901', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8902', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8904', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8905', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8906', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8907', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8908', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8909', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8910', N'BRØNNØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8920', N'SØMNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8921', N'SØMNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8922', N'SØMNA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8960', N'VELFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8961', N'VELFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8976', N'VEVELSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8977', N'VEVELSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8980', N'VEGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8981', N'VEGA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'8985', N'YLVINGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9006', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9007', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9008', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9009', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9010', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9011', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9012', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9013', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9014', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9015', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9016', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9017', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9018', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9019', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9020', N'TROMSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9021', N'TROMSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9022', N'KROKELVDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9023', N'KROKELVDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9024', N'TOMASJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9027', N'RAMFJORDBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9029', N'TROMSDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9030', N'SJURSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9034', N'OLDERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9037', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9038', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9040', N'NORDKJOSBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9042', N'LAKSVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9043', N'JØVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9046', N'OTEREN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9049', N'NORDKJOSBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9050', N'STORSTEINNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9055', N'MEISTERVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9056', N'MORTENHALS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9057', N'VIKRAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9059', N'STORSTEINNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9060', N'LYNGSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9062', N'FURUFLATEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9064', N'SVENSBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9068', N'NORD-LENANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9069', N'LYNGSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9100', N'KVALØYSLETTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9101', N'KVALØYSLETTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9102', N'KVALØYSLETTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9103', N'KVALØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9104', N'KVALØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9105', N'KVALØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9106', N'STRAUMSBUKTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9107', N'KVALØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9108', N'KVALØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9110', N'SOMMARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9118', N'BRENSHOLMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9119', N'SOMMARØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9120', N'VENGSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9128', N'TUSSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9130', N'HANSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9131', N'KÅRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9132', N'STAKKVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9134', N'HANSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9135', N'VANNVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9136', N'VANNAREID')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9137', N'VANNVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9138', N'KARLSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9140', N'REBBENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9141', N'MJØLVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9142', N'SKIBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9143', N'SKIBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9144', N'SAMUELSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9145', N'SAMUELSBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9146', N'OLDERDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9147', N'BIRTAVARRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9148', N'OLDERDALEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9149', N'BIRTAVARRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9151', N'STORSLETT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9152', N'SØRKJOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9153', N'ROTSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9155', N'SØRKJOSEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9156', N'STORSLETT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9159', N'HAVNNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9161', N'BURFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9162', N'SØRSTRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9163', N'JØKELFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9169', N'BURFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9170', N'LONGYEARBYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9171', N'LONGYEARBYEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9173', N'NY-ÅLESUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9174', N'HOPEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9175', N'SVEAGRUVA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9176', N'BJØRNØYA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9178', N'BARENTSBURG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9180', N'SKJERVØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9181', N'HAMNEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9182', N'SEGLVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9184', N'REINFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9185', N'SPILDRA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9186', N'ANDSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9187', N'VALANHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9189', N'SKJERVØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9190', N'AKKARVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9192', N'ARNØYHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9193', N'NIKKEBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9194', N'LAUKSLETTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9195', N'ÅRVIKSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9197', N'ULØYBUKT')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9240', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9251', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9252', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9253', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9254', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9255', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9256', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9257', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9258', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9259', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9260', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9261', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9262', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9263', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9265', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9266', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9267', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9268', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9269', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9270', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9271', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9272', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9273', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9274', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9275', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9276', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9277', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9278', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9279', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9280', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9281', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9282', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9283', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9284', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9285', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9286', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9287', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9288', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9290', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9291', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9292', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9293', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9294', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9296', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9298', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9299', N'TROMSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9300', N'FINNSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9302', N'ROSSFJORDSTRAUMEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9303', N'SILSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9304', N'VANGSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9305', N'FINNSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9306', N'FINNSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9307', N'FINNSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9308', N'FINNSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9309', N'FINNSNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9310', N'SØRREISA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9311', N'BRØSTADBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9315', N'SØRREISA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9316', N'BRØSTADBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9321', N'MOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9322', N'KARLSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9325', N'BARDUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9326', N'BARDUFOSS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9329', N'MOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9334', N'ØVERBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9335', N'ØVERBYGD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9336', N'RUNDHAUG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9350', N'SJØVEGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9355', N'SJØVEGAN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9357', N'TENNEVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9358', N'TENNEVOLL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9360', N'BARDU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9365', N'BARDU')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9370', N'SILSAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9372', N'GIBOSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9373', N'BOTNHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9376', N'SKATVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9379', N'GRYLLEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9380', N'GRYLLEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9381', N'TORSKEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9382', N'GIBOSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9384', N'SKALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9385', N'SKALAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9386', N'SENJAHOPEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9387', N'SENJAHOPEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9388', N'FJORDGARD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9389', N'HUSØY I SENJA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9391', N'STONGLANDSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9392', N'STONGLANDSEIDET')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9393', N'FLAKSTADVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9395', N'KALDFARNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9402', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9403', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9404', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9405', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9406', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9407', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9408', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9409', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9411', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9414', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9415', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9416', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9419', N'SØRVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9420', N'LUNDENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9423', N'GRØTAVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9424', N'KJØTTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9425', N'SANDSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9426', N'BJARKØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9427', N'MELØYVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9430', N'SANDTORG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9436', N'KONGSVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9439', N'EVENSKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9440', N'EVENSKJER')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9441', N'FJELLDAL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9442', N'RAMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9443', N'MYKLEBOSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9444', N'HOL I TJELDSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9445', N'TOVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9446', N'GROVFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9447', N'GROVFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9448', N'RAMSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9450', N'HAMNVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9451', N'HAMNVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9453', N'KRÅKRØHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9454', N'ÅNSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9455', N'ENGENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9456', N'ENGENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9470', N'GRATANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9471', N'GRATANGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9475', N'BORKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9476', N'BORKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9479', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9480', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9481', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9482', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9483', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9484', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9485', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9486', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9487', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9488', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9489', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9496', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9497', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9498', N'HARSTAD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9501', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9502', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9503', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9504', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9505', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9506', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9507', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9508', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9509', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9510', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9511', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9512', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9513', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9514', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9515', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9516', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9517', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9518', N'ALTA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9519', N'KVIBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9520', N'KAUTOKEINO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9521', N'KAUTOKEINO')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9525', N'MAZE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9531', N'KVALFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9532', N'HAKKSTABBEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9533', N'KONGSHUS')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9536', N'KORSFJORDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9540', N'TALVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9545', N'LANGFJORDBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9550', N'ØKSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9580', N'BERGSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9582', N'NUVSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9583', N'LANGFJORDHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9584', N'SØR-TVERRFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9585', N'SANDLAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9586', N'LOPPA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9587', N'SKAVNAKK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9590', N'HASVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9591', N'HASVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9593', N'BREIVIKBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9595', N'SØRVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9600', N'HAMMERFEST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9601', N'HAMMERFEST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9602', N'HAMMERFEST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9603', N'HAMMERFEST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9609', N'NORDRE SEILAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9610', N'RYPEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9611', N'RYPEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9612', N'FORSØL')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9615', N'HAMMERFEST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9616', N'HAMMERFEST')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9620', N'KVALSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9621', N'KVALSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9624', N'REVSNESHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9650', N'AKKARFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9651', N'LANGSTRAND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9657', N'KÅRHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9664', N'SANDØYBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9670', N'TUFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9672', N'INGØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9690', N'HAVØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9691', N'HAVØYSUND')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9692', N'MÅSØY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9700', N'LAKSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9709', N'PORSANGMOEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9710', N'INDRE BILLEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9711', N'LAKSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9712', N'LAKSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9713', N'RUSSENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9714', N'SNEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9715', N'KOKELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9716', N'BØRSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9717', N'VEIDNESKLUBBEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9722', N'SKOGANVARRE')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9730', N'KARASJOK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9735', N'KARASJOK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9740', N'LEBESBY')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9742', N'KUNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9750', N'HONNINGSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9751', N'HONNINGSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9760', N'NORDVÅGEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9763', N'SKARSVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9764', N'NORDKAPP')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9765', N'GJESVÆR')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9768', N'REPVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9770', N'MEHAMN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9771', N'SKJÅNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9772', N'LANGFJORDNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9773', N'NERVEI')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9775', N'GAMVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9782', N'DYFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9790', N'KJØLLEFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9800', N'VADSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9802', N'VESTRE JAKOBSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9810', N'VESTRE JAKOBSELV')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9811', N'VADSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9815', N'VADSØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9820', N'VARANGERBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9826', N'SIRMA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9840', N'VARANGERBOTN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9845', N'TANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9846', N'TANA')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9900', N'KIRKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9910', N'BJØRNEVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9912', N'HESSENG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9914', N'BJØRNEVATN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9915', N'KIRKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9916', N'HESSENG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9917', N'KIRKENES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9925', N'SVANVIK')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9930', N'NEIDEN')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9935', N'BUGØYNES')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9950', N'VARDØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9951', N'VARDØ')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9960', N'KIBERG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9980', N'BERLEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9981', N'BERLEVÅG')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9982', N'KONGSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9990', N'BÅTSFJORD')
GO
INSERT [dbo].[Postaddresse] ([Postnummer], [Poststed]) VALUES (N'9991', N'BÅTSFJORD')
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (1, 10, 0)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (381, 6, 21.29)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (408, 11, 21.29)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (410, 12, 22.75)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (412, 13, 0)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (414, 14, 0)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (416, 15, 21.29)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (418, 16, 21.29)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (420, 17, 21.29)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (422, 18, 21.29)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (430, 20, 22.27)
GO
INSERT [dbo].[TempAlarm] ([TempId], [AlarmId], [Temperatur]) VALUES (432, 21, 21.29)
GO
SET IDENTITY_INSERT [dbo].[TempData] ON 
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (1, CAST(N'2019-04-23T12:22:06.507' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (2, CAST(N'2019-04-23T12:40:22.220' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (3, CAST(N'2019-04-23T12:40:42.220' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (4, CAST(N'2019-04-23T12:41:11.817' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (5, CAST(N'2019-04-23T12:42:31.110' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (6, CAST(N'2019-04-23T12:42:51.117' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (7, CAST(N'2019-04-23T12:45:14.503' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (8, CAST(N'2019-04-23T12:45:34.507' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (9, CAST(N'2019-04-23T12:46:09.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (10, CAST(N'2019-04-23T12:46:29.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (11, CAST(N'2019-04-23T12:46:49.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (12, CAST(N'2019-04-23T12:47:09.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (13, CAST(N'2019-04-23T12:47:29.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (14, CAST(N'2019-04-23T12:47:49.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (15, CAST(N'2019-04-23T12:48:09.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (16, CAST(N'2019-04-23T12:48:29.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (17, CAST(N'2019-04-23T12:48:49.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (18, CAST(N'2019-04-23T12:49:09.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (19, CAST(N'2019-04-23T12:49:29.017' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (20, CAST(N'2019-04-23T12:49:47.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (21, CAST(N'2019-04-23T12:50:07.537' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (22, CAST(N'2019-04-23T12:50:27.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (23, CAST(N'2019-04-23T12:50:47.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (24, CAST(N'2019-04-23T12:51:07.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (25, CAST(N'2019-04-23T12:51:27.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (26, CAST(N'2019-04-23T12:51:47.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (27, CAST(N'2019-04-23T12:52:07.537' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (28, CAST(N'2019-04-23T12:52:27.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (29, CAST(N'2019-04-23T12:52:47.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (30, CAST(N'2019-04-23T12:53:07.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (31, CAST(N'2019-04-23T12:53:27.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (32, CAST(N'2019-04-23T12:55:27.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (33, CAST(N'2019-04-23T12:55:47.533' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (34, CAST(N'2019-04-23T12:55:59.347' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (35, CAST(N'2019-04-23T13:17:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (36, CAST(N'2019-04-23T13:18:04.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (37, CAST(N'2019-04-23T13:18:24.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (38, CAST(N'2019-04-23T13:18:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (39, CAST(N'2019-04-23T13:19:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (40, CAST(N'2019-04-23T13:19:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (41, CAST(N'2019-04-23T13:19:44.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (42, CAST(N'2019-04-23T13:20:04.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (43, CAST(N'2019-04-23T13:20:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (44, CAST(N'2019-04-23T13:20:44.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (45, CAST(N'2019-04-23T13:21:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (46, CAST(N'2019-04-23T13:21:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (47, CAST(N'2019-04-23T13:21:44.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (48, CAST(N'2019-04-23T13:22:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (49, CAST(N'2019-04-23T13:22:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (50, CAST(N'2019-04-23T13:22:44.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (51, CAST(N'2019-04-23T13:23:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (52, CAST(N'2019-04-23T13:23:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (53, CAST(N'2019-04-23T13:23:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (54, CAST(N'2019-04-23T13:24:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (55, CAST(N'2019-04-23T13:24:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (56, CAST(N'2019-04-23T13:24:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (57, CAST(N'2019-04-23T13:25:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (58, CAST(N'2019-04-23T13:25:24.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (59, CAST(N'2019-04-23T13:25:44.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (60, CAST(N'2019-04-23T13:26:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (61, CAST(N'2019-04-23T13:26:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (62, CAST(N'2019-04-23T13:26:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (63, CAST(N'2019-04-23T13:27:04.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (64, CAST(N'2019-04-23T13:27:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (65, CAST(N'2019-04-23T13:27:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (66, CAST(N'2019-04-23T13:28:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (67, CAST(N'2019-04-23T13:28:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (68, CAST(N'2019-04-23T13:28:44.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (69, CAST(N'2019-04-23T13:29:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (70, CAST(N'2019-04-23T13:29:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (71, CAST(N'2019-04-23T13:29:44.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (72, CAST(N'2019-04-23T13:30:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (73, CAST(N'2019-04-23T13:30:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (74, CAST(N'2019-04-23T13:30:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (75, CAST(N'2019-04-23T13:31:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (76, CAST(N'2019-04-23T13:31:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (77, CAST(N'2019-04-23T13:31:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (78, CAST(N'2019-04-23T13:32:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (79, CAST(N'2019-04-23T13:32:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (80, CAST(N'2019-04-23T13:32:44.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (81, CAST(N'2019-04-23T13:33:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (82, CAST(N'2019-04-23T13:33:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (83, CAST(N'2019-04-23T13:33:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (84, CAST(N'2019-04-23T13:34:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (85, CAST(N'2019-04-23T13:34:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (86, CAST(N'2019-04-23T13:34:44.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (87, CAST(N'2019-04-23T13:35:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (88, CAST(N'2019-04-23T13:35:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (89, CAST(N'2019-04-23T13:35:44.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (90, CAST(N'2019-04-23T13:36:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (91, CAST(N'2019-04-23T13:36:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (92, CAST(N'2019-04-23T13:36:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (93, CAST(N'2019-04-23T13:37:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (94, CAST(N'2019-04-23T13:37:24.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (95, CAST(N'2019-04-23T13:37:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (96, CAST(N'2019-04-23T13:38:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (97, CAST(N'2019-04-23T13:38:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (98, CAST(N'2019-04-23T13:38:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (99, CAST(N'2019-04-23T13:39:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (100, CAST(N'2019-04-23T13:39:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (101, CAST(N'2019-04-23T13:39:44.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (102, CAST(N'2019-04-23T13:40:04.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (103, CAST(N'2019-04-23T13:40:24.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (104, CAST(N'2019-04-23T13:40:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (105, CAST(N'2019-04-23T13:41:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (106, CAST(N'2019-04-23T13:41:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (107, CAST(N'2019-04-23T13:41:44.710' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (108, CAST(N'2019-04-23T13:42:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (109, CAST(N'2019-04-23T13:42:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (110, CAST(N'2019-04-23T13:42:44.713' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (111, CAST(N'2019-04-23T13:43:04.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (112, CAST(N'2019-04-23T13:43:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (113, CAST(N'2019-04-23T13:43:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (114, CAST(N'2019-04-23T13:44:04.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (115, CAST(N'2019-04-23T13:44:24.703' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (116, CAST(N'2019-04-23T13:44:44.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (117, CAST(N'2019-04-23T13:47:15.643' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (118, CAST(N'2019-04-23T13:47:35.643' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (119, CAST(N'2019-04-23T13:47:55.643' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (120, CAST(N'2019-04-23T13:48:15.643' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (121, CAST(N'2019-04-23T13:51:55.720' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (122, CAST(N'2019-04-23T13:52:15.720' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (123, CAST(N'2019-04-23T13:52:35.720' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (124, CAST(N'2019-04-23T13:53:19.457' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (125, CAST(N'2019-04-23T13:53:39.453' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (126, CAST(N'2019-04-23T13:56:45.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (127, CAST(N'2019-04-23T13:57:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (128, CAST(N'2019-04-23T13:57:49.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (129, CAST(N'2019-04-23T13:58:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (130, CAST(N'2019-04-23T13:58:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (131, CAST(N'2019-04-23T13:58:49.943' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (132, CAST(N'2019-04-23T13:59:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (133, CAST(N'2019-04-23T13:59:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (134, CAST(N'2019-04-23T13:59:49.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (135, CAST(N'2019-04-23T14:00:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (136, CAST(N'2019-04-23T14:00:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (137, CAST(N'2019-04-23T14:00:49.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (138, CAST(N'2019-04-23T14:01:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (139, CAST(N'2019-04-23T14:01:29.943' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (140, CAST(N'2019-04-23T14:01:49.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (141, CAST(N'2019-04-23T14:02:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (142, CAST(N'2019-04-23T14:02:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (143, CAST(N'2019-04-23T14:02:49.943' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (144, CAST(N'2019-04-23T14:03:09.943' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (145, CAST(N'2019-04-23T14:03:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (146, CAST(N'2019-04-23T14:03:49.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (147, CAST(N'2019-04-23T14:04:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (148, CAST(N'2019-04-23T14:04:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (149, CAST(N'2019-04-23T14:04:49.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (150, CAST(N'2019-04-23T14:05:09.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (151, CAST(N'2019-04-23T14:05:29.940' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (152, CAST(N'2019-04-23T14:05:49.943' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (153, CAST(N'2019-04-23T14:08:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (154, CAST(N'2019-04-23T14:09:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (155, CAST(N'2019-04-23T14:09:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (156, CAST(N'2019-04-23T14:09:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (157, CAST(N'2019-04-23T14:10:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (158, CAST(N'2019-04-23T14:10:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (159, CAST(N'2019-04-23T14:10:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (160, CAST(N'2019-04-23T14:11:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (161, CAST(N'2019-04-23T14:11:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (162, CAST(N'2019-04-23T14:11:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (163, CAST(N'2019-04-23T14:12:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (164, CAST(N'2019-04-23T14:12:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (165, CAST(N'2019-04-23T14:12:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (166, CAST(N'2019-04-23T14:13:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (167, CAST(N'2019-04-23T14:13:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (168, CAST(N'2019-04-23T14:13:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (169, CAST(N'2019-04-23T14:14:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (170, CAST(N'2019-04-23T14:14:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (171, CAST(N'2019-04-23T14:14:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (172, CAST(N'2019-04-23T14:15:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (173, CAST(N'2019-04-23T14:15:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (174, CAST(N'2019-04-23T14:15:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (175, CAST(N'2019-04-23T14:16:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (176, CAST(N'2019-04-23T14:16:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (177, CAST(N'2019-04-23T14:16:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (178, CAST(N'2019-04-23T14:17:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (179, CAST(N'2019-04-23T14:17:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (180, CAST(N'2019-04-23T14:17:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (181, CAST(N'2019-04-23T14:18:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (182, CAST(N'2019-04-23T14:18:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (183, CAST(N'2019-04-23T14:18:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (184, CAST(N'2019-04-23T14:19:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (185, CAST(N'2019-04-23T14:19:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (186, CAST(N'2019-04-23T14:19:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (187, CAST(N'2019-04-23T14:20:02.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (188, CAST(N'2019-04-23T14:20:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (189, CAST(N'2019-04-23T14:20:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (190, CAST(N'2019-04-23T14:21:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (191, CAST(N'2019-04-23T14:21:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (192, CAST(N'2019-04-23T14:21:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (193, CAST(N'2019-04-23T14:22:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (194, CAST(N'2019-04-23T14:22:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (195, CAST(N'2019-04-23T14:22:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (196, CAST(N'2019-04-23T14:23:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (197, CAST(N'2019-04-23T14:23:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (198, CAST(N'2019-04-23T14:23:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (199, CAST(N'2019-04-23T14:24:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (200, CAST(N'2019-04-23T14:24:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (201, CAST(N'2019-04-23T14:24:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (202, CAST(N'2019-04-23T14:25:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (203, CAST(N'2019-04-23T14:25:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (204, CAST(N'2019-04-23T14:25:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (205, CAST(N'2019-04-23T14:26:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (206, CAST(N'2019-04-23T14:26:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (207, CAST(N'2019-04-23T14:26:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (208, CAST(N'2019-04-23T14:27:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (209, CAST(N'2019-04-23T14:27:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (210, CAST(N'2019-04-23T14:27:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (211, CAST(N'2019-04-23T14:28:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (212, CAST(N'2019-04-23T14:28:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (213, CAST(N'2019-04-23T14:28:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (214, CAST(N'2019-04-23T14:29:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (215, CAST(N'2019-04-23T14:29:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (216, CAST(N'2019-04-23T14:29:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (217, CAST(N'2019-04-23T14:30:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (218, CAST(N'2019-04-23T14:30:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (219, CAST(N'2019-04-23T14:30:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (220, CAST(N'2019-04-23T14:31:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (221, CAST(N'2019-04-23T14:31:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (222, CAST(N'2019-04-23T14:31:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (223, CAST(N'2019-04-23T14:32:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (224, CAST(N'2019-04-23T14:32:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (225, CAST(N'2019-04-23T14:32:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (226, CAST(N'2019-04-23T14:33:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (227, CAST(N'2019-04-23T14:33:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (228, CAST(N'2019-04-23T14:33:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (229, CAST(N'2019-04-23T14:34:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (230, CAST(N'2019-04-23T14:34:22.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (231, CAST(N'2019-04-23T14:34:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (232, CAST(N'2019-04-23T14:35:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (233, CAST(N'2019-04-23T14:35:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (234, CAST(N'2019-04-23T14:35:42.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (235, CAST(N'2019-04-23T14:36:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (236, CAST(N'2019-04-23T14:36:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (237, CAST(N'2019-04-23T14:36:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (238, CAST(N'2019-04-23T14:37:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (239, CAST(N'2019-04-23T14:37:22.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (240, CAST(N'2019-04-23T14:37:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (241, CAST(N'2019-04-23T14:38:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (242, CAST(N'2019-04-23T14:38:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (243, CAST(N'2019-04-23T14:38:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (244, CAST(N'2019-04-23T14:39:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (245, CAST(N'2019-04-23T14:39:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (246, CAST(N'2019-04-23T14:39:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (247, CAST(N'2019-04-23T14:40:02.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (248, CAST(N'2019-04-23T14:40:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (249, CAST(N'2019-04-23T14:40:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (250, CAST(N'2019-04-23T14:41:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (251, CAST(N'2019-04-23T14:41:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (252, CAST(N'2019-04-23T14:41:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (253, CAST(N'2019-04-23T14:42:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (254, CAST(N'2019-04-23T14:42:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (255, CAST(N'2019-04-23T14:42:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (256, CAST(N'2019-04-23T14:43:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (257, CAST(N'2019-04-23T14:43:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (258, CAST(N'2019-04-23T14:43:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (259, CAST(N'2019-04-23T14:44:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (260, CAST(N'2019-04-23T14:44:22.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (261, CAST(N'2019-04-23T14:44:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (262, CAST(N'2019-04-23T14:45:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (263, CAST(N'2019-04-23T14:45:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (264, CAST(N'2019-04-23T14:45:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (265, CAST(N'2019-04-23T14:46:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (266, CAST(N'2019-04-23T14:46:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (267, CAST(N'2019-04-23T14:46:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (268, CAST(N'2019-04-23T14:47:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (269, CAST(N'2019-04-23T14:47:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (270, CAST(N'2019-04-23T14:47:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (271, CAST(N'2019-04-23T14:48:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (272, CAST(N'2019-04-23T14:48:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (273, CAST(N'2019-04-23T14:48:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (274, CAST(N'2019-04-23T14:49:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (275, CAST(N'2019-04-23T14:49:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (276, CAST(N'2019-04-23T14:49:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (277, CAST(N'2019-04-23T14:50:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (278, CAST(N'2019-04-23T14:50:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (279, CAST(N'2019-04-23T14:50:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (280, CAST(N'2019-04-23T14:51:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (281, CAST(N'2019-04-23T14:51:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (282, CAST(N'2019-04-23T14:51:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (283, CAST(N'2019-04-23T14:52:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (284, CAST(N'2019-04-23T14:52:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (285, CAST(N'2019-04-23T14:52:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (286, CAST(N'2019-04-23T14:53:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (287, CAST(N'2019-04-23T14:53:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (288, CAST(N'2019-04-23T14:53:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (289, CAST(N'2019-04-23T14:54:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (290, CAST(N'2019-04-23T14:54:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (291, CAST(N'2019-04-23T14:54:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (292, CAST(N'2019-04-23T14:55:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (293, CAST(N'2019-04-23T14:55:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (294, CAST(N'2019-04-23T14:55:42.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (295, CAST(N'2019-04-23T14:56:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (296, CAST(N'2019-04-23T14:56:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (297, CAST(N'2019-04-23T14:56:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (298, CAST(N'2019-04-23T14:57:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (299, CAST(N'2019-04-23T14:57:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (300, CAST(N'2019-04-23T14:57:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (301, CAST(N'2019-04-23T14:58:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (302, CAST(N'2019-04-23T14:58:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (303, CAST(N'2019-04-23T14:58:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (304, CAST(N'2019-04-23T14:59:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (305, CAST(N'2019-04-23T14:59:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (306, CAST(N'2019-04-23T14:59:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (307, CAST(N'2019-04-23T15:00:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (308, CAST(N'2019-04-23T15:00:22.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (309, CAST(N'2019-04-23T15:00:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (310, CAST(N'2019-04-23T15:01:02.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (311, CAST(N'2019-04-23T15:01:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (312, CAST(N'2019-04-23T15:01:42.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (313, CAST(N'2019-04-23T15:02:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (314, CAST(N'2019-04-23T15:02:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (315, CAST(N'2019-04-23T15:02:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (316, CAST(N'2019-04-23T15:03:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (317, CAST(N'2019-04-23T15:03:22.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (318, CAST(N'2019-04-23T15:03:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (319, CAST(N'2019-04-23T15:04:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (320, CAST(N'2019-04-23T15:04:22.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (321, CAST(N'2019-04-23T15:04:42.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (322, CAST(N'2019-04-23T15:05:02.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (323, CAST(N'2019-04-23T15:05:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (324, CAST(N'2019-04-23T15:05:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (325, CAST(N'2019-04-23T15:06:02.000' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (326, CAST(N'2019-04-23T15:06:22.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (327, CAST(N'2019-04-23T15:06:42.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (328, CAST(N'2019-04-24T08:32:22.720' AS DateTime), 19.34)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (329, CAST(N'2019-04-24T08:32:42.720' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (330, CAST(N'2019-04-24T08:33:02.720' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (331, CAST(N'2019-04-24T08:33:22.720' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (332, CAST(N'2019-04-24T08:33:42.720' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (333, CAST(N'2019-04-24T08:34:55.767' AS DateTime), 19.34)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (334, CAST(N'2019-04-24T08:35:15.773' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (335, CAST(N'2019-04-24T08:35:35.767' AS DateTime), 19.34)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (336, CAST(N'2019-04-24T08:35:55.773' AS DateTime), 19.34)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (337, CAST(N'2019-04-24T08:36:15.770' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (338, CAST(N'2019-04-24T08:42:26.787' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (339, CAST(N'2019-04-24T08:42:46.783' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (340, CAST(N'2019-04-24T08:44:22.500' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (341, CAST(N'2019-04-24T08:44:42.530' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (342, CAST(N'2019-04-24T08:45:33.097' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (343, CAST(N'2019-04-24T08:45:55.097' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (344, CAST(N'2019-04-24T08:46:15.097' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (345, CAST(N'2019-04-24T08:46:35.093' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (346, CAST(N'2019-04-24T08:46:55.097' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (347, CAST(N'2019-04-24T08:47:15.097' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (348, CAST(N'2019-04-24T08:47:35.100' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (349, CAST(N'2019-04-24T08:47:55.100' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (350, CAST(N'2019-04-24T08:48:15.093' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (351, CAST(N'2019-04-24T08:48:35.097' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (352, CAST(N'2019-04-24T08:49:21.283' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (353, CAST(N'2019-04-24T08:49:42.173' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (354, CAST(N'2019-04-24T08:50:02.180' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (355, CAST(N'2019-04-24T08:50:22.173' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (356, CAST(N'2019-04-24T08:50:44.630' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (357, CAST(N'2019-04-24T08:51:04.627' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (358, CAST(N'2019-04-24T08:51:24.627' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (359, CAST(N'2019-04-24T08:51:44.630' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (360, CAST(N'2019-04-24T08:52:59.657' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (361, CAST(N'2019-04-24T08:53:59.490' AS DateTime), 19.82)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (362, CAST(N'2019-04-24T08:54:19.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (363, CAST(N'2019-04-24T08:54:39.483' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (364, CAST(N'2019-04-24T08:54:59.490' AS DateTime), 21.78)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (365, CAST(N'2019-04-24T08:55:19.487' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (366, CAST(N'2019-04-24T08:55:39.490' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (367, CAST(N'2019-04-24T08:56:09.487' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (368, CAST(N'2019-04-24T08:56:39.490' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (369, CAST(N'2019-04-24T08:57:09.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (370, CAST(N'2019-04-24T08:57:39.490' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (371, CAST(N'2019-04-24T08:58:09.487' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (372, CAST(N'2019-04-24T08:58:39.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (373, CAST(N'2019-04-24T08:59:09.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (374, CAST(N'2019-04-24T08:59:39.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (375, CAST(N'2019-04-24T09:00:09.487' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (376, CAST(N'2019-04-24T09:00:39.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (377, CAST(N'2019-04-24T09:01:09.487' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (378, CAST(N'2019-04-24T09:01:39.490' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (379, CAST(N'2019-04-24T09:02:09.490' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (380, CAST(N'2019-04-24T09:02:39.487' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (381, CAST(N'2019-04-24T09:02:49.940' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (382, CAST(N'2019-04-24T09:03:09.487' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (383, CAST(N'2019-04-24T09:13:18.003' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (384, CAST(N'2019-04-24T09:13:33.090' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (385, CAST(N'2019-04-24T09:13:48.000' AS DateTime), 22.27)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (386, CAST(N'2019-04-24T09:14:18.003' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (387, CAST(N'2019-04-24T09:14:48.003' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (388, CAST(N'2019-04-24T09:15:18.003' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (389, CAST(N'2019-04-24T09:15:23.853' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (390, CAST(N'2019-04-24T09:15:48.003' AS DateTime), 21.78)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (391, CAST(N'2019-04-24T09:16:18.003' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (392, CAST(N'2019-04-24T09:16:48.003' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (393, CAST(N'2019-04-24T09:17:18.000' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (394, CAST(N'2019-04-24T09:17:48.000' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (395, CAST(N'2019-04-24T09:18:18.003' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (396, CAST(N'2019-04-24T09:18:48.003' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (397, CAST(N'2019-04-24T09:19:18.000' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (398, CAST(N'2019-04-24T09:19:48.003' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (399, CAST(N'2019-04-24T09:20:18.003' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (400, CAST(N'2019-04-24T09:20:48.000' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (401, CAST(N'2019-04-24T09:21:18.003' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (402, CAST(N'2019-04-24T09:21:48.003' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (403, CAST(N'2019-04-24T09:22:18.000' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (404, CAST(N'2019-04-24T09:24:48.860' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (405, CAST(N'2019-04-24T09:24:48.873' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (406, CAST(N'2019-04-24T09:25:04.007' AS DateTime), 21.78)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (407, CAST(N'2019-04-24T09:36:26.910' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (408, CAST(N'2019-04-24T09:36:47.000' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (409, CAST(N'2019-04-24T09:36:56.910' AS DateTime), 22.75)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (410, CAST(N'2019-04-24T09:36:57.483' AS DateTime), 22.75)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (411, CAST(N'2019-04-24T09:39:18.750' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (412, CAST(N'2019-04-24T09:39:18.773' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (413, CAST(N'2019-04-24T09:39:31.987' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (414, CAST(N'2019-04-24T09:39:32.007' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (415, CAST(N'2019-04-24T09:40:01.990' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (416, CAST(N'2019-04-24T09:40:12.793' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (417, CAST(N'2019-04-24T09:52:28.550' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (418, CAST(N'2019-04-24T09:52:43.597' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (419, CAST(N'2019-04-24T09:53:07.880' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (420, CAST(N'2019-04-24T09:53:17.947' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (421, CAST(N'2019-04-24T09:54:33.957' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (422, CAST(N'2019-04-24T09:54:54.003' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (423, CAST(N'2019-04-24T09:55:03.953' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (424, CAST(N'2019-04-24T09:55:33.960' AS DateTime), 21.78)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (425, CAST(N'2019-04-24T09:56:03.953' AS DateTime), 20.31)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (426, CAST(N'2019-04-24T09:56:33.957' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (427, CAST(N'2019-04-24T09:57:03.953' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (428, CAST(N'2019-04-24T09:58:25.500' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (429, CAST(N'2019-04-24T09:58:55.500' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (430, CAST(N'2019-04-24T09:59:00.530' AS DateTime), 22.27)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (431, CAST(N'2019-04-24T09:59:25.503' AS DateTime), 20.8)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (432, CAST(N'2019-04-24T09:59:41.487' AS DateTime), 21.29)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (433, CAST(N'2019-04-24T09:59:55.503' AS DateTime), 21.78)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (434, CAST(N'2019-04-24T10:09:20.033' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (435, CAST(N'2019-04-24T10:09:50.037' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (436, CAST(N'2019-04-24T10:10:20.033' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (437, CAST(N'2019-04-24T10:11:19.800' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (438, CAST(N'2019-04-24T10:11:49.800' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (439, CAST(N'2019-04-24T10:12:19.800' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (440, CAST(N'2019-04-24T10:12:49.800' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (441, CAST(N'2019-04-24T10:13:54.970' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (442, CAST(N'2019-04-24T10:14:24.970' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (443, CAST(N'2019-04-24T10:14:54.970' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (444, CAST(N'2019-04-24T10:16:05.377' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (445, CAST(N'2019-04-24T10:18:30.570' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (446, CAST(N'2019-04-24T10:19:00.563' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (447, CAST(N'2019-04-24T10:27:32.707' AS DateTime), 0)
GO
INSERT [dbo].[TempData] ([TempId], [Måletidspunkt], [Temperatur]) VALUES (448, CAST(N'2019-04-24T10:28:02.703' AS DateTime), 0)
GO
SET IDENTITY_INSERT [dbo].[TempData] OFF
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
/****** Object:  StoredProcedure [dbo].[Abonner]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[AddAbonnent]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[AddAlarm]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[AddAlarmGrense]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[AddAlarmTyper]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[AddMåling]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[AddTempALarm]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[AddTempALarm]
AS
INSERT INTO TempAlarm (TempId, AlarmId,Temperatur)
SELECT TOP 1 TD.TempId,A.AlarmId,TD.Temperatur
FROM TempData TD, Alarmer A,AlarmGrenser AG
ORDER BY TD.TempId DESC, A.AlarmId DESC;

GO
/****** Object:  StoredProcedure [dbo].[DeleteAbonnent]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[DeleteAbonnentFromAlarmData]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[DeleteAbonnentFromAlarmData]
@mail varchar(100)
AS
delete 
from AlarmData
where Mailaddresse =@mail
GO
/****** Object:  StoredProcedure [dbo].[GetAbonnenterFromAlarmData]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAbonnenterFromAlarmData]
@typeId int
AS
SELECT Mailaddresse
FROM AlarmData
WHERE TypeId = @typeId	
AND Abonnerer = 1
GO
/****** Object:  StoredProcedure [dbo].[GetAbonnentMails]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAlarmGrense]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmGrense]
@grenseId int
AS
SELECT GrenseVerdi
FROM AlarmGrenser
WHERE GrenseId = @grenseId
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmHistory]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[GetAlarmHistoryFromView]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmHistoryFromView]
AS
SELECT *
FROM AlarmHistory
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmId]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmId]
AS
SELECT AlarmId
FROM Alarmer
GO
/****** Object:  StoredProcedure [dbo].[GetAlarmTyper]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetAlarmTyper]
AS
SELECT TypeNavn
FROM AlarmTyper
GO
/****** Object:  StoredProcedure [dbo].[GetLatestAlarm]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetLatestAlarm]
AS
SELECT TOP 1*
FROM AlarmHistory
ORDER BY AlarmId DESC
GO
/****** Object:  StoredProcedure [dbo].[GetMåleTidsPunkt]    Script Date: 24/04/2019 13:05:33 ******/
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
/****** Object:  StoredProcedure [dbo].[GetTempId]    Script Date: 24/04/2019 13:05:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetTempId]
AS
SELECT TempId
FROM TempData
GO
/****** Object:  StoredProcedure [dbo].[UpdateAlarmGrense]    Script Date: 24/04/2019 13:05:33 ******/
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
