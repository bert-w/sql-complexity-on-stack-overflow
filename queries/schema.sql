CREATE DATABASE stackoverflow DEFAULT CHARACTER SET utf8mb4 DEFAULT COLLATE utf8mb4_bin;

USE stackoverflow;

CREATE TABLE badges
(
    Id       INT NOT NULL PRIMARY KEY,
    UserId   INT,
    Name     VARCHAR(50),
    Date     DATETIME,
    Class    INT,
    TagBased BOOLEAN
);
CREATE TABLE comments
(
    Id           INT NOT NULL PRIMARY KEY,
    PostId       INT NOT NULL,
    Score        INT NOT NULL DEFAULT 0,
    # Excluded (it will not be analyzed):
    # Text         TEXT,
    CreationDate DATETIME,
    UserId       INT NOT NULL
);
CREATE TABLE post_history
(
    Id                INT      NOT NULL PRIMARY KEY,
    PostHistoryTypeId SMALLINT NOT NULL,
    PostId            INT      NOT NULL,
    RevisionGUID      VARCHAR(36),
    CreationDate      DATETIME,
    UserId            INT      NOT NULL
    # Excluded (it will not be analyzed):
    # Text              TEXT
);
CREATE TABLE posts
(
    Id               INT          NOT NULL PRIMARY KEY,
    PostTypeId       SMALLINT,
    AcceptedAnswerId INT,
    ParentId         INT,
    Score            INT          NULL,
    ViewCount        INT          NULL,
    Body             MEDIUMTEXT   NULL,
    OwnerUserId      INT,
    LastEditorUserId INT,
    LastEditDate     DATETIME,
    LastActivityDate DATETIME,
    Title            VARCHAR(256) NOT NULL,
    Tags             VARCHAR(256),
    AnswerCount      INT          NOT NULL DEFAULT 0,
    CommentCount     INT          NOT NULL DEFAULT 0,
    FavoriteCount    INT          NOT NULL DEFAULT 0,
    CreationDate     DATETIME
);
CREATE TABLE users
(
    Id             INT          NOT NULL PRIMARY KEY,
    Reputation     INT          NOT NULL,
    CreationDate   DATETIME,
    DisplayName    VARCHAR(50)  NULL,
    LastAccessDate DATETIME,
    Views          INT DEFAULT 0,
    WebsiteUrl     VARCHAR(256) NULL,
    Location       VARCHAR(256) NULL,
    # Excluded (it will not be analyzed):
    # AboutMe        TEXT         NULL,
    Age            INT,
    UpVotes        INT,
    DownVotes      INT,
    EmailHash      VARCHAR(32)
);
CREATE TABLE votes
(
    Id           INT NOT NULL PRIMARY KEY,
    PostId       INT NOT NULL,
    VoteTypeId   SMALLINT,
    CreationDate DATETIME
);

CREATE TABLE tags
(
    Id            INT          NOT NULL PRIMARY KEY,
    TagName       VARCHAR(256) NOT NULL,
    Count         INT          NOT NULL DEFAULT 0,
    ExcerptPostId INT          NULL,
    WikiPostId    INT          NULL
);