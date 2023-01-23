docker build -t sibr/citadel-app:latest -f .\docker\app\Dockerfile .
docker run --rm --net citadel-network sibr/citadel-app
