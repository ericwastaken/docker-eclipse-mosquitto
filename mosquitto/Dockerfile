FROM eclipse-mosquitto:2.0.15

# Copy the plain-text-passwd file and then hash it
COPY secrets/mosquitto-plain-text.passwd /etc/mosquitto/mosquitto.passwd
RUN mosquitto_passwd -U /etc/mosquitto/mosquitto.passwd
