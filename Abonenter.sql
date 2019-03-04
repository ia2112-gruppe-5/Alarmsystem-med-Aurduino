CREATE TABLE [dbo].[Abonenter]
(
	[Mailaddresse] NVARCHAR(100) NOT NULL PRIMARY KEY, 
    [Fornavn] NVARCHAR(50) NULL, 
    [Etternavn] NVARCHAR(50) NULL, 
    [Telefonnummer] INT NULL, 
	[Postnummer] CHAR(4) NOT NULL,
    CONSTRAINT [FK_Abonenter_ToTable] FOREIGN KEY (Postnummer) REFERENCES [Postaddresse]([Postnummer])
)
