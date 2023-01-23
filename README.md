# CiTaDel (Chron To Datablase Loader)
Loading blaseball's Delta eon data from SIBR Chron APIs to the Datablase.  May be ad hoc, may be start of real program.

## Quick setup using Docker

- `scripts\init-test-env.sh` (or `.ps1` for Windows)
- `scripts\init-schema.sh`
- `scripts\run-citadel.sh`

At this point you should have a working database running with the data loaded in from the Citadel script. You can execute SQL commands against the DB with `docker exec citadel-db psql <ARGS>`
or connect to an interactive session with `docker exec -it citadel-db psql`. The citadel script can be run in again a container (`run-citadel.sh` above) or locally if a virtualenv is setup.

## Manual setup

To get this program running locally or on SIBR Server:
-  Set up PostgreSQL in same machine as this program.
-  Create database named "blaseball".
-  Run the initial SQL to create two schemas (and appropriate tables inside): delta_data_schema.sql and delta_taxa_schema.sql
-  Make a copy of database_config_example.ini, saved as database_config.ini, with appropriate changes to user/pw/host/port
-  Python code runs on Python 3.10, as well as the following libraries: numpy, pandas, sqlalchemy, psycopg2, configparser, and sys.

Any questions, tips, issues, feel free to come to the Society for Internet Blaseball Research Discord server: https://discord.gg/FfnScUn , 
and visit @Gizmo aka Ifhbiff (he/him) and the other Data Witches in the #datablase forum.

Neither the author of this repo nor SIBR itself are directly affiliated with Blaseball (www.blaseball.com), but obviously recommend joining the cultural event known as Blaseball.

