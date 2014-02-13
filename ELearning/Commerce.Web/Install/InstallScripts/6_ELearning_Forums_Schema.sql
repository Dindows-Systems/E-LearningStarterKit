/*
** Create missing tables
*/
if not exists (select 1 from sysobjects where id = object_id(N'yaf_Active') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Active(
		SessionID		nvarchar (24) NOT NULL ,
		BoardID			int NOT NULL ,
		UserID			int NOT NULL ,
		IP				nvarchar (15) NOT NULL ,
		Login			datetime NOT NULL ,
		LastActive		datetime NOT NULL ,
		Location		nvarchar (50) NOT NULL ,
		ForumID			int NULL ,
		TopicID			int NULL ,
		Browser			nvarchar (50) NULL ,
		Platform		nvarchar (50) NULL 
	)
go

if not exists (select 1 from sysobjects where id = object_id(N'yaf_BannedIP') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_BannedIP(
		ID				int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Mask			nvarchar (15) NOT NULL ,
		Since			datetime NOT NULL 
	)
go

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Category') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Category(
		CategoryID		int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Name			nvarchar (50) NOT NULL ,
		SortOrder		smallint NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_CheckEmail') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_CheckEmail(
		CheckEmailID	int IDENTITY (1, 1) NOT NULL ,
		UserID			int NOT NULL ,
		Email			nvarchar (50) NOT NULL ,
		Created			datetime NOT NULL ,
		Hash			nvarchar (32) NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Choice') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Choice(
		ChoiceID		int IDENTITY (1, 1) NOT NULL ,
		PollID			int NOT NULL ,
		Choice			nvarchar (50) NOT NULL ,
		Votes			int NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_PollVote') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	CREATE TABLE [dbo].[yaf_PollVote] (
		[PollVoteID] [int] IDENTITY (1, 1) NOT NULL ,
		[PollID] [int] NOT NULL ,
		[UserID] [int] NULL ,
		[RemoteIP] [nvarchar] (10) NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Forum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Forum(
		ForumID			int IDENTITY (1, 1) NOT NULL ,
		CategoryID		int NOT NULL ,
		ParentID		int NULL ,
		Name			nvarchar (50) NOT NULL ,
		Description		nvarchar (255) NOT NULL ,
		SortOrder		smallint NOT NULL ,
		LastPosted		datetime NULL ,
		LastTopicID		int NULL ,
		LastMessageID	int NULL ,
		LastUserID		int NULL ,
		LastUserName	nvarchar (50) NULL ,
		NumTopics		int NOT NULL,
		NumPosts		int NOT NULL,
		RemoteURL		nvarchar(100) null,
		Flags			int not null constraint DF_yaf_Forum_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_ForumAccess') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_ForumAccess(
		GroupID			int NOT NULL ,
		ForumID			int NOT NULL ,
		AccessMaskID	int NOT NULL
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Group') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Group(
		GroupID			int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Name			nvarchar (50) NOT NULL ,
		Flags			int not null constraint DF_yaf_Group_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Mail') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Mail(
		MailID			int IDENTITY (1, 1) NOT NULL ,
		FromUser		nvarchar (50) NOT NULL ,
		ToUser			nvarchar (50) NOT NULL ,
		Created			datetime NOT NULL ,
		Subject			nvarchar (100) NOT NULL ,
		Body			ntext NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Message') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Message(
		MessageID		int IDENTITY (1, 1) NOT NULL ,
		TopicID			int NOT NULL ,
		ReplyTo			int NULL ,
		Position		int NOT NULL ,
		Indent			int NOT NULL ,
		UserID			int NOT NULL ,
		UserName		nvarchar (50) NULL ,
		Posted			datetime NOT NULL ,
		Message			ntext NOT NULL ,
		IP				nvarchar (15) NOT NULL ,
		Edited			datetime NULL ,
		Flags			int NOT NULL constraint DF_yaf_Message_Flags default (23)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_PMessage') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_PMessage(
		PMessageID		int IDENTITY (1, 1) NOT NULL ,
		FromUserID		int NOT NULL ,
		Created			datetime NOT NULL ,
		Subject			nvarchar (100) NOT NULL ,
		Body			ntext NOT NULL,
		Flags			int NOT NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Poll') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Poll(
		PollID			int IDENTITY (1, 1) NOT NULL ,
		Question		nvarchar (50) NOT NULL,
		Closes datetime NULL 		
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Smiley') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Smiley(
		SmileyID		int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL ,
		Code			nvarchar (10) NOT NULL ,
		Icon			nvarchar (50) NOT NULL ,
		Emoticon		nvarchar (50) NULL 
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Topic') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Topic(
		TopicID			int IDENTITY (1, 1) NOT NULL ,
		ForumID			int NOT NULL ,
		UserID			int NOT NULL ,
		UserName		nvarchar (50) NULL ,
		Posted			datetime NOT NULL ,
		Topic			nvarchar (100) NOT NULL ,
		Views			int NOT NULL ,
		Priority		smallint NOT NULL ,
		PollID			int NULL ,
		TopicMovedID	int NULL ,
		LastPosted		datetime NULL ,
		LastMessageID	int NULL ,
		LastUserID		int NULL ,
		LastUserName	nvarchar (50) NULL,
		NumPosts		int NOT NULL,
		Flags			int not null constraint DF_yaf_Topic_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_User') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_User(
		UserID			int IDENTITY (1, 1) NOT NULL ,
		BoardID			int NOT NULL,
		Name			nvarchar (50) NOT NULL ,
		Password		nvarchar (32) NOT NULL ,
		Email			nvarchar (50) NULL ,
		Joined			datetime NOT NULL ,
		LastVisit		datetime NOT NULL ,
		IP				nvarchar (15) NULL ,
		NumPosts		int NOT NULL ,
		Location		nvarchar (50) NULL ,
		HomePage		nvarchar (50) NULL ,
		TimeZone		int NOT NULL ,
		Avatar			nvarchar (255) NULL ,
		Signature		ntext NULL ,
		AvatarImage		image NULL,
		RankID			int NOT NULL,
		Suspended		datetime NULL,
		LanguageFile	nvarchar(50) NULL,
		ThemeFile		nvarchar(50) NULL,
		MSN				nvarchar (50) NULL ,
		YIM				nvarchar (30) NULL ,
		AIM				nvarchar (30) NULL ,
		ICQ				int NULL ,
		RealName		nvarchar (50) NULL ,
		Occupation		nvarchar (50) NULL ,
		Interests		nvarchar (100) NULL ,
		Gender			tinyint NOT NULL ,
		Weblog			nvarchar (100) NULL,
		Flags			int not null constraint DF_yaf_User_Flags default (0)
)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_WatchForum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_WatchForum(
		WatchForumID	int IDENTITY (1, 1) NOT NULL ,
		ForumID			int NOT NULL ,
		UserID			int NOT NULL ,
		Created			datetime NOT NULL ,
		LastMail		datetime null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_WatchTopic') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_WatchTopic(
		WatchTopicID	int IDENTITY (1, 1) NOT NULL ,
		TopicID			int NOT NULL ,
		UserID			int NOT NULL ,
		Created			datetime NOT NULL ,
		LastMail		datetime null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Attachment') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Attachment(
		AttachmentID	int identity not null,
		MessageID		int not null,
		FileName		nvarchar(250) not null,
		Bytes			int not null,
		FileID			int null,
		ContentType		nvarchar(50) null,
		Downloads		int not null,
		FileData		image null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_UserGroup') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_UserGroup(
		UserID			int NOT NULL,
		GroupID			int NOT NULL
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Rank') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Rank(
		RankID			int IDENTITY (1, 1) NOT NULL,
		BoardID			int NOT NULL ,
		Name			nvarchar (50) NOT NULL,
		MinPosts		int NULL,
		RankImage		nvarchar (50) NULL,
		Flags			int not null constraint DF_yaf_Rank_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_AccessMask') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_AccessMask(
		AccessMaskID	int IDENTITY NOT NULL ,
		BoardID			int NOT NULL ,
		Name			nvarchar(50) NOT NULL ,
		Flags			int not null constraint DF_yaf_AccessMask_Flags default (0)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_UserForum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_UserForum(
		UserID			int NOT NULL ,
		ForumID			int NOT NULL ,
		AccessMaskID	int NOT NULL ,
		Invited			datetime NOT NULL ,
		Accepted		bit NOT NULL
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Board') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_Board(
		BoardID			int NOT NULL IDENTITY(1,1),
		Name			nvarchar(50) NOT NULL,
		AllowThreaded	bit NOT NULL,
	)
end
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_NntpServer') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_NntpServer(
		NntpServerID	int identity not null,
		BoardID			int NOT NULL ,
		Name			nvarchar(50) not null,
		Address			nvarchar(100) not null,
		Port			int null,
		UserName		nvarchar(50) null,
		UserPass		nvarchar(50) null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_NntpForum') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_NntpForum(
		NntpForumID		int identity not null,
		NntpServerID	int not null,
		GroupName		nvarchar(100) not null,
		ForumID			int not null,
		LastMessageNo	int not null,
		LastUpdate		datetime not null,
		Active			bit not null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_NntpTopic') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_NntpTopic(
		NntpTopicID		int identity not null,
		NntpForumID		int not null,
		Thread			char(32) not null,
		TopicID			int not null
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_UserPMessage') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_UserPMessage(
		UserPMessageID	int identity not null,
		UserID			int not null,
		PMessageID		int not null,
		IsRead			bit not null
	)
end
GO

if not exists (select * from dbo.sysobjects where id = object_id(N'yaf_Replace_Words') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
	create table dbo.yaf_Replace_Words(
		id				int IDENTITY (1, 1) NOT NULL ,
		badword			nvarchar (255) NULL ,
		goodword		nvarchar (255) NULL ,
		constraint PK_Replace_Words primary key(id)
	)
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_Registry') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_Registry(
		RegistryID		int IDENTITY(1, 1) NOT NULL,
		Name			nvarchar(50) NOT NULL,
		Value			nvarchar(400),
		BoardID			int,
		CONSTRAINT PK_Registry PRIMARY KEY (RegistryID)
	)
end
GO

if not exists (select 1 from sysobjects where id = object_id(N'yaf_EventLog') and OBJECTPROPERTY(id, N'IsUserTable') = 1)
begin
	create table dbo.yaf_EventLog(
		EventLogID	int identity(1,1) not null,
		EventTime	datetime not null constraint DF_EventLog_EventTime default getdate(),
		UserID		int not null,
		Source		nvarchar(50) not null,
		Description	ntext not null,
		constraint PK_EventLog primary key(EventLogID)
	)
end
GO

/*
** Added columns
*/

if exists(select 1 from dbo.syscolumns where id = object_id(N'yaf_User') and name=N'Signature' and xtype<>99)
	alter table yaf_User alter column Signature ntext null
go

if not exists(select * from syscolumns where id=object_id('yaf_Forum') and name='RemoteURL')
	alter table yaf_Forum add RemoteURL nvarchar(100) null
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_NntpForum') and name='Active')
begin
	alter table yaf_NntpForum add Active bit null
	exec('update yaf_NntpForum set Active=1 where Active is null')
	alter table yaf_NntpForum alter column Active bit not null
end
GO

if exists (select * from dbo.syscolumns where id = object_id(N'yaf_Replace_Words') and name='badword' and prec < 255)
 	alter table yaf_Replace_Words alter column badword nvarchar(255) NULL
GO

if exists (select * from dbo.syscolumns where id = object_id(N'yaf_Replace_Words') and name='goodword' and prec < 255)
	alter table yaf_Replace_Words alter column goodword nvarchar(255) NULL
GO	

if not exists(select 1 from syscolumns where id=object_id('yaf_Registry') and name='BoardID')
	alter table yaf_Registry add BoardID int
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_PMessage') and name='Flags')
begin
	alter table dbo.yaf_PMessage add Flags int not null constraint DF_yaf_Message_Flags default (23)
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Topic') and name='Flags')
begin
	alter table dbo.yaf_Topic add Flags int not null constraint DF_yaf_Topic_Flags default (0)
	update yaf_Message set Flags = Flags & 7
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Message') and name='Approved')
begin
	exec('update yaf_Message set Flags = Flags | 16 where Approved<>0')
	alter table dbo.yaf_Message drop column Approved
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Flags')
begin
	alter table dbo.yaf_Forum add Flags int not null constraint DF_yaf_Forum_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Locked')
begin
	exec('update yaf_Forum set Flags = Flags | 1 where Locked<>0')
	alter table dbo.yaf_Forum drop column Locked
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Hidden')
begin
	exec('update yaf_Forum set Flags = Flags | 2 where Hidden<>0')
	alter table dbo.yaf_Forum drop column Hidden
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='IsTest')
begin
	exec('update yaf_Forum set Flags = Flags | 4 where IsTest<>0')
	alter table dbo.yaf_Forum drop column IsTest
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Forum') and name='Moderated')
begin
	exec('update yaf_Forum set Flags = Flags | 8 where Moderated<>0')
	alter table dbo.yaf_Forum drop column Moderated
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='Flags')
begin
	alter table dbo.yaf_Group add Flags int not null constraint DF_yaf_Group_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsAdmin')
