#!/bin/bash

# This script uses the TLS-GEN library to generate self-signed
# TLS certs suitable to use for RMQ. The certificates will be
# copied to the RMQ Secrets directory after creation!
#
# You can change the domain to suit your needs!
#
# Learn more about TLS-GEN at https://github.com/michaelklishin/tls-gen
#
# DEPENDENCIES:
# The TLS-GEN library requires Python 3.6 or later and openssl.
# Install those prior to running this tool.

# Save a variable with the location of where the script is located
SCRIPTPATH="$( cd "$(dirname "$0")" ; pwd -P )"

# Change into the tool directory. Basis is fine for our use.
# The more advanced options are not included in this repo, but are part of the original.
cd tls-gen/basic/ || exit

# Prompt for a hostname or wildcard domain
echo "Enter the hostname or wildcard domain (CN) to use for the certs (e.g. 'www.somehost.com' or  '*.somedomain.com'):"
# Collect user input for the domain
read -r CN

# Prompt for the duration of validity for the cert, in days
echo "Enter the number of days of validity for the certs (e.g. 365):"
# Collect user input for the number of days of validity
read -r DAYS_OF_VALIDITY

# make sure we have both CN and DAYS_OF_VALIDITY
if [ -z "$CN" ] || [ -z "$DAYS_OF_VALIDITY" ]; then
    echo "You must provide both a CN and DAYS_OF_VALIDITY."
    exit 1
fi

# Prompt for confirmation of what the script will do
echo "This script will generate a self-signed certificate for the domain '$CN' that will expire in $DAYS_OF_VALIDITY days."
echo "The certificate files will be copied to the **mosquitto/secrets** directory after creation."
# Prompt "press any key to continue or CTLR+C to cancel."
read -n 1 -s -r -p "Press any key to continue or CTLR+C to cancel."

echo "Generating cert files..."
# Generate the cert files suppressing output
make CN="$CN" DAYS_OF_VALIDITY="$DAYS_OF_VALIDITY" > /dev/null 2>&1

# Cleanup
rm -rf server client testca
# Remove any old results
rm -rf ../_result
# Move the results back up
mv result ../_result

# Copy the 3 cert files ca_certificate.pem, server_certificate.pem, server_key.pem to the Mosquitto Secrets directory
cp "${SCRIPTPATH}/tls-gen/_result/ca_certificate.pem" "${SCRIPTPATH}/../mosquitto/secrets"
cp "${SCRIPTPATH}/tls-gen/_result/server_certificate.pem" "${SCRIPTPATH}/../mosquitto/secrets"
cp "${SCRIPTPATH}/tls-gen/_result/server_key.pem" "${SCRIPTPATH}/../mosquitto/secrets"

