.PHONY: sync sync-ms sync-pg stop stop-ms stop-pg start start-ms start-pg status status-ms status-pg default

TARGET_DIR=~/.config/containers/systemd
PG_CONTAINER_FILE=postgres.container
MS_CONTAINER_FILE=mssql-server.container
PG_SERVICE=postgres
MS_SERVICE=mssql-server
SYSTEMCTL=systemctl --user

default:
	@echo "Available tagets: all, pg, ms"

sync: sync-pg sync-ms

sync-pg:
	-${SYSTEMCTL} stop ${PG_SERVICE}
	cp pg/${PG_CONTAINER_FILE} ${TARGET_DIR}
	${SYSTEMCTL} daemon-reload
	${SYSTEMCTL}  start ${PG_SERVICE}
	${SYSTEMCTL} --no-pager status ${PG_SERVICE}

sync-ms:
	-${SYSTEMCTL} --user stop ${MS_SERVICE}
	cp ms/${MS_CONTAINER_FILE} ${TARGET_DIR}
	${SYSTEMCTL} daemon-reload
	${SYSTEMCTL} start ${MS_SERVICE}
	${SYSTEMCTL} --no-pager status ${MS_SERVICE}

stop: stop-ms stop-pg

stop-pg:
	${SYSTEMCTL} stop ${PG_SERVICE}

stop-ms:
	${SYSTEMCTL} stop ${MS_SERVICE}

start: start-ms start-pg

start-pg:
	${SYSTEMCTL} start ${PG_SERVICE}

start-ms:
	${SYSTEMCTL} start ${MS_SERVICE}

status: status-ms status-pg

status-pg:
	${SYSTEMCTL} status ${PG_SERVICE}

status-ms:
	${SYSTEMCTL} status ${MS_SERVICE}