begin
	exec('update yaf_Group set Flags = Flags | 1 where IsAdmin<>0')
	alter table dbo.yaf_Group drop column IsAdmin
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsGuest')
begin
	exec('update yaf_Group set Flags = Flags | 2 where IsGuest<>0')
	alter table dbo.yaf_Group drop column IsGuest
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsStart')
begin
	exec('update yaf_Group set Flags = Flags | 4 where IsStart<>0')
	alter table dbo.yaf_Group drop column IsStart
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Group') and name='IsModerator')
begin
	exec('update yaf_Group set Flags = Flags | 8 where IsModerator<>0')
	alter table dbo.yaf_Group drop column IsModerator
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='Flags')
begin
	alter table dbo.yaf_AccessMask add Flags int not null constraint DF_yaf_AccessMask_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='ReadAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 1 where ReadAccess<>0')
	alter table dbo.yaf_AccessMask drop column ReadAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='PostAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 2 where PostAccess<>0')
	alter table dbo.yaf_AccessMask drop column PostAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='ReplyAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 4 where ReplyAccess<>0')
	alter table dbo.yaf_AccessMask drop column ReplyAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='PriorityAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 8 where PriorityAccess<>0')
	alter table dbo.yaf_AccessMask drop column PriorityAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='PollAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 16 where PollAccess<>0')
	alter table dbo.yaf_AccessMask drop column PollAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='VoteAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 32 where VoteAccess<>0')
	alter table dbo.yaf_AccessMask drop column VoteAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='ModeratorAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 64 where ModeratorAccess<>0')
	alter table dbo.yaf_AccessMask drop column ModeratorAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='EditAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 128 where EditAccess<>0')
	alter table dbo.yaf_AccessMask drop column EditAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='DeleteAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 256 where DeleteAccess<>0')
	alter table dbo.yaf_AccessMask drop column DeleteAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_AccessMask') and name='UploadAccess')
