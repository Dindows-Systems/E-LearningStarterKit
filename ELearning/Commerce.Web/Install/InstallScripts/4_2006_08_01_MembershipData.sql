DELETE FROM dbo.[aspnet_UsersInRoles]
GO
DELETE FROM dbo.[aspnet_Roles]
GO
DELETE FROM dbo.[aspnet_Membership]
GO
DELETE FROM dbo.[aspnet_Users]
GO
DELETE FROM dbo.[aspnet_Applications]
GO
DELETE FROM dbo.[aspnet_SchemaVersions]
GO



INSERT INTO  dbo.[aspnet_SchemaVersions] ([Feature],[CompatibleSchemaVersion],[IsCurrentVersion]) VALUES('common', '1', 1)
INSERT INTO  dbo.[aspnet_SchemaVersions] ([Feature],[CompatibleSchemaVersion],[IsCurrentVersion]) VALUES('health monitoring', '1', 1)
INSERT INTO  dbo.[aspnet_SchemaVersions] ([Feature],[CompatibleSchemaVersion],[IsCurrentVersion]) VALUES('membership', '1', 1)
INSERT INTO  dbo.[aspnet_SchemaVersions] ([Feature],[CompatibleSchemaVersion],[IsCurrentVersion]) VALUES('personalization', '1', 1)
INSERT INTO  dbo.[aspnet_SchemaVersions] ([Feature],[CompatibleSchemaVersion],[IsCurrentVersion]) VALUES('profile', '1', 1)
INSERT INTO  dbo.[aspnet_SchemaVersions] ([Feature],[CompatibleSchemaVersion],[IsCurrentVersion]) VALUES('role manager', '1', 1)

INSERT INTO  dbo.[aspnet_Applications] ([ApplicationName],[LoweredApplicationName],[ApplicationId],[Description]) VALUES('ELearning', 'elearning', '7344b247-4e02-46cd-8fc2-8eb67048ea3b', 'E-Learning Starter Kit')
INSERT INTO  dbo.[aspnet_Users] ([ApplicationId],[UserId],[UserName],[LoweredUserName],[MobileAlias],[IsAnonymous],[LastActivityDate]) VALUES('7344b247-4e02-46cd-8fc2-8eb67048ea3b', 'ed86b0b6-89d6-4f6a-a303-a9245b3e205e', 'admin', 'admin', NULL, 0, '6/1/2006 6:20:55 AM')

INSERT INTO  dbo.[aspnet_Membership] ([ApplicationId],[UserId],[Password],[PasswordFormat],[PasswordSalt],[MobilePIN],[Email],[LoweredEmail],[PasswordQuestion],[PasswordAnswer],[IsApproved],[IsLockedOut],[CreateDate],[LastLoginDate],[LastPasswordChangedDate],[LastLockoutDate],[FailedPasswordAttemptCount],[FailedPasswordAttemptWindowStart],[FailedPasswordAnswerAttemptCount],[FailedPasswordAnswerAttemptWindowStart],[Comment]) VALUES('7344b247-4e02-46cd-8fc2-8eb67048ea3b', 'ed86b0b6-89d6-4f6a-a303-a9245b3e205e', 'XUa5gjosTMZDO75GarxdoD48IVI=', 1, 'rpnfFguDCUHGK1oiiMYnZw==', NULL, 'admin@elearning.org', 'admin@elearning.org', 'Pet´s Name', 'cfLn5vrnHX4wItuqukOlxACazYM=', 1, 0, '6/1/2006 6:20:55 AM', '6/1/2006 6:20:55 AM', '6/1/2006 6:20:55 AM', '1/1/1754 12:00:00 AM', 0, '1/1/1754 12:00:00 AM', 0, '1/1/1754 12:00:00 AM', NULL)
INSERT INTO  dbo.[aspnet_Roles] ([ApplicationId],[RoleId],[RoleName],[LoweredRoleName],[Description]) VALUES('7344b247-4e02-46cd-8fc2-8eb67048ea3b', 'ec448046-dae3-4598-a94c-388363d30d39', 'Administrator', 'administrator', NULL)
INSERT INTO  dbo.[aspnet_UsersInRoles] ([UserId],[RoleId]) VALUES('ed86b0b6-89d6-4f6a-a303-a9245b3e205e', 'ec448046-dae3-4598-a94c-388363d30d39')
