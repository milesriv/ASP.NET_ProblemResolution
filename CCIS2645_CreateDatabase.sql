USE [ServiceCenter]
GO
/****** Object:  Table [dbo].[Clients]    Script Date: 8/20/2014 9:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Clients](
	[ClientID] [int] IDENTITY(1,1) NOT NULL,
	[Institution] [nvarchar](100) NOT NULL,
	[Branch] [nvarchar](50) NOT NULL,
	[Address1] [nvarchar](30) NOT NULL,
	[Address2] [nvarchar](30) NULL,
	[City] [nvarchar](25) NOT NULL,
	[State] [nchar](2) NOT NULL,
	[Zip] [nchar](5) NOT NULL,
	[Zip4] [nchar](4) NULL,
	[Phone] [nchar](10) NOT NULL,
	[Contact] [nvarchar](30) NOT NULL,
	[MAgmt] [nchar](1) NOT NULL CONSTRAINT [DF_Clients_MAgmt]  DEFAULT (N'N'),
 CONSTRAINT [PK_Clients] PRIMARY KEY CLUSTERED 
(
	[ClientID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Problems]    Script Date: 8/20/2014 9:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Problems](
	[TicketID] [int] NOT NULL,
	[IncidentNo] [int] NOT NULL,
	[ProblemDesc] [nvarchar](500) NOT NULL,
	[AssignedTechnician] [int] NOT NULL CONSTRAINT [DF_Problems_AssignedTechnician]  DEFAULT ((1)),
	[ProductID] [nvarchar](10) NOT NULL,
 CONSTRAINT [PK_Problems] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC,
	[IncidentNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Products]    Script Date: 8/20/2014 9:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Products](
	[ProductID] [nvarchar](10) NOT NULL,
	[ProductDesc] [nvarchar](250) NOT NULL,
	[ProductHS] [nchar](1) NOT NULL,
	[Manufacturer] [nvarchar](100) NULL,
 CONSTRAINT [PK_Products] PRIMARY KEY CLUSTERED 
(
	[ProductID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Resolutions]    Script Date: 8/20/2014 9:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Resolutions](
	[TicketID] [int] NOT NULL,
	[IncidentNo] [int] NOT NULL,
	[ResolutionNo] [int] NOT NULL,
	[ResolutionDesc] [nvarchar](500) NOT NULL,
	[DateFixed] [datetime] NULL,
	[DateOnsite] [datetime] NULL,
	[TechnicianID] [int] NOT NULL,
	[Hours] [decimal](10, 2) NULL,
	[CostHours] [money] NULL,
	[Mileage] [decimal](10, 1) NULL,
	[CostMiles] [money] NULL,
	[Supplies] [money] NULL,
	[Misc] [money] NULL,
 CONSTRAINT [PK_Resolutions] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC,
	[IncidentNo] ASC,
	[ResolutionNo] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[ServiceEvents]    Script Date: 8/20/2014 9:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[ServiceEvents](
	[TicketID] [int] IDENTITY(1,1) NOT NULL,
	[ClientID] [int] NOT NULL,
	[EventDate] [datetime] NOT NULL CONSTRAINT [DF_ServiceEvents_EventDate]  DEFAULT (getdate()),
	[Phone] [nvarchar](10) NOT NULL,
	[Contact] [nvarchar](30) NOT NULL,
 CONSTRAINT [PK_ServiceEvents] PRIMARY KEY CLUSTERED 
(
	[TicketID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
/****** Object:  Table [dbo].[Technicians]    Script Date: 8/20/2014 9:27:50 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[Technicians](
	[TechnicianID] [int] IDENTITY(1,1) NOT NULL,
	[LName] [nvarchar](30) NOT NULL,
	[FName] [nvarchar](20) NOT NULL,
	[MInit] [nchar](1) NULL,
	[EMail] [nvarchar](50) NULL,
	[Dept] [nvarchar](25) NULL,
	[Phone] [nchar](10) NOT NULL,
	[HRate] [money] NOT NULL CONSTRAINT [DF_Technicians_HRate]  DEFAULT ((50)),
 CONSTRAINT [PK_Technicians] PRIMARY KEY CLUSTERED 
(
	[TechnicianID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]

GO
SET IDENTITY_INSERT [dbo].[Clients] ON 

INSERT [dbo].[Clients] ([ClientID], [Institution], [Branch], [Address1], [Address2], [City], [State], [Zip], [Zip4], [Phone], [Contact], [MAgmt]) VALUES (1, N'Target', N'Ridgedale', N'1705 Ridgeview Dr.', N'Suite 1920', N'Minnetonka', N'MN', N'55555', NULL, N'7635551212', N'J. Smith', N'Y')
INSERT [dbo].[Clients] ([ClientID], [Institution], [Branch], [Address1], [Address2], [City], [State], [Zip], [Zip4], [Phone], [Contact], [MAgmt]) VALUES (2, N'Target', N'Southtown', N'8907 Penn Ave.', NULL, N'Bloomington', N'MN', N'55555', N'8907', N'9525551313', N'S. Johnson', N'N')
INSERT [dbo].[Clients] ([ClientID], [Institution], [Branch], [Address1], [Address2], [City], [State], [Zip], [Zip4], [Phone], [Contact], [MAgmt]) VALUES (3, N'Best Buy', N'St. Paul', N'3908 Roberts St.', NULL, N'St. Paul', N'MN', N'55555', N'3908', N'6515551414', N'B. Adams', N'Y')
INSERT [dbo].[Clients] ([ClientID], [Institution], [Branch], [Address1], [Address2], [City], [State], [Zip], [Zip4], [Phone], [Contact], [MAgmt]) VALUES (4, N'Cheapos', N'Uptown', N'2907 Lake St.', N'Suite 103', N'Minneapolis', N'MN', N'55555', NULL, N'6125551515', N'Y. Zarkins', N'N')
SET IDENTITY_INSERT [dbo].[Clients] OFF
INSERT [dbo].[Problems] ([TicketID], [IncidentNo], [ProblemDesc], [AssignedTechnician], [ProductID]) VALUES (1, 1, N'Printer does not print properly', 5, N'P100-992')
INSERT [dbo].[Problems] ([TicketID], [IncidentNo], [ProblemDesc], [AssignedTechnician], [ProductID]) VALUES (1, 2, N'Can not create expense document', 4, N'MS20-Word')
INSERT [dbo].[Problems] ([TicketID], [IncidentNo], [ProblemDesc], [AssignedTechnician], [ProductID]) VALUES (2, 1, N'Printer does not print properly', 1, N'P100-992')
INSERT [dbo].[Problems] ([TicketID], [IncidentNo], [ProblemDesc], [AssignedTechnician], [ProductID]) VALUES (2, 2, N'Can not calculate P&E', 3, N'MS25-Excel')
INSERT [dbo].[Problems] ([TicketID], [IncidentNo], [ProblemDesc], [AssignedTechnician], [ProductID]) VALUES (2, 3, N'Can not set 1024 by 768 resolution', 2, N'V89-1800')
INSERT [dbo].[Problems] ([TicketID], [IncidentNo], [ProblemDesc], [AssignedTechnician], [ProductID]) VALUES (3, 1, N'Error starting Word', 4, N'MS20-Word')
INSERT [dbo].[Products] ([ProductID], [ProductDesc], [ProductHS], [Manufacturer]) VALUES (N'A37-Acro', N'Acrobat 5.0', N'S', N'Adobe')
INSERT [dbo].[Products] ([ProductID], [ProductDesc], [ProductHS], [Manufacturer]) VALUES (N'MS20-Word', N'Word 2000', N'S', N'Microsoft')
INSERT [dbo].[Products] ([ProductID], [ProductDesc], [ProductHS], [Manufacturer]) VALUES (N'MS25-Excel', N'Excel 97', N'S', N'Microsoft')
INSERT [dbo].[Products] ([ProductID], [ProductDesc], [ProductHS], [Manufacturer]) VALUES (N'P100-992', N'HP DeskJet 992', N'H', N'Hewlett-Packard')
INSERT [dbo].[Products] ([ProductID], [ProductDesc], [ProductHS], [Manufacturer]) VALUES (N'V89-1800', N'18 inch LCD monitor', N'H', N'Viewsonic')
INSERT [dbo].[Resolutions] ([TicketID], [IncidentNo], [ResolutionNo], [ResolutionDesc], [DateFixed], [DateOnsite], [TechnicianID], [Hours], [CostHours], [Mileage], [CostMiles], [Supplies], [Misc]) VALUES (1, 1, 1, N'Could not correct, need parts', NULL, CAST(N'2012-12-17 09:15:00.000' AS DateTime), 5, CAST(1.00 AS Decimal(10, 2)), 55.0000, CAST(10.0 AS Decimal(10, 1)), 0.3500, NULL, NULL)
INSERT [dbo].[Resolutions] ([TicketID], [IncidentNo], [ResolutionNo], [ResolutionDesc], [DateFixed], [DateOnsite], [TechnicianID], [Hours], [CostHours], [Mileage], [CostMiles], [Supplies], [Misc]) VALUES (1, 1, 2, N'Replaced printhead', CAST(N'2008-12-18 15:15:00.000' AS DateTime), CAST(N'2012-12-18 13:05:00.000' AS DateTime), 5, CAST(2.00 AS Decimal(10, 2)), 55.0000, CAST(10.0 AS Decimal(10, 1)), 0.3500, 50.0000, NULL)
INSERT [dbo].[Resolutions] ([TicketID], [IncidentNo], [ResolutionNo], [ResolutionDesc], [DateFixed], [DateOnsite], [TechnicianID], [Hours], [CostHours], [Mileage], [CostMiles], [Supplies], [Misc]) VALUES (1, 2, 1, N'Reset template directory', CAST(N'2012-12-17 16:45:00.000' AS DateTime), NULL, 4, CAST(0.00 AS Decimal(10, 2)), 95.0000, NULL, NULL, NULL, NULL)
INSERT [dbo].[Resolutions] ([TicketID], [IncidentNo], [ResolutionNo], [ResolutionDesc], [DateFixed], [DateOnsite], [TechnicianID], [Hours], [CostHours], [Mileage], [CostMiles], [Supplies], [Misc]) VALUES (2, 2, 1, N'Rebuilt template', CAST(N'2012-12-04 08:35:00.000' AS DateTime), NULL, 3, CAST(2.00 AS Decimal(10, 2)), 60.0000, NULL, NULL, NULL, 35.0000)
INSERT [dbo].[Resolutions] ([TicketID], [IncidentNo], [ResolutionNo], [ResolutionDesc], [DateFixed], [DateOnsite], [TechnicianID], [Hours], [CostHours], [Mileage], [CostMiles], [Supplies], [Misc]) VALUES (2, 3, 1, N'Replaced monitor driver', CAST(N'2012-12-05 11:45:00.000' AS DateTime), NULL, 2, CAST(4.00 AS Decimal(10, 2)), 75.0000, NULL, NULL, NULL, NULL)
INSERT [dbo].[Resolutions] ([TicketID], [IncidentNo], [ResolutionNo], [ResolutionDesc], [DateFixed], [DateOnsite], [TechnicianID], [Hours], [CostHours], [Mileage], [CostMiles], [Supplies], [Misc]) VALUES (3, 1, 1, N'Restored deleted DLL', CAST(N'2012-12-18 14:05:00.000' AS DateTime), NULL, 4, CAST(2.00 AS Decimal(10, 2)), 95.0000, NULL, NULL, NULL, NULL)
SET IDENTITY_INSERT [dbo].[ServiceEvents] ON 

INSERT [dbo].[ServiceEvents] ([TicketID], [ClientID], [EventDate], [Phone], [Contact]) VALUES (1, 2, CAST(N'2012-12-16 11:45:00.000' AS DateTime), N'9525552222', N'Tom Totems')
INSERT [dbo].[ServiceEvents] ([TicketID], [ClientID], [EventDate], [Phone], [Contact]) VALUES (2, 4, CAST(N'2012-12-03 10:35:00.000' AS DateTime), N'9525553333', N'Jeff Johnson')
INSERT [dbo].[ServiceEvents] ([TicketID], [ClientID], [EventDate], [Phone], [Contact]) VALUES (3, 1, CAST(N'2012-12-18 13:15:00.000' AS DateTime), N'9525554444', N'Nancy Neal')
SET IDENTITY_INSERT [dbo].[ServiceEvents] OFF
SET IDENTITY_INSERT [dbo].[Technicians] ON 

INSERT [dbo].[Technicians] ([TechnicianID], [LName], [FName], [MInit], [EMail], [Dept], [Phone], [HRate]) VALUES (1, N'Support', N'Support', NULL, N'Support@SupportRUs.com', N'Support', N'9525555500', 50.0000)
INSERT [dbo].[Technicians] ([TechnicianID], [LName], [FName], [MInit], [EMail], [Dept], [Phone], [HRate]) VALUES (2, N'Ashton', N'Ashley', N'A', N'AAshton@SupportRUs.com', N'HW Eng', N'9525555550', 75.0000)
INSERT [dbo].[Technicians] ([TechnicianID], [LName], [FName], [MInit], [EMail], [Dept], [Phone], [HRate]) VALUES (3, N'Brown', N'Barry', N'B', N'BBrown@SupportRUs.com', N'App Eng', N'9525555551', 60.0000)
INSERT [dbo].[Technicians] ([TechnicianID], [LName], [FName], [MInit], [EMail], [Dept], [Phone], [HRate]) VALUES (4, N'Cass', N'Carrie', NULL, N'CCass@SupportRUs.com', N'SW Eng', N'9525555552', 95.0000)
INSERT [dbo].[Technicians] ([TechnicianID], [LName], [FName], [MInit], [EMail], [Dept], [Phone], [HRate]) VALUES (5, N'Dobbs', N'Dana', N'D', N'DDobbs@SupportRUs.com', N'Support', N'9525555553', 55.0000)
SET IDENTITY_INSERT [dbo].[Technicians] OFF
ALTER TABLE [dbo].[Problems]  WITH CHECK ADD  CONSTRAINT [FK_Problems_Products] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Products] ([ProductID])
GO
ALTER TABLE [dbo].[Problems] CHECK CONSTRAINT [FK_Problems_Products]
GO
ALTER TABLE [dbo].[Problems]  WITH CHECK ADD  CONSTRAINT [FK_Problems_ServiceEvents] FOREIGN KEY([TicketID])
REFERENCES [dbo].[ServiceEvents] ([TicketID])
GO
ALTER TABLE [dbo].[Problems] CHECK CONSTRAINT [FK_Problems_ServiceEvents]
GO
ALTER TABLE [dbo].[Problems]  WITH CHECK ADD  CONSTRAINT [FK_Problems_Technicians] FOREIGN KEY([AssignedTechnician])
REFERENCES [dbo].[Technicians] ([TechnicianID])
GO
ALTER TABLE [dbo].[Problems] CHECK CONSTRAINT [FK_Problems_Technicians]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [FK_Resolutions_Problems] FOREIGN KEY([TicketID], [IncidentNo])
REFERENCES [dbo].[Problems] ([TicketID], [IncidentNo])
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [FK_Resolutions_Problems]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [FK_Resolutions_Technicians] FOREIGN KEY([TechnicianID])
REFERENCES [dbo].[Technicians] ([TechnicianID])
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [FK_Resolutions_Technicians]
GO
ALTER TABLE [dbo].[ServiceEvents]  WITH CHECK ADD  CONSTRAINT [FK_ServiceEvents_Clients] FOREIGN KEY([ClientID])
REFERENCES [dbo].[Clients] ([ClientID])
GO
ALTER TABLE [dbo].[ServiceEvents] CHECK CONSTRAINT [FK_ServiceEvents_Clients]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [CK_Clients_MAgmt] CHECK  (([MAgmt]=N'Y' OR [MAgmt]=N'N'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_Clients_MAgmt]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [CK_Clients_Phone] CHECK  (([Phone] like N'[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_Clients_Phone]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [CK_Clients_Zip] CHECK  (([Zip] like N'[0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_Clients_Zip]
GO
ALTER TABLE [dbo].[Clients]  WITH CHECK ADD  CONSTRAINT [CK_Clients_Zip4] CHECK  (([Zip4] IS NULL OR [Zip4] like N'[0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Clients] CHECK CONSTRAINT [CK_Clients_Zip4]
GO
ALTER TABLE [dbo].[Problems]  WITH CHECK ADD  CONSTRAINT [CK_Problems_IncidentNo] CHECK  (([IncidentNo]>=(0)))
GO
ALTER TABLE [dbo].[Problems] CHECK CONSTRAINT [CK_Problems_IncidentNo]
GO
ALTER TABLE [dbo].[Products]  WITH CHECK ADD  CONSTRAINT [CK_Products_ProductHS] CHECK  (([ProductHS]=N'H' OR [ProductHS]=N'S'))
GO
ALTER TABLE [dbo].[Products] CHECK CONSTRAINT [CK_Products_ProductHS]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_CostHours] CHECK  (([CostHours] IS NULL OR [CostHours]>=(0.0)))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_CostHours]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_CostMiles] CHECK  (([CostMiles] IS NULL OR [CostMiles]>=(0.0)))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_CostMiles]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_DateFixed] CHECK  (([DateFixed] IS NULL OR [DateFixed]<=getdate()))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_DateFixed]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_DateOnsite] CHECK  (([DateOnsite] IS NULL OR [DateOnsite]<=getdate()))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_DateOnsite]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_Hours] CHECK  (([Hours] IS NULL OR [Hours]>=(0.0)))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_Hours]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_Mileage] CHECK  (([Mileage] IS NULL OR [Mileage]>=(0.0)))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_Mileage]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_Misc] CHECK  (([Misc] IS NULL OR [Misc]>=(0.0)))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_Misc]
GO
ALTER TABLE [dbo].[Resolutions]  WITH CHECK ADD  CONSTRAINT [CK_Resolutions_Supplies] CHECK  (([Supplies] IS NULL OR [Supplies]>=(0.0)))
GO
ALTER TABLE [dbo].[Resolutions] CHECK CONSTRAINT [CK_Resolutions_Supplies]
GO
ALTER TABLE [dbo].[ServiceEvents]  WITH CHECK ADD  CONSTRAINT [CK_ServiceEvents_EventDate] CHECK  (([EventDate]<=getdate()))
GO
ALTER TABLE [dbo].[ServiceEvents] CHECK CONSTRAINT [CK_ServiceEvents_EventDate]
GO
ALTER TABLE [dbo].[ServiceEvents]  WITH CHECK ADD  CONSTRAINT [CK_ServiceEvents_Phone] CHECK  (([Phone] like N'[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[ServiceEvents] CHECK CONSTRAINT [CK_ServiceEvents_Phone]
GO
ALTER TABLE [dbo].[Technicians]  WITH CHECK ADD  CONSTRAINT [CKTechnicians_HRATE] CHECK  (([HRate]>=(0.0)))
GO
ALTER TABLE [dbo].[Technicians] CHECK CONSTRAINT [CKTechnicians_HRATE]
GO
ALTER TABLE [dbo].[Technicians]  WITH CHECK ADD  CONSTRAINT [CKTechnicians_Phone] CHECK  (([Phone] like N'[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'))
GO
ALTER TABLE [dbo].[Technicians] CHECK CONSTRAINT [CKTechnicians_Phone]
GO
/****** Object:  StoredProcedure [dbo].[CreateTables]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--*********************************************************************
--** Creates new table structures, deleting any that might exist
--*********************************************************************

--** CreateTables
CREATE PROCEDURE [dbo].[CreateTables]
AS

DROP TABLE [dbo].[Resolutions]
DROP TABLE [dbo].[Problems]
DROP TABLE [dbo].[ServiceEvents]
DROP TABLE [dbo].[Technicians]
DROP TABLE [dbo].[Products]
DROP TABLE [dbo].[Clients]

--***** Client table
CREATE TABLE [dbo].[Clients]
([ClientID]    int IDENTITY(1,1) NOT NULL,
 [Institution] nvarchar(100) NOT NULL,
 [Branch]      nvarchar(50)  NOT NULL,
 [Address1]    nvarchar(30)  NOT NULL,
 [Address2]    nvarchar(30)  NULL,
 [City]        nvarchar(25)  NOT NULL,
 [State]       nchar(2)      NOT NULL,
 [Zip]         nchar(5)      NOT NULL,
 [Zip4]        nchar(4)      NULL,
 [Phone]       nchar(10)     NOT NULL,
 [Contact]     nvarchar(30)  NOT NULL,
 [MAgmt]       nchar(1)      NOT NULL 
    CONSTRAINT [DF_Clients_MAgmt]  DEFAULT (N'N'))

--***** Problem table
CREATE TABLE [dbo].[Problems]
([TicketID]           int           NOT NULL,
 [IncidentNo]         int           NOT NULL,
 [ProblemDesc]        nvarchar(500) NOT NULL,
 [AssignedTechnician] int           NOT NULL 
    CONSTRAINT [DF_Problems_AssignedTechnician]  DEFAULT ((1)),
 [ProductID]          nvarchar(10)  NOT NULL)

--***** Product table
CREATE TABLE [dbo].[Products]
([ProductID]    nvarchar(10)  NOT NULL,
 [ProductDesc]  nvarchar(250) NOT NULL,
 [ProductHS]    nchar(1)      NOT NULL,
 [Manufacturer] nvarchar(100) NULL)

--***** Resolution table
CREATE TABLE [dbo].[Resolutions]
([TicketID]       int           NOT NULL,
 [IncidentNo]     int           NOT NULL,
 [ResolutionNo]   int           NOT NULL,
 [ResolutionDesc] nvarchar(500) NOT NULL,
 [DateFixed]      datetime      NULL,
 [DateOnsite]     datetime      NULL,
 [TechnicianID]   int           NOT NULL,
 [Hours]          decimal(10,2) NULL,
 [CostHours]      money         NULL,
 [Mileage]        decimal(10,1) NULL,
 [CostMiles]      money         NULL,
 [Supplies]       money         NULL,
 [Misc]           money         NULL)

--***** Service Event table
CREATE TABLE [dbo].[ServiceEvents]
([TicketID]  int IDENTITY(1,1) NOT NULL,
 [ClientID]  int               NOT NULL,
 [EventDate] datetime          NOT NULL 
    CONSTRAINT [DF_ServiceEvents_EventDate]  DEFAULT (GETDATE()),
 [Phone]     nvarchar(10)      NOT NULL,
 [Contact]   nvarchar(30)      NOT NULL)

--***** Technician table
CREATE TABLE [dbo].[Technicians]
([TechnicianID] int IDENTITY(1,1) NOT NULL,
 [LName]        nvarchar(30) NOT NULL,
 [FName]        nvarchar(20) NOT NULL,
 [MInit]        nchar(1)     NULL,
 [EMail]        nvarchar(50) NULL,
 [Dept]         nvarchar(25) NULL,
 [Phone]        nchar(10)    NOT NULL,
 [HRate]        money        NOT NULL 
    CONSTRAINT [DF_Technicians_HRate]  DEFAULT ((50)))

--*****
--** Primary Keys
--*****
ALTER TABLE [dbo].[Clients]
ADD CONSTRAINT [PK_Clients] PRIMARY KEY ([ClientID])

ALTER TABLE [dbo].[Problems]
ADD CONSTRAINT [PK_Problems] PRIMARY KEY ([TicketID],[IncidentNo])

ALTER TABLE [dbo].[Products]
ADD CONSTRAINT [PK_Products] PRIMARY KEY ([ProductID])

ALTER TABLE [dbo].[Resolutions]
ADD CONSTRAINT [PK_Resolutions] PRIMARY KEY ([TicketID],[IncidentNo],[ResolutionNo])

ALTER TABLE [dbo].[ServiceEvents] 
ADD CONSTRAINT [PK_ServiceEvents] PRIMARY KEY ([TicketID])

ALTER TABLE [dbo].[Technicians]
ADD CONSTRAINT [PK_Technicians] PRIMARY KEY ([TechnicianID])

--*****
--** Check constraints
--*****
ALTER TABLE [dbo].[Clients]
ADD  CONSTRAINT [CK_Clients_MAgmt] CHECK ([MAgmt] IN (N'N',N'Y')),
     CONSTRAINT [CK_Clients_Phone] CHECK ([Phone] LIKE N'[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]'),
     CONSTRAINT [CK_Clients_Zip]   CHECK ([Zip] LIKE N'[0-9][0-9][0-9][0-9][0-9]'),
     CONSTRAINT [CK_Clients_Zip4]  CHECK ([Zip4] IS NULL OR [Zip4] LIKE N'[0-9][0-9][0-9][0-9]')

ALTER TABLE [dbo].[Problems]
ADD CONSTRAINT [CK_Problems_IncidentNo] CHECK ([IncidentNo] >= 0)

ALTER TABLE [dbo].[Products]  
ADD  CONSTRAINT [CK_Products_ProductHS] CHECK ([ProductHS] IN (N'S',N'H'))

ALTER TABLE [dbo].[Resolutions]
ADD  CONSTRAINT [CK_Resolutions_Hours]      CHECK ([Hours] IS NULL OR [Hours] >= 0.0),
     CONSTRAINT [CK_Resolutions_CostHours]  CHECK ([CostHours] IS NULL OR [CostHours] >= 0.0),
     CONSTRAINT [CK_Resolutions_CostMiles]  CHECK ([CostMiles] IS NULL OR [CostMiles] >= 0.0),
     CONSTRAINT [CK_Resolutions_DateFixed]  CHECK ([DateFixed] IS NULL OR [DateFixed] <= GETDATE()),
     CONSTRAINT [CK_Resolutions_DateOnsite] CHECK ([DateOnsite] IS NULL OR [DateOnsite] <= GETDATE()),
     CONSTRAINT [CK_Resolutions_Mileage]    CHECK ([Mileage] IS NULL OR [Mileage] >= 0.0),
     CONSTRAINT [CK_Resolutions_Misc]       CHECK ([Misc] IS NULL OR [Misc] >= 0.0),
     CONSTRAINT [CK_Resolutions_Supplies]   CHECK ([Supplies] IS NULL OR [Supplies] >= 0.0)

ALTER TABLE [dbo].[ServiceEvents]
ADD  CONSTRAINT [CK_ServiceEvents_EventDate] CHECK ([EventDate] <= GETDATE()),
     CONSTRAINT [CK_ServiceEvents_Phone]     CHECK ([Phone] LIKE N'[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

ALTER TABLE [dbo].[Technicians]
ADD  CONSTRAINT [CKTechnicians_HRATE] CHECK ([HRate] >= 0.0),
     CONSTRAINT [CKTechnicians_Phone] CHECK ([Phone] LIKE N'[1-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]')

--*****
--** Foreign Key constraints
ALTER TABLE [dbo].[Problems]  
ADD  CONSTRAINT [FK_Problems_Products] FOREIGN KEY ([ProductID])
       REFERENCES [dbo].[Products] ([ProductID]),
     CONSTRAINT [FK_Problems_ServiceEvents] FOREIGN KEY([TicketID])
       REFERENCES [dbo].[ServiceEvents] ([TicketID]),
     CONSTRAINT [FK_Problems_Technicians] FOREIGN KEY ([AssignedTechnician])
       REFERENCES [dbo].[Technicians] ([TechnicianID])

ALTER TABLE [dbo].[Resolutions]  
ADD  CONSTRAINT [FK_Resolutions_Problems] FOREIGN KEY([TicketId], [IncidentNo])
       REFERENCES [dbo].[Problems] ([TicketID], [IncidentNo]),
     CONSTRAINT [FK_Resolutions_Technicians] FOREIGN KEY ([TechnicianID])
       REFERENCES [dbo].[Technicians] ([TechnicianID])

ALTER TABLE [dbo].[ServiceEvents]  
ADD  CONSTRAINT [FK_ServiceEvents_Clients] FOREIGN KEY([ClientID])
       REFERENCES [dbo].[Clients] ([ClientID])

RETURN

GO
/****** Object:  StoredProcedure [dbo].[PopulateTables]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
--** PopulateTables
CREATE PROCEDURE [dbo].[PopulateTables]
AS
--*********************************************************************
--** Populate table structures
--*********************************************************************
/** Clients **/
INSERT INTO [dbo].[Clients] ([Institution],[Branch],[Address1],[Address2],[City],[State],[Zip],[Zip4],[Phone],[Contact],[MAgmt])
  VALUES ('Target','Ridgedale', '1705 Ridgeview Dr.', 'Suite 1920', 'Minnetonka', 'MN', '55555',null, '7635551212', 'J. Smith', 'Y')
