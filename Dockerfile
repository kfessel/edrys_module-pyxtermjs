FROM ubuntu:20.04

RUN apt update
RUN apt install -y \
    curl \
    gcc \
    make \
    python3 \
    python3-pip \
    vim \
    zsh

RUN curl -fsSL https://raw.githubusercontent.com/arduino/arduino-cli/master/install.sh | sh
RUN arduino-cli upgrade
RUN arduino-cli core install arduino:avr


COPY . /var/www
WORKDIR "/var/www"

RUN pip3 install -r requirements.txt

# Set user and group
ARG user=appuser
ARG group=appuser
ARG uid=1000
ARG gid=1000
RUN groupadd -g ${gid} ${group}
RUN useradd -u ${uid} -g ${group} -s /bin/sh -m ${user} # <--- the '-m' create a user home directory
RUN usermod -a -G dialout ${user}

# Switch to user
USER ${uid}:${gid}

ENTRYPOINT python3 -m pyxtermjs --cors True --tmp True --host 0.0.0.0
