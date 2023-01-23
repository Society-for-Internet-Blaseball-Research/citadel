docker exec citadel-db psql -c "CREATE DATABASE blaseball;"
docker exec citadel-db psql -f delta_data_schema.sql -d blaseball
docker exec citadel-db psql -f delta_taxa_schema.sql -d blaseball