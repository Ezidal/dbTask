ifneq (,$(wildcard ./.env))
include .env
export
endif

.PHONY: up down restart copy_conf create_slave login encrypt decrypt
up:
	docker network create --subnet=${SUBNET} --gateway=$(GATEWAY) net
	docker compose up -d
	make copy_conf
	sleep 3
	make login
	sleep 2
	make create_slave
down:
	docker compose down -v
	docker network rm net
restart:
	make down
	make up

copy_conf: 
	docker cp ./postgresql.conf master:/var/lib/postgresql/data/postgresql.conf
	docker cp ./pg_hba.conf master:/var/lib/postgresql/data/pg_hba.conf

create_slave:
	docker exec -it slave1 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U $(POSTGRES_REPL_USER) -D /var/lib/postgresql/data;"
	docker exec -it slave2 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U $(POSTGRES_REPL_USER) -D /var/lib/postgresql/data;"

login:
	docker exec -it shard1 psql -U $(POSTGRES_SHARD_USER) -d db -c "CREATE USER ${SHARD_USER} WITH PASSWORD '${SHARD_PASSWORD}';\
		GRANT ALL PRIVILEGES ON TABLE users TO ${SHARD_USER};"
	docker exec -it shard2 psql -U $(POSTGRES_SHARD_USER) -d db -c "CREATE USER ${SHARD_USER} WITH PASSWORD '${SHARD_PASSWORD}';\
		GRANT ALL PRIVILEGES ON TABLE users TO ${SHARD_USER};"

	docker exec -it master psql -U $(POSTGRES_USER) -d db -c "CREATE USER ${SHARD_USER} WITH PASSWORD '${SHARD_PASSWORD}';\
		CREATE ROLE $(POSTGRES_REPL_USER) WITH REPLICATION LOGIN PASSWORD '$(POSTGRES_REPL_PASSWORD)';\
		CREATE USER MAPPING FOR $(SHARD_USER) SERVER shard1_server OPTIONS (user '$(SHARD_USER)', password '$(SHARD_PASSWORD)');\
		CREATE USER MAPPING FOR $(POSTGRES_USER) SERVER shard1_server OPTIONS (user '$(SHARD_USER)', password '$(SHARD_PASSWORD)');\
		CREATE USER MAPPING FOR $(SHARD_USER) SERVER shard2_server OPTIONS (user '$(SHARD_USER)', password '$(SHARD_PASSWORD)');\
		CREATE USER MAPPING FOR $(POSTGRES_USER) SERVER shard2_server OPTIONS (user '$(SHARD_USER)', password '$(SHARD_PASSWORD)');\
		GRANT ALL PRIVILEGES ON TABLE foreign_users1 TO $(SHARD_USER);\
		GRANT ALL PRIVILEGES ON TABLE foreign_users2 TO $(SHARD_USER);\
		GRANT ALL PRIVILEGES ON TABLE other_users TO $(SHARD_USER);\
		GRANT ALL PRIVILEGES ON ALL_USERS TO $(SHARD_USER);\
		"
	docker cp ./pg_hba.conf shard1:/var/lib/postgresql/data/pg_hba.conf
	docker cp ./pg_hba.conf shard2:/var/lib/postgresql/data/pg_hba.conf
	docker cp ./postgresql.conf shard1:/var/lib/postgresql/data/postgresql.conf
	docker cp ./postgresql.conf shard2:/var/lib/postgresql/data/postgresql.conf

encrypt:
	docker run --rm -d --name ansible cytopia/ansible sleep infinity
	docker cp ./.env ansible:/data/.env
	docker cp ./.key ansible:/data/.key
	docker exec -it ansible sh -c "ansible-vault encrypt .env --vault-password-file .key"
	docker cp ansible:/data/.env ./.env-crypt
	rm .env
	docker kill ansible

decrypt:
	docker run --rm -d --name ansible cytopia/ansible sleep infinity
	docker cp ./.env-crypt ansible:/data/.env
	docker cp ./.key ansible:/data/.key
	docker exec -it ansible sh -c "ansible-vault decrypt .env --vault-password-file .key"
	docker cp ansible:/data/.env ./.env
	rm .env-crypt
	docker kill ansible