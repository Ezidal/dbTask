ifneq (,$(wildcard ./.env))
include .env
export
endif

.PHONY: up down restart set1 set2
up:
	docker network create --subnet=${SUBNET} --gateway=$(GATEWAY) net
	docker compose up -d
	make set1
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
	docker exec -it slave1 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U $(POSTGRES_USER) -D /var/lib/postgresql/data;"
	docker exec -it slave2 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U $(POSTGRES_USER) -D /var/lib/postgresql/data;"
