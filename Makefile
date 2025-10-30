.PHONY: sync-ms sync-pg stop stop-ms stop-pg start start-ms start-pg status-ms status-pg default verify-ms verify_pg

TARGET_DIR=~/.config/containers/systemd
PG_CONTAINER_FILE=postgres.container
MS_CONTAINER_FILE=mssql-server.container
PG_SERVICE=postgres
MS_SERVICE=mssql-server
SYSTEMCTL=systemctl --user
VERIFY_COMMAND=/usr/lib/systemd/system-generators/podman-system-generator --user --dryrun

default:
	@echo -n

reload:
	${SYSTEMCTL} daemon-reload

sync-pg: verify-pg stop-pg copy-pg reload start-pg

copy-pg:
	cp pg/${PG_CONTAINER_FILE} ${TARGET_DIR}

sync-ms: verify-ms stop-ms copy-ms reload start-ms

copy-ms:
	cp ms/${MS_CONTAINER_FILE} ${TARGET_DIR}

stop: stop-ms stop-pg

stop-pg:
	-${SYSTEMCTL} stop ${PG_SERVICE}

stop-ms:
	-${SYSTEMCTL} stop ${MS_SERVICE}

start: start-ms start-pg

start-pg:
	${SYSTEMCTL} start ${PG_SERVICE}

start-ms:
	${SYSTEMCTL} start ${MS_SERVICE}

status-pg:
	${SYSTEMCTL} --no-pager status ${PG_SERVICE}

status-ms:
	${SYSTEMCTL} --no-pager status ${MS_SERVICE}

verify-ms:
	QUADLET_UNIT_DIRS=${PWD}/ms ${VERIFY_COMMAND}

verify-pg:
	QUADLET_UNIT_DIRS=${PWD}/pg ${VERIFY_COMMAND}

