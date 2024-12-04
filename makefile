HOST=172.22.0.2

.PHONY: up down restart set1 set2
up:
	docker network create --subnet=172.22.0.0/16 --gateway=172.22.0.1 bignet
	docker compose up -d
	make set1
	sleep 1.5
	make set2
down:
	docker compose down -v
	docker network rm bignet
restart:
	make down
	make up

set1: 
	docker cp ./pg_hba.conf master:/var/lib/postgresql/data/pg_hba.conf
	docker cp ./postgresql.conf master:/var/lib/postgresql/data/postgresql.conf

set2:
	docker exec -it slave bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U master -D /var/lib/postgresql/data;"
	docker exec -it slave1 bash -c "rm -rf /var/lib/postgresql/data/*; pg_basebackup -P -R -X stream -c fast -h $(HOST) -U master -D /var/lib/postgresql/data;"
