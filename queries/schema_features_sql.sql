USE stackoverflow_mysql_queries;

CREATE TABLE features_sql
(
    QuestionId                 INT            NOT NULL PRIMARY KEY,
    QuestionSQLComplexity      DECIMAL(16, 8) NULL,
    QuestionSQLParseError      INT            NULL,
    QuestionSQLSubqueries      INT            NULL,
    QuestionSQLIsCyclic        INT            NULL,

    QuestionSQLExprInSelect    INT            NULL,
    QuestionSQLExprInFrom      INT            NULL,
    QuestionSQLExprInJoin      INT            NULL,
    QuestionSQLExprInWhere     INT            NULL,
    QuestionSQLExprInGroupBy   INT            NULL,
    QuestionSQLExprInHaving    INT            NULL,
    QuestionSQLExprInOrderBy   INT            NULL,
    QuestionSQLExprInLimit     INT            NULL,
    QuestionSQLExprInOffset    INT            NULL,

    QuestionSQLExprTable       INT            NULL,
    QuestionSQLExprUnary       INT            NULL,
    QuestionSQLExprBinary      INT            NULL,
    QuestionSQLExprColumn      INT            NULL,
    QuestionSQLExprNumber      INT            NULL,
    QuestionSQLExprAggregation INT            NULL,
    QuestionSQLExprList        INT            NULL,
    QuestionSQLExprStar        INT            NULL,
    QuestionSQLExprFunction    INT            NULL,
    QuestionSQLExprString      INT            NULL,
    QuestionSQLExprNull        INT            NULL,

    AnswerId                   INT            NULL,
    AnswerSQLComplexity        DECIMAL(16, 8) NULL,
    AnswerSQLParseError        INT            NULL,
    AnswerSQLSubqueries        INT            NULL,
    AnswerSQLIsCyclic          INT            NULL,

    AnswerSQLExprInSelect      INT            NULL,
    AnswerSQLExprInFrom        INT            NULL,
    AnswerSQLExprInJoin        INT            NULL,
    AnswerSQLExprInWhere       INT            NULL,
    AnswerSQLExprInGroupBy     INT            NULL,
    AnswerSQLExprInHaving      INT            NULL,
    AnswerSQLExprInOrderBy     INT            NULL,
    AnswerSQLExprInLimit       INT            NULL,
    AnswerSQLExprInOffset      INT            NULL,

    AnswerSQLExprTable         INT            NULL,
    AnswerSQLExprUnary         INT            NULL,
    AnswerSQLExprBinary        INT            NULL,
    AnswerSQLExprColumn        INT            NULL,
    AnswerSQLExprNumber        INT            NULL,
    AnswerSQLExprAggregation   INT            NULL,
    AnswerSQLExprList          INT            NULL,
    AnswerSQLExprStar          INT            NULL,
    AnswerSQLExprFunction      INT            NULL,
    AnswerSQLExprString        INT            NULL,
    AnswerSQLExprNull          INT            NULL
);

ALTER TABLE features_sql
    ADD INDEX AnswerId_index (AnswerId);
