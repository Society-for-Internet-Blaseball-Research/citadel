docker stop citadel-db
docker network create citadel-network
docker build -t sibr/citadel-db:latest -f .\docker\db\Dockerfile .
docker run --rm -d --name citadel-db -e POSTGRES_PASSWORD=testpassword --net citadel-network sibr/citadel-db:latest
echo "Initialization complete."