INSERT INTO [dbo].[Clients] ([Institution],[Branch],[Address1],[Address2],[City],[State],[Zip],[Zip4],[Phone],[Contact],[MAgmt])
  VALUES ('Target','Southtown', '8907 Penn Ave.', null, 'Bloomington', 'MN', '55555', '8907', '9525551313', 'S. Johnson', 'N')
INSERT INTO [dbo].[Clients] ([Institution],[Branch],[Address1],[Address2],[City],[State],[Zip],[Zip4],[Phone],[Contact],[MAgmt])
  VALUES ('Best Buy','St. Paul', '3908 Roberts St.', null, 'St. Paul', 'MN', '55555', '3908', '6515551414', 'B. Adams', 'Y')
INSERT INTO [dbo].[Clients] ([Institution],[Branch],[Address1],[Address2],[City],[State],[Zip],[Zip4],[Phone],[Contact],[MAgmt])
  VALUES ('Cheapos','Uptown', '2907 Lake St.', 'Suite 103', 'Minneapolis', 'MN', '55555', null, '6125551515', 'Y. Zarkins', 'N')

/** Technicians **/
INSERT INTO [dbo].[Technicians] ([LName],[FName],[MInit],[EMail],[Dept],[Phone],[HRate])
  VALUES ('Support', 'Support', null, 'Support@SupportRUs.com', 'Support' ,'9525555500',DEFAULT)
