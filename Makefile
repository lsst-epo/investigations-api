start:
	docker-compose -f docker-compose-local-db.yml up --build

clean:
	docker system prune -f && docker volume prune -f

clean-images:
	docker images prune