#!/bin/bash

TAG=0.9.15

if [[  $1 == "-d" ]]; then
	read -p "Keystore file path:" ks_file
	read -p "Keystore password:" -s ks_pass
	echo
	read -p "Keystore key alias:" ks_keyalias
	docker run -d -p 127.0.0.1:8080:8080 -p 127.0.0.1:8443:8443 -h openam.example.com --name openam \
		-e KEYSTORE_FILE=${ks_file} -e KEYSTORE_PASS="${ks_pass}" -e KEYSTORE_KEYALIAS="${ks_keyalias}"  \
		mminderbinder/openam:${TAG}
else
	docker run -it --rm -p 127.0.0.1:8080:8080 -p 127.0.0.1:8443:8443 -h openam.example.com --name openam \
		mminderbinder/openam:${TAG}
fi