INSERT INTO [dbo].[Technicians] ([LName],[FName],[MInit],[EMail],[Dept],[Phone],[HRate])
  VALUES ('Ashton', 'Ashley','A', 'AAshton@SupportRUs.com', 'HW Eng' ,'9525555550',75)
INSERT INTO [dbo].[Technicians] ([LName],[FName],[MInit],[EMail],[Dept],[Phone],[HRate])
  VALUES ('Brown', 'Barry', 'B', 'BBrown@SupportRUs.com', 'App Eng', '9525555551',60)
INSERT INTO [dbo].[Technicians] ([LName],[FName],[MInit],[EMail],[Dept],[Phone],[HRate])
  VALUES ('Cass', 'Carrie', null, 'CCass@SupportRUs.com', 'SW Eng', '9525555552',95)
INSERT INTO [dbo].[Technicians] ([LName],[FName],[MInit],[EMail],[Dept],[Phone],[HRate])
  VALUES ('Dobbs', 'Dana', 'D', 'DDobbs@SupportRUs.com', 'Support', '9525555553',55)

/** Product **/
INSERT INTO [dbo].[Products] ([ProductID],[ProductDesc],[ProductHS],[Manufacturer])
  VALUES ('P100-992','HP DeskJet 992', 'H', 'Hewlett-Packard')
