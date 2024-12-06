ifneq (,$(wildcard ./.env))
include .env
export
endif

.PHONY: up down restart set1 set2 login
up:
	docker network create --subnet=${SUBNET} --gateway=$(GATEWAY) net
	docker compose up -d
	make set1
	sleep 3
	make login
	sleep 2
	make set2
down:
	docker compose down -v
	docker network rm net
restart:
	make down
	make up

set1: 
	docker cp ./postgresql.conf master:/var/lib/postgresql/data/postgresql.conf
	docker cp ./pg_hba.conf master:/var/lib/postgresql/data/pg_hba.conf

set2:
	docker exec -it slave1 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U $(POSTGRES_REPL_USER) -D /var/lib/postgresql/data;"
	docker exec -it slave2 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U $(POSTGRES_REPL_USER) -D /var/lib/postgresql/data;"
login:
	docker exec -it shard1 psql -U postgres -d db -c "CREATE USER ${SHARD_USER} WITH PASSWORD '${SHARD_PASSWORD}';"
	docker exec -it shard2 psql -U postgres -d db -c "CREATE USER ${SHARD_USER} WITH PASSWORD '${SHARD_PASSWORD}';"
	docker exec -it master psql -U postgres -d db -c "CREATE USER ${SHARD_USER} WITH PASSWORD '${SHARD_PASSWORD}';"

	docker exec -it shard1 psql -U postgres -d db -c "GRANT ALL PRIVILEGES ON TABLE users TO ${SHARD_USER};"
	docker exec -it shard2 psql -U postgres -d db -c "GRANT ALL PRIVILEGES ON TABLE users TO ${SHARD_USER};"

	docker exec -it master psql -U postgres -d db -c "CREATE ROLE ${POSTGRES_REPL_USER} WITH REPLICATION LOGIN PASSWORD '${POSTGRES_REPL_PASSWORD}';"
	docker exec -it master psql -U postgres -d db -c "CREATE USER MAPPING FOR ${SHARD_USER} SERVER shard1_server OPTIONS (user '${SHARD_USER}', password '${SHARD_PASSWORD}');"
	docker exec -it master psql -U postgres -d db -c "CREATE USER MAPPING FOR ${POSTGRES_USER} SERVER shard1_server OPTIONS (user '${SHARD_USER}', password '${SHARD_PASSWORD}');"
	docker exec -it master psql -U postgres -d db -c "CREATE USER MAPPING FOR ${SHARD_USER} SERVER shard2_server OPTIONS (user '${SHARD_USER}', password '${SHARD_PASSWORD}');"
	docker exec -it master psql -U postgres -d db -c "CREATE USER MAPPING FOR ${POSTGRES_USER} SERVER shard2_server OPTIONS (user '${SHARD_USER}', password '${SHARD_PASSWORD}');"
	

	docker exec -it master psql -U postgres -d db -c "GRANT ALL PRIVILEGES ON TABLE foreign_users1 TO ${SHARD_USER};"
	docker exec -it master psql -U postgres -d db -c "GRANT ALL PRIVILEGES ON TABLE foreign_users2 TO ${SHARD_USER};"
	docker exec -it master psql -U postgres -d db -c "GRANT ALL PRIVILEGES ON TABLE other_users TO ${SHARD_USER};"
	docker exec -it master psql -U postgres -d db -c "GRANT ALL PRIVILEGES ON ALL_USERS TO ${SHARD_USER};"

	docker cp ./pg_hba.conf shard1:/var/lib/postgresql/data/pg_hba.conf
	docker cp ./pg_hba.conf shard2:/var/lib/postgresql/data/pg_hba.conf
	docker cp ./postgresql.conf shard1:/var/lib/postgresql/data/postgresql.conf
	docker cp ./postgresql.conf shard2:/var/lib/postgresql/data/postgresql.conf