begin
	exec('update yaf_AccessMask set Flags = Flags | 512 where UploadAccess<>0')
	alter table dbo.yaf_AccessMask drop column UploadAccess
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Topic') and name='IsLocked')
begin
	grant update on yaf_Topic to public
	exec('update yaf_Topic set Flags = Flags | 1 where IsLocked<>0')
	revoke update on yaf_Topic from public
	alter table dbo.yaf_Topic drop column IsLocked
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_User') and name='Flags')
begin
	alter table dbo.yaf_User add Flags int not null constraint DF_yaf_User_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_User') and name='IsHostAdmin')
begin
	grant update on yaf_User to public
	exec('update yaf_User set Flags = Flags | 1 where IsHostAdmin<>0')
	revoke update on yaf_User from public
	alter table dbo.yaf_User drop column IsHostAdmin
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_User') and name='Approved')
begin
	grant update on yaf_User to public
	exec('update yaf_User set Flags = Flags | 2 where Approved<>0')
	revoke update on yaf_User from public
	alter table dbo.yaf_User drop column Approved
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Rank') and name='Flags')
begin
	alter table dbo.yaf_Rank add Flags int not null constraint DF_yaf_Rank_Flags default (0)
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Rank') and name='IsStart')
begin
	grant update on yaf_Rank to public
	exec('update yaf_Rank set Flags = Flags | 1 where IsStart<>0')
	revoke update on yaf_Rank from public
	alter table dbo.yaf_Rank drop column IsStart
