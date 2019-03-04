CREATE TABLE [dbo].[AlarmData]
(
	[Mailaddresse] NVARCHAR(100) NOT NULL, 
    [AlarmId] TIMESTAMP NOT NULL,
    CONSTRAINT [FK_AlarmData_Abonenter] FOREIGN KEY ([Mailaddresse]) REFERENCES [Abonenter]([Mailaddresse]), 
    CONSTRAINT [FK_AlarmData_Alarmer] FOREIGN KEY ([AlarmId]) REFERENCES [Alarmer]([AlarmId]),
	CONSTRAINT [PK_AlarmData] PRIMARY KEY ([Mailaddresse], [AlarmId])
)
