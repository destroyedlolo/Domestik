This directory contains SQL files needed to build Domestik's database environment in a PostgreSQL database.

Commands bellow assume you're creating stuffs in **www** database.

# Configuration

All configuration have to be made in **Configuration.sql** script. It's strongly recommended not to modify others.

# Initialisation

Before anything else, execute **Common.sql** to create Domestik2's environment.

`psql -f Common.sql www`

Afterward, use following command to run scripts 

`psql -U domestic2 -f *script*.sql www`

afterward

> [!CAUTION]
> This script will **erase** every existing objects in Domestik2's own schema.
> Use it only once (or to clean previous install).

Everything is created in Domestik2 user own schema.

*.sql declares objects for each probe. You may refine them to the ones you're using ... (obviously, it's harmless to install everything).

