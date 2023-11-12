USE stackoverflow;

CREATE TABLE features
(
    QuestionId                 INT            NOT NULL PRIMARY KEY,
    QuestionUserId             INT            NULL,
    # Questioner = user associated with question (if it exists)
    QuestionerReputation       INT            NULL,
    QuestionerUpvotes          INT            NULL,
    QuestionerDownvotes        INT            NULL,
    QuestionerCreationDate     DATETIME       NULL,
    # Score = upvotes - downvotes
    QuestionScore              INT            NULL,
    QuestionUpvotes            INT            NULL,
    QuestionDownvotes          INT            NULL,
    QuestionCreationDate       DATETIME       NULL,
    QuestionWordCount          INT            NULL,

    QuestionAnswerCount        INT            NULL,
    QuestionCommentCount       INT            NULL,
    QuestionFavoriteCount      INT            NULL,
    QuestionViewCount          INT            NULL,
    QuestionEditCount          INT            NULL,

    # If there is no accepted answer, the answer with the most upvotes will be selected (or none if no answers exist)
    AnswerId                   INT            NULL,
    AnswerUserId               INT            NULL,
    AnswerIsAccepted           INT            NULL,
    # Answerer = user associated with question (if it exists)
    AnswererReputation         INT            NULL,
    AnswererUpvotes            INT            NULL,
    AnswererDownvotes          INT            NULL,
    AnswererCreationDate       DATETIME       NULL,
    AnswerScore                INT            NULL,
    AnswerUpvotes              INT            NULL,
    AnswerDownvotes            INT            NULL,
    AnswerCreationDate         DATETIME       NULL,
    AnswerWordCount            INT            NULL,

    # Metric 1: SQL Complexity (moved to `features_sql`)

    # Metric 2: Language Complexity
    QuestionLanguageComplexity DECIMAL(16, 8) NULL,
    AnswerLanguageComplexity   DECIMAL(16, 8) NULL
);

ALTER TABLE features
    ADD INDEX AnswerId_index (AnswerId);

ALTER TABLE features
    ADD INDEX QuestionUserId_index (QuestionUserId);