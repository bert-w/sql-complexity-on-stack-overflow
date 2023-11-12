/**
 * Repeat queries (preferably with a LIMIT clause) on a database with many records.
 */

import Database from '../viewer/database.js';

const options = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'stackoverflow',
};

const queries = {
    delete_non_mysql_posts: `DELETE
                             FROM posts
                             WHERE NOT MATCH (Tags) AGAINST ('mysql')
                             LIMIT 100000`,
    delete_non_answer_answers: `DELETE
                                FROM answers
                                WHERE ParentId IS NULL
                                LIMIT 100000`,
    delete_non_mysql_post_history: `DELETE
                                    FROM post_history
                                    WHERE PostId NOT IN (SELECT Id FROM posts)
                                      AND PostId NOT IN (SELECT Id FROM answers)
                                    LIMIT 100000`,
    delete_non_mysql_votes: `delete
                             from votes
                             where PostId not in (select postid from temptable)
                             limit 1000000`,
    delete_non_mysql_comments: `DELETE
                                FROM comments
                                WHERE PostId NOT IN (SELECT postid FROM temptable)
                                LIMIT 10000`
};

/**
 * Query to repeat.
 */
const query = queries.delete_non_mysql_comments;

(async function () {
    const db = new Database(options);
    await db.connect()
        .then(() => console.log('Connected'))
        .catch((err) => console.error(err));

    let deleted = 1;
    let i = 1;

    console.log(query);

    while (deleted > 0) {
        console.log(`Query: ${i} (${(new Date()).toString()}`);
        await db.query(query);

        deleted = (await db.query(`SELECT ROW_COUNT() AS count`))[0].count;
        console.log(`Deleted: ${deleted}`);
        i++;
    }

    await db.end()
        .then(() => console.log('Connection closed'))
        .catch((err) => console.error(err));
})();
