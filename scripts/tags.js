/**
 * This script parses the tags which are saved in a merged string, and finds the counts for each.
 * These counts may then provide interesting subcultures.
 */

import Database from '../viewer/database.js';

(async function () {
    const db = new Database({
        host: 'localhost',
        user: 'root',
        password: '',
        database: 'stackoverflow_mysql_queries',
    }, true);

    await db.connect();

    const tagCounts = {};

    await db.queryRow(
        'SELECT Tags FROM posts',
        (row) => {
            let tags = row.Tags.replace(/[<>]/g, ' ').split(' ').filter(i => i);
            tags.forEach((tag) => {
                if (tagCounts[tag]) {
                    tagCounts[tag]++;
                } else {
                    tagCounts[tag] = 1;
                }
            })
        }
    );

    const sorted = Object.fromEntries(
        Object.entries(tagCounts).sort(([, a], [, b]) => a - b)
    );

    console.log(sorted);

    await db.end();
})();

