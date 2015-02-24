#!/bin/bash


read -p "Keystore file path:" ks_file
read -p "Keystore password:" -s ks_pass
echo
read -p "Keystore key alias:" ks_keyalias

TAG=latest
MODE="-it --rm"
if [[ $1 == "-d" ]]; then
	MODE="-d"
	if [[ -n "$2" ]]; then
		TAG="${2}"
	fi
else
	if [[ -n "$1" ]]; then
		TAG="${1}"
	fi
fi
docker run ${MODE} \
	-v "${ks_file}":/usr/share/openam/keystore.jks:ro \
	-p 127.0.0.1:8080:8080 \
	-p 127.0.0.1:8443:8443 \
	-h openam.example.com --name openam \
	-e KEYSTORE_FILE=/usr/share/openam/keystore.jks \
	-e KEYSTORE_PASS="${ks_pass}" \
	-e KEYSTORE_KEYALIAS="${ks_keyalias}"  \
	mminderbinder/openam:${TAG}
