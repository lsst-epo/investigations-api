setup_database() {
	declare sql_file

	# Save DB credentials
	echo *:*:*:$DB_USER:$DB_PASSWORD >~/.pgpass
	chmod 600 ~/.pgpass

	cd /var/www/db

	sql_file=$(find . -name "*.sql" -printf "%t %p\n" | sort -n | rev | cut -d' ' -f 1 | rev | tail -n1)

	if [[ "$sql_file" ]]; then
		h2 "Database dump found: ${sql_file}"

		while ! pg_isready -h $DB_SERVER; do
			h2 "Waiting for PostreSQL server"
			sleep 1
		done

		h2 "Importing database"
		cat "$sql_file" | psql -h $DB_SERVER -d $DB_SERVER -U $DB_USER
		
		h2 "Removing SQL dump file now that DB has been restored."
		rm $sql_file
		h2 "Removed."


	fi
	h2 "Done importing DB!"
}
