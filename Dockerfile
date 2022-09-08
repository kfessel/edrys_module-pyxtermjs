FROM ubuntu:20.04

RUN apt-get update --fix-missing
RUN apt-get install -y \
    apt-utils \
    curl \
    g++ \
    gcc \
    make \
    python3 \
    python3-pip \
    vim \
    zsh

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mono-complete mono-mcs

RUN apt-get install -y golang-go

RUN apt-get install -y rustc

RUN apt-get install -y default-jdk

RUN DEBIAN_FRONTEND=noninteractive apt-get install -y r-base r-base-dev r-recommended \
    r-cran-car \
    r-cran-caret \
    r-cran-data.table \
    r-cran-dplyr \
    r-cran-gdata \
    r-cran-ggplot2 \
    r-cran-lattice \
    r-cran-lme4 \
    r-cran-mapdata \
    r-cran-maps \
    r-cran-maptools \
    r-cran-mgcv \
    r-cran-mvtnorm \
    r-cran-nlme \
    r-cran-reshape \
    r-cran-stringr \
    r-cran-survival \
    r-cran-tidyr \
    r-cran-xml \
    r-cran-xml2 \
    r-cran-xtable \
    r-cran-xts \ 
    r-cran-zoo

RUN apt-get install -y julia

RUN apt-get install -y ghc

RUN apt-get install -y clojure

RUN apt-get install -y lua5.3

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

COPY ./assets/.zshrc /home/appuser/.zshrc
COPY ./assets/.oh-my-zsh /home/appuser/.oh-my-zsh

# Switch to user we must not set group to make the configuration done above apply
# !! if ${user} is not setup correctly the next line might result in group being root !!
USER ${user}

EXPOSE 5000

ENTRYPOINT python3 -m pyxtermjs --cors True --host 0.0.0.0 --command zsh
