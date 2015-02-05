all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make build        - build the oracle image"
	@echo "   2. make quickstart   - start oracle"
	@echo "   3. make stop         - stop oracle"
	@echo "   4. make logs         - view logs"
	@echo "   5. make purge        - stop and remove the container"

assets:
	@docker build --tag=${USER}/oracle-11g2-assets step0

build: assets
	@docker build --tag=${USER}/oracle-11g2 step1

quickstart:
	@echo "Starting oracle..."
	@docker run --name='oracle' -h oracle -d \
		-p 10022:22 -p 1521:1521 \
		${USER}/oracle-11g2:latest >/dev/null
	@echo "Please be patient. This could take a while..."
	@echo "Type 'make logs' for the logs"

stop:
	@echo "Stopping oracle..."
	@docker stop oracle >/dev/null

purge: stop
	@echo "Removing stopped container..."
	@docker rm oracle >/dev/null

clean: purge
	@docker rmi -f ${USER}/oracle-11g2 ${USER}/oracle-11g2-assets >/dev/null

logs:
	@docker logs -f oracle