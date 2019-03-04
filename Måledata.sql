CREATE TABLE [dbo].[Måledata]
(
	[Måletidspunkt] TIMESTAMP NOT NULL, 
    [Mail] NVARCHAR(100) NOT NULL, 
    CONSTRAINT [FK_Måledata_Abonenter] FOREIGN KEY (Mail) REFERENCES [Abonenter]([Mailaddresse]), 
    CONSTRAINT [FK_Måledata_ToTable_1] FOREIGN KEY ([Måletidspunkt]) REFERENCES [Målinger]([Måletidspunkt]), 
    CONSTRAINT [PK_Måledata] PRIMARY KEY ([Mail], [Måletidspunkt]) 
	
)
