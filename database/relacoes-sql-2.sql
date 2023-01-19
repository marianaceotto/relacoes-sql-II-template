-- Active: 1674130500018@@127.0.0.1@3306

-- Práticas
CREATE TABLE users(
    id TEXT PRIMARY KEY UNIQUE NOT NULL,
    name TEXT NOT NULL,
    email TEXT UNIQUE NOT NULL,
    password TEXT NOT NULL, 
    created_at TEXT DEFAULT (DATETIME('now', 'localtime')) NOT NULL
);

DROP TABLE users;

SELECT * FROM users;

INSERT INTO users (id, name, email, password)
VALUES 
("u001", "maria", "maria@gmail@com", "2345"),
("u002", "joao", "joao@gmail.com", "1234"),
("u003", "joaninha", "joaninha@gmail.com", "4566");

-------------------

CREATE TABLE follows (
    follower_id TEXT NOT NULL,
    followed_id TEXT NOT NULL,
    FOREIGN KEY (follower_id) REFERENCES users (id),
    FOREIGN KEY (followed_id) REFERENCES users (id)
);


DROP TABLE follows;

SELECT * FROM follows;

INSERT INTO follows (follower_id, followed_id)
VALUES 
("u001", "u002"),
("u001", "u003"),
("u002", "u001");

-------------------

SELECT * FROM users
INNER JOIN follows
ON follows.follower_id = users.id;

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id;

-------------------

SELECT * FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id;

-- Removendo ambiguidades / selecionando os dados para tabela
SELECT 
users.id AS usersID,
users.name,
users.email,
users.password,
users.created_at AS createAt,
follows.follower_id AS followerId,
follows.followed_id AS followedId,
usersFollowed.name AS nameFollowed
FROM users
LEFT JOIN follows
ON follows.follower_id = users.id
INNER JOIN users AS usersFollowed
ON follows.followed_id = usersFollowed.id;


