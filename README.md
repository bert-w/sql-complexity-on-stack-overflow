# sql-complexity-on-stack-overflow

## Components
- `/data`: Directory to put `.xml` files from the Stack Overflow data dump: https://archive.org/details/stackexchange.
- `/notebooks`: Collection of Jupyter Notebooks (Python) with analysis data:
  - `/correlation.ipynb`: Analysis of complexity correlations.
  - `/language_complexity.ipynb`: Calculating Language Complexity for the Stack Overflow dataset.
  - `/progression.ipynb`: Analysis of complexity progression.
  - `/sql_complexity.ipynb`: Calculating [SQompLexity](https://github.com/bert-w/sqomplexity) for the Stack Overflow dataset.
  - `/database.py`: Database helper functions (memory efficient).
  - `/requirements.txt`: Python pip modules.
- `/queries`: Collection of SQL queries to do with data imports.
- `/scripts`: Collection of development scripts not belonging in another folder.
- `/viewer`: Simplified data viewer for the dataset (use for local development only).