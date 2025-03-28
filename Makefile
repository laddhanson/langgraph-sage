.PHONY: up down logs ps clean python-setup python-envs python-deactivate

# Create and activate Python virtual environment using pyenv
python-setup:
	pyenv global system
	pyenv install 3.11.7
	pyenv virtualenv-delete langgraph
	pyenv virtualenv 3.11.7 langgraph
	pyenv local langgraph
	pip install --upgrade pip

# List all Python environments
python-envs:
	pyenv versions

# Activate Python environment
activate:
	pyenv activate langgraph

# Deactivate current Python environment
deactivate:
	pyenv deactivate

# Start all services
up:
	docker compose up -d

check:
	curl -s http://0.0.0.0:8123/ok | jq '.'

# Stop all services
down:
	docker compose down

# View logs from all services
logs:
	docker compose logs -f

# List running services
ps:
	docker compose ps

# Stop and remove all containers, volumes, and networks
clean:
	docker compose down -v

# Rebuild and restart services
rebuild:
	docker compose down
	docker compose build --no-cache
	docker compose up -d

# View logs from a specific service
# Usage: make service-logs SERVICE=langgraph-api
service-logs:
	docker compose logs -f $(SERVICE)

# Restart a specific service
# Usage: make restart-service SERVICE=langgraph-api
restart-service:
	docker compose restart $(SERVICE)

# Check service health
health:
	docker compose ps --format "table {{.Name}}\t{{.Status}}"

langgraph-cli:
	pip install -U langgraph-cli

langgraph-new:
#	langgraph new --template retrieval-agent-js sage-studio
	langgraph new --template new-langgraph-project-js sage-studio

langgraph-build:
	cd sage-studio; langgraph build -t sage-studio

langgraph-run:
	langgraph run -t my-image

langgraph-serve:
	langgraph serve -t my-image
