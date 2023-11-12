import mysql from 'mysql';

class Database {
    constructor(options, log = false) {
        this.options = options;

        this.log = log;

        this.connection = mysql.createConnection(options);
    }

    async connect() {
        return new Promise((resolve, reject) => {
            this.connection.connect((err) => {
                return err ? reject(err) : resolve();
            });
        });
    }

    async end() {
        return new Promise((resolve, reject) => {
            this.connection.end((err) => {
                return err ? reject(err) : resolve();
            });
        });
    }

    async query(query) {
        if (this.log) {
            console.log(`[database] ${query}`);
        }
        return new Promise((resolve, reject) => {
            this.connection.query(query, (err, result) => {
                return err ? reject(err) : resolve(result);
            });
        });
    }

    async queryRow(query, callback) {
        if (this.log) {
            console.log(`[database] ${query}`);
        }

        return new Promise((resolve, reject) => {
            this.connection.query(query)
                .on('result', async (row) => {
                    this.connection.pause();

                    await callback(row);

                    this.connection.resume();
                })
                .on('end', resolve)
                .on('error', reject);
        });
    }
}

export default Database;