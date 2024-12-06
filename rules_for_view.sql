CREATE RULE users_insert AS ON INSERT TO all_users DO INSTEAD NOTHING;
CREATE RULE users_update AS ON UPDATE TO all_users DO INSTEAD NOTHING;
CREATE RULE users_delete AS ON DELETE TO all_users DO INSTEAD NOTHING;

CREATE RULE users_insert_to_1 AS ON INSERT TO all_users WHERE (email LIKE '%@%.ru') DO INSTEAD INSERT INTO foreign_users1 VALUES (NEW.user_id, NEW.username, NEW.email, NEW.created_at);
CREATE RULE users_insert_to_2 AS ON INSERT TO all_users WHERE (email LIKE '%@%.com') DO INSTEAD INSERT INTO foreign_users2 VALUES (NEW.user_id, NEW.username, NEW.email, NEW.created_at);
CREATE RULE users_insert_to_0 AS ON INSERT TO all_users WHERE (email NOT LIKE '%@%.com' AND email NOT LIKE '%@%.ru') DO INSTEAD INSERT INTO other_users VALUES (NEW.user_id, NEW.username, NEW.email, NEW.created_at);

CREATE RULE users_update_to_1 AS ON UPDATE TO all_users WHERE (email LIKE '%@%.ru') DO INSTEAD UPDATE foreign_users1 SET username = NEW.username, email = NEW.email, created_at = NEW.created_at WHERE user_id = OLD.user_id;
CREATE RULE users_update_to_2 AS ON UPDATE TO all_users WHERE (email LIKE '%@%.com') DO INSTEAD UPDATE foreign_users2 SET username = NEW.username, email = NEW.email, created_at = NEW.created_at WHERE user_id = OLD.user_id;
CREATE RULE users_update_to_0 AS ON UPDATE TO all_users WHERE (email NOT LIKE '%@%.com' AND email NOT LIKE '%@%.ru') DO INSTEAD UPDATE other_users SET username = NEW.username, email = NEW.email, created_at = NEW.created_at WHERE user_id = OLD.user_id;

CREATE RULE users_delete_to_1 AS ON DELETE TO all_users WHERE (email LIKE '%@%.ru') DO INSTEAD DELETE FROM foreign_users1 WHERE user_id = OLD.user_id;
CREATE RULE users_delete_to_2 AS ON DELETE TO all_users WHERE (email LIKE '%@%.com') DO INSTEAD DELETE FROM foreign_users2 WHERE user_id = OLD.user_id;
CREATE RULE users_delete_to_0 AS ON DELETE TO all_users WHERE (email NOT LIKE '%@%.com' AND email NOT LIKE '%@%.ru') DO INSTEAD DELETE FROM other_users WHERE user_id = OLD.user_id;