end
GO

if exists(select 1 from syscolumns where id=object_id('yaf_Rank') and name='IsLadder')
begin
	grant update on yaf_Rank to public
	exec('update yaf_Rank set Flags = Flags | 2 where IsLadder<>0')
	revoke update on yaf_Rank from public
	alter table dbo.yaf_Rank drop column IsLadder
end
GO

if not exists(select 1 from syscolumns where id=object_id('yaf_Poll') and name='Closes')
begin
	alter table dbo.yaf_Poll add Closes datetime null
end
GO

/*
** Defaults
*/

if exists(select 1 from sysobjects where name=N'DF_yaf_Message_Flags' and parent_obj=object_id(N'yaf_Message'))
	alter table dbo.yaf_Message drop constraint DF_yaf_Message_Flags
GO

if not exists(select 1 from sysobjects where name=N'DF_yaf_Message_Flags' and parent_obj=object_id(N'yaf_Message'))
	alter table dbo.yaf_Message add constraint DF_yaf_Message_Flags default (23) for Flags
GO

/*
** Triggers
*/

if exists(select 1 from sysobjects where id=object_id(N'yaf_Active_insert') and objectproperty(id, N'IsTrigger') = 1)
	drop trigger yaf_Active_insert
go

create trigger yaf_Active_insert on dbo.yaf_Active for insert as
begin
	declare @BoardID int, @count int, @max int

	-- Assumes only one row was inserted - shouldn't be a problem?
	select @BoardID = BoardID from inserted
	
	select @count = count(distinct IP) from yaf_Active with(nolock) where BoardID=@BoardID
	select @max = cast(Value as int) from yaf_Registry where BoardID=@BoardID and Name=N'maxusers'
	if @@rowcount=0
	begin
		insert into yaf_Registry(BoardID,Name,Value) values(@BoardID,N'maxusers',cast(@count as nvarchar))
		insert into yaf_Registry(BoardID,Name,Value) values(@BoardID,N'maxuserswhen',convert(nvarchar,getdate(),126))
	end else if @count>@max
	begin
		update yaf_Registry set Value=cast(@count as nvarchar) where BoardID=@BoardID and Name=N'maxusers'
		update yaf_Registry set Value=convert(nvarchar,getdate(),126) where BoardID=@BoardID and Name=N'maxuserswhen'
	end
end
go

if exists(select 1 from sysobjects where id=object_id(N'yaf_Forum_update') and objectproperty(id, N'IsTrigger') = 1)
	drop trigger yaf_Forum_update
go

