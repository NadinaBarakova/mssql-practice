USE Minions 

CREATE TABLE Users(
Id BIGINT IDENTITY NOT NULL,
Username VARCHAR(30) UNIQUE NOT NULL,
Password VARCHAR(26) NOT NULL,
ProfilePicture VARBINARY(MAX),
LastloginTime DATETIME,
IsDeleted BIT,
CONSTRAINT PK_Users PRIMARY KEY (Id)
)

ALTER TABLE Users
DROP CONSTRAINT PK_Users

ALTER TABLE Users
ADD CONSTRAINT PK_Users PRIMARY KEY(Id,Username)

INSERT INTO Users (Username, Password, ProfilePicture,LastloginTime,IsDeleted) VALUES
('Pesho','123456',NULL,NULL,1),
('Gosho','123456',NULL,NULL,1),
('Geci','123456',NULL,NULL,0)

INSERT INTO Users (Username, Password,IsDeleted) VALUES
('Georgi','SDAFG',0)

ALTER TABLE Users
ADD CONSTRAINT CH_ProfilePictureSize CHECK(DATALENGTH(ProfilePicture)<=900*1024)

ALTER TABLE Users
ADD CONSTRAINT CH_PasswordSize CHECK(DATALENGTH(Password)>=5)

ALTER TABLE Users
ADD DEFAULT GETDATE() FOR LastLoginTime