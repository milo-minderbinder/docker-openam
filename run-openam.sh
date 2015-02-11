#!/bin/bash


read -p "Keystore file path:" ks_file
read -p "Keystore password:" -s ks_pass
echo
read -p "Keystore key alias:" ks_keyalias

if [[ $1 == "-d" ]]; then
	if [[ -z "$2" ]]; then
		TAG=latest
	else
		TAG="${2}"
	fi
	docker run -d -v "${ks_file}":/usr/share/openam/keystore.jks:ro \
		-p 127.0.0.1:8080:8080 -p 127.0.0.1:8443:8443 -h openam.example.com --name openam \
		-e KEYSTORE_FILE=/usr/share/openam/keystore.jks -e KEYSTORE_PASS="${ks_pass}" -e KEYSTORE_KEYALIAS="${ks_keyalias}"  \
		mminderbinder/openam:${TAG}
else
	if [[ -z "$1" ]]; then
		TAG=latest
	else
		TAG="${1}"
	fi
	docker run -it --rm -v "${ks_file}":/usr/share/openam/keystore.jks:ro \
		-p 127.0.0.1:8080:8080 -p 127.0.0.1:8443:8443 -h openam.example.com --name openam \
		-e KEYSTORE_FILE=/usr/share/openam/keystore.jks -e KEYSTORE_PASS="${ks_pass}" -e KEYSTORE_KEYALIAS="${ks_keyalias}"  \
		mminderbinder/openam:${TAG}
fi
