.PHONY: db create start-db

db:
	docker run --name phoenix-postgres -e POSTGRES_USER=postgres -e POSTGRES_PASSWORD=postgres -p 5432:5432 -d postgres:14

start-db:
	docker start phoenix_postgres

create:
	mix ecto.create
