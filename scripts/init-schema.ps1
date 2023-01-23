docker exec citadel-db psql -f delta_data_schema.sql
docker exec citadel-db psql -f delta_taxa_schema.sql