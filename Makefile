include .env

postgres:
	docker run --name trello-clone -p 5432:5432 -e POSTGRES_USER=${POSTGRES_USER} -e POSTGRES_PASSWORD=${POSTGRES_PASSWORD} -d postgres:17-alpine

createdb:
	docker exec -it trello-clone createdb --username=${POSTGRES_USER} --owner=${POSTGRES_USER} trello_clone

dropdb:
	docker exec -it trello-clone dropdb trello_clone

migrateup:
	migrate -path db/migration -database "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:5432/trello_clone?sslmode=disable" -verbose up

migratedown:
	migrate -path db/migration -database "postgresql://${POSTGRES_USER}:${POSTGRES_PASSWORD}@localhost:5432/trello_clone?sslmode=disable" -verbose down

sqlc:
	sqlc generate

.PHONY: postgres createdb dropdb migrateup migratedown sqlc
