# README - Secrets

## Password File

Provide a password file for the mosquitto broker, called "mosquitto-plain-text.passwd". This file will be copied and hashed during DOCKER COMPOSE BUILD.

Provide usernames and un-hashed passwords.

Syntax is username:password, one per line. Example:

```text
user1:password1
user2:password2
```

## TLS Certificates

If you have VALID certificates, place them into this repo in:
- ca file /mosquitto/secrets/ca_certificate.pem
- cert file /mosquitto/secrets/server_certificate.pem
- key file /mosquitto/secrets/server_key.pem

If you're testing and want to generate some self-signed certs, you can run the tool `./x-generate-certs.sh` in the **TLS** directory of the project to generate some self-signed certificates and drop them into the secrets directory referenced above.

Regardless of how you provide (or generate) certs, these will be mapped into the container during DOCKER COMPOSE UP and are referenced in the mosquitto.conf.
