# README

## Summary

This is a Docker Compose project that will build and run a Mosquitto MQTT broker with TLS and username/password authentication.

## Dependencies

* Docker must be installed on the host system.
* The host must have internet access to build the initial image. (See "Offline Usage" below if you need to use this in an offline environment.)
* Docker Build will use **eclipse-mosquitto:2.0.15** from Docker Hub. Edit the **Dockerfile** to change the version if needed.

## Usage

### Before Starting

1. Provide TLS certs in **./mosquitto/secrets**. See **./mosquitto/secrets/README - secrets.md** for details.
2. Provide a password file in **./mosquitto/secrets**. See **./mosquitto/secrets/README - secrets.md** for details.

### CONTAINER START
Start the container with the following command:

```bash
$ docker compose up -d
```
* On first "up" the image will build from the Dockerfile. This might take a few minutes. See below for "offline usage" if you need to use this in an offline environment.

### CONTAINER STOP
To stop the container, use:

```bash
$ docker compose down
```

## Offline Usage

If you need to use this container on a server that does not have Internet, you can:

* Build the image on a connected server first. From the root director of this repo:
  ```bash
  $ docker compose build
  ```
* Export the docker image to a file. From the root directory of this repo:
  ```bash
  $ docker save -o ./exported-eclipse-mosquitto.docker eclipse-mosquitto 
  ```
* Move the all the files in this repo, including the exported docker image, using any offline method (usb drive, etc.) 
* Load the image on the offline server. On the offline server, from the root directory of this project:
  ```bash
  $ docker load -i ./exported-eclipse-mosquitto.docker
  ```
* Start the container on the offline server as described above.

