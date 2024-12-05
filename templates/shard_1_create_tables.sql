CREATE TABLE users (
    user_id SERIAL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    CONSTRAINT check_domain CHECK (email LIKE '%@%.ru'),
    created_at TIMESTAMP DEFAULT NOW()
);

CREATE index check_email_idx ON users USING btree(email)