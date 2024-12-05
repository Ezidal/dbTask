CREATE OR REPLACE FUNCTION set_region()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.email LIKE '%.ru' THEN
        NEW.source := 'SHARD1';
    ELSIF NEW.email LIKE '%.com' THEN
        NEW.source := 'SHARD2';
    ELSE
        RAISE EXCEPTION 'Email must end with .ru or .com';
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER before_insert_set_region
BEFORE INSERT ON alll_users
FOR EACH ROW EXECUTE FUNCTION set_region();