# Pruning

## Delete the most records using a Full-Text Search index:
DELETE FROM posts WHERE NOT MATCH (Tags) AGAINST ('mysql');
## Narrow down posts to also delete related mysql tags like "mysqli", "mysql-workbench" and "mysql-python":
DELETE FROM posts WHERE Tags NOT LIKE '%<mysql>%';

# No ParentId means it is a question so it must be removed.
DELETE FROM answers WHERE ParentId IS NULL;
# Delete all records where there is no Id in posts, so we remain with only answers.
DELETE FROM answers WHERE ParentId NOT IN (SELECT Id FROM posts);

# Delete all records that have no associations with questions/answers.
DELETE FROM post_history WHERE post_history.PostId NOT IN (SELECT Id FROM posts UNION SELECT Id FROM answers);
DELETE FROM users WHERE users.Id NOT IN (SELECT OwnerUserId FROM posts UNION SELECT OwnerUserId FROM answers);
DELETE FROM comments WHERE comments.PostId NOT IN (SELECT Id FROM posts UNION SELECT Id FROM answers);