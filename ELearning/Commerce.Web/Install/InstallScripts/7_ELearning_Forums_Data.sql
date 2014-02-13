-----------------
-- yaf_AccessMask
-----------------
SET IDENTITY_INSERT [dbo].[yaf_AccessMask] ON


INSERT INTO [dbo].[yaf_AccessMask] ([AccessMaskID], [BoardID], [Name], [Flags])
VALUES (1, 1, N'Admin Access Mask', 1023)


INSERT INTO [dbo].[yaf_AccessMask] ([AccessMaskID], [BoardID], [Name], [Flags])
VALUES (2, 1, N'Moderator Access Mask', 487)


INSERT INTO [dbo].[yaf_AccessMask] ([AccessMaskID], [BoardID], [Name], [Flags])
VALUES (3, 1, N'Member Access Mask', 423)


INSERT INTO [dbo].[yaf_AccessMask] ([AccessMaskID], [BoardID], [Name], [Flags])
VALUES (4, 1, N'Read Only Access Mask', 1)


INSERT INTO [dbo].[yaf_AccessMask] ([AccessMaskID], [BoardID], [Name], [Flags])
VALUES (5, 1, N'Visitante', 0)

SET IDENTITY_INSERT [dbo].[yaf_AccessMask] OFF


-----------------
-- yaf_Active
-----------------
INSERT INTO [dbo].[yaf_Active] ([SessionID], [BoardID], [UserID], [IP], [Login], [LastActive], [Location], [ForumID], [TopicID], [Browser], [Platform])
VALUES (N'eeyhmh45zywaz4u5plxkwu55', 1, 2, N'127.0.0.1', '20061104', '20061104', N'/Commerce.Web/Forums/default.aspx', NULL, NULL, N'IE 6.0', N'WinXP')


-----------------
-- yaf_Board
-----------------
SET IDENTITY_INSERT [dbo].[yaf_Board] ON


INSERT INTO [dbo].[yaf_Board] ([BoardID], [Name], [AllowThreaded])
VALUES (1, N'Foros', 0)

SET IDENTITY_INSERT [dbo].[yaf_Board] OFF


-----------------
-- yaf_Category
-----------------

SET IDENTITY_INSERT [dbo].[yaf_Category] ON


INSERT INTO [dbo].[yaf_Category] ([CategoryID], [BoardID], [Name], [SortOrder])
VALUES (2, 1, N'Foros Públicos', 0)


INSERT INTO [dbo].[yaf_Category] ([CategoryID], [BoardID], [Name], [SortOrder])
VALUES (3, 1, N'Foros Solo Para Clientes', 0)

SET IDENTITY_INSERT [dbo].[yaf_Category] OFF