CREATE TRIGGER yaf_Forum_update ON dbo.yaf_Forum FOR UPDATE AS
BEGIN
	IF UPDATE(LastTopicID) OR UPDATE(LastMessageID)
	BEGIN	
		-- recursively update the forum
		DECLARE @ParentID int		

		SET @ParentID = (SELECT TOP 1 ParentID FROM inserted)
		
		WHILE (@ParentID IS NOT NULL)
		BEGIN
			UPDATE a SET
				a.LastPosted = b.LastPosted,
				a.LastTopicID = b.LastTopicID,
				a.LastMessageID = b.LastMessageID,
				a.LastUserID = b.LastUserID,
				a.LastUserName = b.LastUserName
			FROM
				yaf_Forum a, inserted b
			WHERE
				a.ForumID = @ParentID AND ((a.LastPosted < b.LastPosted) OR a.LastPosted IS NULL);
			
			SET @ParentID = (SELECT ParentID FROM yaf_Forum WHERE ForumID = @ParentID)
		END
	END
END
GO

if exists(select 1 from sysobjects where id=object_id(N'yaf_Group_update') and objectproperty(id, N'IsTrigger') = 1)
	drop trigger yaf_Group_update
GO

create trigger yaf_Group_update on dbo.yaf_Group for update as
begin
	declare @BoardID int
	declare @GroupID int
	declare @Flags int
	
	declare inserted_cursor cursor for
		select BoardID,GroupID,Flags from inserted
	
	open inserted_cursor
	fetch next from inserted_cursor into @BoardID,@GroupID,@Flags
	while @@FETCH_STATUS = 0
	begin
		if (@Flags & 2)<>0
		begin
			-- This is the guest group. Check for other guest groups
			if exists(select 1 from dbo.yaf_Group where BoardID=@BoardID and GroupID<>@GroupID and (Flags & 2)<>0) 
			begin
				raiserror('There are already other groups marked as guest groups',16,1)
			end
		end else
		begin
			-- This is not the guest group. Check for other guest groups
			if not exists(select 1 from dbo.yaf_Group where BoardID=@BoardID and (Flags & 2)<>0) 
			begin
				raiserror('There are no other groups marked as guest groups',16,1)
			end
		end
	
		fetch next from inserted_cursor into @BoardID,@GroupID,@Flags
	end
	close inserted_cursor
	deallocate inserted_cursor
end
GO

if exists(select 1 from sysobjects where id=object_id(N'yaf_Group_insert') and objectproperty(id, N'IsTrigger') = 1)
	drop trigger yaf_Group_insert
GO

create trigger yaf_Group_insert on dbo.yaf_Group for update as
begin
	declare @BoardID int
	declare @GroupID int
	declare @Flags int
	
	declare inserted_cursor cursor for
		select BoardID,GroupID,Flags from inserted
	
	open inserted_cursor
	fetch next from inserted_cursor into @BoardID,@GroupID,@Flags
	while @@FETCH_STATUS = 0
	begin
		if (@Flags & 2)<>0
		begin
			-- This is the guest group. Check for other guest groups
			if exists(select 1 from dbo.yaf_Group where BoardID=@BoardID and GroupID<>@GroupID and (Flags & 2)<>0) 
			begin
				raiserror('There are already other groups marked as guest groups',16,1)
			end
		end else
		begin
			-- This is not the guest group. Check for other guest groups
			if not exists(select 1 from dbo.yaf_Group where BoardID=@BoardID and (Flags & 2)<>0) 
			begin
				raiserror('There are no other groups marked as guest groups',16,1)
			end
		end
	
		fetch next from inserted_cursor into @BoardID,@GroupID,@Flags
	end
	close inserted_cursor
	deallocate inserted_cursor
end
GO

if exists(select 1 from sysobjects where id=object_id(N'yaf_UserGroup_insert') and objectproperty(id, N'IsTrigger') = 1)
	drop trigger yaf_UserGroup_insert
GO

create trigger yaf_UserGroup_insert on dbo.yaf_UserGroup for insert as
begin
	declare @UserID int
	declare @BoardID int
	declare @GroupID int
	declare @Flags int
	
	declare inserted_cursor cursor for
	select a.UserID,b.BoardID,b.GroupID,b.Flags from inserted a join dbo.yaf_Group b on b.GroupID=a.GroupID
	
	open inserted_cursor
	fetch next from inserted_cursor into @UserID,@BoardID,@GroupID,@Flags
	while @@FETCH_STATUS = 0
	begin
		if (@Flags & 2)<>0
		begin
			-- This is the guest group. Check for guest users
			if exists(select 1 from dbo.yaf_UserGroup where GroupID=@GroupID and UserID<>@UserID) 
			begin
				raiserror('There is already a user in the guest group',16,1)
			end
		end
	
		fetch next from inserted_cursor into @UserID,@BoardID,@GroupID,@Flags
	end
	close inserted_cursor
	deallocate inserted_cursor