INSERT INTO [dbo].[Products] ([ProductID],[ProductDesc],[ProductHS],[Manufacturer])
  VALUES ('V89-1800','18 inch LCD monitor', 'H', 'Viewsonic')
INSERT INTO [dbo].[Products] ([ProductID],[ProductDesc],[ProductHS],[Manufacturer])
  VALUES ('MS20-Word','Word 2000', 'S', 'Microsoft')
INSERT INTO [dbo].[Products] ([ProductID],[ProductDesc],[ProductHS],[Manufacturer])
  VALUES ('MS25-Excel','Excel 97', 'S', 'Microsoft')
INSERT INTO [dbo].[Products] ([ProductID],[ProductDesc],[ProductHS],[Manufacturer])
  VALUES ('A37-Acro','Acrobat 5.0', 'S', 'Adobe')

/** Service Events **/
INSERT INTO [dbo].[ServiceEvents] ([ClientID],[EventDate],[Phone],[Contact])
  VALUES (2, '16 Dec 2012 11:45:00','9525552222','Tom Totems')
INSERT INTO [dbo].[ServiceEvents] ([ClientID],[EventDate],[Phone],[Contact])
  VALUES (4, '3 Dec 2012 10:35:00','9525553333','Jeff Johnson')
INSERT INTO [dbo].[ServiceEvents] ([ClientID],[EventDate],[Phone],[Contact])
  VALUES (1, '18 Dec 2012 13:15:00','9525554444','Nancy Neal')

