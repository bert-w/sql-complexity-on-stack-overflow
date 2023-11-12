# Count = 665861
SELECT COUNT(*) FROM `posts` WHERE MATCH (Tags) AGAINST ('mysql');

# Count = 955945
SELECT COUNT(*) FROM `posts` WHERE MATCH (Tags) AGAINST ('sql');

# Select posts where no answer exists
SELECT COUNT(*) FROM `posts` WHERE Id NOT IN (SELECT ParentId FROM `answers`) LIMIT 10;