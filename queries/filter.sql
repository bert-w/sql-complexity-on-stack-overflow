USE stackoverflow_mysql_queries;

DELETE FROM `posts` WHERE Body LIKE "%<pre><code>SELECT%";