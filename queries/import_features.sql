USE stackoverflow;

# Prefill with empty records for each question:
INSERT IGNORE INTO features (QuestionId)
SELECT Id
FROM posts;

# Import direct columns:
UPDATE features AS f
    INNER JOIN posts AS p ON f.QuestionId = p.Id
    LEFT JOIN users AS u on p.OwnerUserId = u.Id
SET f.QuestionUserId         = u.OwnerUserId,
    f.QuestionerReputation   = u.Reputation,
    f.QuestionerUpvotes      = u.UpVotes,
    f.QuestionerDownvotes    = u.DownVotes,
    f.QuestionerCreationDate = u.CreationDate,
    f.QuestionScore          = p.Score,
    f.QuestionCreationDate   = p.CreationDate,
    f.QuestionAnswerCount    = p.AnswerCount,
    f.QuestionCommentCount   = p.CommentCount,
    f.QuestionFavoriteCount  = p.FavoriteCount,
    f.QuestionViewCount      = p.ViewCount;

# Import accepted answer:
UPDATE features AS f
    INNER JOIN posts AS p ON f.QuestionId = p.Id AND p.AcceptedAnswerId IS NOT NULL
SET f.AnswerId         = p.AcceptedAnswerId,
    f.AnswerIsAccepted = 1;

# Import answer with the highest score if no answer was selected:
UPDATE features AS f
    INNER JOIN (SELECT ParentId AS QuestionId, Id AS AnswerId, Score
                FROM answers AS a1
                WHERE Score = (SELECT MAX(Score) AS Score
                               FROM answers AS a2
                               WHERE a1.ParentId = a2.ParentId)
                ORDER BY ParentId ASC) AS j ON f.QuestionId = j.QuestionId
SET f.AnswerId         = j.AnswerId,
    f.AnswerScore      = j.Score,
    f.AnswerIsAccepted = 0
WHERE f.AnswerId IS NULL;

# Import direct answer columns:
UPDATE features AS f
    INNER JOIN answers AS a ON f.AnswerId = a.Id
    LEFT JOIN users AS u on a.OwnerUserId = u.Id
SET f.AnswererReputation   = u.Reputation,
    f.AnswererUpvotes      = u.UpVotes,
    f.AnswererDownvotes    = u.DownVotes,
    f.AnswererCreationDate = u.CreationDate,
    f.AnswerScore          = a.Score,
    f.AnswerCreationDate   = a.CreationDate;

# Import answer Upvotes aggregate:
UPDATE
    features
        INNER JOIN (SELECT PostId,
                           VoteTypeId,
                           COUNT(VoteTypeId) AS VoteTypeCount
                    FROM votes
                    WHERE VoteTypeId = 2
                    GROUP BY PostId,
                             VoteTypeId) AS j
        ON features.AnswerId = j.PostId
SET features.AnswerUpvotes = j.VoteTypeCount;

# Import answer Downvotes aggregate:
UPDATE
    features
        INNER JOIN (SELECT PostId,
                           VoteTypeId,
                           COUNT(VoteTypeId) AS VoteTypeCount
                    FROM votes
                    WHERE VoteTypeId = 3
                    GROUP BY PostId,
                             VoteTypeId) AS j
        ON features.AnswerId = j.PostId
SET features.AnswerDownvotes = j.VoteTypeCount;

# Import question Upvotes aggregate:
UPDATE
    features
        INNER JOIN (SELECT PostId,
                           VoteTypeId,
                           COUNT(VoteTypeId) AS VoteTypeCount
                    FROM votes
                    WHERE VoteTypeId = 2
                    GROUP BY PostId,
                             VoteTypeId) AS j
        ON features.QuestionId = j.PostId
SET features.QuestionUpvotes = j.VoteTypeCount;

# Import question Downvotes aggregate:
UPDATE
    features
        INNER JOIN (SELECT PostId,
                           VoteTypeId,
                           COUNT(VoteTypeId) AS VoteTypeCount
                    FROM votes
                    WHERE VoteTypeId = 3
                    GROUP BY PostId,
                             VoteTypeId) AS j
        ON features.QuestionId = j.PostId
SET features.QuestionDownvotes = j.VoteTypeCount;

# Import history aggregate:
UPDATE features
    INNER JOIN (SELECT PostId, COUNT(*) AS HistoryCount
                FROM post_history
                WHERE PostHistoryTypeId IN (4, 5, 6, 7, 8, 9)
                GROUP BY PostId) AS j
    ON features.QuestionId = j.PostId
SET features.QuestionEditCount = j.HistoryCount;
