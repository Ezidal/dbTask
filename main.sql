CREATE EXTENSION IF NOT EXISTS postgres_fdw;

CREATE SERVER shard1_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'shard1', dbname 'db', port '5432');
CREATE SERVER shard2_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'shard2', dbname 'db', port '5432');

CREATE FOREIGN TABLE foreign_users1 (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
)
SERVER shard1_server
OPTIONS (schema_name 'public', table_name 'users');

CREATE FOREIGN TABLE foreign_users2 (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP DEFAULT NOW()
)

SERVER shard2_server
OPTIONS (schema_name 'public', table_name 'users');

CREATE TABLE other_users (
    user_id SERIAL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE VIEW all_users AS
SELECT 'shard1' AS source, *
FROM foreign_users1
UNION ALL
SELECT 'shard2' AS source, *
FROM foreign_users2
UNION ALL
SELECT 'other' AS source, *
FROM other_users;
