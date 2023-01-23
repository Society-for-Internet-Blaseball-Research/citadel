docker stop citadel-db
docker build -t sibr/citadel-db:latest -f .\docker\db\Dockerfile .
docker build -t sibr/citadel-app:latest -f .\docker\app\Dockerfile .
docker run --rm -d --name citadel-db -e POSTGRES_PASSWORD=testpassword sibr/citadel-db:latest
echo "Initialization complete."