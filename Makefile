all: help

help:
	@echo ""
	@echo "-- Help Menu"
	@echo ""
	@echo "   1. make assets       - build the temporary data image for oracle installation"
	@echo "   2. make build        - build the oracle image"
	@echo "   3. make quickstart   - start oracle"
	@echo "   4. make stop         - stop oracle"
	@echo "   5. make logs         - view logs"
	@echo "   6. make purge        - stop and remove the container and images"

assets:
	@docker build --tag=${USER}/oracle-11g2-assets step0

build:
	@docker build --tag=${USER}/oracle-11g2 step1

quickstart:
	@echo "Starting oracle..."
	@echo "Please be patient. This could take a while..."

	@echo "Installing oracle..."

	@docker run --name='oracle' -h oracle \
		-i --rm --privileged=true \
		-v /Users/vvkuznetsov/projects/start/oracle-disk/oracle:/u01/app/oracle/11.2.0/db1 \
		-v /Users/vvkuznetsov/projects/start/oracle-disk/oraInventory:/u01/app/oraInventory \
		${USER}/oracle-11g2:latest app:install

	@echo "Starting oracle..."

	@docker run --name='oracle' -h oracle \
		-d --privileged=true \
		-p 10022:22 -p 1521:1521 \
		-v /Users/vvkuznetsov/projects/start/oracle-disk/oracle:/u01/app/oracle/11.2.0/db1 \
		-v /Users/vvkuznetsov/projects/start/oracle-disk/oraInventory:/u01/app/oraInventory \
		${USER}/oracle-11g2:latest app:start

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