end
GO

if exists(select 1 from sysobjects where id=object_id(N'yaf_UserGroup_delete') and objectproperty(id, N'IsTrigger') = 1)
	drop trigger yaf_UserGroup_delete
GO

create trigger yaf_UserGroup_delete on dbo.yaf_UserGroup for delete as
begin
	declare @UserID int
	declare @BoardID int
	declare @GroupID int
	declare @Flags int
	
	declare deleted_cursor cursor for
	select a.UserID,b.BoardID,b.GroupID,b.Flags from deleted a join dbo.yaf_Group b on b.GroupID=a.GroupID
	
	open deleted_cursor
	fetch next from deleted_cursor into @UserID,@BoardID,@GroupID,@Flags
	while @@FETCH_STATUS = 0
	begin
		if (@Flags & 2)<>0
		begin
			-- This is the guest group. We can't remove users from the guest group.
			raiserror('Users can not be removed from the guest group',16,1)
		end
	
		fetch next from deleted_cursor into @UserID,@BoardID,@GroupID,@Flags
	end
	close deleted_cursor
	deallocate deleted_cursor
end
GO

/*
** Views
*/

if exists (select 1 from sysobjects where id = object_id(N'yaf_vaccess') and OBJECTPROPERTY(id, N'IsView') = 1)
	drop view yaf_vaccess
GO

create view dbo.yaf_vaccess as
	select
		UserID				= a.UserID,
		ForumID				= x.ForumID,
		IsAdmin				= max(convert(int,b.Flags & 1)),
		IsGuest				= max(convert(int,b.Flags & 2)),
		IsForumModerator		= max(convert(int,b.Flags & 8)),
		IsModerator			= (select count(1) from dbo.yaf_UserGroup v,dbo.yaf_Group w,dbo.yaf_ForumAccess x,dbo.yaf_AccessMask y where v.UserID=a.UserID and w.GroupID=v.GroupID and x.GroupID=w.GroupID and y.AccessMaskID=x.AccessMaskID and (y.Flags & 64)<>0),
		ReadAccess			= max(x.ReadAccess),
		PostAccess			= max(x.PostAccess),
		ReplyAccess			= max(x.ReplyAccess),
		PriorityAccess			= max(x.PriorityAccess),
		PollAccess			= max(x.PollAccess),
		VoteAccess			= max(x.VoteAccess),
		ModeratorAccess			= max(x.ModeratorAccess),
		EditAccess			= max(x.EditAccess),
		DeleteAccess			= max(x.DeleteAccess),
		UploadAccess			= max(x.UploadAccess)
	from
		(select
			b.UserID,
			b.ForumID,
			ReadAccess		= convert(int,c.Flags & 1),
			PostAccess		= convert(int,c.Flags & 2),
			ReplyAccess		= convert(int,c.Flags & 4),
			PriorityAccess		= convert(int,c.Flags & 8),
			PollAccess		= convert(int,c.Flags & 16),
			VoteAccess		= convert(int,c.Flags & 32),
			ModeratorAccess		= convert(int,c.Flags & 64),
			EditAccess		= convert(int,c.Flags & 128),
			DeleteAccess		= convert(int,c.Flags & 256),
			UploadAccess		= convert(int,c.Flags & 512)
		from
			dbo.yaf_UserForum b
			join dbo.yaf_AccessMask c on c.AccessMaskID=b.AccessMaskID
		
		union
		
		select
			b.UserID,
			c.ForumID,
			ReadAccess		= convert(int,d.Flags & 1),
			PostAccess		= convert(int,d.Flags & 2),
			ReplyAccess		= convert(int,d.Flags & 4),
			PriorityAccess		= convert(int,d.Flags & 8),
			PollAccess		= convert(int,d.Flags & 16),
			VoteAccess		= convert(int,d.Flags & 32),
			ModeratorAccess		= convert(int,d.Flags & 64),
			EditAccess		= convert(int,d.Flags & 128),
			DeleteAccess		= convert(int,d.Flags & 256),
			UploadAccess		= convert(int,d.Flags & 512)
		from
			dbo.yaf_UserGroup b
			join dbo.yaf_ForumAccess c on c.GroupID=b.GroupID
			join dbo.yaf_AccessMask d on d.AccessMaskID=c.AccessMaskID

		union

		select
			a.UserID,
			ForumID			= convert(int,0),
			ReadAccess		= convert(int,0),
			PostAccess		= convert(int,0),
			ReplyAccess		= convert(int,0),
			PriorityAccess	= convert(int,0),
			PollAccess		= convert(int,0),
			VoteAccess		= convert(int,0),
			ModeratorAccess	= convert(int,0),
			EditAccess		= convert(int,0),
			DeleteAccess	= convert(int,0),
			UploadAccess	= convert(int,0)
		from
			dbo.yaf_User a
		) as x
		join dbo.yaf_UserGroup a on a.UserID=x.UserID
		join dbo.yaf_Group b on b.GroupID=a.GroupID
	group by a.UserID,x.ForumID
