USE stackoverflow;

# Performance optimization:
SET foreign_key_checks = 0;

# Import XML:

# This imports `posts` into `answers` (same structure) since we filter it out later:
LOAD XML INFILE "C:\\SomePath\\Posts.xml"
    INTO TABLE answers
    ROWS IDENTIFIED BY '<row>';

LOAD XML INFILE "C:\\SomePath\\Badges.xml"
    INTO TABLE badges
    ROWS IDENTIFIED BY '<row>';

LOAD XML INFILE "C:\\SomePath\\Comments.xml"
    INTO TABLE comments
    ROWS IDENTIFIED BY '<row>';

LOAD XML INFILE "C:\\SomePath\\Posts.xml"
    INTO TABLE posts
    ROWS IDENTIFIED BY '<row>';

LOAD XML INFILE "C:\\SomePath\\PostHistory.xml"
    INTO TABLE post_history
    ROWS IDENTIFIED BY '<row>';

LOAD XML INFILE "C:\\SomePath\\Users.xml"
    INTO TABLE users
    ROWS IDENTIFIED BY '<row>';

LOAD XML INFILE "C:\\SomePath\\Votes.xml"
    INTO TABLE votes
    ROWS IDENTIFIED BY '<row>';

# Indexes (run these after the imports for faster execution time):
ALTER TABLE posts ADD FULLTEXT INDEX Tags_fulltext (Tags);
ALTER TABLE posts ADD INDEX OwnerUserId_index (OwnerUserId);
ALTER TABLE answers ADD INDEX ParentId_index (ParentId);
ALTER TABLE answers ADD INDEX OwnerUserId_index (OwnerUserId);
ALTER TABLE post_history ADD INDEX PostId_index (PostId);
ALTER TABLE comments ADD INDEX PostId_index (PostId);
ALTER TABLE votes ADD INDEX PostId_VoteTypeId_index (PostId, VoteTypeId);
