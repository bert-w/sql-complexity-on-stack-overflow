import mysql.connector
import pandas as pd

class Database:
    def __init__(self, database):
        self.db = mysql.connector.connect(
            user='root', 
            password='',
            host='127.0.0.1',
            database=database,
            charset='utf8mb4'
        )

    def _reset(self):
        if hasattr(self, 'cursor'):
            self.cursor.reset()
        self.cursor = self.db.cursor()

    def close():
        if hasattr(self, 'cursor'):
            self.cursor.reset()
            self.cursor.close()
        self.db.close()

    def execute(self, query):
        """
        For UPDATE and INSERT statements.
        """
        self._reset()
        try:
            q = self.build_query(query)
            self.cursor.execute(q)
            self.db.commit()
            count = self.cursor.rowcount
            return count
        except mysql.connector.Error as err:
            print("Query: {}, Error: {}".format(q, err))
            raise
        finally:
            self.cursor.close()

    def query(self, query, close=True):
        self._reset()
        try:
            q = self.build_query(query)
            self.cursor.execute(q)
            return self.cursor.fetchall()
        except mysql.connector.Error as err:
            print("Query: {}, Error: {}".format(q, err))
            raise
        finally:
            if close:
                self.cursor.close()

    def query_generator(self, query):
        """
        Memory-efficient version that uses a generator to yield rows one by one.
        """
        self._reset()
        try:
            q = self.build_query(query)
            self.cursor.execute(q)
            while True:
                row = self.cursor.fetchone()
                if row is None:
                    self.cursor.close()
                    break
                yield row
        except mysql.connector.Error as err:
            print("Query: {}, Error: {}".format(q, err))
            raise
        finally:
            self.cursor.close()


    def query_df(self, query):
        """
        Execute a query and hydrate it into a dataframe immediately.
        """
        self._reset()
        result = pd.DataFrame(self.query_generator(query))
        result.columns = self.cursor.column_names
        return result

    def build_query(self, query, override={}):
        """
        Create a query from a dictionary of { CLAUSE: args }. It joins the keys and values, but this allows
        the developer to override separate components using the extra parameter.
        :param dict query
        :param dict override
        """
        if isinstance(query, str):
            # Already a string, just return it.
            return query
        q = query.copy() | override
        q = [key + " " + str(value) if value else "" for (key, value) in q.items()]
        return " ".join(q)