-----------------
-- yaf_Forum
-----------------
SET IDENTITY_INSERT [dbo].[yaf_Forum] ON


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (2, 2, NULL, N'Sistemas Operativos', N'Discusiones sobre los distintos sistemas operativos cubiertos por los cursos de Latino E-Learning. ', 1, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (4, 3, NULL, N'Sistemas Operativos', N'Discusiones sobre los distintos sistemas operativos cubiertos por los cursos de Latino E-Learning.', 1, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (5, 3, NULL, N'Utilitarios', N'Discusiones sobre los cursos relacionados con Utilidades de Oficina como Microsoft Office.', 2, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (6, 3, NULL, N'Bases de Datos', N'Discusiones sobre los cursos relacionados con Bases de Datos.', 3, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (7, 3, NULL, N'Herramientas de Desarrollo', N'Discusiones sobre los cursos relacionados con Herramientas de Desarrollo.', 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (8, 3, NULL, N'Servidores', N'Discusiones sobre los cursos relacionados con Servidores.', 5, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (9, 3, NULL, N'Hardware', N'Discusiones sobre los cursos relacionados con Hardware.', 6, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (11, 2, NULL, N'Utilitarios', N'Discusiones sobre los cursos relacionados con Utilidades de Oficina como Microsoft Office. ', 2, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (12, 2, NULL, N'Bases de Datos ', N'Discusiones sobre los cursos relacionados con Bases de Datos. ', 3, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (13, 2, NULL, N'Herramientas de Desarrollo ', N'Discusiones sobre los cursos relacionados con Herramientas de Desarrollo. ', 4, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (14, 2, NULL, N'Servidores', N'Discusiones sobre los cursos relacionados con Servidores. ', 5, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)


INSERT INTO [dbo].[yaf_Forum] ([ForumID], [CategoryID], [ParentID], [Name], [Description], [SortOrder], [LastPosted], [LastTopicID], [LastMessageID], [LastUserID], [LastUserName], [NumTopics], [NumPosts], [RemoteURL], [Flags])
VALUES (15, 2, NULL, N'Hardware', N'Discusiones sobre los cursos relacionados con Hardware.', 6, NULL, NULL, NULL, NULL, NULL, 0, 0, NULL, 0)

SET IDENTITY_INSERT [dbo].[yaf_Forum] OFF


-----------------
-- yaf_ForumAccess
-----------------
INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 2, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 4, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 5, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 6, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 7, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 8, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 9, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 11, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 12, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 13, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 14, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (1, 15, 1)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 2, 4)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 4, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 5, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 6, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 7, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 8, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 9, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 11, 4)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 12, 4)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 13, 4)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 14, 4)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (2, 15, 4)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 2, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 4, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 5, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 6, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 7, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 8, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 9, 5)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 11, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 12, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 13, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 14, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (3, 15, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 2, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 4, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 5, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 6, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 7, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 8, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 9, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 11, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 12, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 13, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 14, 3)


INSERT INTO [dbo].[yaf_ForumAccess] ([GroupID], [ForumID], [AccessMaskID])
VALUES (4, 15, 3)


------------------
-- yaf_Group
------------------
SET IDENTITY_INSERT [dbo].[yaf_Group] ON


INSERT INTO [dbo].[yaf_Group] ([GroupID], [BoardID], [Name], [Flags])
VALUES (1, 1, N'Administration', 1)


INSERT INTO [dbo].[yaf_Group] ([GroupID], [BoardID], [Name], [Flags])
VALUES (2, 1, N'Guest', 2)


INSERT INTO [dbo].[yaf_Group] ([GroupID], [BoardID], [Name], [Flags])
VALUES (3, 1, N'Member', 4)


INSERT INTO [dbo].[yaf_Group] ([GroupID], [BoardID], [Name], [Flags])
VALUES (4, 1, N'Cliente', 0)

SET IDENTITY_INSERT [dbo].[yaf_Group] OFF


------------------
-- yaf_Rank
------------------
SET IDENTITY_INSERT [dbo].[yaf_Rank] ON


INSERT INTO [dbo].[yaf_Rank] ([RankID], [BoardID], [Name], [MinPosts], [RankImage], [Flags])
VALUES (1, 1, N'Administration', NULL, NULL, 0)


INSERT INTO [dbo].[yaf_Rank] ([RankID], [BoardID], [Name], [MinPosts], [RankImage], [Flags])
VALUES (2, 1, N'Guest', NULL, NULL, 0)


INSERT INTO [dbo].[yaf_Rank] ([RankID], [BoardID], [Name], [MinPosts], [RankImage], [Flags])
VALUES (3, 1, N'Newbie', 0, NULL, 3)


INSERT INTO [dbo].[yaf_Rank] ([RankID], [BoardID], [Name], [MinPosts], [RankImage], [Flags])
VALUES (4, 1, N'Member', 10, NULL, 2)


INSERT INTO [dbo].[yaf_Rank] ([RankID], [BoardID], [Name], [MinPosts], [RankImage], [Flags])
VALUES (5, 1, N'Advanced Member', 30, NULL, 2)

SET IDENTITY_INSERT [dbo].[yaf_Rank] OFF


------------------
-- yaf_Registry
------------------
SET IDENTITY_INSERT [dbo].[yaf_Registry] ON


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (1, N'version', N'17', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (2, N'versionname', N'1.0.0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (3, N'timezone', N'-300', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (4, N'smtpserver', N'smtp.msguayaquil.com', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (5, N'forumemail', N'julio_casal@hotmail.com', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (6, N'maxusers', N'1', 1)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (7, N'maxuserswhen', N'2006-11-03T16:20:54.920', 1)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (8, N'showtopicsdefault', N'5', 1)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (9, N'language', N'spanish.xml', 1)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (10, N'theme', N'icgstation.xml', 1)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (11, N'createnntpusers', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (12, N'lockposts', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (13, N'usefiletable', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (14, N'blanklinks', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (15, N'acceptedhtml', N'br,hr,b,i,u,a,div,ol,ul,li,blockquote,img,span,p,em,strong,font,pre,h1,h2,h3,h4,h5,h6,address', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (16, N'allowusertheme', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (17, N'avatarwidth', N'50', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (18, N'smiliescolumns', N'3', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (19, N'avatarremote', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (20, N'topicsperpage', N'15', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (21, N'showgroupsprofile', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (22, N'showgroups', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (23, N'emailverification', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (24, N'showmoved', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (25, N'allowprivatemessages', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (26, N'smtpusername', N'admin@msguayaquil.com', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (27, N'showrsslink', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (28, N'allowuserlanguage', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (29, N'allowsignatures', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (30, N'postflooddelay', N'30', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (31, N'showforumjump', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (32, N'removenestedquotes', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (33, N'allowemailsending', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (34, N'disableregistrations', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (35, N'dateformatfromlanguage', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (36, N'avatarsize', N'50000', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (37, N'maxfilesize', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (38, N'pollvotetiedtoip', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (39, N'smiliesperrow', N'6', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (40, N'postsperpage', N'20', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (41, N'forumeditor', N'1', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (42, N'avatarupload', N'0', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (43, N'avatarheight', N'80', NULL)


INSERT INTO [dbo].[yaf_Registry] ([RegistryID], [Name], [Value], [BoardID])
VALUES (44, N'smtpuserpass', N'twofaces', NULL)

SET IDENTITY_INSERT [dbo].[yaf_Registry] OFF


------------------
-- yaf_User
------------------
SET IDENTITY_INSERT [dbo].[yaf_User] ON


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (1, 1, N'Guest', N'na', N'julio_casal@hotmail.com', '20061103', '20061104', N'127.0.0.1', 0, NULL, NULL, -300, NULL, NULL, 2, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (2, 1, N'admin', N'DB4E020932391D017B4D3423E472FB11', N'julio_casal@hotmail.com', '20061103', '20061104', N'127.0.0.1', 0, NULL, NULL, -300, NULL, NULL, 1, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 3)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (3, 1, N'test', N'098F6BCD4621D373CADE4E832627B4F6', N'jc@hotmail.com', '20061103', '20061103', N'127.0.0.1', 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (4, 1, N'test2', N'AD0234829205B9033196BA818F7A872B', N'test2@hotmail.com', '20061103', '20061103', NULL, 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (5, 1, N'test3', N'8AD8757BAA8564DC136C1E07507F4A98', N'test3@algo.com', '20061103', '20061103', NULL, 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (6, 1, N'test7', N'B04083E53E242626595E2B8EA327E525', N'test7@algo.com', '20061103', '20061103', NULL, 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (7, 1, N'test8', N'DB4E020932391D017B4D3423E472FB11', N'test8@algo.com', '20061103', '20061103', NULL, 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (8, 1, N'test9', N'DB4E020932391D017B4D3423E472FB11', N'test9@algo.com', '20061103', '20061103', NULL, 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (9, 1, N'test10', N'DB4E020932391D017B4D3423E472FB11', N'test10@algo.com', '20061103', '20061103', N'127.0.0.1', 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (10, 1, N'test11', N'DB4E020932391D017B4D3423E472FB11', N'test11@algo.com', '20061103', '20061103', N'127.0.0.1', 0, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)


INSERT INTO [dbo].[yaf_User] ([UserID], [BoardID], [Name], [Password], [Email], [Joined], [LastVisit], [IP], [NumPosts], [Location], [HomePage], [TimeZone], [Avatar], [Signature], [RankID], [Suspended], [LanguageFile], [ThemeFile], [MSN], [YIM], [AIM], [ICQ], [RealName], [Occupation], [Interests], [Gender], [Weblog], [Flags])
VALUES (11, 1, N'test12', N'DB4E020932391D017B4D3423E472FB11', N'test12@algo.com', '20061103', '20061104', N'127.0.0.1', 1, NULL, NULL, -300, NULL, NULL, 3, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, NULL, 2)

SET IDENTITY_INSERT [dbo].[yaf_User] OFF


------------------
-- yaf_UserGroup
------------------
INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (1, 2)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (2, 1)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (2, 4)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (3, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (4, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (5, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (6, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (7, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (8, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (9, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (10, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (11, 3)


INSERT INTO [dbo].[yaf_UserGroup] ([UserID], [GroupID])
VALUES (11, 4)

