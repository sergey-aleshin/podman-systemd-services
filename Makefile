.PHONY: ms pg all default stop stop-ms stop-pg
TARGET_DIR=~/.config/containers/systemd
PG_CONTAINER_FILE=postgres.container
MS_CONTAINER_FILE=mssql-server.container

default:
	@echo "Available tagets: all, pg, ms"

all: pg ms

pg:
	-systemctl --user stop postgres
	cp pg/${PG_CONTAINER_FILE} ${TARGET_DIR}
	systemctl --user daemon-reload
	systemctl --user start postgres
	systemctl --user --no-pager status postgres

ms:
	-systemctl --user stop mssql-server
	cp ms/${MS_CONTAINER_FILE} ${TARGET_DIR}
	systemctl --user daemon-reload
	systemctl --user start mssql-server
	systemctl --user --no-pager status mssql-server

stop: stop-ms stop-pg

stop-pg:
	systemctl --user stop postgres

stop-ms:
	systemctl --user stop mssql-server

