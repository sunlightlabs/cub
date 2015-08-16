
# Get the raw files
source ./get_skede.sh

# Build the tables
psql -d DATABASE -f ../sql/make_sked_tables.sql
