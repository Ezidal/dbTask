CREATE EXTENSION postgres_fdw;

CREATE ROLE repluser WITH REPLICATION LOGIN PASSWORD 'repluser';

CREATE SERVER shard1_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'shard1', dbname 'db', port '5432');
CREATE SERVER shard2_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'shard2', dbname 'db', port '5432');

CREATE USER MAPPING FOR postgres SERVER shard1_server OPTIONS (user 'shardmaster', password '0000');
CREATE USER MAPPING FOR postgres SERVER shard2_server OPTIONS (user 'shardmaster', password '0000');

CREATE FOREIGN TABLE foreign_users1 (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP
)
SERVER shard1_server
OPTIONS (schema_name 'public', table_name 'users');

CREATE FOREIGN TABLE foreign_users2 (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP
)
SERVER shard2_server
OPTIONS (schema_name 'public', table_name 'users');

CREATE VIEW all_users AS
SELECT user_id, username, email, 'shard1' AS source
FROM foreign_users1
UNION ALL
SELECT user_id, username, email, 'shard2' AS source
FROM foreign_users2;