/** Problems **/
INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
  VALUES (1,1,'Printer does not print properly',5,'P100-992')
INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
  VALUES (1,2,'Can not create expense document',4,'MS20-Word')
INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
  VALUES (2,1,'Printer does not print properly',DEFAULT,'P100-992')
INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
  VALUES (2,2,'Can not calculate P&E',3,'MS25-Excel')
INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
  VALUES (2,3,'Can not set 1024 by 768 resolution',2,'V89-1800')
INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
  VALUES (3,1,'Error starting Word',4,'MS20-Word')

/** Resolution **/
INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
  VALUES (1,1,1,'Could not correct, need parts',null,'17 Dec 2012 09:15:00',5,1,55,10,.35,null,null)
INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
  VALUES (1,1,2,'Replaced printhead','18 Dec 2008 15:15:00','18 Dec 2012 13:05:00',5,2,55,10,.35,50,null)
INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
  VALUES (1,2,1,'Reset template directory','17 Dec 2012 16:45:00',null,4,0,95,null,null,null,null)
INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
  VALUES (2,2,1,'Rebuilt template','4 Dec 2012 08:35:00',null,3,2,60,null,null,null,35)
INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
  VALUES (2,3,1,'Replaced monitor driver','5 Dec 2012 11:45:00',null,2,4,75,null,null,null,null)
INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
  VALUES (3,1,1,'Restored deleted DLL','18 Dec 2012 14:05:00',null,4,2,95,null,null,null,null)

RETURN

GO
/****** Object:  StoredProcedure [dbo].[uspDeleteClient]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDeleteClient]
@ClientID int
AS
--*********************************************************************
--** Remove a client
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

DELETE [dbo].[Clients]
WHERE [ClientID] = @ClientID

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteProduct]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDeleteProduct]
@ProductID nvarchar(10)
AS
--*********************************************************************
--** Remove a product
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

DELETE [dbo].[Products]
WHERE [ProductID] = @ProductID

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode
GO
/****** Object:  StoredProcedure [dbo].[uspDeleteTechnician]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspDeleteTechnician]
@TechnicianID int
AS
--*********************************************************************
--** Remove a technician
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

DELETE [dbo].[Technicians]
WHERE [TechnicianID] = @TechnicianID

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode
GO
/****** Object:  StoredProcedure [dbo].[uspGetClientByID]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetClientByID]
@ClientID int
AS
--*********************************************************************
--** Get a specific client
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [ClientID],[Institution],[Branch],[Address1],[Address2],[City],
       [State],[Zip],[Zip4],[Phone],[Contact],[MAgmt]
FROM [dbo].[Clients]
WHERE [ClientID] = @ClientID;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;



GO
/****** Object:  StoredProcedure [dbo].[uspGetClientList]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetClientList]
AS
--*********************************************************************
--** Get client id and client name
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [ClientID],[Institution] + ' - ' + [Branch] AS [ClientName]
FROM [dbo].[Clients]
ORDER BY 2;

SET @ErrCode = @@ERROR;

SET NOCOUNT OFF;
RETURN @ErrCode;
GO
/****** Object:  StoredProcedure [dbo].[uspGetClients]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetClients]
AS
--*********************************************************************
--** Get all clients
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT *
FROM [dbo].[Clients]
ORDER BY 2;

SET @ErrCode = @@ERROR;

SET NOCOUNT OFF;
RETURN @ErrCode;
GO
/****** Object:  StoredProcedure [dbo].[uspGetOpenProblems]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetOpenProblems]
AS
--*********************************************************************
--** Get open problem list
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [se].[TicketID],[p].[IncidentNo],[p].[ProblemDesc],[se].[EventDate],[c].[Institution],[c].[Branch]
FROM [dbo].[ServiceEvents] [se]
LEFT JOIN [dbo].[Problems] [p] ON [se].[TicketID] = [p].[TicketID]
LEFT JOIN [dbo].[Resolutions] [r] ON [p].[TicketID] = [r].[TicketID] AND [p].[IncidentNo] = [r].[IncidentNo]
LEFT JOIN [dbo].[Clients] [c] ON [c].[ClientID] = [se].[ClientID]
WHERE [p].[IncidentNo] IS NOT NULL
  AND [r].[IncidentNo] IS NULL
ORDER BY [se].[TicketID],[p].[IncidentNo];

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspGetProductByID]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetProductByID]
@ProductID nvarchar(10)
AS
--*********************************************************************
--** Get a specific product
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [ProductID],[ProductDesc],[ProductHS],[Manufacturer]
FROM [dbo].[Products]
WHERE [ProductID] = @ProductID;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;


GO
/****** Object:  StoredProcedure [dbo].[uspGetProductList]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetProductList]
AS
--*********************************************************************
--** Get product id and description
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [ProductID],[ProductDesc]
FROM [dbo].[Products]
ORDER BY 2;

SET @ErrCode = @@ERROR;

SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspGetProducts]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetProducts]
AS
--*********************************************************************
--** Get all products
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT *
FROM [dbo].[Products]
ORDER BY 2;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;
GO
/****** Object:  StoredProcedure [dbo].[uspGetTechnicianByID]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTechnicianByID]
@TechnicianID int
AS
--*********************************************************************
--***** Get a specific technician
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [TechnicianID],[LName],[FName],[MInit],[EMail],[Dept],
       [Phone],[HRate]
FROM [dbo].[Technicians]
WHERE [TechnicianID] = @TechnicianID;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspGetTechnicianList]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTechnicianList]
AS
--*********************************************************************
--** Get technician id and name
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT [TechnicianID],LTRIM(RTRIM([LName] + CASE WHEN [FName] = N'Support' THEN N'' ELSE N', ' + [FName] END + CASE WHEN [MInit] IS NULL THEN N'' ELSE N' ' + LTRIM(RTRIM([MInit] + N'.')) END )) AS [TechName]
FROM [dbo].[Technicians]
ORDER BY 2;

SET @ErrCode = @@ERROR;

SET NOCOUNT OFF;
RETURN @ErrCode;
GO
/****** Object:  StoredProcedure [dbo].[uspGetTechnicians]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspGetTechnicians]
AS
--*********************************************************************
--** Get all technicians
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT *
FROM [dbo].[Technicians]
ORDER BY 2;

SET @ErrCode = @@ERROR;

SET NOCOUNT OFF;
RETURN @ErrCode;
GO
/****** Object:  StoredProcedure [dbo].[uspInsertClient]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertClient]
@Inst nvarchar(100),
@Branch nvarchar(50),
@Addr1 nvarchar(30),
@Addr2 nvarchar(30),
@City nvarchar(25),
@State nchar(2),
@Zip nchar(5),
@Zip4 nchar(4),
@Phone nchar(10),
@Contact nvarchar(30),
@MAgmt nchar(1),
@NewClientID int OUTPUT
AS
--*********************************************************************
--** Add a client
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

INSERT INTO [dbo].[Clients] ([Institution],[Branch],[Address1],[Address2],[City],[State],[Zip],[Zip4],[Phone],[Contact],[MAgmt])
  VALUES (@Inst, @Branch, @Addr1, @Addr2, @City, @State, @Zip, @Zip4, @Phone, @Contact, @MAgmt)

SELECT @ErrCode = @@ERROR, @NewClientID = SCOPE_IDENTITY()
SET NOCOUNT OFF
RETURN @ErrCode

GO
/****** Object:  StoredProcedure [dbo].[uspInsertProblem]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertProblem]
@TicketID int,
@IncidentNo int,
@ProbDesc nvarchar(500),
@TechID int,
@ProductID nvarchar(10)
AS
--*********************************************************************
--** Add a problem
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

INSERT INTO [dbo].[Problems] ([TicketID],[IncidentNo],[ProblemDesc],[AssignedTechnician],[ProductID])
VALUES (@TicketID, @IncidentNo, @ProbDesc, @TechID, @ProductID)

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode

GO
/****** Object:  StoredProcedure [dbo].[uspInsertProduct]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertProduct]
@ProductID nvarchar(10),
@ProdDesc nvarchar(250),
@ProdHS nchar(1),
@Mfg nvarchar(50)
AS
--*********************************************************************
--** Add a product
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

INSERT INTO [dbo].[Products] ([ProductID],[ProductDesc],[ProductHS],[Manufacturer])
  VALUES (@ProductID, @ProdDesc, @ProdHS, @Mfg)

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode

GO
/****** Object:  StoredProcedure [dbo].[uspInsertResolution]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertResolution]
@TicketID int,
@IncidentNo int,
@ResNo int,
@ResDesc nvarchar(500),
@DateFix datetime,
@DateOnsite datetime,
@TechID int,
@Hours decimal(10,2),
@Mileage decimal(10,1),
@CostMiles money,
@Supplies money,
@Misc money,
@NoCharge int = 0
AS
--*********************************************************************
--** Add a resolution
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

IF @NoCharge = 1
   INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
   VALUES (@TicketID, @IncidentNo, @ResNo, @ResDesc, @DateFix, @DateOnsite, @TechID, @Hours, 0.0, @Mileage, @CostMiles, @Supplies, @Misc)

ELSE
   INSERT INTO [dbo].[Resolutions] ([TicketID],[IncidentNo],[ResolutionNo],[ResolutionDesc],[DateFixed],[DateOnsite],[TechnicianID],[Hours],[CostHours],[Mileage],[CostMiles],[Supplies],[Misc])
   SELECT @TicketID, @IncidentNo, @ResNo, @ResDesc, @DateFix, @DateOnsite, @TechID, @Hours, [HRate], @Mileage, @CostMiles, @Supplies, @Misc
   FROM [dbo].[Technicians]
   WHERE [TechnicianID] = @TechID;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspInsertServiceEvent]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertServiceEvent]
@ClientID int,
@EventDate datetime,
@Phone nchar(10),
@Contact nvarchar(30),
@NewTicketID int OUTPUT
AS
--*********************************************************************
--** Add a service event
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

INSERT INTO [dbo].[ServiceEvents] ([ClientID],[EventDate],[Phone],[Contact])
VALUES (@ClientID, @EventDate, @Phone, @Contact)

SELECT @ErrCode = @@ERROR, @NewTicketID = SCOPE_IDENTITY()
SET NOCOUNT OFF
RETURN @ErrCode

GO
/****** Object:  StoredProcedure [dbo].[uspInsertTechnician]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspInsertTechnician]
@LName nvarchar(30),
@FName nvarchar(30),
@MInit nchar(1), 
@EMail nvarchar(50),
@Dept nvarchar(25),
@Phone nvarchar(10),
@HRate money,
@NewTechnicianID int OUTPUT
AS
--*********************************************************************
--** Add a technician
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

INSERT INTO [dbo].[Technicians] ([LName],[FName],[MInit],[EMail],[Dept],[Phone],[HRate])
  VALUES (@LName, @FName, @MInit, @EMail, @Dept, @Phone, @HRate)

SELECT @ErrCode = @@ERROR, @NewTechnicianID = SCOPE_IDENTITY()
SET NOCOUNT OFF
RETURN @ErrCode


GO
/****** Object:  StoredProcedure [dbo].[uspOpenProblemsByTicket]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspOpenProblemsByTicket]
@TicketID int
AS
--*********************************************************************
--** Get open problems by ticket id
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT DISTINCT [p].[ProblemDesc],[p].[IncidentNo] 
FROM [dbo].[Problems] [p] 
LEFT JOIN [dbo].[Resolutions] [r] ON [p].[TicketID] = [r].[TicketID] AND [p].[IncidentNo] = [r].[IncidentNo]
WHERE [r].[IncidentNo] IS NULL
  AND [p].[TicketID] = @TicketID
ORDER BY 1;
GO
/****** Object:  StoredProcedure [dbo].[uspProblemsByClient]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProblemsByClient]
AS
--*********************************************************************
--** Get costs by client
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT COUNT(*) AS NumberOfProblems,
       c.Institution, 
       c.Branch,
       SUM(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS TotalExpense,
       AVG(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS AverageExpense
FROM Problems p
INNER JOIN Resolutions r ON r.TicketID = p.TicketID AND r.IncidentNo = p.IncidentNo 
INNER JOIN ServiceEvents se ON se.TicketID = r.TicketID
INNER JOIN Clients c ON c.ClientID = se.ClientID
GROUP BY c.Institution, c.Branch 
ORDER BY 2,3;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;
GO
/****** Object:  StoredProcedure [dbo].[uspProblemsByInstitution]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProblemsByInstitution]
AS
--*********************************************************************
--** Get costs by Institution
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT COUNT(*) AS NumberOfProblems,
       c.Institution, 
       SUM(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS TotalExpense,
       AVG(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS AverageExpense
FROM Problems p
INNER JOIN Resolutions r ON r.TicketID = p.TicketID AND r.IncidentNo = p.IncidentNo 
INNER JOIN ServiceEvents se ON se.TicketID = r.TicketID
INNER JOIN Clients c ON c.ClientID = se.ClientID
GROUP BY c.Institution
ORDER BY 2;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspProblemsByProduct]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProblemsByProduct]
AS
--*********************************************************************
--** Get costs by Product
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT COUNT(*) AS NumberOfProblems,
       CONVERT(varchar,pr.ProductId) AS ProductId,
       RTRIM(pr.ProductDesc) AS Product, 
       SUM(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS TotalExpense,
       AVG(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS AverageExpense
FROM Problems p
INNER JOIN Resolutions r ON r.TicketID = p.TicketID AND r.IncidentNo = p.IncidentNo 
INNER JOIN Products pr ON pr.ProductId = p.ProductId
GROUP BY pr.ProductId, pr.ProductDesc
ORDER BY 3;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspProblemsByTechnician]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspProblemsByTechnician]
AS
--*********************************************************************
--** Get costs by Technician
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT COUNT(*) AS NumberOfProblems,
       t.TechnicianID,
       RTRIM(LName) + ', ' + RTrim(FName) AS TechnicianName,
       SUM(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS TotalExpense,
       AVG(ISNull((r.Hours * r.CostHours),0) + ISNULL((r.Mileage * r.CostMiles),0) + 
           ISNULL(r.Supplies,0) + ISNULL(r.Misc,0)) AS AverageExpense
FROM Problems p
INNER JOIN Resolutions r ON r.TicketID = p.TicketID AND r.IncidentNo = p.IncidentNo 
INNER JOIN Technicians t ON t.TechnicianID = p.AssignedTechnician
GROUP BY t.TechnicianID,RTRIM(LName) + ', ' + RTrim(FName)
ORDER BY 3;

SET @ErrCode = @@ERROR;
SET NOCOUNT OFF;
RETURN @ErrCode;

GO
/****** Object:  StoredProcedure [dbo].[uspTicketsWithOpenProblems]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspTicketsWithOpenProblems]
AS
--*********************************************************************
--** Get tickets with open problem
--*********************************************************************
SET NOCOUNT ON;
DECLARE @ErrCode int;

SELECT DISTINCT N'Ticket ' + CAST([p].[TicketID] AS nvarchar) + N': ' +  CONVERT(nvarchar,[se].[EventDate],106) AS [TicketInfo],[p].[TicketID] 
FROM [dbo].[ServiceEvents] [se]
LEFT JOIN [dbo].[Problems] [p] ON [se].[TicketID] = [p].[TicketID]
LEFT JOIN [dbo].[Resolutions] [r] ON [p].[TicketID] = [r].[TicketID] AND [p].[IncidentNo] = [r].[IncidentNo]
WHERE [p].[IncidentNo] IS NOT NULL
  AND [r].[IncidentNo] IS NULL
ORDER BY 1;
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateClient]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateClient]
@ClientID int,
@Inst nvarchar(100),
@Branch nvarchar(50),
@Addr1 nvarchar(30),
@Addr2 nvarchar(30),
@City nvarchar(25),
@State nchar(2),
@Zip nchar(5),
@Zip4 nchar(4),
@Phone nchar(10),
@Contact nvarchar(30),
@MAgmt nchar(1)
AS
--*********************************************************************
--** Modify a client
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

UPDATE [dbo].[Clients]
  SET [Address1] = @Addr1,
      [Address2] = @Addr2,
      [City] = @City, 
      [State] = @State, 
      [Zip] = @Zip,
      [Zip4] = @Zip4,
      [Phone] = @Phone,
      [Contact] = @Contact,
      [MAgmt] = @MAgmt,
      [Institution] = @Inst,
      [Branch] = @Branch
WHERE [ClientID] = @ClientID

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode

GO
/****** Object:  StoredProcedure [dbo].[uspUpdateProduct]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateProduct]
@ProductID nvarchar(10),
@ProdDesc nvarchar(250),
@ProdHS nchar(1),
@Mfg nvarchar(50)
AS
--*********************************************************************
--** Modify a product
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

UPDATE [dbo].[Products]
  SET [ProductDesc] = @ProdDesc,
      [ProductHS] = @ProdHS,
      [Manufacturer] = @Mfg
WHERE [ProductID] = @ProductID

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode
GO
/****** Object:  StoredProcedure [dbo].[uspUpdateTechnician]    Script Date: 8/20/2014 9:29:09 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[uspUpdateTechnician]
@TechnicianID int, 
@LName nvarchar(30),
@FName nvarchar(20),
@MInit nchar(1), 
@EMail nvarchar(50),
@Dept nvarchar(25),
@Phone nvarchar(10),
@HRate money
AS
--*********************************************************************
--** Modify a technician
--*********************************************************************
SET NOCOUNT ON
DECLARE @ErrCode int

UPDATE [dbo].[Technicians]
  SET LNAme = @LName,
      FName = @FName,
      MInit = @MInit,
      EMail = @EMail,
      Dept = @Dept, 
      Phone = @Phone,
      HRate = @HRate
WHERE TechnicianID = @TechnicianID

SET @ErrCode = @@ERROR
SET NOCOUNT OFF
RETURN @ErrCode
GO
