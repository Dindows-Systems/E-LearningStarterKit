/*
** Foreign keys
*/

if not exists(select 1 from sysobjects where name='FK_Active_Forum' and parent_obj=object_id('yaf_Active') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Active add constraint FK_Active_Forum foreign key (ForumID) references dbo.yaf_Forum (ForumID)
GO

if not exists(select 1 from sysobjects where name='FK_Active_Topic' and parent_obj=object_id('yaf_Active') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Active add constraint FK_Active_Topic foreign key (TopicID) references dbo.yaf_Topic (TopicID)
GO

if not exists(select 1 from sysobjects where name='FK_Active_User' and parent_obj=object_id('yaf_Active') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Active add constraint FK_Active_User foreign key (UserID) references dbo.yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_CheckEmail_User' and parent_obj=object_id('yaf_CheckEmail') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_CheckEmail add constraint FK_CheckEmail_User foreign key (UserID) references dbo.yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_Choice_Poll' and parent_obj=object_id('yaf_Choice') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Choice add constraint FK_Choice_Poll foreign key (PollID) references dbo.yaf_Poll (PollID)
GO

if not exists(select 1 from sysobjects where name='FK_Forum_Category' and parent_obj=object_id('yaf_Forum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Forum add constraint FK_Forum_Category foreign key (CategoryID) references dbo.yaf_Category (CategoryID)
GO

if not exists(select 1 from sysobjects where name='FK_Forum_Message' and parent_obj=object_id('yaf_Forum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Forum add constraint FK_Forum_Message foreign key (LastMessageID) references dbo.yaf_Message (MessageID)
GO

if not exists(select 1 from sysobjects where name='FK_Forum_Topic' and parent_obj=object_id('yaf_Forum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Forum add constraint FK_Forum_Topic foreign key (LastTopicID) references dbo.yaf_Topic (TopicID)
GO

if not exists(select 1 from sysobjects where name='FK_Forum_User' and parent_obj=object_id('yaf_Forum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Forum add constraint FK_Forum_User foreign key (LastUserID) references dbo.yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_ForumAccess_Forum' and parent_obj=object_id('yaf_ForumAccess') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_ForumAccess add constraint FK_ForumAccess_Forum foreign key (ForumID) references dbo.yaf_Forum (ForumID)
GO

if not exists(select 1 from sysobjects where name='FK_ForumAccess_Group' and parent_obj=object_id('yaf_ForumAccess') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_ForumAccess add constraint FK_ForumAccess_Group foreign key (GroupID) references dbo.yaf_Group (GroupID)
GO

if not exists(select 1 from sysobjects where name='FK_Message_Topic' and parent_obj=object_id('yaf_Message') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Message add constraint FK_Message_Topic foreign key (TopicID) references dbo.yaf_Topic (TopicID)
GO

if not exists(select 1 from sysobjects where name='FK_Message_User' and parent_obj=object_id('yaf_Message') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Message add constraint FK_Message_User foreign key (UserID) references dbo.yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_PMessage_User1' and parent_obj=object_id('yaf_PMessage') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_PMessage add constraint FK_PMessage_User1 foreign key (FromUserID) references dbo.yaf_User (UserID)
GO

if exists(select 1 from sysobjects where name='FK_Topic_Forum' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic drop constraint FK_Topic_Forum
GO

if not exists(select 1 from sysobjects where name='FK_Topic_Forum' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic add constraint FK_Topic_Forum foreign key (ForumID) references dbo.yaf_Forum (ForumID) ON DELETE CASCADE
GO

if not exists(select 1 from sysobjects where name='FK_Topic_Message' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic add constraint FK_Topic_Message foreign key (LastMessageID) references dbo.yaf_Message (MessageID)
GO

if not exists(select 1 from sysobjects where name='FK_Topic_Poll' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic add constraint FK_Topic_Poll foreign key (PollID) references dbo.yaf_Poll (PollID)
GO

if not exists(select 1 from sysobjects where name='FK_Topic_Topic' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic add constraint FK_Topic_Topic foreign key (TopicMovedID) references dbo.yaf_Topic (TopicID)
GO

if not exists(select 1 from sysobjects where name='FK_Topic_User' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic add constraint FK_Topic_User foreign key (UserID) references dbo.yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_Topic_User2' and parent_obj=object_id('yaf_Topic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Topic add constraint FK_Topic_User2 foreign key (LastUserID) references dbo.yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_WatchForum_Forum' and parent_obj=object_id('yaf_WatchForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_WatchForum add constraint FK_WatchForum_Forum foreign key (ForumID) references dbo.yaf_Forum(ForumID)
GO

if not exists(select 1 from sysobjects where name='FK_WatchForum_User' and parent_obj=object_id('yaf_WatchForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_WatchForum add constraint FK_WatchForum_User foreign key (UserID) references dbo.yaf_User(UserID)
GO

if not exists(select 1 from sysobjects where name='FK_WatchTopic_Topic' and parent_obj=object_id('yaf_WatchTopic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_WatchTopic add constraint FK_WatchTopic_Topic foreign key (TopicID) references dbo.yaf_Topic(TopicID)
GO

if not exists(select 1 from sysobjects where name='FK_WatchTopic_User' and parent_obj=object_id('yaf_WatchTopic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_WatchTopic add constraint FK_WatchTopic_User foreign key (UserID) references dbo.yaf_User(UserID)
GO

if not exists(select 1 from sysobjects where name='FK_Active_Forum' and parent_obj=object_id('yaf_Active') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Attachment add constraint FK_Attachment_Message foreign key (MessageID) references yaf_Message (MessageID)
GO

if not exists(select 1 from sysobjects where name='FK_UserGroup_User' and parent_obj=object_id('yaf_UserGroup') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserGroup add constraint FK_UserGroup_User foreign key (UserID) references yaf_User(UserID)
GO

if not exists(select 1 from sysobjects where name='FK_UserGroup_Group' and parent_obj=object_id('yaf_UserGroup') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserGroup add constraint FK_UserGroup_Group foreign key(GroupID) references yaf_Group (GroupID)
GO

if not exists(select 1 from sysobjects where name='FK_Attachment_Message' and parent_obj=object_id('yaf_Attachment') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Attachment add constraint FK_Attachment_Message foreign key (MessageID) references yaf_Message (MessageID)
GO

if not exists(select 1 from sysobjects where name='FK_NntpForum_NntpServer' and parent_obj=object_id('yaf_NntpForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_NntpForum add constraint FK_NntpForum_NntpServer foreign key (NntpServerID) references yaf_NntpServer(NntpServerID)
GO

if not exists(select 1 from sysobjects where name='FK_NntpForum_Forum' and parent_obj=object_id('yaf_NntpForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_NntpForum add constraint FK_NntpForum_Forum foreign key (ForumID) references yaf_Forum(ForumID)
GO

if not exists(select 1 from sysobjects where name='FK_NntpTopic_NntpForum' and parent_obj=object_id('yaf_NntpTopic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_NntpTopic add constraint FK_NntpTopic_NntpForum foreign key (NntpForumID) references yaf_NntpForum(NntpForumID)
GO

if not exists(select 1 from sysobjects where name='FK_NntpTopic_Topic' and parent_obj=object_id('yaf_NntpTopic') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_NntpTopic add constraint FK_NntpTopic_Topic foreign key (TopicID) references yaf_Topic(TopicID)
GO

if not exists(select 1 from sysobjects where name='FK_ForumAccess_AccessMask' and parent_obj=object_id('yaf_ForumAccess') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_ForumAccess add constraint FK_ForumAccess_AccessMask foreign key (AccessMaskID) references yaf_AccessMask (AccessMaskID)
GO

if not exists(select 1 from sysobjects where name='FK_UserForum_User' and parent_obj=object_id('yaf_UserForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserForum add constraint FK_UserForum_User foreign key (UserID) references yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_UserForum_Forum' and parent_obj=object_id('yaf_UserForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserForum add constraint FK_UserForum_Forum foreign key (ForumID) references yaf_Forum (ForumID)
GO

if not exists(select 1 from sysobjects where name='FK_UserForum_AccessMask' and parent_obj=object_id('yaf_UserForum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserForum add constraint FK_UserForum_AccessMask foreign key (AccessMaskID) references yaf_AccessMask (AccessMaskID)
GO

if not exists(select 1 from sysobjects where name='FK_Category_Board' and parent_obj=object_id('yaf_Category') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Category add constraint FK_Category_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_AccessMask_Board' and parent_obj=object_id('yaf_AccessMask') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_AccessMask add constraint FK_AccessMask_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_Active_Board' and parent_obj=object_id('yaf_Active') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Active add constraint FK_Active_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_BannedIP_Board' and parent_obj=object_id('yaf_BannedIP') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_BannedIP add constraint FK_BannedIP_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_Group_Board' and parent_obj=object_id('yaf_Group') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Group add constraint FK_Group_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_NntpServer_Board' and parent_obj=object_id('yaf_NntpServer') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_NntpServer add constraint FK_NntpServer_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_Rank_Board' and parent_obj=object_id('yaf_Rank') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Rank add constraint FK_Rank_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_Smiley_Board' and parent_obj=object_id('yaf_Smiley') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Smiley add constraint FK_Smiley_Board foreign key(BoardID) references yaf_Board (BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_User_Rank' and parent_obj=object_id('yaf_User') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_User add constraint FK_User_Rank foreign key(RankID) references yaf_Rank(RankID)
GO

if not exists(select 1 from sysobjects where name='FK_User_Board' and parent_obj=object_id('yaf_User') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_User add constraint FK_User_Board foreign key(BoardID) references yaf_Board(BoardID)
GO

if not exists(select 1 from sysobjects where name='FK_Forum_Forum' and parent_obj=object_id('yaf_Forum') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Forum add constraint FK_Forum_Forum foreign key(ParentID) references yaf_Forum(ForumID)
GO

if not exists(select 1 from sysobjects where name='FK_Message_Message' and parent_obj=object_id('yaf_Message') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Message add constraint FK_Message_Message foreign key(ReplyTo) references yaf_Message(MessageID)
GO

if not exists(select 1 from sysobjects where name='FK_UserPMessage_User' and parent_obj=object_id('yaf_UserPMessage') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserPMessage add constraint FK_UserPMessage_User foreign key (UserID) references yaf_User (UserID)
GO

if not exists(select 1 from sysobjects where name='FK_UserPMessage_PMessage' and parent_obj=object_id('yaf_UserPMessage') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_UserPMessage add constraint FK_UserPMessage_PMessage foreign key (PMessageID) references yaf_PMessage (PMessageID)
GO

if not exists(select 1 from sysobjects where name='FK_Registry_Board' and parent_obj=object_id('yaf_Registry') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_Registry add constraint FK_Registry_Board foreign key(BoardID) references yaf_Board(BoardID) on delete cascade
go

if not exists(select 1 from sysobjects where name='FK_yaf_PollVote_yaf_Poll' and parent_obj=object_id('yaf_PollVote') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_PollVote add constraint FK_yaf_PollVote_yaf_Poll foreign key(PollID) references yaf_Poll(PollID) on delete cascade
go

if not exists(select 1 from sysobjects where name='FK_EventLog_User' and parent_obj=object_id('yaf_EventLog') and OBJECTPROPERTY(id,N'IsForeignKey')=1)
	alter table dbo.yaf_EventLog add constraint FK_EventLog_User foreign key(UserID) references dbo.yaf_User(UserID)
go