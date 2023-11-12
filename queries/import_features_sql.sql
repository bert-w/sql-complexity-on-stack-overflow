USE stackoverflow_mysql_queries;

# Prefill with empty records for each question:
INSERT IGNORE INTO features_sql (QuestionId, AnswerId)
SELECT QuestionId, AnswerId
FROM features;
