CREATE EXTENSION postgres_fdw;

CREATE SERVER shard1_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'shard1', dbname 'db', port '5432');
CREATE SERVER shard2_server FOREIGN DATA WRAPPER postgres_fdw OPTIONS (host 'shard2', dbname 'db', port '5432');

CREATE USER MAPPING FOR master SERVER shard1_server OPTIONS (user 'shard', password 'shard');
CREATE USER MAPPING FOR master SERVER shard2_server OPTIONS (user 'shard', password 'shard');

CREATE FOREIGN TABLE foreign_users1 (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP
)
SERVER shard1_server
OPTIONS (schema_name 'public', table_name 'users');

CREATE FOREIGN TABLE foreign_tasks1 (
    task_id INT,
    user_id INT,
    task_description TEXT,
    is_completed BOOLEAN,
    created_at TIMESTAMP
)
SERVER shard1_server
OPTIONS (schema_name 'public', table_name 'tasks');

CREATE FOREIGN TABLE foreign_users2 (
    user_id INT,
    username VARCHAR(50),
    email VARCHAR(100),
    created_at TIMESTAMP
)
SERVER shard2_server
OPTIONS (schema_name 'public', table_name 'users');

CREATE FOREIGN TABLE foreign_tasks2 (
    task_id INT,
    user_id INT,
    task_description TEXT,
    is_completed BOOLEAN,
    created_at TIMESTAMP
)
SERVER shard2_server
OPTIONS (schema_name 'public', table_name 'tasks');
#########################предсталения
CREATE VIEW all_users AS
SELECT user_id, username, email, 'shard1' AS source
FROM foreign_users1
UNION ALL
SELECT user_id, username, email, 'shard2' AS source
FROM foreign_users2;

CREATE VIEW all_tasks AS
SELECT task_id, user_id, task_description, is_completed, created_at, 'shard1' AS source
FROM foreign_tasks1
UNION ALL
SELECT task_id, user_id, task_description, is_completed, created_at, 'shard2' AS source
FROM foreign_tasks2;