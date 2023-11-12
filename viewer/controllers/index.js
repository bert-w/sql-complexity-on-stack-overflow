import Database from "../database.js";
import ejs from 'ejs';
import path from 'path';
import url from 'url';

const __dirname = url.fileURLToPath(new URL('.', import.meta.url));

class IndexController {
    async index(req, res) {
        const db = await IndexController.db();
        const perPage = 10;

        const page = parseInt(req.query.page || 1);
        const owner_user_id = req.query.owner_user_id;
        const search = req.query.search;
        const id = req.query.id;
        const table = req.query.table || 'posts';

        const offset = page * perPage - perPage;
        const W_OWNER_USER_ID = owner_user_id ? 'OwnerUserId = ' + parseInt(owner_user_id) : null;
        const W_SEARCH = search ? `Body LIKE '${search}'` : null;
        const W_ID = id ? 'Id = ' + parseInt(id) : null;

        console.log(W_ID);

        let WHERE = [W_ID, W_OWNER_USER_ID, W_SEARCH].filter((i) => i).join(' AND ');
        WHERE = WHERE.length ? `WHERE ${WHERE} ` : ' ';

        const db_query = `SELECT *
                          FROM ${table}
                          LEFT JOIN features ON features.QuestionId = ${table}.Id
                          ${WHERE}LIMIT ${perPage} 
                          OFFSET ${offset}`;

        let posts = await db.query(db_query);
        let postIds = posts.map((post) => post.Id);

        // Get answers from the `features` table since we decided here what the answer is if multiple were available.
        let answers = await db.query(`
                    SELECT *
                    FROM answers
                    WHERE Id IN (SELECT AnswerId
                                 FROM features
                                 WHERE QuestionId IN (${postIds.join(',') || 0}))
            `
        );

        posts = posts.map((post) => ({
            ...post,
            Answer: answers.filter((answer) => answer.ParentId === post.Id)[0],
        }));

        return ejs.renderFile(path.join(__dirname, '../views', 'index.ejs'), {
            posts, page, query: {
                page, owner_user_id, search, id, table
            },
            db_query
        }, {}, (err, str) => {
            res.send(str);
        });
    }

    static async db() {
        const db = new Database({
            host: 'localhost',
            user: 'root',
            password: '',
            database: 'stackoverflow_mysql_queries',
        }, true);

        await db.connect();

        return db;
    }
}

export default IndexController;