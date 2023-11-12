# Order of execution

This project uses data from two databases: `stackoverflow_mysql` and `stackoverflow_mysql_queries`. The first database
contains Stack Overflow data filtered on the `[mysql]` tag, and the second database is a subset of the first where only
questions with queries are included (it is filtered on the inclusion of `"<pre><code>SELECT"` in the `posts`.`Body`
column).

## Structure

1. `schema.sql`
    - Creates a database `stackoverflow_mysql` with the tables for the general Stack Overflow database layout.
    - Adds no indices for faster import.

2. `schema_features.sql`
    - Creates the `stackoverflow_mysql.features` table for general question and answer features.
    - Adds indices.

3. `schema_features_sql.sql`
    - Creates the `stackoverflow_mysql.features_sql` table for sql-specific question and answer features.
    - Adds indices.

## Data

1. `import.sql`
    - Imports all Stack Overflow data from XML files into the database `stackoverflow_mysql`.
    - Adds indices.

2. `prune.sql` (use database `stackoverflow_mysql`)
    - Removes all Stack Overflow questions/answers without a `[mysql]` tag.
    - Filters all unnecessary relational data.

3. `Copy database (custom commands)`
    - Copies the database `stackoverflow_mysql` to `stackoverflow_mysql_queries` (commands):
        - `mysqldump -u root -p stackoverflow_mysql > stackoverflow_mysql.sql`
        - `mysqladmin -u root -p create stackoverflow_mysql_queries`
        - `mysql -u root -p stackoverflow_mysql_queries < stackoverflow_mysql.sql`
    - Filters the new database to only contain questions with queries (`"<pre><code>SELECT"`).

4. `prune.sql` (use database `stackoverflow_mysql_queries`)
    - Filters all unnecessary relational data.

5. `import_features.sql`
    - Imports various aggregate data from the Stack overflow tables into `stackoverflow_mysql.features`.
    - Further populated by `notebooks/language_complexity.ipynb`.

6. `import_features_sql.sql`
    - Prefills rows with question and answer ids from the Stack overflow tables into `stackoverflow_mysql.features_sql`.
    - Further populated by `notebooks/sql_complexity.ipynb`.
