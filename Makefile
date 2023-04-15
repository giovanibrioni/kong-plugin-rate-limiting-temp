KONG_VERSION?=3.3.0

PLUGIN_VERSION?=3.3.1-1

### Docker ###
run: 
	@echo "Starting redis and kong ..."
	docker-compose up -d --force-recreate

flush-redis: 
	@echo "Flushing all redis keys ..."
	docker exec -it redis-ratelimiting redis-cli FLUSHALL
	
test: flush-redis
	@echo "Starting tests with parralel calls on kong:3.2.2"
	docker run --rm -i --network host loadimpact/k6 run - <./k6-loadtest/script.js
	@echo "Test finished"

test-fixed: flush-redis
	@echo "Starting tests with parralel calls on rate-limiting plugin with fix"
	docker run --rm -i --network host loadimpact/k6 run - <./k6-loadtest/script2.js
	@echo "Test finished"

stop: 
	docker-compose down