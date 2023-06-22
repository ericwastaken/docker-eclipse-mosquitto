# Note we're forcing the platform to linux/amd64 to avoid issues generating images on Apple Silicon workstations
FROM --platform=linux/amd64 eclipse-mosquitto:2.0.15

# Copy the plain-text-passwd file and then hash it
COPY secrets/mosquitto-plain-text.passwd /etc/mosquitto/mosquitto.passwd
RUN mosquitto_passwd -U /etc/mosquitto/mosquitto.passwd