GO

/*
** Primary keys
*/

if not exists(select 1 from sysindexes where id=object_id('yaf_BannedIP') and name='PK_BannedIP')
	alter table dbo.yaf_BannedIP with nocheck add constraint PK_BannedIP primary key clustered(ID)
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Category') and name='PK_Category')
	alter table dbo.yaf_Category with nocheck add constraint PK_Category primary key clustered(CategoryID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_CheckEmail') and name='PK_CheckEmail')
	alter table dbo.yaf_CheckEmail with nocheck add constraint PK_CheckEmail primary key clustered(CheckEmailID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Choice') and name='PK_Choice')
	alter table dbo.yaf_Choice with nocheck add constraint PK_Choice primary key clustered(ChoiceID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Forum') and name='PK_Forum')
	alter table dbo.yaf_Forum with nocheck add constraint PK_Forum primary key clustered(ForumID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_ForumAccess') and name='PK_ForumAccess')
	alter table dbo.yaf_ForumAccess with nocheck add constraint PK_ForumAccess primary key clustered(GroupID,ForumID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Group') and name='PK_Group')
	alter table dbo.yaf_Group with nocheck add constraint PK_Group primary key clustered(GroupID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Mail') and name='PK_Mail')
	alter table dbo.yaf_Mail with nocheck add constraint PK_Mail primary key clustered(MailID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Message') and name='PK_Message')
	alter table dbo.yaf_Message with nocheck add constraint PK_Message primary key clustered(MessageID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_PMessage') and name='PK_PMessage')
	alter table dbo.yaf_PMessage with nocheck add constraint PK_PMessage primary key clustered(PMessageID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Poll') and name='PK_Poll')
	alter table dbo.yaf_Poll with nocheck add constraint PK_Poll primary key clustered(PollID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Smiley') and name='PK_Smiley')
	alter table dbo.yaf_Smiley with nocheck add constraint PK_Smiley primary key clustered(SmileyID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Topic') and name='PK_Topic')
	alter table dbo.yaf_Topic with nocheck add constraint PK_Topic primary key clustered(TopicID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_User') and name='PK_User')
	alter table dbo.yaf_User with nocheck add constraint PK_User primary key clustered(UserID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_WatchForum') and name='PK_WatchForum')
	alter table dbo.yaf_WatchForum with nocheck add constraint PK_WatchForum primary key clustered(WatchForumID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_WatchTopic') and name='PK_WatchTopic')
	alter table dbo.yaf_WatchTopic with nocheck add constraint PK_WatchTopic primary key clustered(WatchTopicID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_UserGroup') and name='PK_UserGroup')
	alter table dbo.yaf_UserGroup with nocheck add constraint PK_UserGroup primary key clustered(UserID,GroupID)
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Rank') and name='PK_Rank')
	alter table dbo.yaf_Rank with nocheck add constraint PK_Rank primary key clustered(RankID)
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_NntpServer') and name='PK_NntpServer')
	alter table dbo.yaf_NntpServer with nocheck add constraint PK_NntpServer primary key clustered (NntpServerID) 
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_NntpForum') and name='PK_NntpForum')
	alter table dbo.yaf_NntpForum with nocheck add constraint PK_NntpForum primary key clustered (NntpForumID) 
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_NntpTopic') and name='PK_NntpTopic')
	alter table dbo.yaf_NntpTopic with nocheck add constraint PK_NntpTopic primary key clustered (NntpTopicID) 
GO

if not exists(select * from sysindexes where id=object_id('yaf_AccessMask') and name='PK_AccessMask')
	alter table dbo.yaf_AccessMask with nocheck add constraint PK_AccessMask primary key clustered (AccessMaskID) 
GO

if not exists(select * from sysindexes where id=object_id('yaf_UserForum') and name='PK_UserForum')
	alter table dbo.yaf_UserForum with nocheck add constraint PK_UserForum primary key clustered (UserID,ForumID) 
GO

if not exists(select * from sysindexes where id=object_id('yaf_Board') and name='PK_Board')
	alter table dbo.yaf_Board with nocheck add constraint PK_Board primary key clustered (BoardID)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Active') and name='PK_Active')
	alter table dbo.yaf_Active with nocheck add constraint PK_Active primary key clustered(SessionID,BoardID)
GO

if not exists(select * from sysindexes where id=object_id('yaf_UserPMessage') and name='PK_UserPMessage')
	alter table dbo.yaf_UserPMessage with nocheck add constraint PK_UserPMessage primary key clustered (UserPMessageID) 
GO

if not exists(select * from sysindexes where id=object_id('yaf_Attachment') and name='PK_Attachment')
	alter table dbo.yaf_Attachment with nocheck add constraint PK_Attachment primary key clustered (AttachmentID) 
GO

if not exists(select * from sysindexes where id=object_id('yaf_Active') and name='PK_Active')
	alter table dbo.yaf_Active with nocheck add constraint PK_Active primary key clustered(SessionID,BoardID)
GO

if not exists(select * from sysindexes where id=object_id('yaf_PollVote') and name='PK_PollVote')
	alter table dbo.yaf_PollVote with nocheck add constraint PK_PollVote primary key clustered(PollVoteID)
GO

/*
** Unique constraints
*/

if not exists(select 1 from sysindexes where id=object_id('yaf_CheckEmail') and name='IX_CheckEmail')
	alter table dbo.yaf_CheckEmail add constraint IX_CheckEmail unique nonclustered (Hash)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_Forum') and name='IX_Forum')
	alter table dbo.yaf_Forum add constraint IX_Forum unique nonclustered (CategoryID,Name)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_WatchForum') and name='IX_WatchForum')
	alter table dbo.yaf_WatchForum add constraint IX_WatchForum unique nonclustered (ForumID,UserID)   
GO

if not exists(select 1 from sysindexes where id=object_id('yaf_WatchTopic') and name='IX_WatchTopic')
	alter table dbo.yaf_WatchTopic add constraint IX_WatchTopic unique nonclustered (TopicID,UserID)   
GO

if not exists(select * from sysindexes where id=object_id('yaf_Category') and name='IX_Category')
	alter table dbo.yaf_Category add constraint IX_Category unique nonclustered(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Rank') and name='IX_Rank')
	alter table dbo.yaf_Rank add constraint IX_Rank unique(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_User') and name='IX_User')
	alter table dbo.yaf_User add constraint IX_User unique nonclustered(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Group') and name='IX_Group')
	alter table dbo.yaf_Group add constraint IX_Group unique nonclustered(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_BannedIP') and name='IX_BannedIP')
	alter table dbo.yaf_BannedIP add constraint IX_BannedIP unique nonclustered(BoardID,Mask)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Smiley') and name='IX_Smiley')
	alter table dbo.yaf_Smiley add constraint IX_Smiley unique nonclustered(BoardID,Code)
GO

if not exists(select * from sysindexes where id=object_id('yaf_BannedIP') and name='IX_BannedIP')
	alter table dbo.yaf_BannedIP add constraint IX_BannedIP unique nonclustered(BoardID,Mask)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Category') and name='IX_Category')
	alter table dbo.yaf_Category add constraint IX_Category unique nonclustered(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_CheckEmail') and name='IX_CheckEmail')
	alter table dbo.yaf_CheckEmail add constraint IX_CheckEmail unique nonclustered(Hash)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Forum') and name='IX_Forum')
	alter table dbo.yaf_Forum add constraint IX_Forum unique nonclustered(CategoryID,Name)   
GO

if not exists(select * from sysindexes where id=object_id('yaf_Group') and name='IX_Group')
	alter table dbo.yaf_Group add constraint IX_Group unique nonclustered(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Rank') and name='IX_Rank')
	alter table dbo.yaf_Rank add constraint IX_Rank unique nonclustered(BoardID,Name)
GO

if not exists(select * from sysindexes where id=object_id('yaf_Smiley') and name='IX_Smiley')
	alter table dbo.yaf_Smiley add constraint IX_Smiley unique nonclustered(BoardID,Code)
GO

if not exists(select * from sysindexes where id=object_id('yaf_User') and name='IX_User')
	alter table dbo.yaf_User add constraint IX_User unique nonclustered(BoardID,Name)
GO

/*
** Indexes
*/

if exists(select 1 from dbo.sysindexes where name=N'IX_Name' and id=object_id(N'yaf_Registry'))
	drop index dbo.yaf_Registry.IX_Name
go

if not exists(select 1 from dbo.sysindexes where name=N'IX_Name' and id=object_id(N'yaf_Registry'))
	create unique index IX_Name on dbo.yaf_Registry(BoardID,Name)
go

if not exists(select 1 from dbo.sysindexes where name=N'IX_yaf_PollVote_RemoteIP' and id=object_id(N'yaf_PollVote'))
 CREATE  INDEX [IX_yaf_PollVote_RemoteIP] ON [dbo].[yaf_PollVote]([RemoteIP])
GO

if not exists(select 1 from dbo.sysindexes where name=N'IX_yaf_PollVote_UserID' and id=object_id(N'yaf_PollVote'))
 CREATE  INDEX [IX_yaf_PollVote_UserID] ON [dbo].[yaf_PollVote]([UserID])
GO

if not exists(select 1 from dbo.sysindexes where name=N'IX_yaf_PollVote_PollID' and id=object_id(N'yaf_PollVote'))
 CREATE  INDEX [IX_yaf_PollVote_PollID] ON [dbo].[yaf_PollVote]([PollID])
GO